package controller.Customer;

import dao.BookingDetailDAO;
import model.BookingDetails;
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

            BookingDetailDAO dao = new BookingDetailDAO();
            List<BookingDetails> bookingList = null;

            // Ưu tiên tìm kiếm theo tên hồ bơi
            if (poolName != null && !poolName.trim().isEmpty()) {
                bookingList = dao.searchBookingDetailByPoolName(userId, poolName.trim());
            }
            // Nếu chọn 1 ngày cụ thể, chỉ lấy booking trong ngày đó
            else if (fromDateStr != null && !fromDateStr.isEmpty()) {
                Date selectedDate = Date.valueOf(fromDateStr);
                bookingList = dao.searchBookingDetailByDate(userId, selectedDate, selectedDate); // truyền fromDate = toDate = ngày cần tìm
            }
            // Sắp xếp
            else if ("date_asc".equals(sortOrder)) {
                bookingList = dao.sortBookingDetailByDateAsc(userId);
            } else if ("price_asc".equals(sortOrder)) {
                bookingList = dao.sortBookingDetailByPriceAsc(userId);
            } else if ("price_desc".equals(sortOrder)) {
                bookingList = dao.sortBookingDetailByPriceDesc(userId);
            } else { // Mặc định: mới nhất
                bookingList = dao.sortBookingDetailByDateDesc(userId);
            }

            request.setAttribute("bookingList", bookingList);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi lấy lịch sử đặt bể!");
        }
        request.getRequestDispatcher("BookingHistory.jsp").forward(request, response);
    }
}