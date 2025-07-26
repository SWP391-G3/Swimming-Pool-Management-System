package controller.login;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.customer.User;


public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy session hiện tại nếu có
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");  
        if (user == null) {
            response.sendRedirect("LandingPage.jsp");
            return;
        }
        int role = user.getRole_id();
        switch (role) {
            case 1:
                session.removeAttribute("adminAccount");
                break;
            case 2:
                session.removeAttribute("managerAccount");
                break;
            case 3:
                session.removeAttribute("staffAccount");
                break;
            case 4:
                session.removeAttribute("customerAccount");
                break;
            default:
                throw new AssertionError();
        }
        response.sendRedirect("LandingPage.jsp");
    }
}
