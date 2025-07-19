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
import java.util.Calendar;
import java.sql.Time;
import java.time.LocalTime;
import model.staff.SaleTicketDirectly;

/**
 *
 * @author LAZYVL
 */
@WebServlet(name = "StaffSaleServlet", urlPatterns = {"/staff_sale"})
public class StaffSaleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        System.out.println("=== DEBUG StaffSaleServlet START ===");

        HttpSession session = request.getSession();
        StaffJoinedTable staff = (StaffJoinedTable) session.getAttribute("staff");

        if (staff == null) {
            System.out.println("ERROR: Staff is null");
            response.sendRedirect("login");
            return;
        }

        System.out.println("Staff found - Pool ID: " + staff.getPoolId());

        // Tạo StaffSaleData mới hoặc lấy từ session
        StaffSaleData saleData = (StaffSaleData) session.getAttribute("staffSaleData");
        System.out.println("Existing saleData from session: " + (saleData != null ? "EXISTS" : "NULL"));

        if (saleData == null) {
            System.out.println("Creating new StaffSaleData...");

            try {
                saleData = new StaffSaleData();
                System.out.println("StaffSaleData constructor OK");

                // Set thông tin mặc định
                saleData.setBookingDate(java.sql.Date.valueOf(LocalDate.now()));
                System.out.println("Set booking date OK: " + saleData.getBookingDate());

                // Test Pool loading
                System.out.println("Loading pool for ID: " + staff.getPoolId());
                try {
                    PoolDAO poolDAO = new PoolDAO();
                    Pool pool = poolDAO.getPoolByID(staff.getPoolId());

                    if (pool == null) {
                        System.out.println("ERROR: Pool is NULL for ID: " + staff.getPoolId());
                    } else {
                        System.out.println("Pool loaded OK: " + pool.getPool_name());
                        saleData.setPool(pool);
                    }
                } catch (Exception e) {
                    System.out.println("ERROR loading pool: " + e.getMessage());
                    e.printStackTrace();
                }

                // Test TicketType loading
                System.out.println("Loading ticket types for pool ID: " + staff.getPoolId());
                try {
                    TicketTypeDAO ticketTypeDAO = new TicketTypeDAO();
                    List<TicketType> ticketTypes = ticketTypeDAO.getTicketTypesByPoolId(staff.getPoolId());

                    if (ticketTypes == null) {
                        System.out.println("ERROR: TicketTypes is NULL");
                        ticketTypes = new ArrayList<>();
                    } else {
                        System.out.println("TicketTypes loaded OK: " + ticketTypes.size() + " items");
                    }
                    saleData.setAvailableTicketTypes(ticketTypes);
                } catch (Exception e) {
                    System.out.println("ERROR loading ticket types: " + e.getMessage());
                    e.printStackTrace();
                    saleData.setAvailableTicketTypes(new ArrayList<>());
                }

                // Test Service loading
                System.out.println("Loading services for pool ID: " + staff.getPoolId());
                try {
                    PoolServiceDAO serviceDAO = new PoolServiceDAO();
                    List<PoolService> services = serviceDAO.getServicesByPoolId(staff.getPoolId());

                    if (services == null) {
                        System.out.println("ERROR: Services is NULL");
                        services = new ArrayList<>();
                    } else {
                        System.out.println("Services loaded OK: " + services.size() + " items");
                    }
                    saleData.setAvailableServices(services);
                } catch (Exception e) {
                    System.out.println("ERROR loading services: " + e.getMessage());
                    e.printStackTrace();
                    saleData.setAvailableServices(new ArrayList<>());
                }

                System.out.println("Saving saleData to session...");
                session.setAttribute("staffSaleData", saleData);
                System.out.println("SaleData saved to session OK");

            } catch (Exception e) {
                System.out.println("ERROR creating saleData: " + e.getMessage());
                e.printStackTrace();

                // Tạo empty saleData để tránh crash
                saleData = new StaffSaleData();
                session.setAttribute("staffSaleData", saleData);
            }
        }

        // Final check
        saleData = (StaffSaleData) session.getAttribute("staffSaleData");
        System.out.println("Final saleData check: " + (saleData != null ? "EXISTS" : "NULL"));
        if (saleData != null) {
            System.out.println("Pool in saleData: " + (saleData.getPool() != null ? saleData.getPool().getPool_name() : "NULL"));
            System.out.println("TicketTypes in saleData: " + (saleData.getAvailableTicketTypes() != null ? saleData.getAvailableTicketTypes().size() : "NULL"));
            System.out.println("Services in saleData: " + (saleData.getAvailableServices() != null ? saleData.getAvailableServices().size() : "NULL"));
        }

        System.out.println("=== DEBUG StaffSaleServlet END ===");

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

        System.out.println("=== DEBUG SEARCH CUSTOMER ===");
        System.out.println("Input phone: " + phone);

        try (PrintWriter out = response.getWriter()) {
            if (phone != null && phone.trim().length() >= 3) {
                UserDAO userDAO = new UserDAO();
                List<User> customers = userDAO.searchCustomersByPhone(phone);

                System.out.println("Found customers: " + (customers != null ? customers.size() : "NULL"));

                if (customers != null && !customers.isEmpty()) {
                    for (User customer : customers) {
                        System.out.println("Customer: " + customer.getFull_name() + " - " + customer.getPhone());
                        out.println(customer.getUser_id() + "|"
                                + cleanText(customer.getFull_name()) + "|"
                                + cleanText(customer.getEmail()) + "|"
                                + cleanText(customer.getPhone()));
                    }
                } else {
                    System.out.println("No customers found, returning NOT_FOUND");
                    out.print("NOT_FOUND");
                }
            } else {
                System.out.println("Phone too short or null");
                out.print("NOT_FOUND");
            }
        } catch (Exception e) {
            System.out.println("Exception in search: " + e.getMessage());
            e.printStackTrace();
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

        // Kiểm tra xem số điện thoại có trong hệ thống không
        UserDAO userDAO = new UserDAO();
        User customer = userDAO.getUserByPhone(phone);

        if (customer != null) {
            saleData.setCustomer(customer);
            saleData.setHasAccount(true);
            saleData.setCustomerName(customer.getFull_name());
            saleData.setCustomerEmail(customer.getEmail());

            // Lấy danh sách discounts có sẵn cho khách hàng này
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
        // Logic cập nhật tickets
        response.sendRedirect("staff_sale");
    }

    private void handleUpdateServices(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Logic cập nhật services
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
            System.out.println("=== DEBUG PROCESS PAYMENT START ===");

            // Lấy thông tin khách hàng
            String customerPhone = request.getParameter("customerPhone");
            String customerName = request.getParameter("customerName");
            String customerEmail = request.getParameter("customerEmail");
            String isExistingStr = request.getParameter("isExisting");
            String userIdStr = request.getParameter("userId");

            System.out.println("Customer info:");
            System.out.println("- Phone: " + customerPhone);
            System.out.println("- Name: " + customerName);
            System.out.println("- Email: " + customerEmail);
            System.out.println("- IsExisting: " + isExistingStr);
            System.out.println("- UserIdStr: " + userIdStr);

            boolean isExisting = "true".equals(isExistingStr);
            Integer userId = null;

            if (isExisting && userIdStr != null && !userIdStr.isEmpty()) {
                userId = Integer.parseInt(userIdStr);
            }

            System.out.println("- Parsed userId: " + userId);

            // Validate thông tin bắt buộc
            if (customerPhone == null || customerPhone.trim().isEmpty()) {
                System.out.println("ERROR: Missing phone");
                response.sendRedirect("staff_sale?error=missing_phone");
                return;
            }

            if (customerName == null || customerName.trim().isEmpty()) {
                System.out.println("ERROR: Missing name");
                response.sendRedirect("staff_sale?error=missing_name");
                return;
            }

            // Thu thập thông tin tickets và services
            List<TicketSelection> selectedTickets = new ArrayList<>();
            List<PoolServiceSelection> selectedServices = new ArrayList<>();
            BigDecimal totalAmount = BigDecimal.ZERO;

            System.out.println("Processing items from request:");

            // Lấy thông tin tickets
            TicketTypeDAO ticketTypeDAO = new TicketTypeDAO();
            for (String paramName : request.getParameterMap().keySet()) {
                if (paramName.startsWith("ticket-") && !paramName.endsWith("-price")) {
                    String quantityStr = request.getParameter(paramName);
                    String priceStr = request.getParameter(paramName + "-price");

                    System.out.println("Ticket param: " + paramName + " = " + quantityStr + ", price = " + priceStr);

                    if (quantityStr != null && !quantityStr.equals("0") && priceStr != null) {
                        int ticketTypeId = Integer.parseInt(paramName.substring(7));
                        int quantity = Integer.parseInt(quantityStr);
                        BigDecimal price = new BigDecimal(priceStr);

                        // Lấy tên ticket type
                        TicketType ticketType = ticketTypeDAO.getTicketTypeById(ticketTypeId);
                        String typeName = ticketType != null ? ticketType.getTypeName() : "Unknown";

                        System.out.println("Added ticket: " + typeName + " x" + quantity + " @ " + price);

                        selectedTickets.add(new TicketSelection(ticketTypeId, typeName, price, quantity));
                        totalAmount = totalAmount.add(price.multiply(BigDecimal.valueOf(quantity)));
                    }
                }
            }

            // Lấy thông tin services
            PoolServiceDAO poolServiceDAO = new PoolServiceDAO();
            for (String paramName : request.getParameterMap().keySet()) {
                if (paramName.startsWith("service-") && !paramName.endsWith("-price")) {
                    String quantityStr = request.getParameter(paramName);
                    String priceStr = request.getParameter(paramName + "-price");

                    System.out.println("Service param: " + paramName + " = " + quantityStr + ", price = " + priceStr);

                    if (quantityStr != null && !quantityStr.equals("0") && priceStr != null) {
                        int serviceId = Integer.parseInt(paramName.substring(8));
                        int quantity = Integer.parseInt(quantityStr);
                        BigDecimal price = new BigDecimal(priceStr);

                        String serviceName = "Service #" + serviceId;

                        System.out.println("Added service: " + serviceName + " x" + quantity + " @ " + price);

                        selectedServices.add(new PoolServiceSelection(serviceId, serviceName, price, quantity));
                        totalAmount = totalAmount.add(price.multiply(BigDecimal.valueOf(quantity)));
                    }
                }
            }

            System.out.println("Total selected tickets: " + selectedTickets.size());
            System.out.println("Total selected services: " + selectedServices.size());
            System.out.println("Total amount: " + totalAmount);

            // Validate có ít nhất 1 item
            if (selectedTickets.isEmpty() && selectedServices.isEmpty()) {
                System.out.println("ERROR: No items selected");
                response.sendRedirect("staff_sale?error=no_items");
                return;
            }

            // Tính tổng số người (slot) từ các vé
            int totalPerson = 0;
            for (TicketSelection t : selectedTickets) {
                TicketSlot slotObj = ticketTypeDAO.getTicketSlotByTicketTypeId(t.getTicketTypeId());
                int ticketSlot = slotObj != null ? slotObj.getTicketSlot() : 1;
                totalPerson += ticketSlot * t.getQuantity();
                System.out.println("Ticket " + t.getTicketTypeId() + " slot: " + ticketSlot + " x " + t.getQuantity());
            }

            System.out.println("Total persons: " + totalPerson);

            // Kiểm tra giới hạn số người
            if (totalPerson > 10) {
                System.out.println("ERROR: Too many people - " + totalPerson);
                response.sendRedirect("staff_sale?error=too_many_people&count=" + totalPerson);
                return;
            }

            // 1. Tạo Booking
            System.out.println("Creating booking...");
            System.out.println("Staff poolId: " + staff.getPoolId());

            if (isExisting && userIdStr != null && !userIdStr.trim().isEmpty()) {
                try {
                    userId = Integer.parseInt(userIdStr);
                    System.out.println("Existing customer - userId: " + userId);
                } catch (NumberFormatException e) {
                    System.out.println("Invalid userIdStr, treating as guest customer");
                    userId = null;  // ✅ NULL cho guest
                }
            } else {
                System.out.println("Guest customer - userId will be NULL");
                userId = null;  // ✅ NULL cho guest customer
            }

            Booking booking = new Booking();
            booking.setUserId(userId);
            booking.setPoolId(staff.getPoolId());
            booking.setDiscountId(null);
            booking.setBookingDate(new java.sql.Date(System.currentTimeMillis()));

            //Kiểm tra tràn ngày và xử lý
            LocalTime now = java.time.LocalTime.now();
            LocalTime twoHoursLater = now.plusHours(2);

            // Nếu tràn ngày (sau 22:00), đặt thời gian mặc định
            if (now.isAfter(java.time.LocalTime.of(22, 0))) {
                // Sau 22:00 → Đặt từ 8:00 đến 10:00 sáng hôm sau
                now = LocalTime.of(8, 0);
                twoHoursLater = LocalTime.of(10, 0);
                System.out.println("Late booking detected - using next day default time");
            } else if (twoHoursLater.isAfter(java.time.LocalTime.of(23, 59))) {
                // Nếu 2 tiếng sau vượt quá 23:59, cắt về 22:00-23:59
                twoHoursLater = LocalTime.of(23, 59);
                System.out.println("End time adjusted to avoid day overflow");
            }

            Time startTime = Time.valueOf(now);
            Time endTime = Time.valueOf(twoHoursLater);

            booking.setStartTime(startTime);
            booking.setEndTime(endTime);

            System.out.println("Time calculation:");
            System.out.println("- Current time: " + now);
            System.out.println("- Start time: " + startTime);
            System.out.println("- End time: " + endTime);
            System.out.println("- Duration check: " + (endTime.after(startTime) ? "VALID" : "INVALID"));

            booking.setSlotCount(totalPerson);
            booking.setBookingStatus("confirmed");

            System.out.println("Booking object created:");
            System.out.println("- UserId: " + booking.getUserId());
            System.out.println("- PoolId: " + booking.getPoolId());
            System.out.println("- StartTime: " + booking.getStartTime());
            System.out.println("- EndTime: " + booking.getEndTime());
            System.out.println("- SlotCount: " + booking.getSlotCount());
            System.out.println("- Status: " + booking.getBookingStatus());

            BookingDAO bookingDAO = new BookingDAO();
            int bookingId = bookingDAO.createBooking(booking);

            System.out.println("BookingDAO.createBooking returned: " + bookingId);

            if (bookingId <= 0) {
                System.out.println("ERROR: Booking creation failed - bookingId = " + bookingId);
                response.sendRedirect("staff_sale?error=booking_failed");
                return;
            }

            System.out.println("Booking created successfully with ID: " + bookingId);

            // 2. Thêm tickets
            System.out.println("=== CREATING TICKETS ===");
            TicketDAO ticketDAO = new TicketDAO();
            List<Integer> ticketIds = new ArrayList<>();
            for (TicketSelection t : selectedTickets) {
                for (int i = 0; i < t.getQuantity(); i++) {
                    try {
                        System.out.println("Creating ticket: " + t.getTypeName() + " for booking " + bookingId);
                        int ticketId = ticketDAO.addTicket(bookingId, t.getTicketTypeId(), t.getPrice(), userId);
                        System.out.println("Ticket created with ID: " + ticketId);
                        ticketIds.add(ticketId);
                    } catch (Exception e) {
                        System.out.println("ERROR creating ticket: " + e.getMessage());
                        e.printStackTrace();
                        throw e;
                    }
                }
            }

            // 3. Thêm services
            System.out.println("=== CREATING SERVICES ===");
            BookingServiceDAO bookingServiceDAO = new BookingServiceDAO();
            for (PoolServiceSelection s : selectedServices) {
                try {
                    int branchId = staff.getBranchId();

                    System.out.println("Creating service: " + s.getServiceName() + " for booking " + bookingId + ", branch " + branchId);

                    bookingServiceDAO.addServiceToBooking(
                            bookingId,
                            s.getPoolServiceId(),
                            branchId,
                            s.getQuantity(),
                            s.getPrice()
                    );
                    System.out.println("Service created successfully");
                } catch (Exception e) {
                    System.out.println("ERROR creating service: " + e.getMessage());
                    e.printStackTrace();
                    throw e;
                }
            }

            // 4. Tạo Payment (Cash payment)
            Payment payment = new Payment();
            payment.setBookingId(bookingId);
            payment.setPaymentMethod("Cash"); // Thanh toán tiền mặt tại quầy
            payment.setPaymentStatus("completed"); // Đã hoàn thành
            payment.setPaymentDate(new java.sql.Date(System.currentTimeMillis()));
            payment.setTotalAmount(totalAmount);
            payment.setDiscountAmount(BigDecimal.ZERO); // Không có discount
            payment.setTransactionReference(bookingId + "");

            PaymentDAO paymentDAO = new PaymentDAO();
            paymentDAO.addPayment(payment);
            int paymentId = paymentDAO.getLastPaymentIdByBookingId(bookingId);

            // 5. Thêm Payment_Ticket
            PaymentTicketDAO paymentTicketDAO = new PaymentTicketDAO();
            int ticketIndex = 0;
            for (TicketSelection t : selectedTickets) {
                for (int i = 0; i < t.getQuantity(); i++) {
                    int ticketId = ticketIds.get(ticketIndex++);
                    paymentTicketDAO.addPaymentTicket(paymentId, ticketId, t.getPrice(), 1);
                }
            }

            // 6. Thêm Payment_RentItem
            PaymentRentItemDAO paymentRentDAO = new PaymentRentItemDAO();
            for (PoolServiceSelection s : selectedServices) {
                paymentRentDAO.addPaymentRentItem(paymentId, s.getPoolServiceId(), s.getPrice(), s.getQuantity());
            }

            // 7. Tạo record trong Sale_Ticket_Directly
            User currentUser = (User) session.getAttribute("currentUser");
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
            System.out.println("Sale record created with ID: " + saleId);

            // 8. Lưu thông tin giao dịch vào session để hiển thị
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

            // 9. Reset staffSaleData
            session.removeAttribute("staffSaleData");

            // 10. Hiển thị thông báo thành công
            System.out.println("=== TRANSACTION COMPLETED SUCCESSFULLY ===");
            System.out.println("Booking ID: " + bookingId + ", Sale ID: " + saleId);

            //Set thông báo thành công cho JSP
            request.setAttribute("success", true);
            request.setAttribute("successMessage", "Mua vé thành công!");
            request.setAttribute("bookingId", bookingId);
            request.setAttribute("saleId", saleId);
            request.setAttribute("totalAmount", totalAmount);
            request.setAttribute("customerName", customerName);
            request.setAttribute("customerPhone", customerPhone);

            //TẠO LẠI SALEDATA MỚI cho lần bán tiếp theo
            StaffSaleData newSaleData = new StaffSaleData();
            try {
                // Set thông tin mặc định
                newSaleData.setBookingDate(java.sql.Date.valueOf(LocalDate.now()));

                // Load pool data
                PoolDAO poolDAO = new PoolDAO();
                Pool pool = poolDAO.getPoolByID(staff.getPoolId());
                newSaleData.setPool(pool);

                // Load ticket types
                List<TicketType> ticketTypes = ticketTypeDAO.getTicketTypesByPoolId(staff.getPoolId());
                newSaleData.setAvailableTicketTypes(ticketTypes != null ? ticketTypes : new ArrayList<>());

                // Load services
                PoolServiceDAO serviceDAO = new PoolServiceDAO();
                List<PoolService> services = serviceDAO.getServicesByPoolId(staff.getPoolId());
                newSaleData.setAvailableServices(services != null ? services : new ArrayList<>());

                System.out.println("New saleData created for next sale");
            } catch (Exception e) {
                System.out.println("Error creating new saleData: " + e.getMessage());
                e.printStackTrace();
            }

            //Lưu saleData mới vào session
            session.setAttribute("staffSaleData", newSaleData);

            //Set attributes cho JSP
            request.setAttribute("staff", staff);
            request.setAttribute("saleData", newSaleData);

            //Forward đến cùng trang thay vì redirect
            System.out.println("Displaying success notification and fresh form...");
            request.getRequestDispatcher("staffSale.jsp").forward(request, response);

        } catch (NumberFormatException e) {
            System.out.println("NumberFormatException: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("staff_sale?error=invalid_data");
        } catch (Exception e) {
            System.out.println("Exception in processPayment: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect("staff_sale?error=system_error");
        }
    }
}
