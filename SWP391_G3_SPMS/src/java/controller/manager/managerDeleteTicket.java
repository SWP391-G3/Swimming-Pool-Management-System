/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dao.manager.TicketTypeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "managerDeleteTicket", urlPatterns = {"/managerDeleteTicket"})
public class managerDeleteTicket extends HttpServlet {

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
            out.println("<title>Servlet managerDeleteTicket</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet managerDeleteTicket at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idRaw = request.getParameter("id");
        String poolIdRaw = request.getParameter("poolId"); // Lấy poolId từ request
        String page = request.getParameter("page");
        String pageSize = request.getParameter("pageSize");
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String poolId = request.getParameter("poolId");

        // Kiểm tra đủ tham số
        if (idRaw == null || idRaw.isEmpty() || poolIdRaw == null || poolIdRaw.isEmpty()) {
            request.setAttribute("error", "Thiếu tham số id hoặc poolId khi xóa vé!");
            request.getRequestDispatcher("managerTicket.jsp").forward(request, response);
            return;
        }

        try {
            int id = Integer.parseInt(idRaw);
            int poolIdInt = Integer.parseInt(poolIdRaw);

            TicketTypeDAO dao = new TicketTypeDAO();
            dao.deleteTicketTypeFromPool(id, poolIdInt);

            response.sendRedirect("managerTicketServlet?page=" + (page == null ? "" : page)
                    + "&pageSize=" + (pageSize == null ? "" : pageSize)
                    + "&keyword=" + (keyword == null ? "" : java.net.URLEncoder.encode(keyword, "UTF-8"))
                    + "&status=" + (status == null ? "" : status)
                    + "&poolId=" + (poolId == null ? "" : poolId)
                    + "&success=3");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi khi xóa vé: " + e.getMessage());
// Forward về lại trang danh sách (hoặc trang hiện tại của bạn)
            request.getRequestDispatcher("managerTicket.jsp").forward(request, response);
            return;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
