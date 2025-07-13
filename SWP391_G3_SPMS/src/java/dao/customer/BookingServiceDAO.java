/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.customer;

import dal.DBContext;
import java.math.BigDecimal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.customer.BookingService;
/**
 *
 * @author LAZYVL
 */

public class BookingServiceDAO extends DBContext {

    public void addServiceToBooking(int bookingId, int poolServiceId, int branchId, int quantity, BigDecimal price) {
        String sql = "INSERT INTO Booking_Service (booking_id, pool_service_id, branch_id, quantity, total_service_price) "
                + "VALUES (?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, bookingId);
            st.setInt(2, poolServiceId);
            st.setInt(3, branchId);
            st.setInt(4, quantity);
            // total_service_price = price * quantity
            BigDecimal totalPrice = price.multiply(BigDecimal.valueOf(quantity));
            st.setBigDecimal(5, totalPrice);

            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<BookingService> getServicesByBookingId(int bookingId) {
        List<BookingService> list = new ArrayList<>();
        String sql = "SELECT booking_service_id, booking_id, pool_service_id, branch_id, quantity, total_service_price "
                + "FROM Booking_Service WHERE booking_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, bookingId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                BookingService bs = new BookingService();
                bs.setBookingServiceId(rs.getInt("booking_service_id"));
                bs.setBookingId(rs.getInt("booking_id"));
                bs.setPoolServiceId(rs.getInt("pool_service_id"));
                bs.setBranchId(rs.getInt("branch_id"));
                bs.setQuantity(rs.getInt("quantity"));
                bs.setTotalServicePrice(rs.getBigDecimal("total_service_price"));
                list.add(bs);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
