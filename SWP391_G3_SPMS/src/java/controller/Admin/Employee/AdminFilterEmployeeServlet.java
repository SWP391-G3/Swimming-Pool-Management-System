/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.Admin.Employee;

import dao.admin.EmployeeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.admin.Branch;
import model.admin.Employee;
import model.admin.StaffType;

/**
 *
 * @author Lenovo
 */
@WebServlet(name="AdminFilterEmployeeServlet", urlPatterns={"/adminFilterEmployee"})
public class AdminFilterEmployeeServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
            out.println("<title>Servlet AdminFilterEmployeeServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminFilterEmployeeServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
         String keyword = request.getParameter("keyword");
        String branch = request.getParameter("branch");
        String staffType = request.getParameter("staffType");
        String status = request.getParameter("status");

        // Lấy trang hiện tại
        String pageParam = request.getParameter("page");
        int currentPage = 1;
        if (pageParam != null) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
        }
        int record_per_page = 5;
        int offset = (currentPage - 1) * record_per_page;

        // Gọi DAO
        EmployeeDAO dao = new EmployeeDAO();

        // Lấy dữ liệu lọc và phân trang
        List<Employee> employees = dao.getFilteredEmployeesByPage(keyword, branch, staffType, status, offset, record_per_page);
        
        int totalRecords = dao.getFilteredEmployeeCount(keyword, branch, staffType, status);
        int totalPages = (int) Math.ceil((double) totalRecords / record_per_page);

        // Lấy danh sách chi nhánh và loại nhân viên để đổ dropdown
        List<Branch> branchs = dao.getAllBranches();
        List<StaffType> staffTypes = dao.getAllStaffTypes();

        // Truyền dữ liệu sang JSP
        request.setAttribute("employees", employees);
        request.setAttribute("branchs", branchs);
        request.setAttribute("staffTypes", staffTypes);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        // Để giữ lại dữ liệu lọc đã chọn
        request.setAttribute("keyword", keyword);
        request.setAttribute("branch", branch);
        request.setAttribute("selectedStaffType", staffType);
        request.setAttribute("status", status);

        // Forward sang JSP
        request.getRequestDispatcher("adminFilterEmployee.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
