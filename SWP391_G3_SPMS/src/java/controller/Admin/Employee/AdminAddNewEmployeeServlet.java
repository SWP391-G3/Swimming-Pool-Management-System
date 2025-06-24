/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin.Employee;

import com.google.gson.Gson;
import dao.PoolDAO;
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
import java.util.List;
import model.Pool;
import model.admin.Branch;
import model.admin.EmployeeAccount;
import model.admin.StaffType;
import util.PasswordEncryption;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "AdminAddNewEmployeeServlet", urlPatterns = {"/adminAddNewEmployee"})
public class AdminAddNewEmployeeServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminAddNewEmployeeServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminAddNewEmployeeServlet at " + request.getContextPath() + "</h1>");
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

        String branchIdParam = request.getParameter("branchId");

        // AJAX request để lấy danh sách bể bơi theo chi nhánh
        if (branchIdParam != null && !branchIdParam.isEmpty()) {
            try {
                int branchId = Integer.parseInt(branchIdParam);
                PoolDAO pdao = new PoolDAO();
                List<Pool> pools = pdao.getPoolsByBranchId(branchId);

                // Tạo JSON thủ công
                StringBuilder json = new StringBuilder("[");
                for (int i = 0; i < pools.size(); i++) {
                    Pool pool = pools.get(i);
                    json.append("{")
                            .append("\"pool_id\":").append(pool.getPool_id())
                            .append(",\"pool_name\":\"").append(pool.getPool_name().replace("\"", "\\\"")) // Escape quotes
                            .append("\"}");
                    if (i < pools.size() - 1) {
                        json.append(",");
                    }
                }
                json.append("]");

                // Thiết lập response
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(json.toString());
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid branchId");
            }
            return;
        }

        // Truy cập lần đầu: hiển thị form
        EmployeeDAO dao = new EmployeeDAO();
        List<Branch> branches = dao.getAllBranches();
        List<StaffType> staffTypes = dao.getAllStaffTypes();

        request.setAttribute("branches", branches);
        request.setAttribute("staffTypes", staffTypes);
        request.getRequestDispatcher("adminAddNewEmployee.jsp").forward(request, response);
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

        request.setCharacterEncoding("UTF-8"); // Đảm bảo nhận đúng UTF-8

        // 1. Lấy dữ liệu từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String gender = request.getParameter("gender");
        LocalDate dob = LocalDate.parse(request.getParameter("dob"));
        String address = request.getParameter("address");

        int branchId = Integer.parseInt(request.getParameter("branchId"));
        int poolId = Integer.parseInt(request.getParameter("poolId"));
        int staffTypeId = Integer.parseInt(request.getParameter("staffTypeId"));

        // 2. Tạo đối tượng
        EmployeeAccount emp = new EmployeeAccount();
        emp.setUsername(username);
        emp.setPassword(PasswordEncryption.hashPassword(password)); // Nếu cần mã hóa thì xử lý ở đây
        emp.setFullName(fullName);
        emp.setEmail(email);
        emp.setPhone(phone);
        emp.setGender(gender);
        emp.setDob(dob);
        emp.setAddress(address);
        emp.setStatus(true); // mặc định là đang hoạt động
        emp.setBranchId(branchId);
        emp.setPoolId(poolId);
        emp.setStaffTypeId(staffTypeId);

        // 3. Gọi DAO để insert
        EmployeeAccountDAO dao = new EmployeeAccountDAO();
        dao.addNewEmployee(emp);

        // 4. Chuyển hướng hoặc hiển thị thông báo
        response.sendRedirect("adminViewEmployeeList"); // hoặc chuyển về danh sách
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
