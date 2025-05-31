package controller.Customer;

import dao.BookingDAO;
import dao.DiscountDAO;
import dao.UserDAO;
import model.Booking;
import model.Discounts;
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
        int userId = 4; // TODO: Lấy user id từ session

        UserDAO userDAO = new UserDAO();
        BookingDAO bookingDAO = new BookingDAO();
        DiscountDAO discountDAO = new DiscountDAO();

        User user = userDAO.getUserByID(userId);

        List<Booking> recentBookings;
        List<Discounts> vouchersActive, vouchersUsed;
        try {
            // Booking gần nhất
            List<Booking> allBookings = bookingDAO.sortBookingByDateDesc(userId);
            recentBookings = allBookings.size() > 3 ? allBookings.subList(0, 3) : allBookings;

            // Voucher ĐANG CÓ: status = 1
            List<Discounts> allActive = discountDAO.getDiscountByUserIDAndStatus(userId, true);
            vouchersActive = allActive.size() > 3 ? allActive.subList(0, 3) : allActive;

            // Voucher ĐÃ DÙNG: status = 0
            List<Discounts> allUsed = discountDAO.getDiscountByUserIDAndStatus(userId, false);
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
