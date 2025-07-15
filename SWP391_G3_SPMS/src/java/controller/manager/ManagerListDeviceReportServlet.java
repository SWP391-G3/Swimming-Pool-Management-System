package controller.manager;

import dao.manager.DeviceDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.customer.User;
import model.manager.Pooldevice;
import model.manager.ManagerDeviceReport;

@WebServlet(name = "ManagerListDeviceReportServlet", urlPatterns = {"/managerListDeviceReportServlet"})
public class ManagerListDeviceReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        int branchId = 0;
        if (currentUser != null) {
            int currentUser_id = currentUser.getUser_id();
            switch (currentUser_id) {
                case 2:
                    branchId = 1; // hà nội
                    break;
                case 3:
                    branchId = 2; // hồ chí minh
                    break;
                case 4:
                    branchId = 3; // đà nẵng
                    break;
                case 5:
                    branchId = 4; // quy nhơn
                    break;
                case 6:
                    branchId = 5; // cần thơ
                    break;
                default:
                    throw new AssertionError();
            }
        }

        // Lấy tham số từ request
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String poolId = request.getParameter("poolId");
        String pageStr = request.getParameter("page");
        String pageSizeStr = request.getParameter("pageSize");

        // Xử lý phân trang
        int page = 1;
        int pageSize = 5;

        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) {
                    page = 1;
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        if (pageSizeStr != null && !pageSizeStr.isEmpty()) {
            try {
                pageSize = Integer.parseInt(pageSizeStr);
                if (pageSize < 1) {
                    pageSize = 5;
                }
                if (pageSize > 50) {
                    pageSize = 50;
                }
            } catch (NumberFormatException e) {
                pageSize = 5;
            }
        }

        DeviceDao deviceDao = new DeviceDao();

        List<ManagerDeviceReport> reports = deviceDao.getDeviceReports(keyword, status, poolId, page, pageSize, branchId);

        // Lấy tổng số báo cáo để tính phân trang
        int totalReports = deviceDao.getTotalReports(keyword, status, poolId, branchId);
        int totalPages = (int) Math.ceil((double) totalReports / pageSize);

        // Lấy danh sách hồ bơi cho dropdown
        List<Pooldevice> pools = deviceDao.getPoolsByBranchId(branchId);

        System.out.println("=== DEBUG INFO ===");
        System.out.println("Branch ID: " + branchId);
        System.out.println("User ID: " + (currentUser != null ? currentUser.getUser_id() : "null"));
        System.out.println("Reports size: " + reports.size());
        System.out.println("Total count: " + totalReports);
        if (!reports.isEmpty()) {
            ManagerDeviceReport first = reports.get(0);
            System.out.println("First report: ID=" + first.getReportId() + ", Device=" + first.getDeviceName());
        }
        
        // THAY ĐỔI: Sử dụng String thay vì Integer làm key
        Map<String, List<ManagerDeviceReport>> allDevicesReportsHistory = new HashMap<>();
        for (ManagerDeviceReport report : reports) {
            Integer deviceId = report.getDeviceId();
            if (deviceId != null) {
                String deviceIdStr = String.valueOf(deviceId); // Chuyển đổi sang String
                if (!allDevicesReportsHistory.containsKey(deviceIdStr)) {
                    List<ManagerDeviceReport> deviceHistory = deviceDao.getReportsByDeviceId(deviceId);
                    allDevicesReportsHistory.put(deviceIdStr, deviceHistory);
                    
                    // Debug: In ra thông tin lịch sử
                    System.out.println("Device ID: " + deviceIdStr + " has " + deviceHistory.size() + " history reports");
                }
            }
        }
        
        System.out.println("Total devices with history: " + allDevicesReportsHistory.size());
        request.setAttribute("allDevicesReportsHistory", allDevicesReportsHistory);

        // Set attributes
        request.setAttribute("reports", reports);
        request.setAttribute("poolList", pools);
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        request.setAttribute("poolId", poolId);
        request.setAttribute("page", page);
        request.setAttribute("pageSize", pageSize);
        request.setAttribute("endP", totalPages);
        request.setAttribute("totalReports", totalReports);

        // Forward đến JSP
        request.getRequestDispatcher("managerDeviceReport.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}