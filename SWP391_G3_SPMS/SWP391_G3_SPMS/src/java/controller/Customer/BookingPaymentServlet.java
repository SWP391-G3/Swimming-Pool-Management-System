package controller.Customer;

import com.vnpay.common.Config;
import dao.customer.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.math.BigDecimal;
import java.math.RoundingMode;
import model.customer.*;

public class BookingPaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        BookingPageData pageData = (BookingPageData) session.getAttribute("bookingPageData");
        if (pageData == null) {
            request.getRequestDispatcher("Booking.jsp").forward(request, response);
            return;
        }
        request.setAttribute("pageData", pageData);
        request.getRequestDispatcher("BookingPayment.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        BookingPageData pageData = (BookingPageData) session.getAttribute("bookingPageData");
        if (pageData == null) {
            response.sendRedirect("booking");
            return;
        }

        try {
            // Lưu booking
            Booking booking = new Booking(
                    pageData.getUser().getUser_id(),
                    pageData.getPool().getPool_id(),
                    pageData.getSelectedDiscount() != null ? pageData.getSelectedDiscount().getDiscountId() : null,
                    pageData.getBookingDate(),
                    pageData.getStartTime(),
                    pageData.getEndTime(),
                    pageData.getSlotCount(),
                    "pending"
            );
            BookingDAO bookingDAO = new BookingDAO();
            int bookingId = bookingDAO.createBooking(booking);

            // Đánh dấu discount đã dùng nếu có
            if (pageData.getSelectedDiscount() != null) {
                DiscountDAO discountDAO = new DiscountDAO();
                discountDAO.markDiscountAsUsed(pageData.getUser().getUser_id(), pageData.getSelectedDiscount().getDiscountId());
            }

            // Thêm ticket và lưu lại ticketId
            TicketDAO ticketDAO = new TicketDAO();
            List<Integer> ticketIds = new ArrayList<>();
            for (TicketSelection t : pageData.getSelectedTickets()) {
                for (int i = 0; i < t.getQuantity(); i++) {
                    int tid = ticketDAO.addTicket(bookingId, t.getTicketTypeId(), t.getPrice(), pageData.getUser().getUser_id());
                    ticketIds.add(tid);
                }
            }

            // Thêm dịch vụ thuê vào booking
            BookingServiceDAO bookingServiceDAO = new BookingServiceDAO();
            for (PoolServiceSelection r : pageData.getSelectedRents()) {
                bookingServiceDAO.addServiceToBooking(
                        bookingId,
                        r.getPoolServiceId(),
                        pageData.getPool().getBranch_id(),
                        r.getQuantity(),
                        r.getPrice()
                );
            }

            // Thêm payment (status pending, luôn luôn là Bank_transfers)
            Payment payment = new Payment(
                    bookingId,
                    "Bank_transfers",
                    "pending",
                    new java.sql.Date(System.currentTimeMillis()),
                    pageData.getFinalAmount(),
                    pageData.getDiscountAmount(),
                    null
            );
            PaymentDAO paymentDAO = new PaymentDAO();
            paymentDAO.addPayment(payment);
            int paymentId = paymentDAO.getLastPaymentIdByBookingId(bookingId);

            // Insert Payment_Ticket
            PaymentTicketDAO paymentTicketDAO = new PaymentTicketDAO();
            int idx = 0;
            for (TicketSelection t : pageData.getSelectedTickets()) {
                for (int i = 0; i < t.getQuantity(); i++) {
                    int ticketId = ticketIds.get(idx++);
                    paymentTicketDAO.addPaymentTicket(paymentId, ticketId, t.getPrice(), 1);
                }
            }

            // Insert Payment_RentItem
            PaymentRentItemDAO paymentRentDAO = new PaymentRentItemDAO();
            for (PoolServiceSelection r : pageData.getSelectedRents()) {
                paymentRentDAO.addPaymentRentItem(paymentId, r.getPoolServiceId(), r.getPrice(), r.getQuantity());
            }

            // Luôn luôn redirect sang VNPay
            processVnpayPayment(request, response,
                    bookingId,
                    pageData.getFinalAmount(),
                    pageData.getUser().getFull_name(),
                    pageData.getUser().getPhone(),
                    "Booking #" + bookingId
            );

        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    // Hàm gọi VNPay
    private void processVnpayPayment(HttpServletRequest request, HttpServletResponse response,
            int bookingId, BigDecimal finalAmount, String fullName, String phone, String bookingInfo)
            throws IOException {
        HttpSession session = request.getSession();
        session.setAttribute("bookingId", bookingId); // Đúng key

        // VNPay yêu cầu số tiền là VND x 100
        long amount = finalAmount.setScale(0, RoundingMode.HALF_UP).longValue() * 100;

        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String orderType = "other";
        String vnp_TxnRef = String.valueOf(bookingId); // ĐÚNG PHẢI bookingId
        String vnp_IpAddr = Config.getIpAddress(request);
        String vnp_TmnCode = Config.vnp_TmnCode;

        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Booking #" + bookingId);
        vnp_Params.put("vnp_OrderType", orderType);

        String locate = request.getParameter("language");
        if (locate != null && !locate.isEmpty()) {
            vnp_Params.put("vnp_Locale", locate);
        } else {
            vnp_Params.put("vnp_Locale", "vn");
        }
        vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        String vnp_CreateDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

        cld.add(Calendar.MINUTE, 15);
        String vnp_ExpireDate = formatter.format(cld.getTime());
        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

        // Build hash and query string
        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();
        for (int i = 0; i < fieldNames.size(); i++) {
            String fieldName = fieldNames.get(i);
            String fieldValue = vnp_Params.get(fieldName);
            if (fieldValue != null && fieldValue.length() > 0) {
                hashData.append(fieldName).append('=').append(URLEncoder.encode(fieldValue, "UTF-8"));
                query.append(fieldName).append('=').append(URLEncoder.encode(fieldValue, "UTF-8"));
                if (i < fieldNames.size() - 1) {
                    hashData.append('&');
                    query.append('&');
                }
            }
        }
        String queryUrl = query.toString();
        String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
        String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;

        // Log hashData/query/vnp_SecureHash để dễ debug khi lỗi chữ ký
        System.out.println("HASHDATA: " + hashData.toString());
        System.out.println("QUERY: " + queryUrl);
        System.out.println("SECUREHASH: " + vnp_SecureHash);
        System.out.println("paymentUrl: " + paymentUrl);

        response.sendRedirect(paymentUrl);
    }
}
