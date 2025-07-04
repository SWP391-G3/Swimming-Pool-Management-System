/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin.Customer;

import dao.admin.CustomerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.admin.Customer;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "AdminFilterCustomerServlet", urlPatterns = {"/adminFilterCustomer"})
public class AdminFilterCustomerServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminFilterCustomerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminFilterCustomerServlet at " + request.getContextPath() + "</h1>");
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

        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String sortAmount = request.getParameter("sortAmount");
        String userIdRaw = request.getParameter("userId");

        CustomerDAO dao = new CustomerDAO();
        int page = 1;
        int perPage = 5;

        Integer user_id = null;
        try {
            if (userIdRaw != null && !userIdRaw.trim().isEmpty()) {
                user_id = Integer.parseInt(userIdRaw);
            }
        } catch (NumberFormatException e) {
            // user_id sẽ giữ nguyên là null
        }

        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null && !pageParam.trim().isEmpty()) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            // page sẽ giữ mặc định là 1
        }

        int start = (page - 1) * perPage;

        // Tổng số bản ghi để tính tổng số trang
        int totalCustomers = dao.countFilteredCustomers(keyword, status);
        int totalPages = (int) Math.ceil((double) totalCustomers / perPage);


        // Lấy danh sách khách hàng phù hợp
        List<Customer> customers = dao.filterCustomers(keyword, status, sortAmount, user_id, start, perPage);

        // Set thuộc tính để đẩy sang JSP
        request.setAttribute("listCustomer", customers);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);

        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        request.setAttribute("sortAmount", sortAmount);
        request.setAttribute("userId", user_id); // nếu cần hiển thị lại khi search

        // Chuyển tiếp đến JSP
        request.getRequestDispatcher("adminFilterCustomer.jsp").forward(request, response);
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
