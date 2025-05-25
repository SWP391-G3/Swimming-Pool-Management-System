/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.admin;

import dao.PoolDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Pool;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "LocationAdminServlet", urlPatterns = {"/locationAdmin"})
public class LocationAdminServlet extends HttpServlet {

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
            out.println("<title>Servlet LocationAdminServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet LocationAdminServlet at " + request.getContextPath() + "</h1>");
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
//        String pool_address = request.getParameter("location");
//        PoolDao dao = new PoolDao();
//        List<Pool> list = dao.getPoolByLocation(pool_address);
//        request.setAttribute("location", pool_address);
//        request.setAttribute("listPool", list);
//        request.getRequestDispatcher("locationPoolAdmin.jsp").forward(request, response);
        
        int page = 1; // mac dinh ban dau la 1
        int poolContain = 7;
        String pool_address = request.getParameter("location");
        String location;
        if (request.getParameter("page") != null) {
            page = Integer.parseInt(request.getParameter("page"));
        }
        if (request.getParameter("checkLocation") != null) {
            pool_address = request.getParameter("checkLocation");
        }
        PoolDao pdao = new PoolDao();
        int totalRecords = pdao.getTotalRecordLocation(pool_address);
        int totalPages = (int) Math.ceil(totalRecords * 1.0 / poolContain);
        int start = (page - 1) * poolContain;
        List<Pool> list = pdao.getPoolByPageLocation(pool_address, start, poolContain);
        location = pool_address;
        request.setAttribute("listPool", list);
        request.setAttribute("totalrecords", totalRecords);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("location", location);
        request.setAttribute("pool_address", pool_address);
        request.getRequestDispatcher("locationPoolAdmin.jsp").forward(request, response);

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
