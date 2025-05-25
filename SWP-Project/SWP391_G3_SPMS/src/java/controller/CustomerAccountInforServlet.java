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
        HttpSession session = request.getSession(false);
        User user = null;
        if (session != null) {
            user = (User) session.getAttribute("user");
        }
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        request.setAttribute("user", user);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/customer_account_infor.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        // Lấy các trường
        String fullName = request.getParameter("full_name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        // Cập nhật
        user.setFull_name(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setAddress(address);

        // Cập nhật DB
        UserDAO userDAO = new UserDAO();
        try {
            userDAO.updateUserProfile(user);
            request.setAttribute("updateSuccess", "Profile updated successfully!");
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("updateError", "Update failed! Please try again.");
        }
        session.setAttribute("user", user);
        request.setAttribute("user", user);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/customer_account_infor.jsp");
        dispatcher.forward(request, response);
    }
}
