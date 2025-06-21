package controller.Customer;

import dao.customer.DiscountDetailDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.customer.DiscountDetail;
import model.customer.User;

public class VoucherServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String service = request.getParameter("service");
        if (service == null) {
            service = "showVoucher";
        }

        if (service.equals("showVoucher")) {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            int userId = user.getUser_id();

            String search = request.getParameter("search");
            String expiry = request.getParameter("expiry");
            String sort = request.getParameter("sort");
            String pageRaw = request.getParameter("page");
            int page = 1;
            try {
                if (pageRaw != null) page = Integer.parseInt(pageRaw);
                if (page <= 0) page = 1;
            } catch (Exception e) {
                page = 1;
            }
            int pageSize = 6;

            try {
                DiscountDetailDAO dao = new DiscountDetailDAO();
                // Lấy nhiều voucher hơn để lọc chính xác sau khi áp dụng logic
                List<DiscountDetail> rawVouchers = dao.getVoucherListByUserId(userId, search, expiry, sort, 1, 500);

                List<DiscountDetail> vouchers = new ArrayList<>();
                LocalDateTime now = LocalDateTime.now();

                // Lọc lại theo yêu cầu: nếu đã hết hạn và đã dùng thì ẩn khỏi danh sách
                for (DiscountDetail voucher : rawVouchers) {
                    boolean isExpired = voucher.getValidTo().isBefore(now);
                    boolean isUsed = (voucher.getUsedDiscount() != null && !voucher.getUsedDiscount()); // used_discount = 0 là đã dùng
                    if (isExpired && isUsed) {
                        continue; // ẩn voucher này
                    }
                    vouchers.add(voucher);
                }

                int totalVoucher = vouchers.size();
                int totalPage = (totalVoucher + pageSize - 1) / pageSize;
                if (totalPage == 0) totalPage = 1; // LUÔN >= 1

                if (page > totalPage) page = 1;   // Nếu nhập trang lớn hơn tổng số trang, về lại trang 1

                int fromIndex = Math.max(0, (page - 1) * pageSize);
                int toIndex = Math.min(vouchers.size(), fromIndex + pageSize);
                List<DiscountDetail> pageVouchers;
                if (fromIndex >= vouchers.size() || fromIndex >= toIndex) {
                    pageVouchers = new ArrayList<>();
                } else {
                    pageVouchers = vouchers.subList(fromIndex, toIndex);
                }

                request.setAttribute("vouchers", pageVouchers);
                request.setAttribute("search", search != null ? search : "");
                request.setAttribute("expiry", expiry != null ? expiry : "");
                request.setAttribute("sort", sort != null ? sort : "newest");
                request.setAttribute("page", page);
                request.setAttribute("totalPage", totalPage);

                request.getRequestDispatcher("Voucher.jsp").forward(request, response);
            } catch (SQLException e) {
                e.printStackTrace();
                request.setAttribute("error", "Không thể lấy danh sách voucher.");
                request.getRequestDispatcher("Voucher.jsp").forward(request, response);
            }
        }
    }
}