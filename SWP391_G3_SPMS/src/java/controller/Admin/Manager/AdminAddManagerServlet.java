/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin.Manager;

import dao.admin.ManagerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;
import model.User;
import model.admin.Branch;
import util.PasswordEncryption;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "AdminAddManagerServlet", urlPatterns = {"/adminAddManager"})
public class AdminAddManagerServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminAddManagerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminAddManagerServlet at " + request.getContextPath() + "</h1>");
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
        ManagerDAO managerDAO = new ManagerDAO();
        List<Branch> availableBranchs = managerDAO.getAvailableBranches();

        request.setAttribute("availableBranchs", availableBranchs);
        request.getRequestDispatcher("adminAddManager.jsp").forward(request, response);
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
        request.setCharacterEncoding("UTF-8");

        // Lấy dữ liệu từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("full_name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String dobStr = request.getParameter("dob"); // yyyy-MM-dd
        String gender = request.getParameter("gender");
        int branchId = Integer.parseInt(request.getParameter("branch_id"));

        // Parse dob -> java.sql.Date
        java.sql.Date dob = null;
        try {
            if (dobStr != null && !dobStr.isEmpty()) {
                dob = java.sql.Date.valueOf(dobStr); // convert từ chuỗi yyyy-MM-dd
            }
        } catch (IllegalArgumentException e) {
            dob = null;
        }

        // Tạo đối tượng User
        User managerUser = new User();
        managerUser.setUsername(username);
        managerUser.setPassword(PasswordEncryption.hashPassword(password));
        managerUser.setFull_name(fullName);
        managerUser.setEmail(email);
        managerUser.setPhone(phone);
        managerUser.setAddress(address);
        managerUser.setDob(dob);
        managerUser.setGender(gender);

        // Gọi DAO
        ManagerDAO dao = new ManagerDAO();
        int userId = dao.insertManagerUser(managerUser);

        boolean success = false;
        if (userId > 0) {
            success = dao.assignManagerToBranch(userId, branchId);
        }

        // Điều hướng
        if (success) {
            response.sendRedirect("adminViewManagerList");
        } else {
            List<Branch> availableBranches = dao.getAvailableBranches();
            request.setAttribute("availableBranches", availableBranches);
            request.setAttribute("error", "Thêm mới thất bại! Có thể chi nhánh đã có người quản lý hoặc lỗi dữ liệu.");
            request.getRequestDispatcher("adminAddManager.jsp").forward(request, response);
        }
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
