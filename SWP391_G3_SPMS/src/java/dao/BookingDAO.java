/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import model.Booking;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LAZYVL
 */
public class BookingDAO extends DBContext {

    // get booking infor by bookingId
    public Booking getBookingById(int id) throws SQLException {
        String sql = "SELECT b.*, p.pool_name FROM Booking b "
                + "JOIN Pools p ON b.pool_id = p.pool_id "
                + "WHERE b.booking_id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, id);
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            return new Booking(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
                    rs.getString("pool_name"),
                    rs.getDate("booking_date"),
                    rs.getTime("start_time"),
                    rs.getTime("end_time"),
                    rs.getInt("slot_count"),
                    rs.getString("booking_status"),
                    rs.getDate("created_at"),
                    rs.getDate("updated_at")
            );
        }
        return null;
    }

    // Get booking information by userId
    public List<Booking> getBookingByUserId(int uid) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, p.pool_name FROM Booking b "
                + "JOIN Pools p ON b.pool_id = p.pool_id "
                + "WHERE b.user_id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, uid);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Booking b = new Booking(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
                    rs.getString("pool_name"),
                    rs.getDate("booking_date"),
                    rs.getTime("start_time"),
                    rs.getTime("end_time"),
                    rs.getInt("slot_count"),
                    rs.getString("booking_status"),
                    rs.getDate("created_at"),
                    rs.getDate("updated_at")
            );
            list.add(b);
        }
        return list;
    }

    // Search for named pools (pool name, LIKE, by user)
    public List<Booking> searchBookingByPoolName(int userId, String poolName) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, p.pool_name FROM Booking b JOIN Pools p ON b.pool_id = p.pool_id WHERE b.user_id = ? AND p.pool_name LIKE ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, userId);
        st.setString(2, "%" + poolName + "%");
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Booking b = new Booking(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
                    rs.getString("pool_name"),
                    rs.getDate("booking_date"),
                    rs.getTime("start_time"),
                    rs.getTime("end_time"),
                    rs.getInt("slot_count"),
                    rs.getString("booking_status"),
                    rs.getDate("created_at"),
                    rs.getDate("updated_at")
            );
            list.add(b);
        }
        return list;
    }

    // Search for booked pools by date (by user, in range fromDate - toDate)
    public List<Booking> searchBookingByDate(int userId, Date fromDate, Date toDate) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, p.pool_name FROM Booking b JOIN Pools p ON b.pool_id = p.pool_id "
                + "WHERE b.user_id = ? AND b.booking_date BETWEEN ? AND ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, userId);
        st.setDate(2, fromDate);
        st.setDate(3, toDate);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Booking b = new Booking(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
                    rs.getString("pool_name"),
                    rs.getDate("booking_date"),
                    rs.getTime("start_time"),
                    rs.getTime("end_time"),
                    rs.getInt("slot_count"),
                    rs.getString("booking_status"),
                    rs.getDate("created_at"),
                    rs.getDate("updated_at")
            );
            list.add(b);
        }
        return list;
    }

    // Sort tanks by most recent (newest) set time
    public List<Booking> sortBookingByDateDesc(int userId) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, p.pool_name FROM Booking b JOIN Pools p ON b.pool_id = p.pool_id "
                + "WHERE b.user_id = ? ORDER BY b.booking_date DESC, b.start_time DESC";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, userId);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Booking b = new Booking(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
                    rs.getString("pool_name"),
                    rs.getDate("booking_date"),
                    rs.getTime("start_time"),
                    rs.getTime("end_time"),
                    rs.getInt("slot_count"),
                    rs.getString("booking_status"),
                    rs.getDate("created_at"),
                    rs.getDate("updated_at")
            );
            list.add(b);
        }
        return list;
    }

    // Sort tanks by most recent (oldest) set time
    public List<Booking> sortBookingByDateAsc(int userId) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, p.pool_name FROM Booking b JOIN Pools p ON b.pool_id = p.pool_id "
                + "WHERE b.user_id = ? ORDER BY b.booking_date ASC, b.start_time ASC";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, userId);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Booking b = new Booking(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
                    rs.getString("pool_name"),
                    rs.getDate("booking_date"),
                    rs.getTime("start_time"),
                    rs.getTime("end_time"),
                    rs.getInt("slot_count"),
                    rs.getString("booking_status"),
                    rs.getDate("created_at"),
                    rs.getDate("updated_at")
            );
            list.add(b);
        }
        return list;
    }

    // Sort tanks by price from high to low
    public List<Booking> sortBookingByPriceDesc(int userId) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, p.pool_name FROM Booking b JOIN Pools p ON b.pool_id = p.pool_id "
                + "WHERE b.user_id = ? ORDER BY p.price DESC";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, userId);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Booking b = new Booking(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
                    rs.getString("pool_name"),
                    rs.getDate("booking_date"),
                    rs.getTime("start_time"),
                    rs.getTime("end_time"),
                    rs.getInt("slot_count"),
                    rs.getString("booking_status"),
                    rs.getDate("created_at"),
                    rs.getDate("updated_at")
            );
            list.add(b);
        }
        return list;
    }

    // Sort tanks by price from low to high
    public List<Booking> sortBookingByPriceAsc(int userId) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.*, p.pool_name FROM Booking b JOIN Pools p ON b.pool_id = p.pool_id "
                + "WHERE b.user_id = ? ORDER BY p.price ASC";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, userId);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Booking b = new Booking(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
                    rs.getString("pool_name"),
                    rs.getDate("booking_date"),
                    rs.getTime("start_time"),
                    rs.getTime("end_time"),
                    rs.getInt("slot_count"),
                    rs.getString("booking_status"),
                    rs.getDate("created_at"),
                    rs.getDate("updated_at")
            );
            list.add(b);
        }
        return list;
    }

    // Update booking status to "Paid"
    public void updateStatusToPaid(int bookingId) throws SQLException {
        String sql = "UPDATE Booking SET booking_status = 'Đã thanh toán', updated_at = GETDATE() WHERE booking_id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, bookingId);
        st.executeUpdate();
    }

    // Function to automatically update status for bookings that have reached the time but have not been paid (e.g. change to "Completed" or "Cancelled")
    public void autoUpdateBookingStatus() throws SQLException {
        // For example: if the booking is past the due date and not paid, update to "Cancelled"
        String sql = "UPDATE Booking SET booking_status = 'Đã hủy', updated_at = GETDATE() "
                + "WHERE booking_date < CAST(GETDATE() AS DATE) AND booking_status = 'Chưa thanh toán'";
        PreparedStatement st = connection.prepareStatement(sql);
        st.executeUpdate();
    }
}
