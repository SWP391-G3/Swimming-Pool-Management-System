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
import java.net.URLEncoder;
import java.util.Optional;
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
        String poolIdRaw = request.getParameter("poolId");
        String page = request.getParameter("page");
        String pageSize = request.getParameter("pageSize");
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");

        try {
            // Validate poolId
            if (idRaw == null || idRaw.isEmpty() || poolIdRaw == null || poolIdRaw.isEmpty() || "all".equals(poolIdRaw)) {
                // REDIRECT với error và filter!
                response.sendRedirect("managerTicketServlet?error=" + URLEncoder.encode("Vui lòng vào danh sách vé hồ bơi cụ thể để xóa vé!", "UTF-8")
                        + "&keyword=" + (keyword == null ? "" : URLEncoder.encode(keyword, "UTF-8"))
                        + "&poolId=" + (poolIdRaw == null ? "" : poolIdRaw)
                        + "&status=" + (status == null ? "" : status)
                        + "&page=" + (page == null ? "" : page)
                        + "&pageSize=" + (pageSize == null ? "" : pageSize));
                return;
            }

            int id = Integer.parseInt(idRaw);
            int poolIdInt = Integer.parseInt(poolIdRaw);

            TicketTypeDAO dao = new TicketTypeDAO();

            // Lấy trạng thái vé ở pool này
            String ticketStatus = dao.getTicketStatus(id, poolIdInt); // "active" hoặc "inactive"
            if ("active".equalsIgnoreCase(ticketStatus)) {
                response.sendRedirect("managerTicketServlet?error=" + URLEncoder.encode("Chỉ được xóa vé khi trạng thái là 'Ngừng bán'!", "UTF-8")
                        + "&keyword=" + (keyword == null ? "" : URLEncoder.encode(keyword, "UTF-8"))
                        + "&poolId=" + (poolIdRaw == null ? "" : poolIdRaw)
                        + "&status=" + (status == null ? "" : status)
                        + "&page=" + (page == null ? "" : page)
                        + "&pageSize=" + (pageSize == null ? "" : pageSize));
                return;
            }

            // Nếu là inactive thì xóa
            dao.deleteTicketTypeFromPool(id, poolIdInt);

            // Thành công, redirect và báo success
            response.sendRedirect("managerTicketServlet?success=3"
                    + "&keyword=" + (keyword == null ? "" : URLEncoder.encode(keyword, "UTF-8"))
                    + "&poolId=" + (poolIdRaw == null ? "" : poolIdRaw)
                    + "&status=" + (status == null ? "" : status)
                    + "&page=" + (page == null ? "" : page)
                    + "&pageSize=" + (pageSize == null ? "" : pageSize));
        } catch (Exception e) {
            // Xử lý lỗi bất ngờ
            response.sendRedirect("managerTicketServlet?error=" + URLEncoder.encode("Lỗi khi xóa vé: " + e.getMessage(), "UTF-8")
                    + "&keyword=" + (keyword == null ? "" : URLEncoder.encode(keyword, "UTF-8"))
                    + "&poolId=" + (poolIdRaw == null ? "" : poolIdRaw)
                    + "&status=" + (status == null ? "" : status)
                    + "&page=" + (page == null ? "" : page)
                    + "&pageSize=" + (pageSize == null ? "" : pageSize));
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
