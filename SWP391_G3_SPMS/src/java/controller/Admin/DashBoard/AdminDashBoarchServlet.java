/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin.DashBoard;

import dao.admin.DashboardDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import model.admin.BookingSummary;
import model.admin.BookingTrendStats;
import model.admin.Branch;
import model.admin.BranchStaffStats;
import model.admin.CustomerJoinStats;
import model.admin.CustomerPoolFeedback;
import model.admin.DashboardStats;
import model.admin.DeviceStatusStats;
import model.admin.PoolStatusStats;
import model.admin.RevenueBranchByMonth;
import model.admin.RevenueByMonth;
import model.admin.ServiceTotalStats;
import model.admin.TotalRevenue;
import model.admin.TotalServiceUsage;
import model.admin.TotalTicketUsage;
import model.admin.UserCountByRole;
import model.admin.UserDetails;
import model.admin.UserGrowth;
import model.admin.VoucherUsage;
import model.customer.Pool;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "AdminDashBoarchServlet", urlPatterns = {"/adminDashBoard"})
public class AdminDashBoarchServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminDashBoarchServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminDashBoarchServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DashboardDAO dao = new DashboardDAO();
        DashboardStats ds = dao.getDashboardStats();
        RevenueByMonth rm = dao.getRevenueByMonth();
        UserGrowth ug = dao.getUserGrowthByMonth();
        PoolStatusStats ps = dao.getPoolStatusStats();
        BookingTrendStats bt = dao.getBookingTrendThisWeek();
        UserCountByRole uc = dao.getUserCountByRole();
        DeviceStatusStats de = dao.getDeviceStatusStats();
        UserDetails ud = dao.getUserDetails();
        List<TotalServiceUsage> totalServiceUsageByMonth = dao.getTotalServiceUsages();
        List<VoucherUsage> usageList = dao.getVoucherUsageToday();
        List<BookingSummary> listBookingSummarys = dao.getBookingSummarys();
        Map<String, List<BookingSummary>> groupedSummaries = new LinkedHashMap<>();

        for (BookingSummary summary : listBookingSummarys) {
            String key = summary.getPoolName() + " - " + summary.getBranchName();
            groupedSummaries.computeIfAbsent(key, k -> new ArrayList<>()).add(summary);
        }
        List<RevenueBranchByMonth> listBranchByMonths = dao.getRevenueByBranchAndMonth();
        List<Branch> branchs = dao.getAllBranches();
        List<Pool> poolActive = dao.getActivePools();
        List<Pool> poolInactive = dao.getInactivePools();
        List<ServiceTotalStats> st = dao.getAllService();
        List<String> service_name = new ArrayList<>();
        List<Integer> service_total = new ArrayList<>();
        for (ServiceTotalStats item : st) {
            service_name.add(item.getService_name());
            service_total.add(item.getTotal_quantity());
        }
        List<BranchStaffStats> statsList = dao.getBranchStaffStatses();

        Map<String, int[]> branchMap = new LinkedHashMap<>();

        for (BranchStaffStats s : statsList) {
            String name = s.getBranch_name();
            branchMap.putIfAbsent(name, new int[2]);
            if (Boolean.TRUE.equals(s.getStaff_status())) {
                branchMap.get(name)[0] = s.getTotal_staff();
            } else {
                branchMap.get(name)[1] = s.getTotal_staff();
            }
        }

        List<String> labels = new ArrayList<>();
        List<Integer> activeData = new ArrayList<>();
        List<Integer> inactiveData = new ArrayList<>();

        for (Map.Entry<String, int[]> entry : branchMap.entrySet()) {
            labels.add(entry.getKey());
            activeData.add(entry.getValue()[0]);
            inactiveData.add(entry.getValue()[1]);
        }
        CustomerJoinStats cj = dao.getCustomerJoinStats();
        List<TotalTicketUsage> totalTicketUsages = dao.getTotalTicketUsages();
        List<CustomerPoolFeedback> customerPoolFeedbacks = dao.getPoolFeedbacks();
        List<TotalRevenue> listRevenues = dao.getTotalRevenue();
        request.setAttribute("branchLabels", labels);
        request.setAttribute("activeStaffData", activeData);
        request.setAttribute("inactiveStaffData", inactiveData);
        request.setAttribute("ds", ds);
        request.setAttribute("rm", rm);
        request.setAttribute("ug", ug);
        request.setAttribute("ps", ps);
        request.setAttribute("bt", bt);
        request.setAttribute("uc", uc);
        request.setAttribute("de", de);
        request.setAttribute("ud", ud);
        request.setAttribute("service_name", service_name);
        request.setAttribute("service_total", service_total);
        request.setAttribute("poolActive", poolActive);
        request.setAttribute("poolInactive", poolInactive);
        request.setAttribute("listBranchByMonths", listBranchByMonths);
        request.setAttribute("branchList", branchs);
        request.setAttribute("groupedSummaries", groupedSummaries);
        request.setAttribute("usageList", usageList);
        request.setAttribute("totalServiceUsageByMonth", totalServiceUsageByMonth);
        request.setAttribute("totalTicketUsages", totalTicketUsages);
        request.setAttribute("customerPoolFeedbacks", customerPoolFeedbacks);
        request.setAttribute("listRevenues", listRevenues);
        request.setAttribute("cj", cj);
        request.getRequestDispatcher("adminDashBoard.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        DashboardDAO dao = new DashboardDAO();
        CustomerJoinStats cj = dao.getCustomerJoinStats();
        int liveUsers = cj.getTota_customer();
        double avgRating = cj.getAverage_feedking();
        int serviceToday = cj.getTotal_service_today();

        PrintWriter out = response.getWriter();
        out.printf("{\"liveUsers\": %d, \"avgRating\": %.2f, \"serviceToday\": %d}",
                liveUsers, avgRating, serviceToday);
        out.flush();
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
