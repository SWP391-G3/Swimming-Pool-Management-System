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
import model.customer.User;
import model.manager.Discount;

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
        User currentUser = (User) session.getAttribute("managerAccount");
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
        User currentUser = (User) session.getAttribute("managerAccount");
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
        double percent = 0.0;
        if (error == null) {
            try {
                percent = Double.parseDouble(percentStr);
                if (percent < 1 || percent > 50) {
                    error = "Phần trăm giảm giá phải từ 1 đến 50!";
                }
            } catch (Exception e) {
                error = "Phần trăm giảm giá không hợp lệ!";
            }
        }

        // Validate quantity
        int quantity = 1;
        if (error == null) {
            try {
                quantity = Integer.parseInt(quantityStr);
                if (quantity < 1 || quantity > 100) {
                    error = "Số lượng từ 1 đến 100!";
                }
            } catch (Exception e) {
                error = "Số lượng không hợp lệ!";
            }
        }

        // Validate ngày
        java.time.LocalDateTime validFrom = null, validTo = null;
        if (error == null) {
            try {
                validFrom = java.time.LocalDateTime.parse(validFromStr.replace(" ", "T"));
                validTo = java.time.LocalDateTime.parse(validToStr.replace(" ", "T"));
                if (validFrom.isAfter(validTo)) {
                    error = "Ngày bắt đầu phải trước ngày kết thúc!";
                }
                if (validFrom.isBefore(java.time.LocalDateTime.now())) {
                    error = "Ngày bắt đầu không được trong quá khứ!";
                }
            } catch (Exception e) {
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

        // Tạo Discount đúng model.manager.Discount
        Discount d = new Discount();
        d.setCode(code.trim());
        d.setDescription(description);
        d.setPercent(percent);
        d.setQuantity(quantity);
        d.setValidFrom(java.sql.Timestamp.valueOf(validFrom));
        d.setValidTo(java.sql.Timestamp.valueOf(validTo));
        d.setStatus(true);

        // Lấy id của manager hiện tại 
        int managerId = currentUser.getUser_id();

        // Add Voucher
        boolean result = dao.insert(d, managerId); // Truyền thêm managerId vào DAO

        if (result) {
            // Tính lại số lượng voucher và số trang cuối cùng
            int pageSize = Integer.parseInt(pageSizeStr);

            java.util.Date fromDateObj = null, toDateObj = null;
            try {
                if (fromDate != null && !fromDate.isEmpty()) {
                    fromDateObj = java.sql.Date.valueOf(fromDate);
                }
                if (toDate != null && !toDate.isEmpty()) {
                    toDateObj = java.sql.Date.valueOf(toDate);
                }
            } catch (Exception e) {
            }

            int totalVoucher = 0;
            try {
                totalVoucher = dao.countDiscounts(keyword, status, fromDateObj, toDateObj);
            } catch (Exception e) {
                totalVoucher = 0;
            }
            int endPage = (int) Math.ceil((double) totalVoucher / pageSize);
            if (endPage < 1) {
                endPage = 1;
            }

            session.setAttribute("success", "Thêm voucher thành công!");

            String redirectUrl = "managerDiscountServlet?page=" + endPage
                    + "&pageSize=" + pageSize
                    + "&keyword=" + java.net.URLEncoder.encode(keyword, "UTF-8")
                    + "&status=" + status
                    + (fromDate != null && !fromDate.isEmpty() ? "&fromDate=" + fromDate : "")
                    + (toDate != null && !toDate.isEmpty() ? "&toDate=" + toDate : "");
            response.sendRedirect(redirectUrl);
        } else {
            request.setAttribute("error", "Lỗi khi lưu vào CSDL!");

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
