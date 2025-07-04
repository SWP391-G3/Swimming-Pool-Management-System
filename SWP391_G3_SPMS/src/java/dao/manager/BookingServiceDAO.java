/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.manager;


import dao.customer.BookingDAO;
import dal.DBContext;
import model.customer.BookingService;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingServiceDAO extends DBContext {

    public boolean addServiceToBooking(int bookingId, int poolServiceId, int branchId, int quantity, double totalPrice) throws SQLException {
        String sql = "INSERT INTO Booking_Service (booking_id, pool_service_id, branch_id, quantity, total_service_price) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, bookingId);
        st.setInt(2, poolServiceId);
        st.setInt(3, branchId);
        st.setInt(4, quantity);
        st.setDouble(5, totalPrice);
        return st.executeUpdate() > 0;
    }

    public List<BookingService> getServicesByBookingId(int bookingId) throws SQLException {
        List<BookingService> list = new ArrayList<>();
        String sql = "SELECT * FROM Booking_Service WHERE booking_id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, bookingId);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            BookingService bs = new BookingService(
                rs.getInt("booking_service_id"),
                rs.getInt("booking_id"),
                rs.getInt("pool_service_id"),
                rs.getInt("branch_id"),
                rs.getInt("quantity"),
                rs.getBigDecimal("total_service_price")
            );
            list.add(bs);
        }
        return list;
    }

    public boolean deleteServiceFromBooking(int bookingServiceId) throws SQLException {
        String sql = "DELETE FROM Booking_Service WHERE booking_service_id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, bookingServiceId);
        return st.executeUpdate() > 0;
    }
}
