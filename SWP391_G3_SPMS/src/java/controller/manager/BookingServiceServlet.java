/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.manager;


import dao.manager.BookingServiceDAO;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/booking-service")
public class BookingServiceServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        BookingServiceDAO dao = new BookingServiceDAO();

        try {
            if ("add".equals(action)) {
                int bookingId = Integer.parseInt(request.getParameter("booking_id"));
                int poolServiceId = Integer.parseInt(request.getParameter("pool_service_id"));
                int branchId = Integer.parseInt(request.getParameter("branch_id"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                double pricePerUnit = Double.parseDouble(request.getParameter("price"));
                double totalPrice = pricePerUnit * quantity;

                boolean success = dao.addServiceToBooking(bookingId, poolServiceId, branchId, quantity, totalPrice);
                session.setAttribute(success ? "message" : "error", success ? "Thêm dịch vụ thành công" : "Thêm thất bại");
                response.sendRedirect("booking-detail.jsp?booking_id=" + bookingId);
            }

            if ("delete".equals(action)) {
                int bookingServiceId = Integer.parseInt(request.getParameter("booking_service_id"));
                boolean success = dao.deleteServiceFromBooking(bookingServiceId);
                session.setAttribute(success ? "message" : "error", success ? "Xóa dịch vụ thành công" : "Xóa thất bại");
                response.sendRedirect("booking-list.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Lỗi hệ thống");
            response.sendRedirect("error.jsp");
        }
    }
}
