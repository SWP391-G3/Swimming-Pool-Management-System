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
import java.time.format.DateTimeFormatter;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "ManagerEditDiscountServlet", urlPatterns = {"/managerEditDiscountServlet"})
public class ManagerEditDiscountServlet extends HttpServlet {

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
            out.println("<title>Servlet ManagerEditDiscountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerEditDiscountServlet at " + request.getContextPath() + "</h1>");
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
        if (idRaw == null) {
            response.sendRedirect("managerDiscountServlet");
            return;
        }

        try {
            int id = Integer.parseInt(idRaw);
            DiscountDAO dao = new DiscountDAO();
            Discounts d = dao.getDiscountById(id);
            if (d == null) {
                response.sendRedirect("managerDiscountServlet");
                return;
            }

            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
            request.setAttribute("validFromVal", d.getValidFrom() != null ? d.getValidFrom().format(formatter) : "");
            request.setAttribute("validToVal", d.getValidTo() != null ? d.getValidTo().format(formatter) : "");
            // Truyền dữ liệu voucher vào form
            request.setAttribute("discount", d);

            // Giữ filter nếu có
            request.setAttribute("page", request.getParameter("page"));
            request.setAttribute("pageSize", request.getParameter("pageSize"));
            request.setAttribute("keyword", request.getParameter("keyword"));
            request.setAttribute("status", request.getParameter("status"));
            request.setAttribute("fromDate", request.getParameter("fromDate"));
            request.setAttribute("toDate", request.getParameter("toDate"));

            request.getRequestDispatcher("managerEditDiscount.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect("managerDiscountServlet");
        }
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

        String idRaw = request.getParameter("discount_id");
        if (idRaw == null || idRaw.isEmpty()) {
            session.setAttribute("error", "ID không hợp lệ!");
            response.sendRedirect("managerDiscountServlet");
            return;
        }

        try {
            int discountId = Integer.parseInt(idRaw);

            String description = request.getParameter("description");
            String percentStr = request.getParameter("discount_percent");
            String quantityStr = request.getParameter("quantity");
            String validFromStr = request.getParameter("valid_from");
            String validToStr = request.getParameter("valid_to");
            String statusStr = request.getParameter("status");

            // Lấy lại các filter
            String page = request.getParameter("page");
            String pageSize = request.getParameter("pageSize");
            String keyword = request.getParameter("keyword");
            String statusFilter = request.getParameter("status");
            String fromDate = request.getParameter("fromDate");
            String toDate = request.getParameter("toDate");

            String error = null;

            // Validate discount_percent
            BigDecimal percent = null;
            if (error == null) {
                try {
                    percent = new BigDecimal(percentStr);
                    if (percent.compareTo(BigDecimal.ONE) < 0 || percent.compareTo(new BigDecimal("50")) > 0) {
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
            LocalDateTime validFrom = null, validTo = null;
            if (error == null) {
                try {
                    validFrom = LocalDateTime.parse(validFromStr.replace(" ", "T"));
                    validTo = LocalDateTime.parse(validToStr.replace(" ", "T"));
                    if (validFrom.isAfter(validTo)) {
                        error = "Ngày bắt đầu phải trước ngày kết thúc!";
                    }
                    if (validFrom.isBefore(LocalDateTime.now())) {
                        error = "Ngày bắt đầu không được trong quá khứ!";
                    }
                } catch (DateTimeParseException e) {
                    error = "Ngày bắt đầu/kết thúc không hợp lệ!";
                }
            }

            boolean checkedStatus = (statusStr != null && statusStr.equals("1"));

            if (error != null) {
                Discounts d = new Discounts();
                d.setDiscountId(discountId);
                d.setDiscountCode(request.getParameter("discount_code"));
                d.setDescription(description);
                d.setDiscountPercent(percent);
                d.setQuantity(quantity);
                d.setValidFrom(validFrom);
                d.setValidTo(validTo);
                d.setStatus(checkedStatus);

                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
                request.setAttribute("validFromVal", validFrom != null ? validFrom.format(formatter) : "");
                request.setAttribute("validToVal", validTo != null ? validTo.format(formatter) : "");
                request.setAttribute("discount", d);
                request.setAttribute("error", error);

                // Giữ filter
                request.setAttribute("page", page);
                request.setAttribute("pageSize", pageSize);
                request.setAttribute("keyword", keyword);
                request.setAttribute("status", statusFilter);
                request.setAttribute("fromDate", fromDate);
                request.setAttribute("toDate", toDate);

                request.getRequestDispatcher("managerEditDiscount.jsp").forward(request, response);
                return;
            }

            String discountCode = request.getParameter("discount_code");
            if (discountCode == null || discountCode.isEmpty()) {
                discountCode = dao.getDiscountById(discountId).getDiscountCode();
            }

            Discounts d = new Discounts();
            d.setDiscountId(discountId);
            d.setDescription(description);
            d.setDiscountPercent(percent);
            d.setQuantity(quantity);
            d.setValidFrom(validFrom);
            d.setValidTo(validTo);
            d.setStatus(checkedStatus);
            d.setDiscountCode(discountCode);

            boolean result = dao.update(d);

            if (result) {
                session.setAttribute("success", "Cập nhật voucher thành công!");
            } else {
                session.setAttribute("error", "Lỗi khi cập nhật!");
            }

            // Quay lại đúng trang/filter cũ
            String redirectUrl = "managerDiscountServlet?page=" + (page != null ? page : "1")
                    + "&pageSize=" + (pageSize != null ? pageSize : "10")
                    + "&keyword=" + java.net.URLEncoder.encode(keyword != null ? keyword : "", "UTF-8")
                    + "&status=" + (statusFilter != null ? statusFilter : "all")
                    + (fromDate != null && !fromDate.isEmpty() ? "&fromDate=" + fromDate : "")
                    + (toDate != null && !toDate.isEmpty() ? "&toDate=" + toDate : "");
            response.sendRedirect(redirectUrl);

        } catch (NumberFormatException e) {
            session.setAttribute("error", "ID không hợp lệ!");
            response.sendRedirect("managerDiscountServlet");
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
