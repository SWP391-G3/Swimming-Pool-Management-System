/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.admin;

import dal.DBContext;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import model.admin.CustomerBooking;

/**
 *
 * @author Lenovo
 */
public class CustomerBookingDAO extends DBContext {

    public CustomerBooking getLastBooking(int customer_id) {
        List<CustomerBooking> list = new ArrayList<>();
        String sql = "SELECT Top 1\n"
                + "    u.full_name AS customer_name,\n"
                + "    b.booking_id,\n"
                + "    p.pool_name,\n"
                + "    b.booking_date,\n"
                + "    b.start_time,\n"
                + "    b.end_time,\n"
                + "    b.slot_count,\n"
                + "    b.booking_status,\n"
                + "    ISNULL(pay.total_amount, 0) AS total_payment,\n"
                + "    pay.payment_status,\n"
                + "    b.created_at\n"
                + "FROM Booking b\n"
                + "JOIN Users u ON b.user_id = u.user_id\n"
                + "JOIN Pools p ON b.pool_id = p.pool_id\n"
                + "LEFT JOIN Payments pay ON pay.booking_id = b.booking_id\n"
                + "WHERE u.user_id = ? -- truyền vào ID của khách hàng cần xem\n"
                + "ORDER BY b.created_at DESC;";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, customer_id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {

                String customerName = rs.getString("customer_name");
                int bookingId = rs.getInt("booking_id");
                String poolName = rs.getString("pool_name");
                LocalDate bookingDate = rs.getTimestamp("booking_date").toLocalDateTime().toLocalDate();
                LocalDateTime startTime = rs.getTimestamp("start_time").toLocalDateTime();
                LocalDateTime endTime = rs.getTimestamp("end_time").toLocalDateTime();
                int slotCount = rs.getInt("slot_count");
                String bookingStatus = rs.getString("booking_status");
                double totalSpent = rs.getDouble("total_payment");
                String paymentStatus = rs.getString("payment_status");
                LocalDate createdAt = rs.getTimestamp("created_at").toLocalDateTime().toLocalDate();

                return new CustomerBooking(customerName, bookingId, poolName,bookingDate,
                        startTime, endTime, slotCount, bookingStatus, totalSpent, paymentStatus, createdAt);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
