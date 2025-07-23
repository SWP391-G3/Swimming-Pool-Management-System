package controller.login;

import dao.customer.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.Date;
import java.util.Random;
import model.customer.User;
import util.HashUtils;
import util.CheckNewPassword;
import static util.CheckNewPassword.validateRegisterPassword;
import util.EmailUtil;

/**
 *
 * @author 84823
 */
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        String step = request.getParameter("step");
        HttpSession session = request.getSession();

        if (step == null || step.equals("info")) {
            // Bước nhập thông tin người dùng
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            String confirmPassword = request.getParameter("confirm_password");
            String fullName = request.getParameter("full_name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String dobStr = request.getParameter("dob");
            String address = request.getParameter("address");

            if (!password.equals(confirmPassword)) {
                request.setAttribute("error", "Mật khẩu xác nhận không khớp.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            String passwordValidationMessage = validateRegisterPassword(password);
            if (passwordValidationMessage != null) {
                request.setAttribute("error", passwordValidationMessage);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            UserDAO dao = new UserDAO();
            if (dao.isUsernameExists(username)) {
                request.setAttribute("error", "Tên đăng nhập đã tồn tại!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            if (dao.isEmailExists(email)) {
                request.setAttribute("error", "Email đã tồn tại!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            if (dao.isPhoneExists(phone)) {
                request.setAttribute("error", "Số điện thoại đã tồn tại!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Validate date of birth (must be over 14 years)
            if (dobStr == null || dobStr.isEmpty()) {
                request.setAttribute("error", "Ngày sinh là bắt buộc.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            LocalDate dob = LocalDate.parse(dobStr);
            LocalDate minDob = LocalDate.now().minusYears(14);
            if (dob.isAfter(minDob)) {
                request.setAttribute("error", "Bạn phải từ 14 tuổi trở lên.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            // Lưu user tạm vào session (chưa hashPassword)
            User tempUser = new User(0, username, password, fullName, email, phone, address,
                    4, true, java.sql.Date.valueOf(dob), null, null, LocalDate.now(), null);
            session.setAttribute("tempUser", tempUser);

            // Gửi OTP
            String otp = String.format("%06d", new Random().nextInt(999999));
            session.setAttribute("otp", otp);
            session.setAttribute("otpCreatedAt", new Date());

            try {
                EmailUtil.sendOTP(email, otp, "register");
                session.setAttribute("message", "Mã OTP đã được gửi tới email " + email);
                response.sendRedirect("register.jsp?step=otp");
            } catch (Exception e) {
                request.setAttribute("error", "Không gửi được OTP.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
            }

        } else if (step.equals("otp")) {
            // Bước xác nhận OTP
            String inputOtp = request.getParameter("otp");
            String expectedOtp = (String) session.getAttribute("otp");
            Date otpCreatedAt = (Date) session.getAttribute("otpCreatedAt");
            User tempUser = (User) session.getAttribute("tempUser");

            if (expectedOtp == null || otpCreatedAt == null || tempUser == null) {
                request.setAttribute("error", "Thông tin không hợp lệ hoặc đã hết phiên.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            long secondsPassed = (new Date().getTime() - otpCreatedAt.getTime()) / 1000;
            if (secondsPassed > 120) {
                request.setAttribute("error", "Mã OTP đã hết hạn.");
                request.getRequestDispatcher("register.jsp?step=otp").forward(request, response);
                return;
            }

            if (!expectedOtp.equals(inputOtp)) {
                request.setAttribute("error", "Mã OTP không chính xác.");
                request.getRequestDispatcher("register.jsp?step=otp").forward(request, response);
                return;
            }

            // ✅ Chỉ khi OTP đúng mới hash mật khẩu và insert
            tempUser.setPassword(HashUtils.hashPassword(tempUser.getPassword()));
            new UserDAO().insertUser(tempUser);

            // Clear session
            session.removeAttribute("otp");
            session.removeAttribute("otpCreatedAt");
            session.removeAttribute("tempUser");

            session.setAttribute("message", "Register successfully!");
            response.sendRedirect("login.jsp");

        } else if (step.equals("resend")) {
            // Gửi lại OTP
            User tempUser = (User) session.getAttribute("tempUser");
            if (tempUser == null) {
                request.setAttribute("error", "Không tìm thấy thông tin người dùng tạm thời.");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            String otp = String.format("%06d", new Random().nextInt(999999));
            session.setAttribute("otp", otp);
            session.setAttribute("otpCreatedAt", new Date());

            try {
                EmailUtil.sendOTP(tempUser.getEmail(), otp, "register");
                session.setAttribute("message", "Mã OTP mới đã được gửi.");
                response.sendRedirect("register.jsp?step=otp");
            } catch (Exception e) {
                request.setAttribute("error", "Gửi lại OTP thất bại.");
                request.getRequestDispatcher("register.jsp?step=otp").forward(request, response);
            }
        }
    }
}