package controller.poolist;

import dao.customer.FeedbackDAO;
import dao.customer.PoolServiceDAO;
import dao.customer.PoolsCustomerDAO;
import dao.customer.PoolImageDAO; // 👈 import DAO mới

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
            response.sendRedirect("customerViewPoolList");
            return;
        }

        try {
            int poolId = Integer.parseInt(poolIdStr);
            PoolsCustomerDAO dao = new PoolsCustomerDAO();
            PoolsCustomer pool = dao.getPoolById(poolId);
            if (pool == null) {
                response.sendRedirect("customerViewPoolList");
                return;
            }

            // Lấy danh sách ảnh từ bảng PoolImage
            PoolImageDAO imageDAO = new PoolImageDAO();
            List<String> imageList = imageDAO.getImagesByPoolId(poolId);

            // Lấy services và feedbacks
            PoolServiceDAO serviceDAO = new PoolServiceDAO();
            List<PoolService> services = serviceDAO.getServicesByPoolId(poolId);

            FeedbackDAO feedbackDAO = new FeedbackDAO();
            List<Feedback> feedbacks = feedbackDAO.getFeedbacksByPoolId(poolId);

            // Gửi dữ liệu về JSP
            request.setAttribute("pool", pool);
            request.setAttribute("imageList", imageList); // 👈 gửi list ảnh
            request.setAttribute("services", services);
            request.setAttribute("feedbacks", feedbacks);
            request.getRequestDispatcher("pool-detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("customerViewPoolList");
        }
    }
}
