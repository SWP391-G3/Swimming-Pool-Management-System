package controller.Customer;

import dao.BookingDAO;
import model.Booking;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class BookingHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            Integer userId = (Integer) request.getSession().getAttribute("userId");
            if (userId == null) userId = 2; // test cứng, thay bằng lấy từ phiên đăng nhập thực tế

            String poolName = request.getParameter("poolName");
            String fromDateStr = request.getParameter("fromDate");
            String sortOrder = request.getParameter("sortOrder");

            BookingDAO dao = new BookingDAO();
            List<Booking> bookingList = null;

            // Ưu tiên tìm kiếm theo tên hồ bơi
            if (poolName != null && !poolName.trim().isEmpty()) {
                bookingList = dao.searchBookingByPoolName(userId, poolName.trim());
            }
            // Ưu tiên lọc theo ngày nếu có fromDate
            else if (fromDateStr != null && !fromDateStr.isEmpty()) {
                Date fromDate = Date.valueOf(fromDateStr);
                Date toDate = new Date(System.currentTimeMillis());
                bookingList = dao.searchBookingByDate(userId, fromDate, toDate);
            }
            // Sắp xếp
            else if ("date_asc".equals(sortOrder)) {
                bookingList = dao.sortBookingByDateAsc(userId);
            } else if ("price_asc".equals(sortOrder)) {
                bookingList = dao.sortBookingByPriceAsc(userId);
            } else if ("price_desc".equals(sortOrder)) {
                bookingList = dao.sortBookingByPriceDesc(userId);
            } else { // Mặc định: mới nhất
                bookingList = dao.sortBookingByDateDesc(userId);
            }

            request.setAttribute("bookingList", bookingList);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi lấy lịch sử đặt bể!");
        }
        request.getRequestDispatcher("BookingHistory.jsp").forward(request, response);
    }
}