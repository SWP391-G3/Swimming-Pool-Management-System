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

            // Lấy trang hiện tại (nếu không có thì mặc định là 1)
            int page = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                page = Integer.parseInt(pageStr);
            }
            int pageSize = 5;

            BookingDetailDAO dao = new BookingDetailDAO();
            int totalBookings = dao.countBookingDetails(userId, poolName, fromDateStr, status);
            int totalPages = (int) Math.ceil((double) totalBookings / pageSize);

            List<BookingDetails> bookingList = dao.searchBookingDetails(
                    userId, poolName, fromDateStr, status, sortOrder, page, pageSize
            );

            request.setAttribute("bookingList", bookingList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            // Giữ lại các tham số filter để dùng cho link phân trang
            request.setAttribute("poolName", poolName);
            request.setAttribute("fromDate", fromDateStr);
            request.setAttribute("status", status);
            request.setAttribute("sortOrder", sortOrder);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi lấy lịch sử đặt bể!");
        }
        request.getRequestDispatcher("BookingHistory.jsp").forward(request, response);
    }
}
