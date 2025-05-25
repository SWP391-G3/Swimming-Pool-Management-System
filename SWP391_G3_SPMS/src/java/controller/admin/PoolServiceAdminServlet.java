/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "PoolServiceAdminServlet", urlPatterns = {"/poolservice"})
public class PoolServiceAdminServlet extends HttpServlet {

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
            out.println("<title>Servlet PoolServiceAdminServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet PoolServiceAdminServlet at " + request.getContextPath() + "</h1>");
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
        String search = request.getParameter("search");
        String location = request.getParameter("location");
        String status = request.getParameter("status");
        String sort = request.getParameter("sort");
        boolean pool_status = true;
        if (search != null && !search.trim().isEmpty()) {
            request.setAttribute("search", search);
            request.getRequestDispatcher("searchAdmin").forward(request, response);
        } else if (location != null && !location.trim().isEmpty()) {
            request.setAttribute("location", location);
            request.getRequestDispatcher("locationAdmin").forward(request, response);
        } else if (status != null && !status.trim().isEmpty()) {
            try {
                pool_status = Boolean.parseBoolean(status);
            } catch (Exception e) {
            }
            request.setAttribute("status", pool_status);
            request.getRequestDispatcher("statusPoolAdmin").forward(request, response);
        } else if (sort != null && !sort.trim().isEmpty()) {
            request.setAttribute("sort", sort);
            request.getRequestDispatcher("sortPoolAdmin").forward(request, response);
        } else if (sort != null && !sort.trim().isEmpty() && search != null && !search.trim().isEmpty() && location != null && !location.trim().isEmpty() && status != null && !status.trim().isEmpty()) {
            request.setAttribute("location", location);
            try {
                pool_status = Boolean.parseBoolean(status);
            } catch (Exception e) {
            }
            request.setAttribute("sort", sort);
            request.setAttribute("search", search);
            request.setAttribute("status", pool_status);
            request.getRequestDispatcher("locationStatusPoolAdmin").forward(request, response);
        } else {
            request.getRequestDispatcher("poolmanagement").forward(request, response);
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
