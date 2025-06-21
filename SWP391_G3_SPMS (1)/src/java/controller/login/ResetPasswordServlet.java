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
import java.util.Random;
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
        } else {
            response.getWriter().println("Step không hợp lệ.");
        }
    }

    private void handleEmailStep(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String email = request.getParameter("email");
        String otp = String.format("%06d", new Random().nextInt(999999));
        HttpSession session = request.getSession();
        session.setAttribute("otp", otp);
        session.setAttribute("resetEmail", email);

        try {
            EmailUtil.sendOTP(email, otp);
            session.setAttribute("message", "OTP đã được gửi tới email.");
            response.sendRedirect("ResetPassword.jsp?step=otp");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Không gửi được OTP.");
            response.sendRedirect("ResetPassword.jsp?step=email");
        }
    }

    private void handleOtpStep(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String userInputOtp = request.getParameter("otp");
        HttpSession session = request.getSession();
        String expectedOtp = (String) session.getAttribute("otp");

        if (expectedOtp != null && expectedOtp.equals(userInputOtp)) {
            session.setAttribute("message", "OTP đúng. Hãy đặt lại mật khẩu.");
            response.sendRedirect("ResetPassword.jsp?step=newpass");
        } else {
            session.setAttribute("error", "OTP sai. Vui lòng thử lại.");
            response.sendRedirect("ResetPassword.jsp?step=otp");
        }
    }

    private void handleNewPasswordStep(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String newPassword = request.getParameter("newPassword");
        HttpSession session = request.getSession();
        String email = (String) session.getAttribute("resetEmail");

        if (email == null) {
            response.getWriter().println("Chưa xác thực OTP.");
            return;
        }
        UserDAO userDao = new UserDAO();
      
        String hashedPassword = HashUtils.hashPassword(newPassword);
        boolean updated = userDao.updatePasswordByEmail(email, hashedPassword);

        if (updated) {
            session.removeAttribute("otp");
            session.removeAttribute("resetEmail");
            session.setAttribute("message", "Đặt lại mật khẩu thành công. Vui lòng đăng nhập.");
            response.sendRedirect("login.jsp");
        } else {
            session.setAttribute("error", "Không thể cập nhật mật khẩu.");
            response.sendRedirect("ResetPassword.jsp?step=newpass");
        }
    }
}
