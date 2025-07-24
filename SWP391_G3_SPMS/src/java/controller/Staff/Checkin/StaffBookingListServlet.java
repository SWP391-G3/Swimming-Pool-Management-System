package controller.Staff.Checkin;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.staff.CustomerCheckinDAO;
import dao.customer.BookingDetailDAO;
import model.staff.StaffCheckinInfo;
import model.staff.StaffJoinedTable;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet(name = "StaffBookingListServlet", urlPatterns = {"/checkin_list"})
public class StaffBookingListServlet extends HttpServlet {

    private static final int RECORDS_PER_PAGE = 10; // Số bản ghi mỗi trang

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy thông tin staff để biết poolId
        HttpSession session = request.getSession();
        StaffJoinedTable staff = (StaffJoinedTable) session.getAttribute("staff");
        int poolId = staff != null ? staff.getPoolId() : 0;

        // Lấy các tham số filter
        String type = request.getParameter("type");
        String search = request.getParameter("search");
        String fromDate = request.getParameter("fromDate");
        String toDate = request.getParameter("toDate");
        String status = request.getParameter("status");
        String message = request.getParameter("message");

        // Lấy tham số phân trang
        String pageStr = request.getParameter("page");
        int currentPage = 1;
        try {
            if (pageStr != null && !pageStr.isEmpty()) {
                currentPage = Integer.parseInt(pageStr);
                if (currentPage < 1) {
                    currentPage = 1;
                }
            }
        } catch (NumberFormatException e) {
            currentPage = 1;
        }

        // Xử lý giá trị mặc định
        if (type == null || type.isEmpty()) {
            type = "checkin";
        }
        if (search == null) {
            search = "";
        }
        if (status == null) {
            status = "";
        }

        // Nếu không có ngày, mặc định là hôm nay
        if (fromDate == null || fromDate.isEmpty()) {
            fromDate = LocalDate.now().toString();
        }
        if (toDate == null || toDate.isEmpty()) {
            toDate = LocalDate.now().toString();
        }

        // Tính offset cho phân trang
        int offset = (currentPage - 1) * RECORDS_PER_PAGE;

        // Lấy danh sách và tổng số bản ghi
        List<StaffCheckinInfo> list;
        int totalRecords;

        if ("booking".equalsIgnoreCase(type)) {
            BookingDetailDAO bookingDao = new BookingDetailDAO();
            list = bookingDao.getBookingByPoolIdWithPagination(poolId, fromDate, toDate, search, status, offset, RECORDS_PER_PAGE);
            totalRecords = bookingDao.countBookingByPoolId(poolId, fromDate, toDate, search, status);
        } else {
            CustomerCheckinDAO checkinDao = new CustomerCheckinDAO();
            list = checkinDao.getCheckedInListWithPagination(fromDate, toDate, search, status, offset, RECORDS_PER_PAGE);
            totalRecords = checkinDao.countCheckedInList(fromDate, toDate, search, status);
        }

        // Tính toán thông tin phân trang
        int totalPages = (int) Math.ceil((double) totalRecords / RECORDS_PER_PAGE);
        if (totalPages == 0) {
            totalPages = 1;
        }
        if (currentPage > totalPages) {
            currentPage = totalPages;
        }

        // Gán các attribute cho JSP
        request.setAttribute("list", list);
        request.setAttribute("search", search);
        request.setAttribute("fromDate", fromDate);
        request.setAttribute("toDate", toDate);
        request.setAttribute("type", type);
        request.setAttribute("status", status);
        request.setAttribute("message", message);

        // Thông tin phân trang
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalRecords", totalRecords);
        request.setAttribute("recordsPerPage", RECORDS_PER_PAGE);

        // Forward tới JSP
        request.getRequestDispatcher("staffCheckin.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
