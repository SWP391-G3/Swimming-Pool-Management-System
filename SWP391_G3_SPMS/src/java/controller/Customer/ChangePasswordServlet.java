package controller.Customer;

import dao.UserDAO;
import model.User;
import util.PasswordEncryption;

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
        // Hiển thị trang đổi mật khẩu
        request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = 4; // TODO: lấy từ session thực tế
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
        } else if (newPassword.length() < 6) {
            message = "Mật khẩu mới phải có ít nhất 6 ký tự!";
        } else {
            userDAO.updatePassword(user.getUserId(), newPassword);
            message = "Đổi mật khẩu thành công!";
        }

        request.setAttribute("message", message);
        request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
    }
}
