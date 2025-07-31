package controller.manager;

import dao.customer.PoolDAO;
import dao.manager.PoolServiceDAO;
import model.customer.Pool;
import model.manager.ServiceReport;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import model.customer.User;

@WebServlet("/service-reports")
public class ServiceReportListServlet extends HttpServlet {

    private final PoolServiceDAO poolServiceDAO = new PoolServiceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            PoolDAO poolDAO = new PoolDAO();
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("managerAccount");
            int branchId = 0;
            if (currentUser != null) {
                int currentUser_id = currentUser.getUser_id();
                switch (currentUser_id) {
                    case 2:
                        branchId = 1;
                        break; // hà nội
                    case 3:
                        branchId = 2;
                        break; // hồ chí minh
                    case 4:
                        branchId = 3;
                        break; // đà nẵng
                    case 5:
                        branchId = 4;
                        break; // quy nhơn
                    case 6:
                        branchId = 5;
                        break; // cần thơ
                    default:
                        throw new AssertionError();
                }
            }
            List<Pool> poolList = poolDAO.getPoolsByBranchId(branchId);

            // Lấy filter từ request
            String name = request.getParameter("name");
            String poolIdStr = request.getParameter("poolId");
            String status = request.getParameter("status"); // Lấy trạng thái từ request
            String pageStr = request.getParameter("page");
            String pageSizeStr = request.getParameter("pageSize");
            Integer poolId = null;
            if (poolIdStr != null && !poolIdStr.isEmpty()) {
                try {
                    poolId = Integer.parseInt(poolIdStr);
                } catch (NumberFormatException ignore) {
                }
            }
            int page = 1, pageSize = 5;
            try {
                if (pageStr != null && !pageStr.isEmpty()) {
                    page = Integer.parseInt(pageStr);
                }
                if (pageSizeStr != null && !pageSizeStr.isEmpty()) {
                    pageSize = Integer.parseInt(pageSizeStr);
                }
            } catch (NumberFormatException ignore) {
            }

            int offset = (page - 1) * pageSize;

            // Gọi DAO, thêm tham số lọc status
            List<ServiceReport> list = poolServiceDAO.filterServiceReports(name, poolId, status,branchId, offset, pageSize);
            int total = poolServiceDAO.countServiceReports(name, poolId, status, branchId);
            int endPage = (int) Math.ceil((double) total / pageSize);

            request.setAttribute("list", list);
            request.setAttribute("page", page);
            request.setAttribute("endPage", endPage);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("name", name == null ? "" : name);
            request.setAttribute("poolId", poolIdStr == null ? "" : poolIdStr);
            request.setAttribute("poolList", poolList);
            request.setAttribute("status", status == null ? "" : status); // Truyền status về UI
            request.getRequestDispatcher("serviceReportList.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        try {
            if ("done".equals(action)) {
                String idRaw = request.getParameter("id");
                if (idRaw == null || idRaw.trim().isEmpty()) {
                    response.getWriter().write("{\"success\":false,\"message\":\"Thiếu id báo cáo\"}");
                    return;
                }
                int reportId;
                try {
                    reportId = Integer.parseInt(idRaw.trim());
                } catch (NumberFormatException e) {
                    response.getWriter().write("{\"success\":false,\"message\":\"ID không hợp lệ\"}");
                    return;
                }
                boolean ok = poolServiceDAO.updateReportStatus(reportId, "done");
                if (ok) {
                    response.getWriter().write("{\"success\":true,\"message\":\"Đã duyệt báo cáo\"}");
                } else {
                    response.getWriter().write("{\"success\":false,\"message\":\"Không tìm thấy hoặc không thể cập nhật báo cáo\"}");
                }
                return;
            }

            // Có thể bổ sung các action khác nếu cần
            response.getWriter().write("{\"success\":false,\"message\":\"Action không hợp lệ\"}");
        } catch (Exception ex) {
            ex.printStackTrace();
            response.getWriter().write("{\"success\":false,\"message\":\"Lỗi hệ thống: " + ex.getMessage() + "\"}");
        }
    }
}
