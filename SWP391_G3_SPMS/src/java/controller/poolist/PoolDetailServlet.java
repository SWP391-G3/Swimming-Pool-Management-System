package controller.poolist;

import dao.PoolsCustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.PoolsCustomer;

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
            request.setAttribute("pool", pool);
            request.getRequestDispatcher("pool-detail.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("homepage");
        }
    }
}
