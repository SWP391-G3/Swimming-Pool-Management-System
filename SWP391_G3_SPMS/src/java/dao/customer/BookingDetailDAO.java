/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.customer;

import dal.DBContext;
import model.customer.BookingDetails;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LAZYVL
 */
public class BookingDetailDAO extends DBContext {

    // Get booking detail by bookingId
    public BookingDetails getBookingDetailById(int id) throws SQLException {
        String sql = "SELECT b.booking_id, b.user_id, b.pool_id, p.pool_name, "
                + "(p.pool_road + ', ' + p.pool_address) AS pool_address_detail, "
                + "b.booking_date, b.slot_count, ISNULL(pm.total_amount, 0) AS amount, b.booking_status, "
                + "f.rating, f.comment "
                + "FROM Booking b "
                + "JOIN Pools p ON b.pool_id = p.pool_id "
                + "LEFT JOIN Payments pm ON b.booking_id = pm.booking_id "
                + "LEFT JOIN Feedbacks f ON b.user_id = f.user_id AND b.pool_id = f.pool_id "
                + "WHERE b.booking_id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, id);
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            return new BookingDetails(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
                    rs.getString("pool_name"),
                    rs.getString("pool_address_detail"),
                    rs.getDate("booking_date"),
                    rs.getInt("slot_count"),
                    rs.getBigDecimal("amount"),
                    rs.getString("booking_status"),
                    rs.getObject("rating") == null ? null : rs.getInt("rating"),
                    rs.getString("comment")
            );
        }
        return null;
    }

    // Get all booking details by userId
    public List<BookingDetails> getBookingDetailsByUserId(int userId) throws SQLException {
        List<BookingDetails> list = new ArrayList<>();
        String sql = "SELECT b.booking_id, b.user_id, b.pool_id, p.pool_name, "
                + "(p.pool_road + ', ' + p.pool_address) AS pool_address_detail, "
                + "b.booking_date, b.slot_count, ISNULL(pm.total_amount, 0) AS amount, b.booking_status, "
                + "f.rating, f.comment "
                + "FROM Booking b "
                + "JOIN Pools p ON b.pool_id = p.pool_id "
                + "LEFT JOIN Payments pm ON b.booking_id = pm.booking_id "
                + "LEFT JOIN Feedbacks f ON b.user_id = f.user_id AND b.pool_id = f.pool_id "
                + "WHERE b.user_id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, userId);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            BookingDetails bd = new BookingDetails(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
                    rs.getString("pool_name"),
                    rs.getString("pool_address_detail"),
                    rs.getDate("booking_date"),
                    rs.getInt("slot_count"),
                    rs.getBigDecimal("amount"),
                    rs.getString("booking_status"),
                    rs.getObject("rating") == null ? null : rs.getInt("rating"),
                    rs.getString("comment")
            );
            list.add(bd);
        }
        return list;
    }

    //Search All Info
    public List<BookingDetails> searchBookingDetails(int userId, String poolName, String fromDateStr, String status, String sortOrder) throws SQLException {
        List<BookingDetails> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT b.booking_id, b.user_id, b.pool_id, p.pool_name, "
                + "(p.pool_road + ', ' + p.pool_address) AS pool_address_detail, "
                + "b.booking_date, b.slot_count, ISNULL(pm.total_amount, 0) AS amount, b.booking_status, "
                + "f.rating, f.comment "
                + "FROM Booking b "
                + "JOIN Pools p ON b.pool_id = p.pool_id "
                + "LEFT JOIN Payments pm ON b.booking_id = pm.booking_id "
                + "LEFT JOIN Feedbacks f ON b.user_id = f.user_id AND b.pool_id = f.pool_id "
                + "WHERE b.user_id = ?"
        );
        List<Object> params = new ArrayList<>();
        params.add(userId);

        if (poolName != null && !poolName.trim().isEmpty()) {
            sql.append(" AND p.pool_name LIKE ?");
            params.add("%" + poolName.trim() + "%");
        }
        if (fromDateStr != null && !fromDateStr.trim().isEmpty()) {
            sql.append(" AND b.booking_date = ?");
            params.add(Date.valueOf(fromDateStr));
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND b.booking_status = ?");
            params.add(status.trim());
        }

        // Sắp xếp
        if ("date_asc".equals(sortOrder)) {
            sql.append(" ORDER BY b.booking_date ASC");
        } else if ("price_asc".equals(sortOrder)) {
            sql.append(" ORDER BY amount ASC");
        } else if ("price_desc".equals(sortOrder)) {
            sql.append(" ORDER BY amount DESC");
        } else {
            sql.append(" ORDER BY b.booking_date DESC");
        }

        PreparedStatement st = connection.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); ++i) {
            st.setObject(i + 1, params.get(i));
        }
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            BookingDetails bd = new BookingDetails(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
                    rs.getString("pool_name"),
                    rs.getString("pool_address_detail"),
                    rs.getDate("booking_date"),
                    rs.getInt("slot_count"),
                    rs.getBigDecimal("amount"),
                    rs.getString("booking_status"),
                    rs.getObject("rating") == null ? null : rs.getInt("rating"),
                    rs.getString("comment")
            );
            list.add(bd);
        }
        return list;
    }

    //Search All Info with paging
    public List<BookingDetails> searchBookingDetails(int userId, String poolName, String fromDateStr, String toDateStr, String status, String sortOrder, int page, int pageSize) throws SQLException {
        List<BookingDetails> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT b.booking_id, b.user_id, b.pool_id, p.pool_name, "
                + "(p.pool_road + ', ' + p.pool_address) AS pool_address_detail, "
                + "b.booking_date, b.slot_count, ISNULL(pm.total_amount, 0) AS amount, b.booking_status, "
                + "f.rating, f.comment "
                + "FROM Booking b "
                + "JOIN Pools p ON b.pool_id = p.pool_id "
                + "LEFT JOIN Payments pm ON b.booking_id = pm.booking_id "
                + "LEFT JOIN Feedbacks f ON b.user_id = f.user_id AND b.pool_id = f.pool_id "
                + "WHERE b.user_id = ?"
        );
        List<Object> params = new ArrayList<>();
        params.add(userId);

        if (poolName != null && !poolName.trim().isEmpty()) {
            sql.append(" AND p.pool_name LIKE ?");
            params.add("%" + poolName.trim() + "%");
        }
        if (fromDateStr != null && !fromDateStr.trim().isEmpty()) {
            sql.append(" AND b.booking_date >= ?");
            params.add(Date.valueOf(fromDateStr));
        }
        if (toDateStr != null && !toDateStr.trim().isEmpty()) {
            sql.append(" AND b.booking_date <= ?");
            params.add(Date.valueOf(toDateStr));
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND b.booking_status = ?");
            params.add(status.trim());
        }

        // Sắp xếp
        if ("date_asc".equals(sortOrder)) {
            sql.append(" ORDER BY b.booking_date ASC");
        } else if ("price_asc".equals(sortOrder)) {
            sql.append(" ORDER BY amount ASC");
        } else if ("price_desc".equals(sortOrder)) {
            sql.append(" ORDER BY amount DESC");
        } else {
            sql.append(" ORDER BY b.booking_date DESC");
        }

        // OFFSET-FETCH cho phân trang
        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        PreparedStatement st = connection.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); ++i) {
            st.setObject(i + 1, params.get(i));
        }
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            BookingDetails bd = new BookingDetails(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
                    rs.getString("pool_name"),
                    rs.getString("pool_address_detail"),
                    rs.getDate("booking_date"),
                    rs.getInt("slot_count"),
                    rs.getBigDecimal("amount"),
                    rs.getString("booking_status"),
                    rs.getObject("rating") == null ? null : rs.getInt("rating"),
                    rs.getString("comment")
            );
            list.add(bd);
        }
        return list;
    }

    // Đếm tổng booking cho phân trang (khoảng ngày)
    public int countBookingDetails(int userId, String poolName, String fromDateStr, String toDateStr, String status) throws SQLException {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM Booking b JOIN Pools p ON b.pool_id = p.pool_id WHERE b.user_id = ?"
        );
        List<Object> params = new ArrayList<>();
        params.add(userId);

        if (poolName != null && !poolName.trim().isEmpty()) {
            sql.append(" AND p.pool_name LIKE ?");
            params.add("%" + poolName.trim() + "%");
        }
        if (fromDateStr != null && !fromDateStr.trim().isEmpty()) {
            sql.append(" AND b.booking_date >= ?");
            params.add(Date.valueOf(fromDateStr));
        }
        if (toDateStr != null && !toDateStr.trim().isEmpty()) {
            sql.append(" AND b.booking_date <= ?");
            params.add(Date.valueOf(toDateStr));
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND b.booking_status = ?");
            params.add(status.trim());
        }
        PreparedStatement st = connection.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); ++i) {
            st.setObject(i + 1, params.get(i));
        }
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }

    // Hàm này lấy tổng số booking
    public int countBookingDetails(int userId, String poolName, String fromDateStr, String status) throws SQLException {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM Booking b JOIN Pools p ON b.pool_id = p.pool_id WHERE b.user_id = ?"
        );
        List<Object> params = new ArrayList<>();
        params.add(userId);

        if (poolName != null && !poolName.trim().isEmpty()) {
            sql.append(" AND p.pool_name LIKE ?");
            params.add("%" + poolName.trim() + "%");
        }
        if (fromDateStr != null && !fromDateStr.trim().isEmpty()) {
            sql.append(" AND b.booking_date = ?");
            params.add(Date.valueOf(fromDateStr));
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append(" AND b.booking_status = ?");
            params.add(status.trim());
        }
        PreparedStatement st = connection.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); ++i) {
            st.setObject(i + 1, params.get(i));
        }
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }

    // Sort by booking_date DESC
    public List<BookingDetails> sortBookingDetailByDateDesc(int userId) throws SQLException {
        List<BookingDetails> list = new ArrayList<>();
        String sql = "SELECT b.booking_id, b.user_id, b.pool_id, p.pool_name, "
                + "(p.pool_road + ', ' + p.pool_address) AS pool_address_detail, "
                + "b.booking_date, b.slot_count, ISNULL(pm.total_amount, 0) AS amount, b.booking_status, "
                + "f.rating, f.comment "
                + "FROM Booking b "
                + "JOIN Pools p ON b.pool_id = p.pool_id "
                + "LEFT JOIN Payments pm ON b.booking_id = pm.booking_id "
                + "LEFT JOIN Feedbacks f ON b.user_id = f.user_id AND b.pool_id = f.pool_id "
                + "WHERE b.user_id = ? "
                + "ORDER BY b.booking_date DESC";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, userId);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            BookingDetails bd = new BookingDetails(
                    rs.getInt("booking_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
                    rs.getString("pool_name"),
                    rs.getString("pool_address_detail"),
                    rs.getDate("booking_date"),
                    rs.getInt("slot_count"),
                    rs.getBigDecimal("amount"),
                    rs.getString("booking_status"),
                    rs.getObject("rating") == null ? null : rs.getInt("rating"),
                    rs.getString("comment")
            );
            list.add(bd);
        }
        return list;
    }

    // Update booking status to "Paid"
    public void updateStatusToPaid(int bookingId) throws SQLException {
        String sql = "UPDATE Booking SET booking_status = 'confirmed', updated_at = GETDATE() WHERE booking_id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, bookingId);
        st.executeUpdate();
    }

    // Function to automatically update status for bookings that have reached the time but have not been paid (e.g. change to "Completed" or "Cancelled")
    public void autoUpdateBookingStatus() throws SQLException {
        // For example: if the booking is past the due date and not paid, update to "Cancelled"
        String sql = "UPDATE Booking SET booking_status = 'cancelled', updated_at = GETDATE() "
                + "WHERE booking_date < CAST(GETDATE() AS DATE) AND booking_status = 'pending'";
        PreparedStatement st = connection.prepareStatement(sql);
        st.executeUpdate();
    }
}
