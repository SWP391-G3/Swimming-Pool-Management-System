/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dao.manager.StaffDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import model.User;
import model.manager.PoolTicket;
import model.manager.Staff;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "managerStaff", urlPatterns = {"/managerStaff"})
public class managerStaff extends HttpServlet {

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
            out.println("<title>Servlet managerStaff</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet managerStaff at " + request.getContextPath() + "</h1>");
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
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int managerId = currentUser.getUser_id();

        String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
        String status = request.getParameter("status") != null ? request.getParameter("status") : "";
        String poolId = request.getParameter("poolId") != null ? request.getParameter("poolId") : "all";

        int page = 1;
        int pageSize = 2;
        if (request.getParameter("page") != null) {
            try {
                page = Integer.parseInt(request.getParameter("page"));
            } catch (Exception ignored) {
            }
        }

        try {
            StaffDAO staffDAO = new StaffDAO(/* truyền connection ở đây, ví dụ: DBUtils.getConnection() */);
            int totalStaff = staffDAO.countStaff(managerId, keyword, status, poolId);
            int totalPages = (int) Math.ceil(totalStaff * 1.0 / pageSize);
            int offset = (page - 1) * pageSize;

            List<Staff> staffList = staffDAO.getStaffs(managerId, keyword, status, poolId, offset, pageSize);
            List<PoolTicket> poolList = staffDAO.getPoolsByManager(managerId);

            request.setAttribute("staffList", staffList);
            request.setAttribute("poolList", poolList);
            request.setAttribute("page", page);
            request.setAttribute("endP", totalPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("keyword", keyword);
            request.setAttribute("status", status);
            request.setAttribute("poolId", poolId);
            

            request.getRequestDispatcher("/managerStaffInfo.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi truy xuất dữ liệu");
            request.getRequestDispatcher("/managerStaffInfo.jsp").forward(request, response);
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
        processRequest(request, response);
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
