/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin.DashBoard;

import dao.admin.ManagerDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.admin.Manager;
import util.SendEmailContact;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "AdminSendContactToManagerServlet", urlPatterns = {"/adminSendContactToManagerServlet"})
public class AdminSendContactToManagerServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminSendContactToManagerServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminSendContactToManagerServlet at " + request.getContextPath() + "</h1>");
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
        int branchId = Integer.parseInt(request.getParameter("branchId"));
        ManagerDAO dao = new ManagerDAO();
        Manager manager = dao.getManagerByBranchId(branchId);
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        if (manager != null) {
            out.print("{\"name\": \"" + manager.getFull_name() + "\", \"email\": \"" + manager.getEmail() + "\"}");
        } else {
            out.print("{}");
        }
        out.flush();
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
            int branchId = Integer.parseInt(request.getParameter("branchId"));
            String subject = request.getParameter("subject");
            String message = request.getParameter("message");

            ManagerDAO managerDAO = new ManagerDAO();
            Manager manager = managerDAO.getManagerByBranchId(branchId);

            if (manager != null && manager.getEmail() != null) {
                SendEmailContact.sendEmail(manager.getEmail(), subject, message);
                request.getSession().setAttribute("successMessage", "Đã gửi thông báo đến quản lý thành công.");
            } else {
                request.getSession().setAttribute("errorMessage", "Không tìm thấy thông tin quản lý.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Có lỗi xảy ra khi gửi email.");
        }

        response.sendRedirect("adminDashBoard");
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
