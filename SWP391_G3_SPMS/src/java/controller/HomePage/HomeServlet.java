package controller.HomePage;

import dao.FeedbackDAO;
import dao.PoolDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Feedback;
import model.Pool;

public class HomeServlet extends HttpServlet { 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PoolDAO dao = new PoolDAO();
        FeedbackDAO fdao = new FeedbackDAO();
        List<Pool> list = dao.getTop3();
        List<Pool> list2 = dao.getPoolImage();
        List<Feedback> listFeedback = fdao.getFeedback();
        request.setAttribute("listPool", list);
        request.setAttribute("listPool2", list2);
        request.setAttribute("listPool3", listFeedback);
        request.getRequestDispatcher("HomePage.jsp").forward(request, response);
    } 
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        doGet(request, response);
    }

}