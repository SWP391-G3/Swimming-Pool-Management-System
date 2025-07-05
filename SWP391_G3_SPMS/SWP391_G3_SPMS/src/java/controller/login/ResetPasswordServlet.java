/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.login;

import dao.UserDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.Date;
import java.util.Random;
import static util.CheckNewPassword.validateRegisterPassword;
import util.EmailUtil;
import util.HashUtils;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String step = request.getParameter("step");

        if ("email".equals(step)) {
            handleEmailStep(request, response);
        } else if ("otp".equals(step)) {
            handleOtpStep(request, response);
        } else if ("newpass".equals(step)) {
            handleNewPasswordStep(request, response);
        } else if ("resend".equals(step)) {
            handleResendOtp(request, response);
        } else {
            response.getWriter().println("Step không hợp lệ.");
        }
    }

    // Bước 1: Nhập email để gửi OTP
    private void handleEmailStep(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        HttpSession session = request.getSession();

        UserDAO userDao = new UserDAO();
        boolean exists = userDao.isEmailExists(email);

        if (!exists) {
            session.setAttribute("error", "Email không tồn tại trong hệ thống.");
            response.sendRedirect("ResetPassword.jsp?step=email");
            return;
        }

        // Tạo mã OTP và thời điểm gửi
        String otp = String.format("%06d", new Random().nextInt(999999));
        Date otpCreatedAt = new Date();

        // Lưu vào session
        session.setAttribute("otp", otp);
        session.setAttribute("otpCreatedAt", otpCreatedAt);
        session.setAttribute("resetEmail", email);

        try {
            EmailUtil.sendOTP(email, otp, "reset");
            session.setAttribute("message", "Mã OTP đã được gửi đến email.");
            response.sendRedirect("ResetPassword.jsp?step=otp");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Không gửi được mã OTP.");
            response.sendRedirect("ResetPassword.jsp?step=email");
        }
    }

    // Bước 2: Xác thực OTP
    private void handleOtpStep(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String userInputOtp = request.getParameter("otp");
        String expectedOtp = (String) session.getAttribute("otp");
        Date otpCreatedAt = (Date) session.getAttribute("otpCreatedAt");

        if (expectedOtp == null || otpCreatedAt == null) {
            session.setAttribute("error", "Không tìm thấy mã OTP. Hãy yêu cầu lại.");
            response.sendRedirect("ResetPassword.jsp?step=email");
            return;
        }

        long millisPassed = new Date().getTime() - otpCreatedAt.getTime();
        long secondsPassed = millisPassed / 1000;

        if (secondsPassed > 120) {
            session.setAttribute("error", "Mã OTP đã hết hạn sau " + secondsPassed + " giây.");
            response.sendRedirect("ResetPassword.jsp?step=otp");
            return;
        }

        if (expectedOtp.equals(userInputOtp)) {
            session.setAttribute("message", "Hoàn tất mã OTP. Vui lòng đặt lại mật khẩu.");
            response.sendRedirect("ResetPassword.jsp?step=newpass");
        } else {
            session.setAttribute("error", "Mã OTP không chính xác.");
            response.sendRedirect("ResetPassword.jsp?step=otp");
        }
    }

    // Bước 3: Đặt lại mật khẩu mới
    private void handleNewPasswordStep(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String email = (String) session.getAttribute("resetEmail");

        if (email == null) {
            response.getWriter().println("Chưa xác thực OTP.");
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            session.setAttribute("error", "Mật khẩu xác nhận không khớp.");
            response.sendRedirect("ResetPassword.jsp?step=newpass");
            return;
        }

        String passwordValidationMessage = validateRegisterPassword(newPassword);
        if (passwordValidationMessage != null) {
            session.setAttribute("error", passwordValidationMessage);
            response.sendRedirect("ResetPassword.jsp?step=newpass");
            return;
        }

        UserDAO userDao = new UserDAO();
        String hashedPassword = HashUtils.hashPassword(newPassword);
        boolean updated = userDao.updatePasswordByEmail(email, hashedPassword);

        if (updated) {
            session.removeAttribute("otp");
            session.removeAttribute("otpCreatedAt");
            session.removeAttribute("resetEmail");

            session.setAttribute("message", "Đặt lại mật khẩu thành công. Vui lòng đăng nhập.");
            response.sendRedirect("login.jsp");
        } else {
            session.setAttribute("error", "Không thể cập nhật mật khẩu.");
            response.sendRedirect("ResetPassword.jsp?step=newpass");
        }
    }

    // Gửi lại mã OTP mới
    private void handleResendOtp(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("resetEmail");

        if (email == null) {
            session.setAttribute("error", "Không có email để gửi lại OTP.");
            response.sendRedirect("ResetPassword.jsp?step=email");
            return;
        }

        String otp = String.format("%06d", new Random().nextInt(999999));
        Date otpCreatedAt = new Date();

        session.setAttribute("otp", otp);
        session.setAttribute("otpCreatedAt", otpCreatedAt);

        try {
            EmailUtil.sendOTP(email, otp, "reset");
            session.setAttribute("message", "Mã OTP mới đã được gửi.");
            response.sendRedirect("ResetPassword.jsp?step=otp");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Không gửi được mã OTP mới.");
            response.sendRedirect("ResetPassword.jsp?step=otp");
        }
    }
}
