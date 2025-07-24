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
import model.customer.User;
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
        String dobStr = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String branchIdRaw = request.getParameter("branchId");

        ManagerDAO dao = new ManagerDAO();

        // Kiểm tra chi nhánh
        if (branchIdRaw == null || branchIdRaw.isEmpty()) {
            request.setAttribute("error", "Vui lòng chọn chi nhánh quản lý.");
            request.setAttribute("availableBranchs", dao.getAvailableBranches());
            request.getRequestDispatcher("adminAddManager.jsp").forward(request, response);
            return;
        }

        int branchId = Integer.parseInt(branchIdRaw);

        // Parse ngày sinh
        java.sql.Date dob = null;
        try {
            if (dobStr != null && !dobStr.isEmpty()) {
                dob = java.sql.Date.valueOf(dobStr);
            }
        } catch (IllegalArgumentException e) {
            dob = null;
        }

        // Kiểm tra username đã tồn tại chưa
        if (dao.isUsernameExists(username)) {
            request.setAttribute("availableBranchs", dao.getAvailableBranches());
            request.setAttribute("error", "Tên đăng nhập đã tồn tại, vui lòng chọn tên khác.");
            request.getRequestDispatcher("adminAddManager.jsp").forward(request, response);
            return;
        }

        // Kiểm tra email đã tồn tại chưa
        if (dao.isEmailExists(email)) {
            request.setAttribute("availableBranchs", dao.getAvailableBranches());
            request.setAttribute("error", "Email đã tồn tại, vui lòng sử dụng email khác.");
            request.getRequestDispatcher("adminAddManager.jsp").forward(request, response);
            return;
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

        // Thêm user và gán chi nhánh
        int userId = dao.insertManagerUser(managerUser);
        boolean success = false;
        if (userId > 0) {
            success = dao.assignManagerToBranch(userId, branchId);
        }

        if (success) {
            response.sendRedirect("adminViewManagerList");
        } else {
            request.setAttribute("availableBranchs", dao.getAvailableBranches());
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
