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
import java.util.List;
import model.admin.Branch;
import model.admin.Manager;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "AdminUpdateManagerServlet", urlPatterns = {"/adminUpdateManager"})
public class AdminUpdateManagerServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminUpdateManagerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminUpdateManagerServlet at " + request.getContextPath() + "</h1>");
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
        int id = Integer.parseInt(request.getParameter("id"));

        ManagerDAO managerDAO = new ManagerDAO();
        Manager manager = managerDAO.getManagerById(id);

        ManagerDAO branchDAO = new ManagerDAO();
        List<Branch> branchList = branchDAO.getAllBranches(); // Lấy từ DB

        request.setAttribute("manager", manager);
        request.setAttribute("branchList", branchList); // Truyền list Branch

        request.getRequestDispatcher("adminUpdateManager.jsp").forward(request, response);
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
        int managerId = Integer.parseInt(request.getParameter("manager_id"));
        String fullName = request.getParameter("full_name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        boolean status = Boolean.parseBoolean(request.getParameter("status"));
        int branchId = Integer.parseInt(request.getParameter("branch_id"));

        // Tạo đối tượng Manager
        Manager manager = new Manager();
        manager.setManager_id(managerId);
        manager.setFull_name(fullName);
        manager.setEmail(email);
        manager.setPhone(phone);
        manager.setAddress(address);
        manager.setStatus(status);
        manager.setBranch_id(branchId);

        ManagerDAO branchDAO = new ManagerDAO();
        List<Branch> branchList = branchDAO.getAllBranches();
//        String error = "";
//        for (Branch branch : branchList) {
//            if (branch.getBranch_id() == branchId) {
//                error = "Khu vực này đã có manager";
//                break;
//            }
//        }
//        if (!error.isEmpty()) {
//            ManagerDAO managerDAO = new ManagerDAO();
//            Manager fullManager = managerDAO.getManagerById(managerId);
//            branchList = managerDAO.getAllBranches();
//            request.setAttribute("manager", fullManager);
//            request.setAttribute("branchList", branchList);
//            request.setAttribute("error", "Khu vực này đã có manager!");
//
//            request.getRequestDispatcher("adminUpdateManager.jsp").forward(request, response);
//            return;
//        }

        // Gọi DAO
        ManagerDAO dao = new ManagerDAO();
        boolean success = dao.updateManager(manager);

        // Điều hướng sau khi update
        if (success) {
            response.sendRedirect("adminViewManagerList"); // load lại danh sách manager
        } else {
            ManagerDAO managerDAO = new ManagerDAO();
            Manager fullManager = managerDAO.getManagerById(managerId);
            branchList = managerDAO.getAllBranches();
            request.setAttribute("manager", fullManager);
            request.setAttribute("branchList", branchList);
            request.setAttribute("error", "Cập nhật thất bại!");

            request.getRequestDispatcher("adminUpdateManager.jsp").forward(request, response);
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
