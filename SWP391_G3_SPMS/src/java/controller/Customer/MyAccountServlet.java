package controller.Customer;

import dao.customer.BookingDetailDAO;
import dao.customer.DiscountDetailDAO;
import dao.customer.UserDAO;
import model.customer.BookingDetails;
import model.customer.DiscountDetail;
import model.customer.User;


import java.util.List;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class MyAccountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = currentUser.getUser_id(); // Gan tam userId = 2

        UserDAO userDAO = new UserDAO();
        BookingDetailDAO bookingDetailDAO = new BookingDetailDAO();
        DiscountDetailDAO discountDetailDAO = new DiscountDetailDAO();

        User user = userDAO.getUserByID(userId);

        List<BookingDetails> recentBookings;
        List<DiscountDetail> vouchersActive;
        List<DiscountDetail> vouchersUsed;
        try {
            // Recent bookings (BookingDetail)
            List<BookingDetails> allBookings = bookingDetailDAO.sortBookingDetailByDateDesc(userId);
            recentBookings = allBookings.size() > 3 ? allBookings.subList(0, 3) : allBookings;

            // Voucher AVAILABLE: status = true
            List<DiscountDetail> allActive = discountDetailDAO.getDiscountByUserIDAndStatus(userId, true);
            vouchersActive = allActive.size() > 3 ? allActive.subList(0, 3) : allActive;

            // Voucher USED: status = false
            List<DiscountDetail> allUsed = discountDetailDAO.getDiscountByUserIDAndStatus(userId, false);
            vouchersUsed = allUsed.size() > 3 ? allUsed.subList(0, 3) : allUsed;

            request.setAttribute("voucherActiveCount", allActive.size());
            request.setAttribute("voucherUsedCount", allUsed.size());
        } catch (Exception e) {
            throw new ServletException("Database error", e);
        }

        request.setAttribute("user", user);
        request.setAttribute("recentBookings", recentBookings);
        request.setAttribute("voucherActive", vouchersActive);
        request.setAttribute("voucherUsed", vouchersUsed);

        request.getRequestDispatcher("MyAccountProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
