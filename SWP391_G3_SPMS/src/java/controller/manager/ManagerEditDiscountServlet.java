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
import model.manager.Discount;
import java.text.SimpleDateFormat;
import java.text.ParseException;
import model.customer.User;

@WebServlet(name = "ManagerEditDiscountServlet", urlPatterns = {"/managerEditDiscountServlet"})
public class ManagerEditDiscountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("managerAccount");
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
            Discount d = dao.getDiscountById(id);
            if (d == null) {
                response.sendRedirect("managerDiscountServlet");
                return;
            }

            // Chỉ cho phép manager tạo discount này mới được sửa
            int managerId = currentUser.getUser_id();
            if (!dao.canManagerEditDiscount(id, managerId)) {
                session.setAttribute("error", "Bạn không phải người tạo voucher này, không có quyền chỉnh sửa!");
                response.sendRedirect("managerDiscountServlet");
                return;
            }

            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            request.setAttribute("validFromVal", d.getValidFrom() != null ? formatter.format(d.getValidFrom()) : "");
            request.setAttribute("validToVal", d.getValidTo() != null ? formatter.format(d.getValidTo()) : "");
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
        User currentUser = (User) session.getAttribute("managerAccount");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int managerId = currentUser.getUser_id(); // hoặc getId()

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

            // Kiểm tra quyền sửa trước khi xử lý gì thêm!
            if (!dao.canManagerEditDiscount(discountId, managerId)) {
                session.setAttribute("error", "Bạn không phải người tạo voucher này, không có quyền chỉnh sửa!");
                response.sendRedirect("managerDiscountServlet");
                return;
            }

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
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            java.util.Date validFrom = null, validTo = null;
            if (error == null) {
                try {
                    validFrom = sdf.parse(validFromStr);
                    validTo = sdf.parse(validToStr);
                    if (validFrom.after(validTo)) {
                        error = "Ngày bắt đầu phải trước ngày kết thúc!";
                    }
                    if (validFrom.before(new java.util.Date())) {
                        error = "Ngày bắt đầu không được trong quá khứ!";
                    }
                } catch (ParseException e) {
                    error = "Ngày bắt đầu/kết thúc không hợp lệ!";
                }
            }

            boolean checkedStatus = (statusStr != null && statusStr.equals("1"));

            if (error != null) {
                Discount d = new Discount();
                d.setId(discountId);
                d.setCode(request.getParameter("discount_code"));
                d.setDescription(description);
                d.setPercent(percent);
                d.setQuantity(quantity);
                d.setValidFrom(validFrom);
                d.setValidTo(validTo);
                d.setStatus(checkedStatus);

                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
                request.setAttribute("validFromVal", validFrom != null ? formatter.format(validFrom) : "");
                request.setAttribute("validToVal", validTo != null ? formatter.format(validTo) : "");
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
                discountCode = dao.getDiscountById(discountId).getCode();
            }

            Discount d = new Discount();
            d.setId(discountId);
            d.setDescription(description);
            d.setPercent(percent);
            d.setQuantity(quantity);
            d.setValidFrom(validFrom);
            d.setValidTo(validTo);
            d.setStatus(checkedStatus);
            d.setCode(discountCode);
            
            // Cập nhập Voucher
            boolean result = dao.update(d, managerId); // Truyền managerId vào DAO

            if (result) {
                session.setAttribute("success", "Cập nhật voucher thành công!");
            } else {
                // Không đúng quyền thì đã redirect ở trên. Nếu lỗi khác thì báo lỗi chung.
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