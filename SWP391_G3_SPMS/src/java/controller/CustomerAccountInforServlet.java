package controller;

import model.User;
import dao.UserDAO;
import dao.UserDAO;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

public class CustomerAccountInforServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin user từ session (sau khi login)
        HttpSession session = request.getSession(false);
        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("user");
        }

        // Nếu chưa đăng nhập thì chuyển về trang login
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        request.setAttribute("user", user);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/customerProfile.jsp");
        dispatcher.forward(request, response);
    }

    // Nếu có form cập nhật thông tin profile, xử lý ở POST
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Giả sử người dùng đã đăng nhập
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Lấy dữ liệu từ form
        String fullName = request.getParameter("full_name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Cập nhật đối tượng User
        user.setFull_name(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);

        // Cập nhật DB
        UserDAO userDAO = new UserDAO();
        try {
            userDAO.updateUserProfile(user);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("updateError", "Update failed! Please try again.");
        }

        // Cập nhật lại session
        session.setAttribute("user", user);

        // Thông báo thành công
        request.setAttribute("updateSuccess", "Profile updated successfully!");
        request.setAttribute("user", user);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/customerProfile.jsp");
        dispatcher.forward(request, response);
    }
}