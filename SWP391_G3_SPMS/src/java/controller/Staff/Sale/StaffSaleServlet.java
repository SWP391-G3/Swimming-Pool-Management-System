package controller.Staff.Sale;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import dao.customer.*;
import dao.staff.SaleTicketDirectlyDAO;
import model.staff.StaffSaleData;
import model.staff.StaffJoinedTable;
import model.customer.User;
import model.customer.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.staff.StaffSaleResult;
import java.sql.Time;
import java.time.LocalTime;
import model.staff.SaleTicketDirectly;

@WebServlet(name = "StaffSaleServlet", urlPatterns = {"/staff_sale"})
public class StaffSaleServlet extends HttpServlet {

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

        // Tạo StaffSaleData mới hoặc lấy từ session
        StaffSaleData saleData = (StaffSaleData) session.getAttribute("staffSaleData");

        if (saleData == null) {
            try {
                saleData = new StaffSaleData();
                saleData.setBookingDate(java.sql.Date.valueOf(LocalDate.now()));

                try {
                    PoolDAO poolDAO = new PoolDAO();
                    Pool pool = poolDAO.getPoolByID(staff.getPoolId());
                    if (pool != null) {
                        saleData.setPool(pool);
                    }
                } catch (Exception e) {
                    // ignore
                }

                try {
                    TicketTypeDAO ticketTypeDAO = new TicketTypeDAO();
                    List<TicketType> ticketTypes = ticketTypeDAO.getTicketTypesByPoolId(staff.getPoolId());
                    saleData.setAvailableTicketTypes(ticketTypes != null ? ticketTypes : new ArrayList<>());
                } catch (Exception e) {
                    saleData.setAvailableTicketTypes(new ArrayList<>());
                }

                try {
                    PoolServiceDAO serviceDAO = new PoolServiceDAO();
                    List<PoolService> services = serviceDAO.getServicesByPoolId(staff.getPoolId());
                    saleData.setAvailableServices(services != null ? services : new ArrayList<>());
                } catch (Exception e) {
                    saleData.setAvailableServices(new ArrayList<>());
                }

                session.setAttribute("staffSaleData", saleData);

            } catch (Exception e) {
                saleData = new StaffSaleData();
                session.setAttribute("staffSaleData", saleData);
            }
        }

