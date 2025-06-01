package controller.Customer;

import dao.BookingDetailDAO;
import dao.FeedbackDAO;
import model.BookingDetails;
import model.Feedback;
import model.User;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

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
            User user = (User) request.getSession().getAttribute("user");
            Feedback userFeedback = null;
            if (user != null) {
                FeedbackDAO feedbackDAO = new FeedbackDAO();
                List<Feedback> feedbackList = feedbackDAO.getFeedbackByUserId(user.getUserId());
                for (Feedback fb : feedbackList) {
                    // Nếu user đã feedback cho đúng pool này
                    if (fb.getPoolId() == bookingDetail.getPoolId()) {
                        userFeedback = fb;
                        break;
                    }
                }
            }

            request.setAttribute("bookingDetail", bookingDetail);
            request.setAttribute("userFeedback", userFeedback);
            request.setAttribute("successMsg", request.getParameter("success"));
            request.setAttribute("errorMsg", request.getParameter("error"));
            request.getRequestDispatcher("BookingDetail.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        User user = (User) request.getSession().getAttribute("user");
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
            if (bookingDetail == null || bookingDetail.getUserId() != user.getUserId()) {
                response.sendRedirect("booking_history");
                return;
            }

            // Đảm bảo user chỉ feedback 1 lần cho hồ bơi này
            FeedbackDAO feedbackDAO = new FeedbackDAO();
            List<Feedback> feedbackList = feedbackDAO.getFeedbackByUserId(user.getUserId());
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
                // Không cho feedback lần 2
                response.sendRedirect("booking_detail?bookingId=" + bookingId + "&error=1");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("booking_detail?bookingId=" + request.getParameter("bookingId") + "&error=1");
        }
    }
}