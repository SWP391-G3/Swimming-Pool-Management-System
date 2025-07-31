package controller.Staff;

import dao.manager.PoolServiceDAO;
import dao.manager.StaffDAO;
import model.manager.PoolService;
import model.customer.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import model.manager.Staff;

@WebServlet("/staffPoolService")
public class StaffPoolServiceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("staffAccount");

        String poolName = null;
        StaffDAO staffDAO = new StaffDAO(); // hoặc inject qua DI
        Staff staff = staffDAO.getStaffById(currentUser.getUser_id());
        if (currentUser != null) {
            if (staff != null) {
                poolName = staff.getPoolName();
            }
        }

        try {
            // Lấy danh sách pool staff được phép xem (theo location)
            PoolServiceDAO dao = new PoolServiceDAO();

            // Lọc dữ liệu
            String name = request.getParameter("name");
            String minPriceStr = request.getParameter("minPrice");
            String maxPriceStr = request.getParameter("maxPrice");
            String pageStr = request.getParameter("page");
            String pageSizeStr = request.getParameter("pageSize");
            String poolIdStr = request.getParameter("poolId");

            int page = 1, pageSize = 5;
            try {
                if (pageStr != null && !pageStr.isEmpty()) {
                    page = Integer.parseInt(pageStr);
                }
                if (pageSizeStr != null && !pageSizeStr.isEmpty()) {
                    pageSize = Integer.parseInt(pageSizeStr);
                }
            } catch (NumberFormatException ex) {
                page = 1;
                pageSize = 5;
            }

            Double minPrice = null, maxPrice = null;
            try {
                if (minPriceStr != null && !minPriceStr.isEmpty()) {
                    minPrice = Double.parseDouble(minPriceStr);
                }
            } catch (NumberFormatException ignore) {
            }
            try {
                if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                    maxPrice = Double.parseDouble(maxPriceStr);
                }
            } catch (NumberFormatException ignore) {
            }

            int offset = (page - 1) * pageSize;

            List<PoolService> list = dao.filterServicesByPoolName(name, minPrice, maxPrice, poolName, offset, pageSize);
            int totalRecords = dao.countFilteredByPoolName(name, minPrice, maxPrice, poolName);
            int endPage = (int) Math.ceil((double) totalRecords / pageSize);

            request.setAttribute("list", list);
            request.setAttribute("page", page);
            request.setAttribute("endPage", endPage);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("name", name);
            request.setAttribute("minPrice", minPriceStr);
            request.setAttribute("maxPrice", maxPriceStr);
            request.setAttribute("poolId", poolIdStr);
            request.setAttribute("activeMenu", "pool-service");
            request.getRequestDispatcher("staffPoolService.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
