/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin.Employee;

import dao.customer.PoolDAO;
import dao.admin.EmployeeAccountDAO;
import dao.admin.EmployeeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import model.customer.Pool;
import model.admin.Branch;
import model.admin.Employee;
import model.admin.EmployeeAccount;
import model.admin.StaffType;
import util.PasswordEncryption;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "AdminEditEmployeeServlet", urlPatterns = {"/adminEditEmployee"})
public class AdminEditEmployeeServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminEditEmployeeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminEditEmployeeServlet at " + request.getContextPath() + "</h1>");
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
        String staffIdRaw = request.getParameter("id");
        int staffId = Integer.parseInt(staffIdRaw);
        String branchIdParam = request.getParameter("branchId");
        int branchId = Integer.parseInt(branchIdParam);
        PoolDAO pdao = new PoolDAO();
        List<Pool> pools = pdao.getPoolsByBranchId(branchId);

        EmployeeDAO dao = new EmployeeDAO();
        EmployeeAccountDAO acdao = new EmployeeAccountDAO();

        // Lấy thông tin tài khoản nhân viên
        EmployeeAccount employee = acdao.getEmployeeAccount(staffId);

        Employee e = dao.getEmployeeById(staffId);
        // Lấy danh sách chi nhánh và loại công việc
        List<Branch> branches = dao.getAllBranches();
        List<StaffType> staffTypes = dao.getAllStaffTypes();

        // Gán dữ liệu vào request
        request.setAttribute("employee", employee);
        request.setAttribute("e", e);
        request.setAttribute("branches", branches);
        request.setAttribute("staffTypes", staffTypes);
        request.setAttribute("pools", pools);

        // Điều hướng tới JSP
        request.getRequestDispatcher("adminEditEmployee.jsp").forward(request, response);
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

        try {
            // Lấy dữ liệu từ form
            int staffId = Integer.parseInt(request.getParameter("employeeId"));
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String gender = request.getParameter("gender");
            String address = request.getParameter("address");
            LocalDate dob = LocalDate.parse(request.getParameter("dob"));
            int branchId = Integer.parseInt(request.getParameter("branchId"));
            int poolId = Integer.parseInt(request.getParameter("poolId"));
            int staffTypeId = Integer.parseInt(request.getParameter("staffTypeId"));

            // Gọi DAO để cập nhật dữ liệu
            EmployeeDAO edao = new EmployeeDAO();

            if (edao.isEmailExists(email)) {
                EmployeeDAO dao = new EmployeeDAO();
                EmployeeAccountDAO acdao = new EmployeeAccountDAO();
                PoolDAO pdao = new PoolDAO();
                List<Pool> pools = pdao.getPoolsByBranchId(branchId);
                EmployeeAccount employee = acdao.getEmployeeAccount(staffId);
                List<Branch> branches = dao.getAllBranches();
                List<StaffType> staffTypes = dao.getAllStaffTypes();
                Employee e = dao.getEmployeeById(staffId);
                String error = "Email đã tồn tại!!!";
                request.setAttribute("error", error);
                request.setAttribute("employee", employee);
                request.setAttribute("e", e);
                request.setAttribute("branches", branches);
                request.setAttribute("staffTypes", staffTypes);
                request.setAttribute("pools", pools);
                request.getRequestDispatcher("adminEditEmployee.jsp").forward(request, response);
                return;
            }

            boolean userUpdated = edao.editUserByStaffId(fullName, email, phone, java.sql.Date.valueOf(dob),
                    gender, address, staffId);
            boolean staffUpdated = edao.editStaffInfo(branchId, poolId, staffTypeId, staffId);

            if (userUpdated && staffUpdated) {
                response.sendRedirect("adminViewEmployeeList");
            } else {
                request.setAttribute("error", "Cập nhật thất bại. Vui lòng thử lại.");
                request.getRequestDispatcher("adminEditEmployee.jsp").forward(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("adminEditEmployee.jsp").forward(request, response);
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
