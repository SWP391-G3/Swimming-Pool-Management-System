package controller;

import dao.BookingDAO;
import model.Booking;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet(name = "ListCustomerBookingServlet", urlPatterns = {"/customer-bookings"})
public class ListCustomerBookingServlet extends HttpServlet {
    private static final int PAGE_SIZE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String search = request.getParameter("search");
        String status = request.getParameter("status");
        String sort = request.getParameter("sort");
        String sortDir = request.getParameter("sortDir");
        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
        } catch (Exception e) {}
        if (status == null) status = "all";
        if (sort == null) sort = "date";
        if (sortDir == null) sortDir = "asc";

        BookingDAO dao = new BookingDAO();
        try {
            int total = dao.countBookingsToday(search, status);
            int totalPages = (int) Math.ceil(total * 1.0 / PAGE_SIZE);
            List<Booking> bookings = dao.listBookingsToday(search, status, sort, sortDir, page, PAGE_SIZE);

            request.setAttribute("bookings", bookings);
            request.setAttribute("total", total);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("page", page);
            request.setAttribute("search", search);
            request.setAttribute("status", status);
            request.setAttribute("sort", sort);
            request.setAttribute("sortDir", sortDir);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi truy vấn dữ liệu!");
        }
        request.getRequestDispatcher("/list_customer_booking.jsp").forward(request, response);
    }
}