package controller.Customer;

import dao.customer.BookingDetailDAO;
import dao.customer.UserDAO;
import model.customer.BookingDetails;
import java.io.IOException;
import java.sql.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.customer.User;
/**
 *
 * @author LAZYVL
 */

public class BookingHistoryServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("customerAccount");
            if (currentUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            int userId = currentUser.getUser_id();

            UserDAO userDAO = new UserDAO();
            User userDetails = userDAO.getUserByID(userId);

            String poolName = request.getParameter("poolName");
            String fromDateStr = request.getParameter("fromDate");
            String toDateStr = request.getParameter("toDate");
            String status = request.getParameter("status");
            String sortOrder = request.getParameter("sortOrder");

            // Thêm pageSize
            int pageSize = 5;
            String pageSizeStr = request.getParameter("pageSize");
            if (pageSizeStr != null && !pageSizeStr.isEmpty()) {
                try {
                    pageSize = Integer.parseInt(pageSizeStr);
                    if (pageSize < 1) {
                        pageSize = 1;
                    }
                    if (pageSize > 50) {
                        pageSize = 50;
                    }
                } catch (NumberFormatException e) {
                    pageSize = 5;
                }
            }

            // Lấy trang hiện tại (nếu không có thì mặc định là 1)
            int page = 1;
            String pageStr = request.getParameter("page");
            if (pageStr != null && !pageStr.isEmpty()) {
                page = Integer.parseInt(pageStr);
            }

            BookingDetailDAO dao = new BookingDetailDAO();
            int totalBookings = dao.countBookingDetails(userId, poolName, fromDateStr, toDateStr, status);
            int totalPages = (int) Math.ceil((double) totalBookings / pageSize);

            List<BookingDetails> bookingList = dao.searchBookingDetails(
                    userId, poolName, fromDateStr, toDateStr, status, sortOrder, page, pageSize
            );

            request.setAttribute("bookingList", bookingList);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("poolName", poolName);
            request.setAttribute("fromDate", fromDateStr);
            request.setAttribute("toDate", toDateStr);
            request.setAttribute("status", status);
            request.setAttribute("sortOrder", sortOrder);
            request.setAttribute("pageSize", pageSize);

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi lấy lịch sử đặt bể!");
        }
        request.getRequestDispatcher("BookingHistory.jsp").forward(request, response);
    }
}
