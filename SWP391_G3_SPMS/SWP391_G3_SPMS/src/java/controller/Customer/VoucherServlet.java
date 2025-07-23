package controller.Customer;

import dao.customer.DiscountDetailDAO;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
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

        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user.getUser_id();

        // Xử lý nhận voucher mới qua input search
        String search = request.getParameter("search");
        if (search != null && !search.trim().isEmpty()) {
            DiscountDetailDAO dao = new DiscountDetailDAO();
            try {
                DiscountDetail voucherDetail = null;
                try {
                    voucherDetail = dao.getVoucherDetailByUserIdAndCode(userId, search.trim());
                } catch (Exception ex) {
                    voucherDetail = null;
                }
                // Nếu đã có voucher này rồi và đã dùng
                if (voucherDetail != null && voucherDetail.getUsedDiscount() != null && !voucherDetail.getUsedDiscount()) {
                    request.setAttribute("voucherMsg", "Bạn đã sử dụng voucher này.");
                } else {
                    boolean added = dao.addVoucherToCustomer(userId, search.trim());
                    if (added) {
                        request.setAttribute("voucherMsg", "Nhận voucher thành công!");
                    } else {
                        request.setAttribute("voucherMsg", "Không tìm thấy mã voucher hoặc đã nhận rồi.");
                    }
                }
            } catch (SQLException e) {
                request.setAttribute("voucherMsg", "Có lỗi khi nhận voucher.");
            }
        }

        if (service.equals("showVoucher")) {
            String expiryStatus = request.getParameter("expiryStatus");
            String expiryFrom = request.getParameter("expiryFrom");
            String expiryTo = request.getParameter("expiryTo");
            String sort = request.getParameter("sort");
            String pageRaw = request.getParameter("page");
            int page = 1;
            try {
                if (pageRaw != null) {
                    page = Integer.parseInt(pageRaw);
                }
                if (page <= 0) {
                    page = 1;
                }
            } catch (Exception e) {
                page = 1;
            }
            int pageSize = 6;

            try {
                DiscountDetailDAO dao = new DiscountDetailDAO();
                // Lấy nhiều voucher hơn để lọc chính xác sau khi áp dụng logic
                List<DiscountDetail> rawVouchers = dao.getVoucherListByUserId(userId, search, null, sort, 1, 500);

                List<DiscountDetail> vouchers = new ArrayList<>();
                LocalDateTime now = LocalDateTime.now();
                LocalDate today = now.toLocalDate();

                for (DiscountDetail voucher : rawVouchers) {
                    boolean isExpired = voucher.getValidTo().isBefore(now);
                    boolean isUsed = (voucher.getUsedDiscount() != null && !voucher.getUsedDiscount()); // used_discount = 0 là đã dùng
                    if (isExpired && isUsed) {
                        continue; // ẩn voucher này
                    }
                    // Lọc theo trạng thái hạn sử dụng
                    LocalDate validToDate = voucher.getValidTo().toLocalDate();
                    boolean passFilter = true;
                    if ("active".equals(expiryStatus)) {
                        if (validToDate.isBefore(today)) {
                            passFilter = false;
                        }
                    } else if ("expiring".equals(expiryStatus)) {
                        long days = ChronoUnit.DAYS.between(today, validToDate);
                        if (days < 0 || days > 7) {
                            passFilter = false;
                        }
                    } else if ("expired".equals(expiryStatus)) {
                        if (!validToDate.isBefore(today)) {
                            passFilter = false;
                        }
                    } else if ("range".equals(expiryStatus)) {
                        if (expiryFrom == null || expiryTo == null || expiryFrom.isEmpty() || expiryTo.isEmpty()) {
                            passFilter = false;
                        } else {
                            try {
                                LocalDate from = LocalDate.parse(expiryFrom);
                                LocalDate to = LocalDate.parse(expiryTo);
                                if (validToDate.isBefore(from) || validToDate.isAfter(to)) {
                                    passFilter = false;
                                }
                            } catch (Exception ex) {
                                passFilter = false;
                            }
                        }
                    }
                    if (passFilter) {
                        vouchers.add(voucher);
                    }
                }

                int totalVoucher = vouchers.size();
                int totalPage = (totalVoucher + pageSize - 1) / pageSize;
                if (totalPage == 0) {
                    totalPage = 1; // LUÔN >= 1
                }
                if (page > totalPage) {
                    page = 1;   // Nếu nhập trang lớn hơn tổng số trang, về lại trang 1
                }
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
                request.setAttribute("expiryStatus", expiryStatus != null ? expiryStatus : "all");
                request.setAttribute("expiryFrom", expiryFrom != null ? expiryFrom : "");
                request.setAttribute("expiryTo", expiryTo != null ? expiryTo : "");
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