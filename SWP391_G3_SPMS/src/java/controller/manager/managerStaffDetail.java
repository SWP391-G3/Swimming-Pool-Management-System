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
import model.manager.Staff;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "managerStaffDetail", urlPatterns = {"/managerStaffDetail"})
public class managerStaffDetail extends HttpServlet {

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
            out.println("<title>Servlet managerStaffDetail</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet managerStaffDetail at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String userIdRaw = request.getParameter("userId");
        if (userIdRaw == null) {
            response.setStatus(400);
            response.getWriter().write("Thiếu userId");
            return;
        }
        int userId = Integer.parseInt(userIdRaw);
        StaffDAO staffDAO = new StaffDAO(); // truyền connection nếu cần
        Staff staff = staffDAO.getStaffById(userId);
        if (staff == null) {
            response.setStatus(404);
            response.getWriter().write("Không tìm thấy nhân viên");
            return;
        }
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        out.println("<div class='staff-detail'>");
        out.println("<div><strong>ID:</strong> " + staff.getUserId() + "</div>");
        out.println("<div><strong>Họ tên:</strong> " + staff.getFullName() + "</div>");
        out.println("<div><strong>Email:</strong> " + staff.getEmail() + "</div>");
        out.println("<div><strong>Điện thoại:</strong> " + staff.getPhone() + "</div>");
        out.println("<div><strong>Chi nhánh:</strong> " + staff.getBranchName() + "</div>");
        out.println("<div><strong>Hồ bơi:</strong> " + (staff.getPoolName() != null ? staff.getPoolName() : "Chưa phân vào hồ bơi") + "</div>");
        out.println("<div><strong>Tên công việc:</strong> " + staff.getTypeName() + "</div>");
        out.println("<div><strong>Trạng thái:</strong> " + (staff.getStatus() == 1 ? "Đang hoạt động" : "Đã khóa") + "</div>");
        // Thêm các thông tin cần thiết khác ở đây
        out.println("</div>");
        
    }

        @Override
        protected void doPost
        (HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            processRequest(request, response);
        }

        /**
         * Returns a short description of the servlet.
         *
         * @return a String containing servlet description
         */
        @Override
        public String getServletInfo
        
            () {
        return "Short description";
        }// </editor-fold>

    }
