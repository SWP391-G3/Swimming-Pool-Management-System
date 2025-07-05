/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin.Pool;

import dao.PoolDAO;
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
@WebServlet(name = "AdminSearchPoolServlet", urlPatterns = {"/adminSearchPool"})
public class AdminSearchPoolServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminSearchPoolServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminSearchPoolServlet at " + request.getContextPath() + "</h1>");
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
        Boolean pool_status = null;
        String nameSort, nameStatus = "";
        PoolDAO dao = new PoolDAO();
        List<Pool> list;
        int page = 1; // mac dinh ban dau la 1
        int poolContain = 4;
        try {
            if (status != null && !status.trim().isEmpty()) {
                pool_status = Boolean.parseBoolean(status);
                if (pool_status) {
                    nameStatus = "Đang hoạt động";
                } else {
                    nameStatus = "Hủy hoạt động";
                }
            }
            if (sort == null || sort.trim().isEmpty()) {
                sort = null; // hoặc gán "default" nếu cần
                nameSort = "";
            } else if (sort.equals("capacity_desc")) {
                nameSort = "Sức chứa giảm dần";
            } else {
                nameSort = "Sức chứa tăng dần";
            }

            int totalRecords = dao.getTotalFilteredPools(search, location, pool_status);
            int totalPages = (int) Math.ceil(totalRecords * 1.0 / poolContain);
            try {
                String pageStr = request.getParameter("page");
                if (pageStr != null) {
                    page = Integer.parseInt(pageStr);
                    if (page < 1) {
                        page = 1;
                    } else if (page > totalPages) {
                        page = totalPages;
                    }
                }
            } catch (NumberFormatException e) {
                page = 1;
            }
            int start = (page - 1) * poolContain;
            list = dao.searchPools(search, location, pool_status, sort, start, poolContain);
            request.setAttribute("listPool", list);
            request.setAttribute("totalrecords", totalRecords);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            
            request.setAttribute("statusValue", pool_status);
            request.setAttribute("sortValue", sort);
            request.setAttribute("search", search);
            request.setAttribute("location", location);
            request.setAttribute("status", nameStatus);
            request.setAttribute("sort", nameSort);
            request.getRequestDispatcher("AdminSearchPool.jsp").forward(request, response);
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
