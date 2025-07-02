/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Customer;

import dao.customer.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import model.customer.*;

/**
 *
 * @author LAZYVL
 */
public class BookingPaymentServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        BookingPageData pageData = (BookingPageData) request.getSession().getAttribute("bookingPageData");
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
            // 1. Booking
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

            //Chuyển trạng thái của vé người dùng đã sdung
            if (pageData.getSelectedDiscount() != null) {
                DiscountDAO discountDAO = new DiscountDAO();
                discountDAO.markDiscountAsUsed(pageData.getUser().getUser_id(), pageData.getSelectedDiscount().getDiscountId());
            }

            //Ticket và lưu lại ticketId
            TicketDAO ticketDAO = new TicketDAO();
            List<Integer> ticketIds = new ArrayList<>();
            for (TicketSelection t : pageData.getSelectedTickets()) {
                for (int i = 0; i < t.getQuantity(); i++) {
                    int tid = ticketDAO.addTicket(bookingId, t.getTicketTypeId(), t.getPrice(), pageData.getUser().getUser_id());
                    ticketIds.add(tid);
                }
            }

            //Insert Booking_Service
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

            //Insert Payment
            model.customer.Payment payment = new model.customer.Payment(
                    bookingId,
                    "Bank_transfers",
                    "pending",
                    new java.sql.Date(System.currentTimeMillis()),
                    pageData.getFinalAmount(),
                    pageData.getDiscountAmount(),
                    null // transaction_reference
            );
            PaymentDAO paymentDAO = new PaymentDAO();
            paymentDAO.addPayment(payment);
            int paymentId = paymentDAO.getLastPaymentIdByBookingId(bookingId);

            //Insert Payment_Ticket
            PaymentTicketDAO paymentTicketDAO = new PaymentTicketDAO();
            int idx = 0;
            for (TicketSelection t : pageData.getSelectedTickets()) {
                for (int i = 0; i < t.getQuantity(); i++) {
                    // Mỗi ticketId ứng với 1 vé
                    int ticketId = ticketIds.get(idx++);
                    paymentTicketDAO.addPaymentTicket(paymentId, ticketId, t.getPrice(), 1);
                }
            }

            //Insert Payment_RentItem
            PaymentRentItemDAO paymentRentDAO = new PaymentRentItemDAO();
            for (model.customer.PoolServiceSelection r : pageData.getSelectedRents()) {
                paymentRentDAO.addPaymentRentItem(paymentId, r.getPoolServiceId(), r.getPrice(), r.getQuantity());
            }

            //Xóa dữ liệu booking trên session và chuyển tới trang thành công
            session.removeAttribute("bookingPageData");
            response.sendRedirect("payment-success.jsp");
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("payment-error.jsp");
        }
    }

}
