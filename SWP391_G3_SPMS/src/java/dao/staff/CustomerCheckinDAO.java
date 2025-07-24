/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.staff;

/**
 *
 * @author LAZYVL
 */
import dal.DBContext;
import model.staff.CustomerCheckin;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.staff.StaffCheckinInfo;

public class CustomerCheckinDAO extends DBContext {

    public boolean checkin(int userId, int bookingId, Timestamp checkinTime) {
        String sql = "INSERT INTO Customer_Checkin (userId, bookingId, checkinStatus, checkinTime) VALUES (?, ?, 1, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, bookingId);
            ps.setTimestamp(3, checkinTime);
            return ps.executeUpdate() > 0;
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }

    // Lấy danh sách đã check-in theo ngày và filter
    public List<StaffCheckinInfo> getCheckedInList(String fromDate, String toDate, String search, String status) {
        List<StaffCheckinInfo> list = new ArrayList<>();
        String sql = "SELECT c.bookingId, u.full_name, b.booking_date, b.start_time, b.end_time, c.checkinTime "
                + "FROM Customer_Checkin c "
                + "JOIN Booking b ON c.bookingId = b.booking_id "
                + "JOIN Users u ON b.user_id = u.user_id "
                + "WHERE c.checkinStatus = 1 "
                + "AND b.booking_date BETWEEN ? AND ? ";

        // Tìm kiếm theo tên hoặc bookingId
        if (search != null && !search.isEmpty()) {
            sql += "AND (u.full_name LIKE ? OR c.bookingId LIKE ?) ";
        }

        // Lọc trạng thái nếu có
        // Ở đây đã là check-in nên luôn là checked
        // Nếu muốn linh động thêm status thì bổ sung
        sql += "ORDER BY b.booking_date DESC, c.checkinTime DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int idx = 1;
            ps.setString(idx++, fromDate);
            ps.setString(idx++, toDate);
            if (search != null && !search.isEmpty()) {
                ps.setString(idx++, "%" + search + "%");
                ps.setString(idx++, "%" + search + "%");
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StaffCheckinInfo info = new StaffCheckinInfo();
                info.setBookingId(rs.getInt("bookingId"));
                info.setUserName(rs.getString("full_name"));
                info.setBookingDate(rs.getString("booking_date"));
                info.setStartTime(rs.getString("start_time"));
                info.setEndTime(rs.getString("end_time"));
                info.setCheckinTime(rs.getString("checkinTime"));
                info.setChecked(true);
                list.add(info);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Kiểm tra một booking đã check-in chưa
    public boolean isCheckedIn(int bookingId) {
        String sql = "SELECT 1 FROM Customer_Checkin WHERE bookingId = ? AND checkinStatus = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception ex) {
            ex.printStackTrace();
            return false;
        }
    }

    // Lấy thời gian check-in của booking
    public String getCheckinTime(int bookingId) {
        String sql = "SELECT checkinTime FROM Customer_Checkin WHERE bookingId = ? AND checkinStatus = 1";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Timestamp ts = rs.getTimestamp("checkinTime");
                return (ts != null) ? ts.toString() : null;
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public List<StaffCheckinInfo> getCheckedInListWithPagination(String fromDate, String toDate, String search,
            String status, int offset, int limit) {
        List<StaffCheckinInfo> list = new ArrayList<>();
        String sql = "SELECT c.bookingId, u.full_name, b.booking_date, b.start_time, b.end_time, c.checkinTime "
                + "FROM Customer_Checkin c "
                + "JOIN Booking b ON c.bookingId = b.booking_id "
                + "JOIN Users u ON b.user_id = u.user_id "
                + "WHERE c.checkinStatus = 1 ";

        if (fromDate != null && !fromDate.isEmpty() && toDate != null && !toDate.isEmpty()) {
            sql += "AND b.booking_date BETWEEN ? AND ? ";
        }

        if (search != null && !search.isEmpty()) {
            sql += "AND (u.full_name LIKE ? OR c.bookingId LIKE ?) ";
        }

        sql += "ORDER BY b.booking_date DESC, c.checkinTime DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int idx = 1;

            if (fromDate != null && !fromDate.isEmpty() && toDate != null && !toDate.isEmpty()) {
                ps.setString(idx++, fromDate);
                ps.setString(idx++, toDate);
            }

            if (search != null && !search.isEmpty()) {
                ps.setString(idx++, "%" + search + "%");
                ps.setString(idx++, "%" + search + "%");
            }

            ps.setInt(idx++, offset);
            ps.setInt(idx++, limit);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StaffCheckinInfo info = new StaffCheckinInfo();
                info.setBookingId(rs.getInt("bookingId"));
                info.setUserName(rs.getString("full_name"));
                info.setBookingDate(rs.getString("booking_date"));
                info.setStartTime(rs.getString("start_time"));
                info.setEndTime(rs.getString("end_time"));
                info.setCheckinTime(rs.getString("checkinTime"));
                info.setChecked(true);
                list.add(info);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public int countCheckedInList(String fromDate, String toDate, String search, String status) {
        String sql = "SELECT COUNT(*) FROM Customer_Checkin c "
                + "JOIN Booking b ON c.bookingId = b.booking_id "
                + "JOIN Users u ON b.user_id = u.user_id "
                + "WHERE c.checkinStatus = 1 ";

        if (fromDate != null && !fromDate.isEmpty() && toDate != null && !toDate.isEmpty()) {
            sql += "AND b.booking_date BETWEEN ? AND ? ";
        }

        if (search != null && !search.isEmpty()) {
            sql += "AND (u.full_name LIKE ? OR c.bookingId LIKE ?) ";
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int idx = 1;

            if (fromDate != null && !fromDate.isEmpty() && toDate != null && !toDate.isEmpty()) {
                ps.setString(idx++, fromDate);
                ps.setString(idx++, toDate);
            }

            if (search != null && !search.isEmpty()) {
                ps.setString(idx++, "%" + search + "%");
                ps.setString(idx++, "%" + search + "%");
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return 0;
    }
}
