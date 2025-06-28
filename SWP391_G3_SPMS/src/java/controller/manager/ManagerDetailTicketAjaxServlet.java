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
import java.util.Map;
import model.manager.TicketType;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "managerDetailTicketAjax", urlPatterns = {"/managerDetailTicketAjax"})
public class ManagerDetailTicketAjaxServlet extends HttpServlet {

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
            // Nếu là combo thì hiển thị chi tiết thành phần combo
            if (ticket.isIsCombo()) {
                Map<Integer, Integer> comboDetail = dao.getComboDetail(id);
                double discountPercent = ticket.getDiscountPercent();
                if (comboDetail != null && !comboDetail.isEmpty()) {
                    out.println("<tr><th style='text-align:left;vertical-align:top;'>Thành phần combo:</th><td>");
                    out.println("<table style='width:100%;border:1px solid #eee;background:#fafbfc;margin-bottom:8px;'>");
                    out.println("<tr><th style='text-align:left'>Tên vé</th><th style='text-align:right'>Đơn giá</th><th style='text-align:right'>Số lượng</th><th style='text-align:right'>Thành tiền</th></tr>");
                    double total = 0;
                    for (Map.Entry<Integer, Integer> entry : comboDetail.entrySet()) {
                        int singleId = entry.getKey();
                        int qty = entry.getValue();
                        TicketType single = dao.getTicketTypeById(singleId);
                        if (single == null) {
                            continue;
                        }
                        double sub = single.getBasePrice() * qty;
                        total += sub;
                        out.println("<tr>");
                        out.println("<td>" + single.getName() + "</td>");
                        out.println("<td style='text-align:right'>" + String.format("%,.0f₫", single.getBasePrice()) + "</td>");
                        out.println("<td style='text-align:right'>" + qty + "</td>");
                        out.println("<td style='text-align:right'>" + String.format("%,.0f₫", sub) + "</td>");
                        out.println("</tr>");
                    }
                    out.println("<tr><td colspan='3' style='text-align:right;font-weight:bold;'>Tổng:</td><td style='text-align:right;font-weight:bold;'>" + String.format("%,.0f₫", total) + "</td></tr>");
                    out.println("</table>");
                    // Hiển thị discount
                    out.println("<div style='margin:5px 0;'>Ưu đãi: <b>" + discountPercent + "%</b></div>");
                    double finalPrice = total * (1 - discountPercent / 100.0);
                    out.println("<div style='margin:5px 0;'>Giá sau ưu đãi: <b style='color:#d9534f;'>" + String.format("%,.0f₫", finalPrice) + "</b></div>");
                    out.println("</td></tr>");
                } else {
                    out.println("<tr><th style='text-align:left;vertical-align:top;'>Thành phần combo:</th><td>Không có thành phần.</td></tr>");
                }
            }
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
