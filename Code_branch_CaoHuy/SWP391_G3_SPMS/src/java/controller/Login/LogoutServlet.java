package controller.Login;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;


public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy session hiện tại nếu có
        HttpSession session = request.getSession(false);
        if (session != null) {
            // Hủy session để đăng xuất
            session.invalidate();
        }
        // Chuyển hướng về trang homepage hoặc login tùy ý
        response.sendRedirect("LandingPage.jsp");
    }
}
