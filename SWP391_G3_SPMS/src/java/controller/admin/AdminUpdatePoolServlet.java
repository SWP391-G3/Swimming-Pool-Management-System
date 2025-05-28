/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin;

import dao.PoolDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.time.LocalTime;
import model.Pool;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "AdminUpdatePoolServlet", urlPatterns = {"/adminUpdatePool"})
public class AdminUpdatePoolServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminUpdatePoolServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminUpdatePoolServlet at " + request.getContextPath() + "</h1>");
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
        String id = request.getParameter("id");
        PoolDAO dao = new PoolDAO();
        int pool_id;
        try {
            pool_id = Integer.parseInt(id);
            Pool pool = dao.getPoolByID(pool_id);
            if (pool != null) {
                request.setAttribute("Pool", pool);
                request.getRequestDispatcher("AdminUpdatePool.jsp").forward(request, response);
            }
        } catch (IOException e) {
            e.printStackTrace();
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
        PoolDAO dao = new PoolDAO();
        Pool pool;
        String id = request.getParameter("pool_id");
        String pool_name = request.getParameter("pool_name");
        String pool_image = request.getParameter("pool_image");
        String pool_road = request.getParameter("pool_road");
        String pool_address = request.getParameter("pool_address");
        String slot = request.getParameter("max_slot");
        String open = request.getParameter("open_time");
        String close = request.getParameter("close_time");
        String status = request.getParameter("pool_status");
        LocalDate updateDate = LocalDate.now();
        LocalTime open_time, close_time;
        int max_slot, pool_id;
        boolean pool_status;
        try {
            pool_id = Integer.parseInt(id);
            pool_status = Boolean.parseBoolean(status);
            max_slot = Integer.parseInt(slot);
            open_time = LocalTime.parse(open);
            close_time = LocalTime.parse(close);
            pool = new Pool(pool_id, pool_name, pool_road, pool_address, max_slot, open_time, close_time, pool_status, pool_image, null, updateDate);
            dao.updatePool(pool);
            response.sendRedirect("adminPoolManagement");
        } catch (NumberFormatException e) {
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
