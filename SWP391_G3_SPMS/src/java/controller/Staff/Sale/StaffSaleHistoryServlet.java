package controller.Staff.Sale;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import dao.staff.SaleTicketDirectlyDAO;
import model.staff.*;

@WebServlet(name = "StaffSaleHistoryServlet", urlPatterns = {"/staff_sale_history"})
public class StaffSaleHistoryServlet extends HttpServlet {

    private static final int RECORDS_PER_PAGE = 10;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        StaffJoinedTable staff = (StaffJoinedTable) session.getAttribute("staff");

        if (staff == null) {
            response.sendRedirect("login");
            return;
        }

        // ✅ Kiểm tra xem có phải là request xem chi tiết không
        String saleIdStr = request.getParameter("saleId");
        if (saleIdStr != null && !saleIdStr.isEmpty()) {
            // Forward đến trang chi tiết
            showSaleDetail(request, response, staff);
            return;
        }

        try {
            // ✅ Get parameters cho danh sách
            String pageStr = request.getParameter("page");
            String search = request.getParameter("search");
            String fromDateStr = request.getParameter("fromDate");
            String toDateStr = request.getParameter("toDate");
            String sortBy = request.getParameter("sortBy");
            String sortOrder = request.getParameter("sortOrder");
            String pageSizeStr = request.getParameter("pageSize");

            // Process parameters
            int page = 1;
            if (pageStr != null && !pageStr.isEmpty()) {
                try {
                    page = Integer.parseInt(pageStr);
                    if (page < 1) {
                        page = 1;
                    }
                } catch (NumberFormatException e) {
                    page = 1;
                }
            }

            int pageSize = RECORDS_PER_PAGE;
            if (pageSizeStr != null && !pageSizeStr.isEmpty()) {
                try {
                    pageSize = Integer.parseInt(pageSizeStr);
                    if (pageSize < 5 || pageSize > 100) {
                        pageSize = RECORDS_PER_PAGE;
                    }
                } catch (NumberFormatException e) {
                    pageSize = RECORDS_PER_PAGE;
                }
            }

            if (sortBy == null || sortBy.isEmpty()) {
                sortBy = "date";
            }
            if (sortOrder == null || sortOrder.isEmpty()) {
                sortOrder = "desc";
            }

            // Parse dates
            Date fromDate = null;
            Date toDate = null;
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

            if (fromDateStr != null && !fromDateStr.isEmpty()) {
                fromDate = new Date(sdf.parse(fromDateStr).getTime());
            }
            if (toDateStr != null && !toDateStr.isEmpty()) {
                toDate = new Date(sdf.parse(toDateStr).getTime());
            }

            // Calculate pagination
            int offset = (page - 1) * pageSize;

            // Get data
            SaleTicketDirectlyDAO saleDAO = new SaleTicketDirectlyDAO();

            List<SaleTicketDirectly> salesHistory = saleDAO.getSaleHistoryByStaff(
                    staff.getStaffId(),
                    staff.getPoolId(),
                    offset,
                    pageSize,
                    search,
                    fromDate,
                    toDate,
                    sortBy,
                    sortOrder
            );

            int totalRecords = saleDAO.countSaleHistoryByStaff(
                    staff.getStaffId(),
                    staff.getPoolId(),
                    search,
                    fromDate,
                    toDate
            );

            SaleStatistics statistics = saleDAO.getSaleStatistics(
                    staff.getStaffId(),
                    staff.getPoolId(),
                    search,
                    fromDate,
                    toDate
            );

            int totalPages = (int) Math.ceil((double) totalRecords / pageSize);

            // Set attributes
            request.setAttribute("staff", staff);
            request.setAttribute("salesHistory", salesHistory);
            request.setAttribute("statistics", statistics);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("totalRecords", totalRecords);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("search", search);
            request.setAttribute("fromDate", fromDateStr);
            request.setAttribute("toDate", toDateStr);
            request.setAttribute("sortBy", sortBy);
            request.setAttribute("sortOrder", sortOrder);

            System.out.println("=== Staff Sale History ===");
            System.out.println("Staff ID: " + staff.getStaffId());
            System.out.println("Pool ID: " + staff.getPoolId());
            System.out.println("Page: " + page + "/" + totalPages + " (Size: " + pageSize + ")");
            System.out.println("Total Records: " + totalRecords);
            System.out.println("Sales found: " + salesHistory.size());

        } catch (Exception e) {
            System.out.println("Error in StaffSaleHistoryServlet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải dữ liệu");
        }

        // Forward đến trang danh sách
        request.getRequestDispatcher("staffSaleHistory.jsp").forward(request, response);
    }

    // ✅ Method xử lý chi tiết đơn giản
    private void showSaleDetail(HttpServletRequest request, HttpServletResponse response, StaffJoinedTable staff)
            throws ServletException, IOException {

        try {
            String saleIdStr = request.getParameter("saleId");
            int saleId = Integer.parseInt(saleIdStr);

            SaleTicketDirectlyDAO saleDAO = new SaleTicketDirectlyDAO();
            SaleDetailInfo detailInfo = saleDAO.getSaleDetailInfo(saleId);

            if (detailInfo == null) {
                request.setAttribute("error", "Không tìm thấy giao dịch");
            } else {
                request.setAttribute("detailInfo", detailInfo);
            }

            request.setAttribute("staff", staff);

            // Forward đến trang chi tiết
            request.getRequestDispatcher("staffSaleDetail.jsp").forward(request, response);

        } catch (Exception e) {
            System.out.println("Error getting sale detail: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra khi tải chi tiết");
            request.getRequestDispatcher("staffSaleDetail.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // POST chỉ redirect về GET
        doGet(request, response);
    }
}
