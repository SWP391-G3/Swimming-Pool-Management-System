package controller.Staff.Checkin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import dao.staff.CustomerCheckinDAO;
import dao.customer.BookingDetailDAO;
import model.customer.BookingDetails;
import java.io.IOException;
import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.*;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "CheckinServlet", urlPatterns = {"/checkin"})
public class CheckinServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingIdStr = request.getParameter("bookingId");
        String message = "";

        try {
            // Kiểm tra đầu vào
            if (bookingIdStr == null || bookingIdStr.trim().isEmpty()) {
                message = "Hãy đưa QR Code vào khung hình!";
            } else {
                int bookingId = Integer.parseInt(bookingIdStr);

                // Lấy thông tin booking
                BookingDetailDAO bookingDAO = new BookingDetailDAO();
                BookingDetails booking = bookingDAO.getBookingDetailById(bookingId);

                if (booking == null) {
                    message = "Không tìm thấy booking!";
                } else if (!"confirmed".equalsIgnoreCase(booking.getBookingStatus())) {
                    message = "Booking chưa hoàn thành thanh toán!";
                } else {
                    // Kiểm tra thời gian
                    Date bookingDate = booking.getBookingDate();
                    Time startTime = booking.getStartTime();

                    if (bookingDate == null || startTime == null) {
                        message = "Thiếu thông tin ngày/giờ đặt!";
                    } else {
                        // Chuyển đổi sang múi giờ Việt Nam
                        ZoneId vietnamZone = ZoneId.of("Asia/Ho_Chi_Minh");

                        // Tạo LocalDateTime từ booking date và start time
                        LocalDate localBookingDate = bookingDate.toLocalDate();
                        LocalTime localStartTime = startTime.toLocalTime();
                        LocalDateTime bookingDateTime = LocalDateTime.of(localBookingDate, localStartTime);

                        // Chuyển sang ZonedDateTime với múi giờ Việt Nam
                        ZonedDateTime bookingZoned = bookingDateTime.atZone(vietnamZone);
                        ZonedDateTime nowZoned = ZonedDateTime.now(vietnamZone);

                        // Tính chênh lệch thời gian
                        long diffMin = Duration.between(bookingZoned, nowZoned).toMinutes();

                        if (diffMin < -15) {
                            message = "Chưa thể check-in! Vui lòng đợi đến 15 phút trước thời gian booking.";
                        } else if (diffMin > 15) {
                            message = "Đã quá thời gian check-in cho booking này!";
                        } else {
                            // Thực hiện check-in
                            int userId = booking.getUserId();
                            CustomerCheckinDAO checkinDAO = new CustomerCheckinDAO();
                            boolean inserted = checkinDAO.checkin(userId, bookingId, new Timestamp(System.currentTimeMillis()));

                            if (inserted) {
                                message = "Check-in thành công!";
                            } else {
                                message = "Khách đã check-in trước đó!";
                            }
                        }
                    }
                }
            }
        } catch (NumberFormatException nf) {
            message = "Mã booking không hợp lệ!";
        } catch (Exception ex) {
            ex.printStackTrace();
            message = "Lỗi xử lý: " + ex.getMessage();
        }

        // Sau khi xử lý check-in, redirect đến StaffBookingListServlet để hiển thị danh sách check-in
        String redirectUrl = "checkin_list?type=checkin&page=1&message=" + java.net.URLEncoder.encode(message, "UTF-8");
        response.sendRedirect(redirectUrl);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển hướng đến trang danh sách nếu truy cập qua GET
        response.sendRedirect("checkin_list");
    }
}
