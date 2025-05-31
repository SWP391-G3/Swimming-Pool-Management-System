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

    // Lấy thông tin booking theo id
    public Booking getBookingById(int id) throws SQLException {
        String sql = "SELECT * FROM Booking WHERE booking_id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, id);
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            return new Booking(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
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

    // Tìm kiếm bể đã đặt theo tên (pool name, LIKE, theo user)
    public List<Booking> searchBookingByPoolName(int userId, String poolName) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM Booking b JOIN Pools p ON b.pool_id = p.pool_id WHERE b.user_id = ? AND p.pool_name LIKE ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, userId);
        st.setString(2, "%" + poolName + "%");
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Booking b = new Booking(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
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

    // Tìm kiếm bể đã đặt theo ngày (theo user, trong khoảng fromDate - toDate)
    public List<Booking> searchBookingByDate(int userId, Date fromDate, Date toDate) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM Booking WHERE user_id = ? AND booking_date BETWEEN ? AND ?";
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

    // Sắp xếp bể theo thời gian đặt gần nhất (mới nhất)
    public List<Booking> sortBookingByDateDesc(int userId) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM Booking WHERE user_id = ? ORDER BY booking_date DESC, start_time DESC";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, userId);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Booking b = new Booking(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
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

    // Sắp xếp bể theo thời gian đặt xa nhất (cũ nhất)
    public List<Booking> sortBookingByDateAsc(int userId) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT * FROM Booking WHERE user_id = ? ORDER BY booking_date ASC, start_time ASC";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, userId);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Booking b = new Booking(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
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

    // Sắp xếp bể theo giá tiền từ cao đến thấp
    public List<Booking> sortBookingByPriceDesc(int userId) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.* FROM Booking b JOIN Pools p ON b.pool_id = p.pool_id WHERE b.user_id = ? ORDER BY p.price DESC";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, userId);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Booking b = new Booking(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
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

    // Sắp xếp bể theo giá tiền từ thấp đến cao
    public List<Booking> sortBookingByPriceAsc(int userId) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.* FROM Booking b JOIN Pools p ON b.pool_id = p.pool_id WHERE b.user_id = ? ORDER BY p.price ASC";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, userId);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Booking b = new Booking(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
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

    // Update trạng thái booking sang "Đã thanh toán"
    public void updateStatusToPaid(int bookingId) throws SQLException {
        String sql = "UPDATE Booking SET booking_status = 'Đã thanh toán', updated_at = GETDATE() WHERE booking_id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, bookingId);
        st.executeUpdate();
    }

    // Hàm tự động cập nhật trạng thái cho các booking đã đến giờ nhưng chưa thanh toán (ví dụ chuyển sang "Đã hoàn thành" hoặc "Đã hủy")
    public void autoUpdateBookingStatus() throws SQLException {
        // Ví dụ: nếu booking đã qua ngày, chưa thanh toán, update thành "Đã hủy"
        String sql = "UPDATE Booking SET booking_status = 'Đã hủy', updated_at = GETDATE() "
                + "WHERE booking_date < CAST(GETDATE() AS DATE) AND booking_status = 'Chưa thanh toán'";
        PreparedStatement st = connection.prepareStatement(sql);
        st.executeUpdate();
    }

    // Đếm số lượng booking của 1 user
    public int countUserBookings(int userId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Booking WHERE user_id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, userId);
        ResultSet rs = st.executeQuery();
        return rs.next() ? rs.getInt(1) : 0;
    }

    // Lấy danh sách các trạng thái booking khác nhau
    public List<String> getAllBookingStatuses() throws SQLException {
        List<String> statuses = new ArrayList<>();
        String sql = "SELECT DISTINCT booking_status FROM Booking";
        Statement st = connection.createStatement();
        ResultSet rs = st.executeQuery(sql);
        while (rs.next()) {
            statuses.add(rs.getString("booking_status"));
        }
        return statuses;
    }
}
