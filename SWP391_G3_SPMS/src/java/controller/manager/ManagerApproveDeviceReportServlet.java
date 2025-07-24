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

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "ManagerApproveDeviceReportServlet", urlPatterns = {"/managerApproveDeviceReportServlet"})
public class ManagerApproveDeviceReportServlet extends HttpServlet {

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
            out.println("<title>Servlet ManagerApproveDeviceReportServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerApproveDeviceReportServlet at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
    }

    
     @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String reportIdRaw = request.getParameter("reportId");
        int reportId = (reportIdRaw != null && !reportIdRaw.isEmpty()) ? Integer.parseInt(reportIdRaw) : 0;

        DeviceDao dao = new DeviceDao();

        boolean success = false;
        if (reportId > 0) {
            success = dao.approveReport(reportId); // Phương thức này cập nhật trạng thái thành 'done'
        }

        // Trả về lại danh sách báo cáo, giữ filter/phân trang
        String redirectUrl = "managerListDeviceReportServlet?";
        redirectUrl += "poolId=" + (request.getParameter("poolId") != null ? request.getParameter("poolId") : "");
        redirectUrl += "&keyword=" + (request.getParameter("keyword") != null ? request.getParameter("keyword") : "");
        redirectUrl += "&status=" + (request.getParameter("status") != null ? request.getParameter("status") : "");
        redirectUrl += "&page=" + (request.getParameter("page") != null ? request.getParameter("page") : "1");
        redirectUrl += "&pageSize=" + (request.getParameter("pageSize") != null ? request.getParameter("pageSize") : "10");
        if (success) {
            request.getSession().setAttribute("updateSuccess", "Duyệt báo cáo thành công!");
        } else {
            request.getSession().setAttribute("updateError", "Có lỗi khi duyệt báo cáo!");
        }
        response.sendRedirect(redirectUrl);
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
