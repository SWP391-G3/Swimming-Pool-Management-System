package controller.poolist;

import dao.customer.FeedbackDAO;
import dao.customer.PoolServiceDAO;
import dao.customer.PoolsCustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;
import model.customer.Feedback;
import model.customer.PoolService;
import model.customer.PoolsCustomer;

@WebServlet("/pool-detail")
public class PoolDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String poolIdStr = request.getParameter("poolId");
        if (poolIdStr == null || poolIdStr.isEmpty()) {
            response.sendRedirect("homepage");
            return;
        }
        try {
            int poolId = Integer.parseInt(poolIdStr);
            PoolsCustomerDAO dao = new PoolsCustomerDAO();
            PoolsCustomer pool = dao.getPoolById(poolId);
            if (pool == null) {

                response.sendRedirect("homepage");
                return;
            }

            // Lấy services và feedbacks
            PoolServiceDAO serviceDAO = new PoolServiceDAO();
            List<PoolService> services = serviceDAO.getServicesByPoolId(poolId);

            FeedbackDAO feedbackDAO = new FeedbackDAO();
            List<Feedback> feedbacks = feedbackDAO.getFeedbacksByPoolId(poolId);

            request.setAttribute("pool", pool);
            request.setAttribute("services", services);
            request.setAttribute("feedbacks", feedbacks);
            request.getRequestDispatcher("pool-detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("homepage");
        }
    }
}
