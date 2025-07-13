package controller.Customer;

import dao.customer.UserDAO;
import model.customer.User;
import util.PasswordEncryption;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
/**
 *
 * @author LAZYVL
 */

public class ChangePasswordServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getUser_id();
        UserDAO userDAO = new UserDAO();
        user = userDAO.getUserByID(userId);

        String currentPassword = request.getParameter("current_password");
        String newPassword = request.getParameter("new_password");
        String confirmPassword = request.getParameter("confirm_password");

        String message = null;

        if (!PasswordEncryption.checkPassword(currentPassword, user.getPassword())) {
            message = "Mật khẩu hiện tại không đúng!";
        } else if (!newPassword.equals(confirmPassword)) {
            message = "Mật khẩu mới và xác nhận không khớp!";
        } else {
            userDAO.updatePassword(userId, newPassword); // Đảm bảo DAO tự mã hóa
            message = "Đổi mật khẩu thành công!";
        }

        request.setAttribute("message", message);
        request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
    }
}
