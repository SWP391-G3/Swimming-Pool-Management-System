package controller.Customer.Mail;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.EmailUtil;

/**
 *
 * @author LAZYVL
 */
@WebServlet(name = "BookingMailService", urlPatterns = {"/mail_service"})
public class BookingMailService extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String toEmail = request.getParameter("email");
        String customerName = request.getParameter("customerName");
        String bookingId = request.getParameter("bookingId");
        String bookingDate = request.getParameter("bookingDate");
        String ticketInfo = request.getParameter("ticketInfo");

        try {
            EmailUtil.sendBookingConfirmation(
                    toEmail,
                    customerName,
                    bookingId,
                    bookingDate,
                    ticketInfo
            );
            response.getWriter().write("Email xác nhận đã được gửi!");
        } catch (Exception ex) {
            response.getWriter().write("Gửi email thất bại: " + ex.getMessage());
            ex.printStackTrace();
        }
    }
}
