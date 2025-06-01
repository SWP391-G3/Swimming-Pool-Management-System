package controller.pool;

import dao.PoolsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import model.Pools;

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
            PoolsDAO dao = new PoolsDAO();
            Pools pool = dao.getPoolById(poolId);
            if (pool == null) {
                // Không tìm thấy bể bơi, quay lại homepage
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