        request.setAttribute("staff", staff);
        request.setAttribute("saleData", saleData);
        request.getRequestDispatcher("staffSale.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("searchCustomer".equals(action)) {
            handleSearchCustomer(request, response);
        } else if ("checkCustomer".equals(action)) {
            handleCheckCustomer(request, response);
        } else if ("updateTickets".equals(action)) {
            handleUpdateTickets(request, response);
        } else if ("updateServices".equals(action)) {
            handleUpdateServices(request, response);
        } else if ("processPayment".equals(action)) {
            handleProcessPayment(request, response);
        } else {
            doGet(request, response);
        }
    }

    private void handleSearchCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/plain; charset=UTF-8");
        String phone = request.getParameter("phone");

        try (PrintWriter out = response.getWriter()) {
            if (phone != null && phone.trim().length() >= 3) {
                UserDAO userDAO = new UserDAO();
                List<User> customers = userDAO.searchCustomersByPhone(phone);

                if (customers != null && !customers.isEmpty()) {
                    for (User customer : customers) {
                        out.println(customer.getUser_id() + "|"
                                + cleanText(customer.getFull_name()) + "|"
                                + cleanText(customer.getEmail()) + "|"
                                + cleanText(customer.getPhone()));
                    }
                } else {
                    out.print("NOT_FOUND");
                }
            } else {
                out.print("NOT_FOUND");
            }
        } catch (Exception e) {
            response.getWriter().print("ERROR");
        }
    }

    // Helper method
    private String cleanText(String text) {
        if (text == null) {
            return "";
        }
        return text.replace("|", "").replace("\n", "").replace("\r", "");
    }

    private void handleCheckCustomer(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        StaffSaleData saleData = (StaffSaleData) session.getAttribute("staffSaleData");

        String phone = request.getParameter("customerPhone");
        String name = request.getParameter("customerName");
        String email = request.getParameter("customerEmail");

        saleData.setCustomerPhone(phone);
        saleData.setCustomerName(name);
        saleData.setCustomerEmail(email);

        UserDAO userDAO = new UserDAO();
        User customer = userDAO.getUserByPhone(phone);

        if (customer != null) {
            saleData.setCustomer(customer);
            saleData.setHasAccount(true);
            saleData.setCustomerName(customer.getFull_name());
            saleData.setCustomerEmail(customer.getEmail());

            DiscountDAO discountDAO = new DiscountDAO();
            List<Discounts> discounts = discountDAO.getAvailableDiscountsForUser(customer.getUser_id());
            saleData.setAvailableDiscounts(discounts);
        } else {
            saleData.setCustomer(null);
            saleData.setHasAccount(false);
            saleData.setAvailableDiscounts(null);
        }

        session.setAttribute("staffSaleData", saleData);
        response.sendRedirect("staff_sale");
    }

    private void handleUpdateTickets(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("staff_sale");
    }

    private void handleUpdateServices(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("staff_sale");
    }

    private void handleProcessPayment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        StaffJoinedTable staff = (StaffJoinedTable) session.getAttribute("staff");

        if (staff == null) {
            response.sendRedirect("login");
            return;
        }

        try {
            String customerPhone = request.getParameter("customerPhone");
            String customerName = request.getParameter("customerName");
            String customerEmail = request.getParameter("customerEmail");
            String isExistingStr = request.getParameter("isExisting");
            String userIdStr = request.getParameter("userId");

            boolean isExisting = "true".equals(isExistingStr);
            Integer userId = null;

            if (isExisting && userIdStr != null && !userIdStr.isEmpty()) {
                userId = Integer.parseInt(userIdStr);
            }

            if (customerPhone == null || customerPhone.trim().isEmpty()) {
                response.sendRedirect("staff_sale?error=missing_phone");
                return;
            }

            if (customerName == null || customerName.trim().isEmpty()) {
                response.sendRedirect("staff_sale?error=missing_name");
                return;
            }

            List<TicketSelection> selectedTickets = new ArrayList<>();
            List<PoolServiceSelection> selectedServices = new ArrayList<>();
            BigDecimal totalAmount = BigDecimal.ZERO;

            TicketTypeDAO ticketTypeDAO = new TicketTypeDAO();
            for (String paramName : request.getParameterMap().keySet()) {
                if (paramName.startsWith("ticket-") && !paramName.endsWith("-price")) {
                    String quantityStr = request.getParameter(paramName);
                    String priceStr = request.getParameter(paramName + "-price");

                    if (quantityStr != null && !quantityStr.equals("0") && priceStr != null) {
                        int ticketTypeId = Integer.parseInt(paramName.substring(7));
                        int quantity = Integer.parseInt(quantityStr);
                        BigDecimal price = new BigDecimal(priceStr);

                        TicketType ticketType = ticketTypeDAO.getTicketTypeById(ticketTypeId);
                        String typeName = ticketType != null ? ticketType.getTypeName() : "Unknown";

                        selectedTickets.add(new TicketSelection(ticketTypeId, typeName, price, quantity));
                        totalAmount = totalAmount.add(price.multiply(BigDecimal.valueOf(quantity)));
                    }
                }
            }

            PoolServiceDAO poolServiceDAO = new PoolServiceDAO();
            for (String paramName : request.getParameterMap().keySet()) {
                if (paramName.startsWith("service-") && !paramName.endsWith("-price")) {
                    String quantityStr = request.getParameter(paramName);
                    String priceStr = request.getParameter(paramName + "-price");

                    if (quantityStr != null && !quantityStr.equals("0") && priceStr != null) {
                        int serviceId = Integer.parseInt(paramName.substring(8));
                        int quantity = Integer.parseInt(quantityStr);
                        BigDecimal price = new BigDecimal(priceStr);

                        String serviceName = "Service #" + serviceId;

                        selectedServices.add(new PoolServiceSelection(serviceId, serviceName, price, quantity));
                        totalAmount = totalAmount.add(price.multiply(BigDecimal.valueOf(quantity)));
                    }
                }
            }

            if (selectedTickets.isEmpty() && selectedServices.isEmpty()) {
                response.sendRedirect("staff_sale?error=no_items");
                return;
            }

            int totalPerson = 0;
            for (TicketSelection t : selectedTickets) {
                TicketSlot slotObj = ticketTypeDAO.getTicketSlotByTicketTypeId(t.getTicketTypeId());
                int ticketSlot = slotObj != null ? slotObj.getTicketSlot() : 1;
                totalPerson += ticketSlot * t.getQuantity();
            }

            if (totalPerson > 10) {
                response.sendRedirect("staff_sale?error=too_many_people&count=" + totalPerson);
                return;
            }

            if (isExisting && userIdStr != null && !userIdStr.trim().isEmpty()) {
                try {
                    userId = Integer.parseInt(userIdStr);
                } catch (NumberFormatException e) {
                    userId = null;
                }
            } else {
                userId = null;
            }

            Booking booking = new Booking();
            booking.setUserId(userId);
            booking.setPoolId(staff.getPoolId());
            booking.setDiscountId(null);
            booking.setBookingDate(new java.sql.Date(System.currentTimeMillis()));

            LocalTime now = java.time.LocalTime.now();
            LocalTime twoHoursLater = now.plusHours(2);

            if (now.isAfter(java.time.LocalTime.of(22, 0))) {
                now = LocalTime.of(8, 0);
                twoHoursLater = LocalTime.of(10, 0);
            } else if (twoHoursLater.isAfter(java.time.LocalTime.of(23, 59))) {
                twoHoursLater = LocalTime.of(23, 59);
            }

            Time startTime = Time.valueOf(now);
            Time endTime = Time.valueOf(twoHoursLater);

            booking.setStartTime(startTime);
            booking.setEndTime(endTime);
            booking.setSlotCount(totalPerson);
            booking.setBookingStatus("confirmed");

            BookingDAO bookingDAO = new BookingDAO();
            int bookingId = bookingDAO.createBooking(booking);

            if (bookingId <= 0) {
                response.sendRedirect("staff_sale?error=booking_failed");
                return;
            }

            TicketDAO ticketDAO = new TicketDAO();
            List<Integer> ticketIds = new ArrayList<>();
            for (TicketSelection t : selectedTickets) {
                for (int i = 0; i < t.getQuantity(); i++) {
                    int ticketId = ticketDAO.addTicket(bookingId, t.getTicketTypeId(), t.getPrice(), userId);
                    ticketIds.add(ticketId);
                }
            }

            BookingServiceDAO bookingServiceDAO = new BookingServiceDAO();
            for (PoolServiceSelection s : selectedServices) {
                int branchId = staff.getBranchId();
                bookingServiceDAO.addServiceToBooking(
                        bookingId,
                        s.getPoolServiceId(),
                        branchId,
                        s.getQuantity(),
                        s.getPrice()
                );
            }

            Payment payment = new Payment();
            payment.setBookingId(bookingId);
            payment.setPaymentMethod("Cash");
            payment.setPaymentStatus("completed");
            payment.setPaymentDate(new java.sql.Date(System.currentTimeMillis()));
            payment.setTotalAmount(totalAmount);
            payment.setDiscountAmount(BigDecimal.ZERO);
            payment.setTransactionReference(bookingId + "");

            PaymentDAO paymentDAO = new PaymentDAO();
            paymentDAO.addPayment(payment);
            int paymentId = paymentDAO.getLastPaymentIdByBookingId(bookingId);

            PaymentTicketDAO paymentTicketDAO = new PaymentTicketDAO();
            int ticketIndex = 0;
            for (TicketSelection t : selectedTickets) {
                for (int i = 0; i < t.getQuantity(); i++) {
                    int ticketId = ticketIds.get(ticketIndex++);
                    paymentTicketDAO.addPaymentTicket(paymentId, ticketId, t.getPrice(), 1);
                }
            }

            PaymentRentItemDAO paymentRentDAO = new PaymentRentItemDAO();
            for (PoolServiceSelection s : selectedServices) {
                paymentRentDAO.addPaymentRentItem(paymentId, s.getPoolServiceId(), s.getPrice(), s.getQuantity());
            }

            User currentUser = (User) session.getAttribute("staffAccount");
            String staffName = currentUser != null ? currentUser.getFull_name() : "Unknown Staff";

            SaleTicketDirectly sale = new SaleTicketDirectly();
            sale.setCustomerName(customerName);
            sale.setCustomerPhone(customerPhone);
            sale.setCustomerEmail(customerEmail);
            sale.setUserId(userId);
            sale.setStaffId(staff.getStaffId());
            sale.setPoolId(staff.getPoolId());
            sale.setBranchId(staff.getBranchId());
            sale.setBookingId(bookingId);
            sale.setTotalAmount(totalAmount);
            sale.setPaymentMethod("Cash");
            sale.setPaymentStatus("completed");
            sale.setSaleDate(new java.sql.Timestamp(System.currentTimeMillis()));
            sale.setNotes("Bán vé trực tiếp tại quầy bởi " + staffName);

            SaleTicketDirectlyDAO saleDAO = new SaleTicketDirectlyDAO();
            int saleId = saleDAO.createSaleTicketDirectly(sale);

            StaffSaleResult saleResult = new StaffSaleResult();
            saleResult.setBookingId(bookingId);
            saleResult.setPaymentId(paymentId);
            saleResult.setCustomerName(customerName);
            saleResult.setCustomerPhone(customerPhone);
            saleResult.setCustomerEmail(customerEmail);
            saleResult.setIsExistingCustomer(isExisting);
            saleResult.setUserId(userId);
            saleResult.setSelectedTickets(selectedTickets);
            saleResult.setSelectedServices(selectedServices);
            saleResult.setTotalAmount(totalAmount);
            saleResult.setStaffName(staffName);
            saleResult.setPoolName(staff.getPoolName());
            saleResult.setSaleDate(new java.sql.Date(System.currentTimeMillis()));

            session.setAttribute("saleResult", saleResult);

            session.removeAttribute("staffSaleData");

            request.setAttribute("success", true);
            request.setAttribute("successMessage", "Mua vé thành công!");
            request.setAttribute("bookingId", bookingId);
            request.setAttribute("saleId", saleId);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("customerName", customerName);
            request.setAttribute("customerPhone", customerPhone);

            StaffSaleData newSaleData = new StaffSaleData();
            try {
                newSaleData.setBookingDate(java.sql.Date.valueOf(LocalDate.now()));

                PoolDAO poolDAO = new PoolDAO();
                Pool pool = poolDAO.getPoolByID(staff.getPoolId());
                newSaleData.setPool(pool);

                List<TicketType> ticketTypes = ticketTypeDAO.getTicketTypesByPoolId(staff.getPoolId());
                newSaleData.setAvailableTicketTypes(ticketTypes != null ? ticketTypes : new ArrayList<>());

                PoolServiceDAO serviceDAO = new PoolServiceDAO();
                List<PoolService> services = serviceDAO.getServicesByPoolId(staff.getPoolId());
                newSaleData.setAvailableServices(services != null ? services : new ArrayList<>());
            } catch (Exception e) {
                // ignore
            }

            session.setAttribute("staffSaleData", newSaleData);

            request.setAttribute("staff", staff);
            request.setAttribute("saleData", newSaleData);

            request.getRequestDispatcher("staffSale.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            response.sendRedirect("staff_sale?error=invalid_data");
        } catch (Exception e) {
            response.sendRedirect("staff_sale?error=system_error");
        }
    }
}
