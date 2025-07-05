/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dao.manager.DiscountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.manager.Discount;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "ManagerDetailDiscountAjax", urlPatterns = {"/managerDetailDiscountAjax"})
public class ManagerDetailDiscountAjax extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagerDetailDiscountAjax</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerDetailDiscountAjax at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

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
            int id = Integer.parseInt(idRaw);
            DiscountDAO dao = new DiscountDAO();
            Discount d = dao.getDiscountByIdAjax(id);
            if (d == null) {
                out.println("<div style='color:red'>Không tìm thấy mã giảm giá!</div>");
                return;
            }
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm");
            out.println("<div class='discount-detail-popup'>");
            out.println("<h3>Chi tiết mã giảm giá</h3>");
            out.println("<ul>");
            out.printf("<li><b>ID:</b> %d</li>", d.getId());
            out.printf("<li><b>Mã:</b> %s</li>", d.getCode());
            out.printf("<li><b>Phần trăm giảm:</b> %d%%</li>", Math.round(d.getPercent()));
            out.printf("<li><b>Mô tả:</b> %s</li>", d.getDescription());
            out.printf("<li><b>Ngày bắt đầu:</b> %s</li>", sdf.format(d.getValidFrom()));
            out.printf("<li><b>Số lượng:</b> %d</li>", d.getQuantity());
            out.printf("<li><b>Ngày kết thúc:</b> %s</li>", sdf.format(d.getValidTo()));
            out.printf("<li><b>Trạng thái:</b> %s</li>", d.isStatus() ? "Đang hoạt động" : "Ngừng hoạt động");
            out.printf("<li><b>Ngày tạo:</b> %s</li>", sdf.format(d.getCreatedAt()));
            if (d.getUpdatedAt() != null) {
                out.printf("<li><b>Cập nhật cuối:</b> %s</li>", sdf.format(d.getUpdatedAt()));
            }
            out.println("</ul>");
            out.println("</div>");
        } catch (Exception e) {
            response.getWriter().println("<div style='color:red'>Có lỗi xảy ra khi tải chi tiết!</div>");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
