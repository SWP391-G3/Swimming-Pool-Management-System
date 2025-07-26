package controller.manager;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import dao.manager.ManagerDashboardDAO;
import model.customer.User;
import model.manager.Branch;
import model.manager.CustomerTrend;
import model.manager.DashboardStats;
import model.manager.PoolStats;
import model.manager.RevenueChart;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.*;

@WebServlet(name = "ManagerDashBoardServlet", urlPatterns = {"/managerDashBoardServlet"})
public class ManagerDashBoardServlet extends HttpServlet {

    private ManagerDashboardDAO dao;
    private Gson gson;

    @Override
    public void init() throws ServletException {
        dao = new ManagerDashboardDAO();
        gson = new GsonBuilder()
                .setDateFormat("yyyy-MM-dd HH:mm:ss")
                .create();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("managerAccount");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int branchId = 0;
        int managerId = currentUser.getUser_id();

        // Xác định branch dựa trên user ID
        switch (managerId) {
            case 2:
                branchId = 1; // Hà Nội
                break;
            case 3:
                branchId = 2; // Hồ Chí Minh
                break;
            case 4:
                branchId = 3; // Đà Nẵng
                break;
            case 5:
                branchId = 4; // Quy Nhơn
                break;
            case 6:
                branchId = 5; // Cần Thơ
                break;
            default:
                handleError(request, response, "Bạn không có quyền truy cập chi nhánh nào!");
                return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            action = "dashboard";
        }

        try {
            switch (action) {
                case "dashboard":
                    showManagerDashboard(request, response, managerId, branchId);
                    break;
                case "revenue-data":
                    getRevenueData(request, response, branchId);
                    break;
                case "pool-performance":
                    getPoolPerformanceData(request, response, branchId);
                    break;
                case "customer-trend":
                    getCustomerTrendData(request, response, branchId);
                    break;
                case "peak-hour":
                    getPeakHourData(request, response, branchId);
                    break;
                case "pool-details":
                    getPoolDetailsData(request, response, branchId);
                    break;
                case "booking-status":
                    getBookingStatusData(request, response, branchId);
                    break;
                case "top-customers":
                    getTopCustomersData(request, response, branchId);
                    break;
                case "summary":
                    getSummaryData(request, response, branchId);
                    break;
                default:
                    showManagerDashboard(request, response, managerId, branchId);
            }
        } catch (SQLException e) {
            sendJsonError(response, "Lỗi kết nối cơ sở dữ liệu: " + e.getMessage());
        } catch (Exception e) {
            sendJsonError(response, "Lỗi hệ thống: " + e.getMessage());
        }
    }

    private void showManagerDashboard(HttpServletRequest request, HttpServletResponse response,
            int managerId, int branchId) throws ServletException, IOException, SQLException {

        // Lấy chi nhánh của manager
        Branch branch = dao.getBranchByManager(managerId);

        if (branch == null) {
            branch = new Branch();
            branch.setBranchId(branchId);
            switch (branchId) {
                case 1:
                    branch.setBranchName("Chi nhánh Hà Nội");
                    break;
                case 2:
                    branch.setBranchName("Chi nhánh Hồ Chí Minh");
                    break;
                case 3:
                    branch.setBranchName("Chi nhánh Đà Nẵng");
                    break;
                case 4:
                    branch.setBranchName("Chi nhánh Quy Nhơn");
                    break;
                case 5:
                    branch.setBranchName("Chi nhánh Cần Thơ");
                    break;
                default:
                    branch.setBranchName("Chi nhánh");
            }
            branch.setManagerName("Poweye");
        }
        request.setAttribute("branch", branch);

        String period = request.getParameter("period");
        if (period == null) {
            period = "monthly";
        }

        DashboardStats stats = dao.getBranchStats(branchId, period);
        request.setAttribute("stats", stats);

        List<PoolStats> poolStats = dao.getPoolStatsInBranch(branchId, period);
        request.setAttribute("poolStats", poolStats);

        List<RevenueChart> revenueData = dao.getRevenueByPeriod(branchId, period);
        request.setAttribute("revenueData", revenueData);

        if (stats != null) {
            DashboardStats previousStats = new DashboardStats();
            previousStats.setTotalRevenue(stats.getPreviousRevenue());
            previousStats.setTotalBookings(stats.getPreviousBookings());
            previousStats.setTotalCustomers(stats.getPreviousCustomers());
            request.setAttribute("previousStats", previousStats);
        }

        request.setAttribute("selectedPeriod", period);
        //request.setAttribute("currentUser", "Poweye");
        request.setAttribute("currentUser", branch.getManagerName());

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        sdf.setTimeZone(java.util.TimeZone.getTimeZone("UTC"));
        request.setAttribute("currentDateTimeUTC", sdf.format(new Date()));
        request.setAttribute("currentDateTime", new Date());

        request.getRequestDispatcher("managerDashBoard.jsp").forward(request, response);
    }

