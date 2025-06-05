package controller.Customer;

import dao.BookingDetailDAO;
import model.BookingDetails;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class BookingHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy session hiện có
            HttpSession session = request.getSession(false);
            Integer userId = null;
            if (session != null) {
                userId = (Integer) session.getAttribute("userId");
            }
            if (userId == null) {
//                response.sendRedirect("login.jsp");
//                return;
                userId = 2;
            }

            String poolName = request.getParameter("poolName");
            String fromDateStr = request.getParameter("fromDate");
            String status = request.getParameter("status");
            String sortOrder = request.getParameter("sortOrder");

            BookingDetailDAO dao = new BookingDetailDAO();
            List<BookingDetails> bookingList = dao.searchBookingDetails(userId,poolName,fromDateStr,status,sortOrder);

            request.setAttribute("bookingList", bookingList);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi lấy lịch sử đặt bể!");
        }
        request.getRequestDispatcher("BookingHistory.jsp").forward(request, response);
    }
}
