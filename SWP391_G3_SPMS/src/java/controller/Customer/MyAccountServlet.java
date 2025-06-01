package controller.Customer;

import dao.BookingDetailDAO;
import dao.DiscountDetailDAO;
import dao.UserDAO;
import model.BookingDetails;
import model.DiscountDetail;
import model.User;

import java.util.List;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class MyAccountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = 2; // TODO: Lấy user id từ session

        UserDAO userDAO = new UserDAO();
        BookingDetailDAO bookingDetailDAO = new BookingDetailDAO();
        DiscountDetailDAO discountDetailDAO = new DiscountDetailDAO();

        User user = userDAO.getUserByID(userId);

        List<BookingDetails> recentBookings;
        List<DiscountDetail> vouchersActive, vouchersUsed;
        try {
            // Booking gần nhất (BookingDetail)
            List<BookingDetails> allBookings = bookingDetailDAO.sortBookingDetailByDateDesc(userId);
            recentBookings = allBookings.size() > 3 ? allBookings.subList(0, 3) : allBookings;

            // Voucher ĐANG CÓ: status = true
            List<DiscountDetail> allActive = discountDetailDAO.getDiscountByUserIDAndStatus(userId, true);
            vouchersActive = allActive.size() > 3 ? allActive.subList(0, 3) : allActive;

            // Voucher ĐÃ DÙNG: status = false
            List<DiscountDetail> allUsed = discountDetailDAO.getDiscountByUserIDAndStatus(userId, false);
            vouchersUsed = allUsed.size() > 3 ? allUsed.subList(0, 3) : allUsed;

            // Đếm tổng số lượng
            request.setAttribute("voucherActiveCount", allActive.size());
            request.setAttribute("voucherUsedCount", allUsed.size());
        } catch (Exception e) {
            throw new ServletException("Database error", e);
        }

        request.setAttribute("user", user);
        request.setAttribute("recentBookings", recentBookings);
        request.setAttribute("voucherActive", vouchersActive); // Đang có
        request.setAttribute("voucherUsed", vouchersUsed);     // Đã dùng

        request.getRequestDispatcher("MyAccountProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}