    private void getRevenueData(HttpServletRequest request, HttpServletResponse response,
            int branchId) throws IOException, SQLException {
        String period = request.getParameter("period");
        if (period == null) {
            period = "monthly";
        }
        List<RevenueChart> revenueData = dao.getRevenueByPeriod(branchId, period);
        sendJsonResponse(response, revenueData);
    }

    private void getPoolPerformanceData(HttpServletRequest request, HttpServletResponse response,
            int branchId) throws IOException, SQLException {
        String period = request.getParameter("period");
        if (period == null) {
            period = "monthly";
        }
        List<RevenueChart> poolPerformance = dao.getPoolPerformanceComparison(branchId, period);
        sendJsonResponse(response, poolPerformance);
    }

    private void getCustomerTrendData(HttpServletRequest request, HttpServletResponse response,
            int branchId) throws IOException, SQLException {
        String period = request.getParameter("period");
        if (period == null) {
            period = "monthly";
        }
        List<CustomerTrend> customerTrend = dao.getCustomerTrendByBranch(branchId, period);
        sendJsonResponse(response, customerTrend);
    }

    private void getPeakHourData(HttpServletRequest request, HttpServletResponse response,
            int branchId) throws IOException, SQLException {
        List<RevenueChart> peakHourData = dao.getPeakHourAnalysis(branchId);
        sendJsonResponse(response, peakHourData);
    }

    private void getPoolDetailsData(HttpServletRequest request, HttpServletResponse response,
            int branchId) throws IOException, SQLException {
        String period = request.getParameter("period");
        if (period == null) {
            period = "monthly";
        }
        List<PoolStats> poolStats = dao.getPoolStatsInBranch(branchId, period);
        sendJsonResponse(response, poolStats);
    }

    private void getBookingStatusData(HttpServletRequest request, HttpServletResponse response,
            int branchId) throws IOException, SQLException {
        List<RevenueChart> bookingStatus = dao.getBookingStatusStats(branchId);
        sendJsonResponse(response, bookingStatus);
    }

    private void getTopCustomersData(HttpServletRequest request, HttpServletResponse response,
            int branchId) throws IOException, SQLException {
        int limit = 10;
        String limitParam = request.getParameter("limit");
        if (limitParam != null) {
            try {
                limit = Integer.parseInt(limitParam);
            } catch (NumberFormatException e) {
                limit = 10;
            }
        }
        List<RevenueChart> topCustomers = dao.getTopCustomers(branchId, limit);
        sendJsonResponse(response, topCustomers);
    }

    private void getSummaryData(HttpServletRequest request, HttpServletResponse response,
            int branchId) throws IOException, SQLException {
        String period = request.getParameter("period");
        if (period == null) {
            period = "monthly";
        }
        Map<String, Object> summary = new HashMap<>();
        DashboardStats stats = dao.getBranchStats(branchId, period);
        summary.put("stats", stats);
        List<PoolStats> poolStats = dao.getPoolStatsInBranch(branchId, period);
        summary.put("poolStats", poolStats);
        if (poolStats != null && !poolStats.isEmpty()) {
            double avgUtilization = poolStats.stream()
                    .mapToDouble(PoolStats::getUtilizationRate)
                    .average()
                    .orElse(0.0);
            summary.put("avgUtilization", avgUtilization);
            long activePools = poolStats.stream()
                    .filter(p -> "Active".equals(p.getStatus()))
                    .count();
            summary.put("activePools", activePools);
        }
        summary.put("timestamp", new Date());
        summary.put("period", period);
        sendJsonResponse(response, summary);
    }

    private void sendJsonResponse(HttpServletResponse response, Object data) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(data));
    }

    private void handleError(HttpServletRequest request, HttpServletResponse response,
            String errorMessage) throws ServletException, IOException {
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("managerError.jsp").forward(request, response);
    }

    private void sendJsonError(HttpServletResponse response, String message) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"error\": \"" + message.replace("\"", "\\\"") + "\"}");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
