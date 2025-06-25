package controller.Customer;

import dao.customer.*;
import model.customer.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.sql.Date;
import java.sql.Time;

public class BookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String service = request.getParameter("service");
        if (service == null) {
            service = "showBookingPage";
        }
        if (service.equals("showBookingPage")) {
            try {
//            String poolIdRaw = request.getParameter("poolId");
//            if (poolIdRaw == null) {
//                response.getWriter().println("Thiếu poolId trên URL hoặc form!");
//                return;
//            }
//            int poolId = Integer.parseInt(poolIdRaw);

                int poolId = 2; //Hardcode để tsst

                // Lấy thông tin pool
                PoolDAO poolDAO = new PoolDAO();
                Pool pool = poolDAO.getPoolByID(poolId);

                // Lấy danh sách loại vé
                TicketTypeDAO ticketTypeDAO = new TicketTypeDAO();
                List<TicketType> ticketTypes = ticketTypeDAO.getTicketTypesByPoolId(poolId);

                // Lấy danh sách dịch vụ thuê đồ
                PoolServiceDAO poolServiceDAO = new PoolServiceDAO();
                List<PoolService> poolServices = poolServiceDAO.getServicesByPoolId(poolId);

                // Lấy các voucher/discount hợp lệ
                DiscountDAO discountDAO = new DiscountDAO();
                List<Discounts> discounts = discountDAO.getAvailableDiscountsForUser(user.getUser_id());

                // Chuẩn bị dữ liệu truyền sang JSP
                BookingPageData pageData = new BookingPageData();
                pageData.setUser(user);
                pageData.setPool(pool);
                pageData.setTicketTypes(ticketTypes);
                pageData.setPoolServices(poolServices);
                pageData.setDiscounts(discounts);

                request.setAttribute("pageData", pageData);
                request.getRequestDispatcher("Booking.jsp").forward(request, response);
            } catch (Exception e) {
                e.printStackTrace();
                response.getWriter().println("Lỗi khi tải dữ liệu trang Booking: " + e.getMessage());
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//            String poolIdRaw = request.getParameter("poolId");
//            if (poolIdRaw == null) {
//                response.getWriter().println("Thiếu poolId trên URL hoặc form!");
//                return;
//            }
//            int poolId = Integer.parseInt(poolIdRaw);

        int poolId = 2; //Hardcode để tsst
        String bookingDateStr = request.getParameter("bookingDate");
        String startTimeStr = request.getParameter("startTime");
        String endTimeStr = request.getParameter("endTime");
        int slotCount = Integer.parseInt(request.getParameter("slotCount"));
        String discountCode = request.getParameter("discountCode");

        String[] ticketTypeIds = request.getParameterValues("ticketTypeId");
        String[] ticketTypeNames = request.getParameterValues("ticketTypeName");
        String[] ticketPrices = request.getParameterValues("ticketPrice");
        String[] ticketQuantities = request.getParameterValues("ticketQuantity");

        String[] rentIds = request.getParameterValues("rentId");
        String[] rentNames = request.getParameterValues("rentName");
        String[] rentPrices = request.getParameterValues("rentPrice");
        String[] rentQuantities = request.getParameterValues("rentQuantity");

        // Build danh sách vé, dịch vụ thuê
        List<TicketSelection> selectedTickets = new ArrayList<>();
        if (ticketTypeIds != null) {
            for (int i = 0; i < ticketTypeIds.length; i++) {
                selectedTickets.add(new TicketSelection(
                        Integer.parseInt(ticketTypeIds[i]),
                        ticketTypeNames[i],
                        new BigDecimal(ticketPrices[i]),
                        Integer.parseInt(ticketQuantities[i])
                ));
            }
        }
        List<PoolServiceSelection> selectedRents = new ArrayList<>();
        if (rentIds != null) {
            for (int i = 0; i < rentIds.length; i++) {
                selectedRents.add(new PoolServiceSelection(
                        Integer.parseInt(rentIds[i]),
                        rentNames[i],
                        new BigDecimal(rentPrices[i]),
                        Integer.parseInt(rentQuantities[i])
                ));
            }
        }

        // Lấy user từ session
        User user = (User) request.getSession().getAttribute("currentUser");
        // Lấy pool, discount nếu cần hiển thị chi tiết
        Pool pool = new PoolDAO().getPoolByID(poolId);
        Discounts selectedDiscount = discountCode != null && !discountCode.isEmpty()
                ? new DiscountDAO().getDiscountByCode(discountCode)
                : null;

        // Tính tổng tiền
        BigDecimal totalAmount = BigDecimal.ZERO;
        for (TicketSelection t : selectedTickets) {
            totalAmount = totalAmount.add(t.getPrice().multiply(BigDecimal.valueOf(t.getQuantity())));
        }
        for (PoolServiceSelection r : selectedRents) {
            totalAmount = totalAmount.add(r.getPrice().multiply(BigDecimal.valueOf(r.getQuantity())));
        }

        // Tính giảm giá đúng theo phần trăm
        BigDecimal discountAmount = BigDecimal.ZERO;
        if (selectedDiscount != null && selectedDiscount.getDiscountPercent() != null) {
            discountAmount = totalAmount.multiply(selectedDiscount.getDiscountPercent()).divide(BigDecimal.valueOf(100));
        }

        BigDecimal finalAmount = totalAmount.subtract(discountAmount);
        if (finalAmount.compareTo(BigDecimal.ZERO) < 0) {
            finalAmount = BigDecimal.ZERO;
        }

        //Check bookingDate
        Date bookingDate = null;
        if (bookingDateStr != null && !bookingDateStr.isBlank()) {
            try {
                bookingDate = Date.valueOf(bookingDateStr);
            } catch (IllegalArgumentException e) {
                System.out.println("Sai định dạng ngày: " + bookingDateStr);
            }
        } else {
            System.out.println("Không có ngày đặt!");
        }

        //Check startTime & endTime
        Time startTime = null;
        Time endTime = null;

        try {
            if (startTimeStr != null && !startTimeStr.isBlank()) {
                startTime = Time.valueOf(startTimeStr + ":00");
            }
            if (endTimeStr != null && !endTimeStr.isBlank()) {
                endTime = Time.valueOf(endTimeStr + ":00");
            }
        } catch (IllegalArgumentException e) {
            e.printStackTrace();
        }

        //Tinh TicketSlot
        List<TicketSlot> ts = new ArrayList<>();

        for (int i = 0; i < ticketTypeIds.length; i++) {
            TicketTypeDAO ttDAO = new TicketTypeDAO();
            int ticketTypeId = Integer.parseInt(ticketTypeIds[i]);
            TicketSlot tts = ttDAO.getTicketSlotByTicketTypeId(ticketTypeId);
            ts.add(tts);
        }

        int countTicketSlot = 0;
        for (TicketSlot t : ts) {
            countTicketSlot += t.getTicketSlot();
        }

        // Build BookingPageData
        BookingPageData pageData = new BookingPageData(
                user, pool, null, null, null,
                bookingDate,
                startTime,
                endTime,
                countTicketSlot,
                selectedTickets,
                selectedRents,
                selectedDiscount,
                totalAmount,
                discountAmount,
                finalAmount
        );
        // Lưu vào session
        request.getSession().setAttribute("bookingPageData", pageData);
        // Redirect sang bước thanh toán
        response.sendRedirect("payment");
    }
}
