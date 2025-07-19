/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dao.manager.PoolServiceDAO;
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
import model.manager.ServiceReport;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ManagerListServiceReportServlet", urlPatterns = {"/managerListServiceReportServlet"})
public class ManagerListServiceReportServlet extends HttpServlet {

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
            out.println("<title>Servlet ManagerListServiceReportServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerListServiceReportServlet at " + request.getContextPath() + "</h1>");
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
            HttpSession session = request.getSession();
     
        User currentUser = (User) session.getAttribute("currentUser");
        int branchId = 0;
        if (currentUser != null) {
            int currentUser_id = currentUser.getUser_id();
            switch (currentUser_id) {
                case 2: branchId = 1; break; // Hà Nội
                case 3: branchId = 2; break; // HCM
                case 4: branchId = 3; break; // Đà Nẵng
                case 5: branchId = 4; break; // Quy Nhơn
                case 6: branchId = 5; break; // Cần Thơ
                default: throw new IllegalArgumentException("User không hợp lệ");
            }
        }

        // Nhận tham số
        String name = request.getParameter("name");
        String poolIdStr = request.getParameter("poolId");
        String status = request.getParameter("status");
        String pageStr = request.getParameter("page");
        String pageSizeStr = request.getParameter("pageSize");

        int page = 1, pageSize = 5;
        try {
            if (pageStr != null) page = Math.max(1, Integer.parseInt(pageStr));
        } catch (NumberFormatException ignored) {}
        try {
            if (pageSizeStr != null) pageSize = Math.min(50, Math.max(1, Integer.parseInt(pageSizeStr)));
        } catch (NumberFormatException ignored) {}

        Integer poolId = null;
        if (poolIdStr != null && !poolIdStr.isEmpty()) {
            try {
                poolId = Integer.parseInt(poolIdStr);
            } catch (NumberFormatException ignored) {}
        }

        int offset = (page - 1) * pageSize;

        PoolServiceDAO serviceDAO = new PoolServiceDAO();

        try {
            // Lấy danh sách báo cáo
            List<ServiceReport> list = serviceDAO.filterServiceReports(name, poolId, status, branchId, offset, pageSize);
            int totalReports = serviceDAO.countServiceReports(name, poolId, status, branchId);
            int endPage = (int) Math.ceil((double) totalReports / pageSize);

            // Set dữ liệu
            request.setAttribute("list", list);
            request.setAttribute("name", name);
            request.setAttribute("poolId", poolIdStr);
            request.setAttribute("status", status);
            request.setAttribute("page", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("endPage", endPage);
            request.setAttribute("totalReports", totalReports);

            // Pool list cho dropdown
            request.setAttribute("poolList", serviceDAO.getAllPoolsByBranch(branchId));

            // Forward
            request.getRequestDispatcher("serviceReportList.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi tải danh sách báo cáo dịch vụ.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
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
