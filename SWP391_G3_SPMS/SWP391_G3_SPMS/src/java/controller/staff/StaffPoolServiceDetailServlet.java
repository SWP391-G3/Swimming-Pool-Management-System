package controller.staff;

import dao.customer.PoolDAO;
import dao.manager.PoolServiceDAO;
import dao.staff.StaffDAO;
import model.customer.Pool;
import model.manager.PoolService;
import model.customer.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.manager.Staff;

@WebServlet("/staffPoolServiceDetail")
public class StaffPoolServiceDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        String poolName = null;
        StaffDAO staffDAO = new StaffDAO(); // hoặc inject qua DI
        Staff staff = staffDAO.getStaffById(currentUser.getUser_id());
        if (currentUser != null) {
            if (staff != null) {
                poolName = staff.getPoolName();
            }
        }
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            response.sendRedirect("staffPoolService");
            return;
        }

        try {
            PoolServiceDAO dao = new PoolServiceDAO();
            PoolDAO poolDAO = new PoolDAO();

            int id = Integer.parseInt(idStr);
            PoolService ps = dao.getById(id);

            request.setAttribute("poolService", ps);
            request.setAttribute("poolName", poolName);
            // Có thể gửi poolList nếu muốn
            request.getRequestDispatcher("staffPoolServiceDetail.jsp").forward(request, response);

        } catch (SQLException | NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        int serviceId = Integer.parseInt(request.getParameter("serviceId"));
        String serviceName = request.getParameter("serviceName");
        int poolId = Integer.parseInt(request.getParameter("poolId"));
        int branchId = 0;
        String poolName = null;
        if (currentUser != null) {
            StaffDAO staffDAO = new StaffDAO(); // hoặc inject qua DI
            Staff staff = staffDAO.getStaffById(currentUser.getUser_id());
            if (staff != null) {
                branchId = staff.getBranchId();
                poolName = staff.getPoolName();
            } else {
            }
        }
        String reportReason = request.getParameter("reportReason");
        String suggestion = request.getParameter("suggestion");
        int staffId = currentUser.getUser_id();

        // Lưu báo cáo dịch vụ
        StaffDAO staffDao = new StaffDAO();
        boolean success = staffDao.addServiceReport(
                staffId, poolId, branchId, serviceId, serviceName, reportReason, suggestion
        );

        // Load lại thông tin dịch vụ
        PoolServiceDAO dao = new PoolServiceDAO();
        PoolService poolService = null;
        try {
            poolService = dao.getById(serviceId);
        } catch (SQLException ex) {
            Logger.getLogger(StaffPoolServiceDetailServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        request.setAttribute("poolService", poolService);
        request.setAttribute("poolName", poolName);

        // Thông báo
        String message = success ? "Gửi báo cáo dịch vụ thành công!" : "Đã xảy ra lỗi, vui lòng thử lại.";
        request.setAttribute("reportMessage", message);

        // Forward lại trang detail
        request.getRequestDispatcher("staffPoolServiceDetail.jsp").forward(request, response);
    }
}
