package dao.customer;

import dal.DBContext;
import model.customer.BookingDetails;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.customer.Ticket;
import model.staff.StaffCheckinInfo;

/**
 *
 * @author LAZYVL
 */
public class BookingDetailDAO extends DBContext {

    public BookingDetails getBookingDetailById(int id) {
        BookingDetails details = null;
        String sql = "SELECT b.booking_id, "
                + "b.user_id, "
                + "b.pool_id, "
                + "p.pool_name, "
                + "p.pool_address AS poolAddressDetail, "
                + "b.booking_date, "
                + "b.slot_count, "
                + "pay.total_amount AS amount, "
                + "b.booking_status, "
                + "f.rating, "
                + "f.comment, "
                + "b.start_time, "
                + "b.end_time, "
                + "COALESCE(d.discount_code, NULL) AS discount_code, "
                + "COALESCE(d.discount_percent, 0) AS discount_percent, "
                + "(SELECT COUNT(*) FROM Ticket t WHERE t.booking_id = b.booking_id) AS ticket_count "
                + "FROM Booking b "
                + "INNER JOIN Pools p ON b.pool_id = p.pool_id "
                + "LEFT JOIN Discounts d ON b.discount_id = d.discount_id "
                + "LEFT JOIN Feedbacks f ON f.user_id = b.user_id AND f.pool_id = b.pool_id "
                + "LEFT JOIN Payments pay ON pay.booking_id = b.booking_id "
                + "WHERE b.booking_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    // Lấy danh sách vé một lần
                    TicketDAO ticketDAO = new TicketDAO();
                    List<Ticket> tickets = ticketDAO.getTicketsByBookingId(id);

                    details = new BookingDetails(
                            rs.getInt("booking_id"),
                            rs.getInt("user_id"),
                            rs.getInt("pool_id"),
                            rs.getString("pool_name"),
                            rs.getString("poolAddressDetail"),
                            rs.getDate("booking_date"),
                            rs.getInt("slot_count"),
                            rs.getBigDecimal("amount"),
                            rs.getString("booking_status"),
                            rs.getObject("rating") == null ? null : rs.getInt("rating"),
                            rs.getString("comment"),
                            rs.getInt("ticket_count"),
                            rs.getTime("start_time"),
                            rs.getTime("end_time"),
                            rs.getString("discount_code"),
                            rs.getBigDecimal("discount_percent"),
                            tickets
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return details;
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
                + "WHERE b.user_id = ? "
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
            sql.append(" ORDER BY b.created_at ASC");
        } else if ("price_asc".equals(sortOrder)) {
            sql.append(" ORDER BY amount ASC");
        } else if ("price_desc".equals(sortOrder)) {
            sql.append(" ORDER BY amount DESC");
        } else {
            sql.append(" ORDER BY b.created_at DESC");
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
                + "ORDER BY b.created_at DESC";
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

    // Function to automatically update status for bookings that have reached the time but have not been paid
    public void autoUpdateBookingStatus() throws SQLException {
        // For example: if the booking is past the due date and not paid, update to "Cancelled"
        String sql = "UPDATE Booking SET booking_status = 'cancelled', updated_at = GETDATE() "
                + "WHERE booking_date < CAST(GETDATE() AS DATE) AND booking_status = 'pending'";
        PreparedStatement st = connection.prepareStatement(sql);
        st.executeUpdate();
    }

    public void cancelBooking(int bookingId) throws SQLException {
        String sql = "UPDATE Booking SET booking_status = 'cancelled', updated_at = GETDATE() WHERE booking_id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, bookingId);
        st.executeUpdate();
    }

    public List<StaffCheckinInfo> getBookingList(String fromDate, String toDate, String search, String status) {
        List<StaffCheckinInfo> list = new ArrayList<>();
        String sql = "SELECT b.booking_id, u.full_name, b.booking_date, b.start_time, b.end_time, c.checkinTime, c.checkinStatus "
                + "FROM Booking b "
                + "JOIN Users u ON b.user_id = u.user_id "
                + "LEFT JOIN Customer_Checkin c ON b.booking_id = c.bookingId AND c.checkinStatus = 1 "
                + "WHERE b.booking_date BETWEEN ? AND ? AND b.booking_status = 'confirmed' ";

        if (search != null && !search.isEmpty()) {
            sql += "AND (u.full_name LIKE ? OR b.booking_id LIKE ?) ";
        }

        // Lọc trạng thái checkin
        if ("checkedin".equals(status)) {
            sql += "AND c.checkinStatus = 1 ";
        } else if ("notcheckedin".equals(status)) {
            sql += "AND (c.checkinStatus IS NULL) ";
        }

        sql += "ORDER BY b.booking_date DESC, b.start_time";

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
                info.setBookingId(rs.getInt("booking_id"));
                info.setUserName(rs.getString("full_name"));
                info.setBookingDate(rs.getString("booking_date"));
                info.setStartTime(rs.getString("start_time"));
                info.setEndTime(rs.getString("end_time"));
                info.setCheckinTime(rs.getString("checkinTime"));
                info.setChecked(rs.getObject("checkinStatus") != null && rs.getInt("checkinStatus") == 1);
                list.add(info);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    // Thêm phương thức này vào BookingDetailDAO
    public List<StaffCheckinInfo> getBookingByPoolId(int poolId, String fromDate, String toDate, String search, String status) {
        List<StaffCheckinInfo> list = new ArrayList<>();
        String sql = "SELECT b.booking_id, u.full_name, b.booking_date, b.start_time, b.end_time, "
                + "c.checkinTime, CASE WHEN c.bookingId IS NOT NULL THEN 1 ELSE 0 END AS checked "
                + "FROM Booking b "
                + "JOIN Users u ON b.user_id = u.user_id "
                + "LEFT JOIN Customer_Checkin c ON b.booking_id = c.bookingId AND c.checkinStatus = 1 "
                + "WHERE b.pool_id = ? AND b.booking_status = 'confirmed' ";

        // Nếu có fromDate và toDate thì filter theo ngày
        if (fromDate != null && !fromDate.isEmpty() && toDate != null && !toDate.isEmpty()) {
            sql += "AND b.booking_date BETWEEN ? AND ? ";
        }

        // Tìm kiếm theo tên hoặc bookingId
        if (search != null && !search.isEmpty()) {
            sql += "AND (u.full_name LIKE ? OR b.booking_id LIKE ?) ";
        }

        // Lọc theo trạng thái check-in
        if (status != null && !status.isEmpty()) {
            if ("checkedin".equals(status)) {
                sql += "AND c.bookingId IS NOT NULL ";
            } else if ("notcheckedin".equals(status)) {
                sql += "AND c.bookingId IS NULL ";
            }
        }

        sql += "ORDER BY b.booking_date DESC, b.start_time DESC";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int idx = 1;
            ps.setInt(idx++, poolId);

            if (fromDate != null && !fromDate.isEmpty() && toDate != null && !toDate.isEmpty()) {
                ps.setString(idx++, fromDate);
                ps.setString(idx++, toDate);
            }

            if (search != null && !search.isEmpty()) {
                ps.setString(idx++, "%" + search + "%");
                ps.setString(idx++, "%" + search + "%");
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StaffCheckinInfo info = new StaffCheckinInfo();
                info.setBookingId(rs.getInt("booking_id"));
                info.setUserName(rs.getString("full_name"));
                info.setBookingDate(rs.getString("booking_date"));
                info.setStartTime(rs.getString("start_time"));
                info.setEndTime(rs.getString("end_time"));
                info.setCheckinTime(rs.getString("checkinTime"));
                info.setChecked(rs.getInt("checked") == 1);
                list.add(info);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public List<StaffCheckinInfo> getBookingByPoolIdWithPagination(int poolId, String fromDate, String toDate,
            String search, String status, int offset, int limit) {
        List<StaffCheckinInfo> list = new ArrayList<>();
        String sql = "SELECT b.booking_id, u.full_name, b.booking_date, b.start_time, b.end_time, "
                + "c.checkinTime, CASE WHEN c.bookingId IS NOT NULL THEN 1 ELSE 0 END AS checked "
                + "FROM Booking b "
                + "JOIN Users u ON b.user_id = u.user_id "
                + "LEFT JOIN Customer_Checkin c ON b.booking_id = c.bookingId AND c.checkinStatus = 1 "
                + "WHERE b.pool_id = ? AND b.booking_status = 'confirmed' ";

        if (fromDate != null && !fromDate.isEmpty() && toDate != null && !toDate.isEmpty()) {
            sql += "AND b.booking_date BETWEEN ? AND ? ";
        }

        if (search != null && !search.isEmpty()) {
            sql += "AND (u.full_name LIKE ? OR b.booking_id LIKE ?) ";
        }

        if (status != null && !status.isEmpty()) {
            if ("checkedin".equals(status)) {
                sql += "AND c.bookingId IS NOT NULL ";
            } else if ("notcheckedin".equals(status)) {
                sql += "AND c.bookingId IS NULL ";
            }
        }

        sql += "ORDER BY b.booking_date DESC, b.start_time DESC "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int idx = 1;
            ps.setInt(idx++, poolId);

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
                info.setBookingId(rs.getInt("booking_id"));
                info.setUserName(rs.getString("full_name"));
                info.setBookingDate(rs.getString("booking_date"));
                info.setStartTime(rs.getString("start_time"));
                info.setEndTime(rs.getString("end_time"));
                info.setCheckinTime(rs.getString("checkinTime"));
                info.setChecked(rs.getInt("checked") == 1);
                list.add(info);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return list;
    }

    public int countBookingByPoolId(int poolId, String fromDate, String toDate, String search, String status) {
        String sql = "SELECT COUNT(*) FROM Booking b "
                + "JOIN Users u ON b.user_id = u.user_id "
                + "LEFT JOIN Customer_Checkin c ON b.booking_id = c.bookingId AND c.checkinStatus = 1 "
                + "WHERE b.pool_id = ? AND b.booking_status = 'confirmed' ";

        if (fromDate != null && !fromDate.isEmpty() && toDate != null && !toDate.isEmpty()) {
            sql += "AND b.booking_date BETWEEN ? AND ? ";
        }

        if (search != null && !search.isEmpty()) {
            sql += "AND (u.full_name LIKE ? OR b.booking_id LIKE ?) ";
        }

        if (status != null && !status.isEmpty()) {
            if ("checkedin".equals(status)) {
                sql += "AND c.bookingId IS NOT NULL ";
            } else if ("notcheckedin".equals(status)) {
                sql += "AND c.bookingId IS NULL ";
            }
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int idx = 1;
            ps.setInt(idx++, poolId);

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

//    public static void main(String[] args) throws SQLException {
//        BookingDetailDAO b = new BookingDetailDAO();
//        b.cancelBooking(35);
//    }
}
