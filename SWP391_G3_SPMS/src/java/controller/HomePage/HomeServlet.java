/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.HomePage;

import dao.customer.FeedbackHomepageDAO;
import dao.customer.PoolDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.customer.FeedbackHomepage;
import model.customer.Pool;
import model.customer.User;

@WebServlet(name = "HomeServlet", urlPatterns = {"/home"})
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        PoolDAO dao = new PoolDAO();
        FeedbackHomepageDAO fdao = new FeedbackHomepageDAO();
        List<Pool> list = dao.getTop3();
        List<Pool> list2 = dao.getPoolImage();
        List<FeedbackHomepage> listFeedback = fdao.getFeedback();
        User user = (User) session.getAttribute("currentUser");
        request.setAttribute("listPool", list);
        request.setAttribute("listPool2", list2);
        request.setAttribute("listPool3", listFeedback);
        session.setAttribute("currentUser", user);
        request.getRequestDispatcher("HomePage.jsp").forward(request, response);
    }

}
