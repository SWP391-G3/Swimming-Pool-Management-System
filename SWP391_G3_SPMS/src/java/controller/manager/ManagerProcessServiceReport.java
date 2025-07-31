package controller.manager;

import dao.manager.PoolServiceDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import model.customer.PoolService;
import model.customer.User;
import model.manager.ServiceReport;

@WebServlet(name = "ManagerProcessServiceReport", urlPatterns = {"/ManagerProcessServiceReport"})
public class ManagerProcessServiceReport extends HttpServlet {

    private final PoolServiceDAO dao = new PoolServiceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String reportIdRaw = request.getParameter("reportId");
            int reportId = 0;
            if (reportIdRaw != null && !reportIdRaw.trim().isEmpty()) {
                reportId = Integer.parseInt(reportIdRaw.trim());
            }
            ServiceReport report = dao.getReportById(reportId);
            List<ServiceReport> serviceReportsHistory = null;
            model.manager.PoolService service = null;
            if (report != null && report.getPoolId() != 0) {
                serviceReportsHistory = dao.getReportsByPoolId(report.getPoolId());
                service = dao.getById(report.getServiceId()); 
            }
            request.setAttribute("report", report);
            request.setAttribute("serviceReportsHistory", serviceReportsHistory);
            request.setAttribute("service", service); // Truyền PoolService vào JSP
            request.getRequestDispatcher("ManagerServiceProcess.jsp").forward(request, response);
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi lấy báo cáo: " + e.getMessage());
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu không hợp lệ: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String reportIdRaw = request.getParameter("reportId");
            int reportId = Integer.parseInt(reportIdRaw.trim());
            String managerNote = request.getParameter("managerNote");
            String serviceStatus = request.getParameter("serviceStatus");
            String quantityRaw = request.getParameter("quantity");
            int quantity = Integer.parseInt(quantityRaw.trim());

            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("managerAccount");
            int managerId = (currentUser != null) ? currentUser.getRole_id(): 0;
            if (managerId == 0) {
                response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Vui lòng đăng nhập để xử lý báo cáo.");
                return;
            }

//            int branchId = 0;
//            if (currentUser != null) {
//                switch (currentUser.getUser_id()) {
//                    case 2: branchId = 1; break; // Hà Nội
//                    case 3: branchId = 2; break; // Hồ Chí Minh
//                    case 4: branchId = 3; break; // Đà Nẵng
//                    case 5: branchId = 4; break; // Quy Nhơn
//                    case 6: branchId = 5; break; // Cần Thơ
//                    default: throw new AssertionError();
//                }
//            }

            ServiceReport report = dao.getReportById(reportId);
            if (report != null) {
                dao.updateManagerNote(reportId, managerNote, managerId);
                dao.approveReport(reportId);
                dao.updatePoolService(report.getServiceId(), serviceStatus, quantity); // Cập nhật trạng thái và số lượng
            }

            session.setAttribute("updateSuccess", "Đã xử lý báo cáo dịch vụ thành công!");
            response.sendRedirect("managerListServiceReportServlet");
        } catch (SQLException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Lỗi khi xử lý báo cáo: " + e.getMessage());
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Dữ liệu không hợp lệ: " + e.getMessage());
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet để xử lý báo cáo dịch vụ của quản lý";
    }
}