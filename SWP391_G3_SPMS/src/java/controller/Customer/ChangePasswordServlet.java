package controller.Customer;

import dao.UserDAO;
import model.User;
import util.PasswordEncryption;
import util.CheckNewPassword;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        //        HttpSession session = request.getSession();
        //        User user = (User) session.getAttribute("user");
        //        if (user == null) {
        //            response.sendRedirect("login.jsp");
        //            return;
        //        }

        int userId = 2;
        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByID(userId);

        String currentPassword = request.getParameter("current_password");
        String newPassword = request.getParameter("new_password");
        String confirmPassword = request.getParameter("confirm_password");
        String message = null;

        if (user == null) {
            message = "Không tìm thấy người dùng!";
        } else if (currentPassword == null || newPassword == null || confirmPassword == null
                || currentPassword.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            message = "Vui lòng nhập đầy đủ thông tin!";
        } else if (!PasswordEncryption.checkPassword(currentPassword, user.getPassword())) {
            message = "Mật khẩu hiện tại không đúng!";
        } else if (!newPassword.equals(confirmPassword)) {
            message = "Mật khẩu mới và xác nhận không khớp!";
        } else {
            // Kiểm tra quy tắc mật khẩu mới
            String ruleMsg = CheckNewPassword.validateNewPassword(newPassword, currentPassword);
            if (ruleMsg != null) {
                message = ruleMsg;
            } else {
                userDAO.updatePassword(user.getUserId(), newPassword); //Mã hóa trước khi lưu
                message = "Đổi mật khẩu thành công!";
            }
        }

        request.setAttribute("message", message);
        request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
    }
}
