package controller.Customer;

import dao.customer.BookingDetailDAO;
import dao.customer.FeedbackDAO;
import dao.customer.UserDAO;
import model.customer.BookingDetails;
import model.customer.Feedback;
import model.customer.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.time.LocalDate; // Thêm import này

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
            User user = (User) request.getSession().getAttribute("currentUser");
            Feedback userFeedback = null;
            if (user != null) {
                FeedbackDAO feedbackDAO = new FeedbackDAO();
                List<Feedback> feedbackList = feedbackDAO.getFeedbackByUserId(user.getUser_id());
                for (Feedback fb : feedbackList) {
                    // Nếu user đã feedback cho pool này
                    if (fb.getPoolId() == bookingDetail.getPoolId()) {
                        userFeedback = fb;
                        break;
                    }
                }
            }

            // Kiểm tra có cho phép huỷ không (nếu ngày đặt < hôm nay thì không cho huỷ)
            LocalDate today = LocalDate.now();
            boolean canCancel = bookingDetail.getBookingDate().toLocalDate().isAfter(today);

            request.setAttribute("bookingDetail", bookingDetail);
            request.setAttribute("userFeedback", userFeedback);
            request.setAttribute("successMsg", request.getParameter("success"));
            request.setAttribute("errorMsg", request.getParameter("error"));
            request.setAttribute("canCancel", canCancel);
            request.getRequestDispatcher("BookingDetail.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        // ----------- Xử lý huỷ đặt bể -----------
        if ("cancelBooking".equals(action)) {
            String bookingIdStr = request.getParameter("bookingId");
            User currentUser = (User) request.getSession().getAttribute("currentUser");
            int userId = currentUser.getUser_id();
            try {
                int bookingId = Integer.parseInt(bookingIdStr);
                BookingDetailDAO bookingDetailDAO = new BookingDetailDAO();
                BookingDetails bookingDetail = bookingDetailDAO.getBookingDetailById(bookingId);
                // Kiểm tra quyền huỷ
                if (bookingDetail == null || bookingDetail.getUserId() != userId) {
                    response.sendRedirect("booking_history");
                    return;
                }
                // Kiểm tra ngày đặt để không cho huỷ nếu đã quá hoặc bằng hôm nay
                LocalDate today = LocalDate.now();
                if (!bookingDetail.getBookingDate().toLocalDate().isAfter(today)) {
                    response.sendRedirect("booking_detail?bookingId=" + bookingId + "&error=1");
                    return;
                }
                // Huỷ đặt bể
                bookingDetailDAO.cancelBooking(bookingId);
                response.sendRedirect("booking_detail?bookingId=" + bookingId);
                return;
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("booking_detail?bookingId=" + bookingIdStr + "&error=1");
                return;
            }
        }

        // ----------- Xử lý gửi feedback -----------
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        int userId = currentUser.getUser_id();

        UserDAO userDAO = new UserDAO();
        User user = userDAO.getUserByID(userId);

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        String bookingIdStr = request.getParameter("bookingId");
        String poolIdStr = request.getParameter("poolId");
        String ratingStr = request.getParameter("rating");
        String comment = request.getParameter("comment");

        try {
            int bookingId = Integer.parseInt(bookingIdStr);
            int poolId = Integer.parseInt(poolIdStr);
            int rating = Integer.parseInt(ratingStr);

            // Kiểm tra quyền feedback
            BookingDetailDAO bookingDetailDAO = new BookingDetailDAO();
            BookingDetails bookingDetail = bookingDetailDAO.getBookingDetailById(bookingId);
            if (bookingDetail == null || bookingDetail.getUserId() != user.getUser_id()) {
                response.sendRedirect("booking_history");
                return;
            }

            // Đảm bảo user chỉ feedback 1 lần cho hồ bơi này
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            List<Feedback> feedbackList = feedbackDAO.getFeedbackByUserId(user.getUser_id());
            boolean alreadyFeedback = false;
            for (Feedback fb : feedbackList) {
                if (fb.getPoolId() == poolId) {
                    alreadyFeedback = true;
                    break;
                }
            }
            if (!alreadyFeedback) {
                feedbackDAO.sendFeedback(user, poolId, rating, comment);
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