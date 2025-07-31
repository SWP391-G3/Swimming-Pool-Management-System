package controller.Customer;

import dao.customer.BookingDAO;
import dao.customer.BookingDetailDAO;
import dao.customer.FeedbackDAO;
import dao.customer.PaymentDAO;
import dao.customer.TicketTypeDAO;
import dao.customer.UserDAO;
import model.customer.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.sql.SQLException;
import java.util.List;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.Duration;
import java.time.format.DateTimeFormatter;
import java.util.Date;

/**
 *
 * @author LAZYVL
 */
public class BookingDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bookingIdStr = request.getParameter("bookingId");
        if (bookingIdStr == null) {
            response.sendRedirect("booking_history");
            return;
        }
        int bookingId = Integer.parseInt(bookingIdStr);
        try {
            BookingDetailDAO bookingDetailDAO = new BookingDetailDAO();
            BookingDetails bookingDetail = bookingDetailDAO.getBookingDetailById(bookingId);
            if (bookingDetail == null) {
                response.sendRedirect("booking_history");
                return;
            }

            // Lấy user hiện tại từ session
            User user = (User) request.getSession().getAttribute("customerAccount");
            Feedback userFeedback = null;
            if (user != null) {
                FeedbackDAO feedbackDAO = new FeedbackDAO();
                List<Feedback> feedbackList = feedbackDAO.getFeedbackByUserId(user.getUser_id());
                for (Feedback fb : feedbackList) {
                    if (fb.getPoolId() == bookingDetail.getPoolId()) {
                        userFeedback = fb;
                        break;
                    }
                }
            }

            // Xử lý quantity cho từng ticket
            List<Ticket> tickets = bookingDetail.getTickets();
            TicketTypeDAO ticketTypeDAO = new TicketTypeDAO();
            for (Ticket ticket : tickets) {
                int ticketTypeId = ticket.getTicketTypeId();
                TicketSlot slot = ticketTypeDAO.getTicketSlotByTicketTypeId(ticketTypeId);
                int quantity = (slot != null) ? slot.getTicketSlot() : 1;
                ticket.setQuantity(quantity);
            }

            // Kiểm tra có cho phép huỷ
            ZoneId vietnamZone = ZoneId.of("Asia/Ho_Chi_Minh");
            LocalDateTime now = LocalDateTime.now(vietnamZone);
            LocalDateTime bookingDateTime = LocalDateTime.of(new java.util.Date(bookingDetail.getBookingDate().getTime()).toInstant().atZone(vietnamZone).toLocalDate(), bookingDetail.getStartTime().toLocalTime());
            boolean canCancel = bookingDateTime.isAfter(now.plusHours(6))
                    && ("pending".equalsIgnoreCase(bookingDetail.getBookingStatus())
                    || "confirmed".equalsIgnoreCase(bookingDetail.getBookingStatus()));

            // Kiểm tra có cho phép hoàn tiền
            boolean canRefund = false;
            long minutesSinceCancel = Long.MAX_VALUE;
            PaymentDAO paymentDAO = new PaymentDAO();
            Payment payment = paymentDAO.getPaymentByBookingId(bookingId);
            if ("cancelled".equalsIgnoreCase(bookingDetail.getBookingStatus())
                    && !("refunded".equalsIgnoreCase(payment.getPaymentStatus()))) {
                // Lấy updatedAt từ Booking entity
                BookingDAO bookingDAO = new BookingDAO();
                Booking booking = bookingDAO.getBookingById(bookingId);
                Date updatedAt = booking.getCreatedAt();
                if (updatedAt != null) {
                    LocalDateTime cancelledTime = LocalDateTime.ofInstant(updatedAt.toInstant(), ZoneId.of("Asia/Ho_Chi_Minh"));
                    minutesSinceCancel = Duration.between(cancelledTime, now).toMinutes();
                    if (minutesSinceCancel <= 60) {
                        canRefund = true;
                    }
                }
            }

            request.setAttribute("tickets", tickets);
            request.setAttribute("bookingDetail", bookingDetail);
            request.setAttribute("userFeedback", userFeedback);
            request.setAttribute("successMsg", request.getParameter("success"));
            request.setAttribute("errorMsg", request.getParameter("error"));
            request.setAttribute("canCancel", canCancel);
            request.setAttribute("canRefund", canRefund);
            request.setAttribute("minutesSinceCancel", minutesSinceCancel);
            request.getRequestDispatcher("BookingDetail.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String service = request.getParameter("service");
        System.out.println("service param: " + service);

        User currentUser = (User) request.getSession().getAttribute("customerAccount");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = currentUser.getUser_id();

        if ("cancelBooking".equals(service)) {
            String bookingIdStr = request.getParameter("bookingId");
            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                BookingDetailDAO bookingDetailDAO = new BookingDetailDAO();
                bookingDetailDAO.cancelBooking(bookingId);
                response.sendRedirect("booking_detail?bookingId=" + bookingId + "&success=cancelled");
            } catch (Exception e) {
                e.printStackTrace();
            }
        } else if ("requestRefund".equals(service)) {
            String bookingIdStr = request.getParameter("bookingId");
            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                BookingDAO bookingDAO = new BookingDAO();
                Booking booking = bookingDAO.getBookingById(bookingId);

                PaymentDAO paymentDAO = new PaymentDAO();
                Payment payment = paymentDAO.getPaymentByBookingId(bookingId);

                if (booking == null && payment == null) {
                    response.sendRedirect("booking_detail?bookingId=" + request.getParameter("bookingId") + "&error=1");
                    return;
                }

                Date createdAt = booking.getCreatedAt();
                LocalDateTime creationTime = LocalDateTime.ofInstant(createdAt.toInstant(), ZoneId.of("Asia/Ho_Chi_Minh"));
                String transDateStr = creationTime.format(DateTimeFormatter.ofPattern("yyyyMMddHHmmss"));

                String redirectUrl = request.getContextPath() + "/vnpayrefund"
                        + "?order_id=" + payment.getPaymentId()
                        + "&amount=" + payment.getTotalAmount().intValue()
                        + "&trans_date=" + transDateStr
                        + "&user=" + URLEncoder.encode(currentUser.getFull_name(), "UTF-8");
                response.sendRedirect(redirectUrl);

            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("booking_detail?bookingId=" + request.getParameter("bookingId") + "&error=1");
            }
            //Xử lý feedback
        } else {
            String bookingIdStr = request.getParameter("bookingId");
            String poolIdStr = request.getParameter("poolId");
            String ratingStr = request.getParameter("rating");
            String comment = request.getParameter("comment");

            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                int poolId = Integer.parseInt(poolIdStr);
                int rating = Integer.parseInt(ratingStr);
                BookingDetailDAO bookingDetailDAO = new BookingDetailDAO();
                BookingDetails bookingDetail = bookingDetailDAO.getBookingDetailById(bookingId);
                if (bookingDetail == null || bookingDetail.getUserId() != userId) {
                    response.sendRedirect("booking_history");
                    return;
                }
                FeedbackDAO feedbackDAO = new FeedbackDAO();
                List<Feedback> feedbackList = feedbackDAO.getFeedbackByUserId(userId);
                boolean alreadyFeedback = false;
                for (Feedback fb : feedbackList) {
                    if (fb.getPoolId() == poolId) {
                        alreadyFeedback = true;
                        break;
                    }
                }
                if (!alreadyFeedback) {
                    feedbackDAO.sendFeedback(currentUser, poolId, rating, comment);
                    response.sendRedirect("booking_detail?bookingId=" + bookingId + "&success=1");
                } else {
                    response.sendRedirect("booking_detail?bookingId=" + bookingId + "&error=1");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("booking_detail?bookingId=" + request.getParameter("bookingId") + "&error=1");
            }
        }
    }
}
