/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dao.manager.DiscountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.time.format.DateTimeParseException;
import model.Discounts;
import model.User;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "ManagerAddDiscountServlet", urlPatterns = {"/ManagerAddDiscountServlet"})
public class ManagerAddDiscountServlet extends HttpServlet {

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
            out.println("<title>Servlet ManagerAddDiscountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerAddDiscountServlet at " + request.getContextPath() + "</h1>");
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
        
        
        request.getRequestDispatcher("managerAddDiscount.jsp").forward(request, response);
        
        
        
        
    }

  
    @Override
protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

    HttpSession session = request.getSession();
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    request.setCharacterEncoding("UTF-8");
    DiscountDAO dao = new DiscountDAO();

    String code = request.getParameter("discount_code");
    String description = request.getParameter("description");
    String percentStr = request.getParameter("discount_percent");
    String quantityStr = request.getParameter("quantity");
    String validFromStr = request.getParameter("valid_from");
    String validToStr = request.getParameter("valid_to");

    // Các tham số filter để giữ lại sau redirect
    String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
    String status = request.getParameter("status") != null ? request.getParameter("status") : "all";
    String pageSizeStr = request.getParameter("pageSize") != null ? request.getParameter("pageSize") : "5";
    String fromDate = request.getParameter("fromDate") != null ? request.getParameter("fromDate") : "";
    String toDate = request.getParameter("toDate") != null ? request.getParameter("toDate") : "";

    String error = null;

    // Validate mã code
    if (code == null || code.trim().isEmpty()) {
        error = "Mã voucher không được để trống!";
    } else if (dao.isCodeExists(code.trim())) {
        error = "Mã voucher đã tồn tại!";
    }

    // Validate discount_percent
    BigDecimal percent = null;
    if (error == null) {
        try {
            percent = new BigDecimal(percentStr);
            if (percent.compareTo(BigDecimal.ONE) < 0 || percent.compareTo(new BigDecimal("50")) > 0)
                error = "Phần trăm giảm giá phải từ 1 đến 50!";
        } catch (Exception e) {
            error = "Phần trăm giảm giá không hợp lệ!";
        }
    }

    // Validate quantity
    int quantity = 1;
    if (error == null) {
        try {
            quantity = Integer.parseInt(quantityStr);
            if (quantity < 1 || quantity > 100)
                error = "Số lượng từ 1 đến 100!";
        } catch (Exception e) {
            error = "Số lượng không hợp lệ!";
        }
    }

    // Validate ngày
    LocalDateTime validFrom = null, validTo = null;
    if (error == null) {
        try {
            validFrom = LocalDateTime.parse(validFromStr.replace(" ", "T"));
            validTo = LocalDateTime.parse(validToStr.replace(" ", "T"));
            if (validFrom.isAfter(validTo))
                error = "Ngày bắt đầu phải trước ngày kết thúc!";
            if (validFrom.isBefore(LocalDateTime.now()))
                error = "Ngày bắt đầu không được trong quá khứ!";
        } catch (DateTimeParseException e) {
            error = "Ngày bắt đầu/kết thúc không hợp lệ!";
        }
    }

    if (error != null) {
        request.setAttribute("error", error);

        // Giữ lại filter khi về lại form
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        request.setAttribute("pageSize", pageSizeStr);
        request.setAttribute("fromDate", fromDate);
        request.setAttribute("toDate", toDate);

        request.getRequestDispatcher("managerAddDiscount.jsp").forward(request, response);
        return;
    }

    Discounts d = new Discounts();
    d.setDiscountCode(code.trim());
    d.setDescription(description);
    d.setDiscountPercent(percent);
    d.setQuantity(quantity);
    d.setValidFrom(validFrom);
    d.setValidTo(validTo);
    d.setStatus(true);

    boolean result = dao.insert(d);

    if (result) {
        // Tính lại số lượng voucher và số trang cuối cùng
        int pageSize = Integer.parseInt(pageSizeStr);

        // Chuyển fromDate, toDate sang java.util.Date nếu cần (nếu bạn truyền Date cho countDiscounts)
        java.util.Date fromDateObj = null, toDateObj = null;
        try {
            if (fromDate != null && !fromDate.isEmpty())
                fromDateObj = java.sql.Date.valueOf(fromDate);
            if (toDate != null && !toDate.isEmpty())
                toDateObj = java.sql.Date.valueOf(toDate);
        } catch (Exception e) { }

        int totalVoucher = 0;
        try {
            totalVoucher = dao.countDiscounts(keyword, status, fromDateObj, toDateObj);
        } catch (Exception e) {
            totalVoucher = 0;
        }
        int endPage = (int) Math.ceil((double) totalVoucher / pageSize);
        if (endPage < 1) endPage = 1;

        // Đặt message vào session để chuyển hướng vẫn hiển thị được
        session.setAttribute("success", "Thêm voucher thành công!");

        // Giữ lại filter khi redirect về trang cuối cùng
        String redirectUrl = "managerDiscountServlet?page=" + endPage
                + "&pageSize=" + pageSize
                + "&keyword=" + java.net.URLEncoder.encode(keyword, "UTF-8")
                + "&status=" + status
                + (fromDate != null && !fromDate.isEmpty() ? "&fromDate=" + fromDate : "")
                + (toDate != null && !toDate.isEmpty() ? "&toDate=" + toDate : "");
        response.sendRedirect(redirectUrl);
    } else {
        request.setAttribute("error", "Lỗi khi lưu vào CSDL!");

        // Giữ lại filter khi về lại form
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        request.setAttribute("pageSize", pageSizeStr);
        request.setAttribute("fromDate", fromDate);
        request.setAttribute("toDate", toDate);

        request.getRequestDispatcher("managerAddDiscount.jsp").forward(request, response);
    }
}
        
        
    

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
