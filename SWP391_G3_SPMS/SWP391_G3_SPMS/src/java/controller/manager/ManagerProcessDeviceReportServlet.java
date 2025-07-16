/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dao.manager.DeviceDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.customer.User;
import model.manager.Device;
import model.manager.ManagerDeviceReport;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "ManagerProcessDeviceReportServlet", urlPatterns = {"/managerProcessDeviceReportServlet"})
public class ManagerProcessDeviceReportServlet extends HttpServlet {

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
            out.println("<title>Servlet ManagerProcessDeviceReportServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerProcessDeviceReportServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String reportIdRaw = request.getParameter("reportId");
        int reportId = 0;
        if (reportIdRaw != null && !reportIdRaw.trim().isEmpty()) {
            reportId = Integer.parseInt(reportIdRaw.trim());
        }
        DeviceDao dao = new DeviceDao();
        ManagerDeviceReport report = dao.getReportById(reportId);
        Device device = null;
        List<ManagerDeviceReport> deviceReportsHistory = null;
        if (report != null && report.getDeviceId() != null) {
            device = dao.getDeviceById(report.getDeviceId());
            // Lấy lịch sử các báo cáo về thiết bị này
            deviceReportsHistory = dao.getReportsByDeviceId(report.getDeviceId());
        }
        request.setAttribute("report", report);
        request.setAttribute("device", device);
        // Truyền lịch sử báo cáo sang JSP
        request.setAttribute("deviceReportsHistory", deviceReportsHistory);

        request.getRequestDispatcher("managerProcessDeviceReport.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String reportIdRaw = request.getParameter("reportId");
        int reportId = Integer.parseInt(reportIdRaw.trim());
        String deviceStatus = request.getParameter("deviceStatus");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String managerNote = request.getParameter("managerNote");

        // Lấy thông tin manager đang đăng nhập
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
        int managerId = currentUser.getUser_id();

        DeviceDao dao = new DeviceDao();
        ManagerDeviceReport report = dao.getReportById(reportId);

        // Cập nhật trạng thái, số lượng thiết bị (nếu cần)
        Device device = dao.getDeviceById(report.getDeviceId());
        if (device != null) {
            device.setDeviceStatus(deviceStatus);
            device.setQuantity(quantity);
            device.setNotes(managerNote); // nếu muốn lưu cả vào thiết bị
            dao.updateDevice(device);
        }

        // Cập nhật trạng thái báo cáo + ghi chú xử lý
        dao.approveReport(reportId);
        dao.updateManagerNote(reportId, managerNote, managerId);

        request.getSession().setAttribute("updateSuccess", "Đã xử lý báo cáo thành công!");
        response.sendRedirect("managerListDeviceReportServlet");
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
