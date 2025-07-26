package controller.Staff;

import dao.manager.DeviceDao;
import model.customer.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import model.staff.DeviceReport;

@WebServlet("/staffDeviceReport")
public class StaffDeviceReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("staffAccount");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int staffId = currentUser.getUser_id();

        String status = request.getParameter("status");
        String pageStr = request.getParameter("page");
        String pageSizeStr = request.getParameter("pageSize");
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

        try {
            DeviceDao dao = new DeviceDao();
            List<DeviceReport> reportList = dao.filterDeviceReportsByStaff(staffId, status, offset, pageSize);
            int totalRecords = dao.countDeviceReportsByStaff(staffId, status);
            int endPage = (int) Math.ceil((double) totalRecords / pageSize);

            request.setAttribute("reportList", reportList);
            request.setAttribute("page", page);
            request.setAttribute("endPage", endPage);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("status", status);

            request.setAttribute("activeMenu", "device-history");
            request.getRequestDispatcher("staffDeviceReport.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }
}
