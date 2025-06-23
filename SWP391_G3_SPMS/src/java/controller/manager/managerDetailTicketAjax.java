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
import model.manager.TicketType;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "managerDetailTicketAjax", urlPatterns = {"/managerDetailTicketAjax"})
public class managerDetailTicketAjax extends HttpServlet {

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
            out.println("<title>Servlet managerDetailTicketAjax</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet managerDetailTicketAjax at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        String idRaw = request.getParameter("id");
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            if (idRaw == null) {
                out.println("<div style='color:red'>Không tìm thấy mã vé!</div>");
                return;
            }
            int id = Integer.parseInt(idRaw);
            TicketTypeDAO dao = new TicketTypeDAO();
            TicketType ticket = dao.getTicketTypeById(id);
            if (ticket == null) {
                out.println("<div style='color:red'>Không tìm thấy vé!</div>");
                return;
            }
            out.println("<h3 style='text-align:center;'>Chi tiết loại vé</h3>");
            out.println("<table style='width:100%; border-collapse:collapse;'>");
            out.println("<tr><th style='text-align:left;width:140px;'>Mã loại vé:</th><td>" + ticket.getCode() + "</td></tr>");
            out.println("<tr><th style='text-align:left;'>Tên loại vé:</th><td>" + ticket.getName() + "</td></tr>");
            out.println("<tr><th style='text-align:left;'>Giá vé:</th><td>" + String.format("%,.0f₫", ticket.getBasePrice()) + "</td></tr>");
            out.println("<tr><th style='text-align:left;'>Mô tả:</th><td>" + (ticket.getDescription() == null ? "" : ticket.getDescription()) + "</td></tr>");
            out.println("<tr><th style='text-align:left;'>Combo:</th><td>" + (ticket.isIsCombo() ? "Có" : "Không") + "</td></tr>");
            out.println("<tr><th style='text-align:left;'>Áp dụng tại:</th><td>");
            for (String pool : ticket.getPools()) {
                out.print("<span class='tag' style='background:#4dc3ff;color:#fff;border-radius:8px;padding:4px 10px;margin:2px 6px 2px 0;display:inline-block;'>" + pool + "</span>");
            }
            out.println("</td></tr>");
            out.println("<tr><th style='text-align:left;'>Ngày tạo:</th><td>" + (ticket.getCreatedAt() == null ? "" : ticket.getCreatedAt()) + "</td></tr>");
            out.println("<tr><th style='text-align:left;'>Trạng thái:</th><td>");
            out.println("<span class='tag' style='background:" + (ticket.isActive() ? "#28b779" : "#d9534f") + ";color:#fff;'>" + (ticket.isActive() ? "Đang bán" : "Ngừng bán") + "</span>");
            out.println("</td></tr>");
            out.println("</table>");
        } catch (Exception ex) {
            ex.printStackTrace();
            response.getWriter().println("<div style='color:red'>Xảy ra lỗi khi lấy chi tiết vé!</div>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
