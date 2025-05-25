package controller;

import model.User;
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

@WebServlet("/profile")
public class CustomerAccountInforServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        User userDetails = userDAO.getUserByID(4);
        if (userDetails != null) {
            request.setAttribute("user", userDetails);
            request.getRequestDispatcher("customer_account_infor.jsp").forward(request, response);
        } else {
            response.getWriter().println("Không tìm thấy user có id = 4 trong database!");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        String service = request.getParameter("service");

        if (service == null) {
            service = "updateProfile";
        }

        if (service.equals("updateProfile")) {
            int id = 4;
            String fullName = request.getParameter("full_name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            User user = userDAO.getUserByID(id);
            if (user != null) {
                user.setFull_name(fullName);
                user.setEmail(email);
                user.setPhone(phone);
                user.setAddress(address);

                userDAO.updateUser(user);

                request.setAttribute("updateSuccess", "Profile updated successfully!");
                request.setAttribute("user", userDAO.getUserByID(id));
                request.getRequestDispatcher("customer_account_infor.jsp").forward(request, response);
            } else {
                response.getWriter().println("Không tìm thấy user có id = 4 trong database!");
            }
        }
    }
}