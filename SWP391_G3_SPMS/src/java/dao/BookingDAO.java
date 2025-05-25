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
    // Đếm tổng số booking hôm nay (sau khi search/filter)
    public int countBookingsToday(String search, String status) throws SQLException {
        String sql = "SELECT COUNT(*) " +
                "FROM Booking b " +
                "JOIN Users u ON b.user_id = u.user_id " +
                "JOIN Pools p ON b.pool_id = p.pool_id " +
                "WHERE b.booking_date = CAST(GETDATE() AS DATE) ";
        if (search != null && !search.trim().isEmpty()) {
            sql += "AND (u.full_name LIKE ? OR u.email LIKE ? OR u.phone LIKE ? OR p.pool_name LIKE ?) ";
        }
        if (status != null && !status.equals("all")) {
            sql += "AND b.booking_status = ? ";
        }
        PreparedStatement st = connection.prepareStatement(sql);
        int idx = 1;
        if (search != null && !search.trim().isEmpty()) {
            for (int i = 0; i < 4; i++) {
                st.setString(idx++, "%" + search + "%");
            }
        }
        if (status != null && !status.equals("all")) {
            st.setString(idx++, status);
        }
        ResultSet rs = st.executeQuery();
        return rs.next() ? rs.getInt(1) : 0;
    }

    // Lấy list booking hôm nay với search/filter/sort/pagination
    public List<Booking> listBookingsToday(String search, String status, String sort, String sortDir, int page, int pageSize) throws SQLException {
        List<Booking> list = new ArrayList<>();
        String sql = "SELECT b.booking_id, u.full_name, u.phone, u.email, p.pool_name, b.booking_date, b.start_time, b.end_time, b.slot_count, b.booking_status " +
                "FROM Booking b " +
                "JOIN Users u ON b.user_id = u.user_id " +
                "JOIN Pools p ON b.pool_id = p.pool_id " +
                "WHERE b.booking_date = CAST(GETDATE() AS DATE) ";
        if (search != null && !search.trim().isEmpty()) {
            sql += "AND (u.full_name LIKE ? OR u.email LIKE ? OR u.phone LIKE ? OR p.pool_name LIKE ?) ";
        }
        if (status != null && !status.equals("all")) {
            sql += "AND b.booking_status = ? ";
        }
        // sort
        String orderBy = "b.booking_id";
        if (sort != null) {
            switch (sort) {
                case "name": orderBy = "u.full_name"; break;
                case "pool": orderBy = "p.pool_name"; break;
                case "date": orderBy = "b.booking_date"; break;
                case "status": orderBy = "b.booking_status"; break;
            }
        }
        sql += "ORDER BY " + orderBy + (sortDir != null && sortDir.equalsIgnoreCase("desc") ? " DESC " : " ASC ");
        // pagination
        sql += "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        PreparedStatement st = connection.prepareStatement(sql);
        int idx = 1;
        if (search != null && !search.trim().isEmpty()) {
            for (int i = 0; i < 4; i++) {
                st.setString(idx++, "%" + search + "%");
            }
        }
        if (status != null && !status.equals("all")) {
            st.setString(idx++, status);
        }
        st.setInt(idx++, (page - 1) * pageSize);
        st.setInt(idx, pageSize);

        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Booking b = new Booking(
                    rs.getInt("booking_id"),
                    rs.getString("full_name"),
                    rs.getString("phone"),
                    rs.getString("email"),
                    rs.getString("pool_name"),
                    rs.getDate("booking_date"),
                    rs.getTime("start_time"),
                    rs.getTime("end_time"),
                    rs.getInt("slot_count"),
                    rs.getString("booking_status")
            );
            list.add(b);
        }
        return list;
    }
}
