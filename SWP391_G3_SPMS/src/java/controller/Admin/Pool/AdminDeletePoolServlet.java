/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin.Pool;

import dao.customer.PoolDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "AdminDeletePoolServlet", urlPatterns = {"/adminDeletePool"})
public class AdminDeletePoolServlet extends HttpServlet {

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
            out.println("<title>Servlet AdminDeletePoolServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminDeletePoolServlet at " + request.getContextPath() + "</h1>");
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
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String pageRaw = request.getParameter("page");
        PoolDAO dao = new PoolDAO();

        if (id == null || id.isEmpty()) {
            response.sendRedirect("adminPoolManagement?error=2");
            return;
        }

        try {
            int pool_id = Integer.parseInt(id);
            int page = (pageRaw != null) ? Integer.parseInt(pageRaw) : 1;
            boolean checkBooking = dao.checkBookingForDelete(pool_id);
            if (checkBooking) {
                HttpSession session = request.getSession();
                session.setAttribute("deleteError", "Bể bơi hiện tại đã có người đặt trong hôm nay, không thể xóa.");

                // Redirect hoặc forward về trang quản lý bể bơi
                response.sendRedirect("adminPoolManagement?page=" + page);
                return;
            }

            if (!dao.canDelete(pool_id)) {
                // Không thể xóa vì vẫn đang hoạt động
                response.sendRedirect("adminPoolManagement?error=1&page=" + page);
            } else {
                dao.deletePool(pool_id);
                response.sendRedirect("adminPoolManagement?page=" + page);
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("adminPoolManagement?error=2"); // Tham số không hợp lệ
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminPoolManagement?error=3"); // Lỗi khác
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
