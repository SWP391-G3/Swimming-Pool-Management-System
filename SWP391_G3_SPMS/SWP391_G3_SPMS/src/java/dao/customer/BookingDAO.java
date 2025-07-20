package dao.customer;

import dal.DBContext;
import java.math.BigDecimal;
import model.customer.Booking;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LAZYVL
 */
public class BookingDAO extends DBContext {

    public int createBooking(Booking booking) {
        int generatedId = -1;
        String sql = "INSERT INTO Booking (user_id, pool_id, discount_id, booking_date, start_time, end_time, slot_count, booking_status, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, GETDATE())";

        try {
            PreparedStatement st = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            if (booking.getUserId() != null) {
                st.setInt(1, booking.getUserId());
            } else {
                st.setNull(1, java.sql.Types.INTEGER);
            }
            st.setInt(2, booking.getPoolId());
            // discount_id
            if (booking.getDiscountId() != null) {
                st.setInt(3, booking.getDiscountId());
            } else {
                st.setNull(3, java.sql.Types.INTEGER);
            }
            st.setDate(4, booking.getBookingDate());
            st.setTime(5, booking.getStartTime());
            st.setTime(6, booking.getEndTime());
            st.setInt(7, booking.getSlotCount());
            st.setString(8, booking.getBookingStatus());

            int affectedRows = st.executeUpdate();

            if (affectedRows > 0) {
                ResultSet rs = st.getGeneratedKeys();
                if (rs.next()) {
                    generatedId = rs.getInt(1);
                }
                rs.close();
            }
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return generatedId;
    }

    public boolean isSlotAvailable(int poolId, Date date, Time start, Time end, int slotCount) {
        try {
            // Lấy max_slot
            String sqlMaxSlot = "SELECT max_slot FROM Pools WHERE pool_id = ?";
            PreparedStatement psMaxSlot = connection.prepareStatement(sqlMaxSlot);
            psMaxSlot.setInt(1, poolId);
            ResultSet rsMaxSlot = psMaxSlot.executeQuery();
            int maxSlot = 0;
            if (rsMaxSlot.next()) {
                maxSlot = rsMaxSlot.getInt(1);
            }
            rsMaxSlot.close();
            psMaxSlot.close();

            // Tính tổng slot_count đã đặt trùng thời gian đó (pending hoặc confirmed)
            String sqlBooked = """
            SELECT ISNULL(SUM(slot_count), 0)
            FROM Booking
            WHERE pool_id = ? 
              AND booking_date = ?
              AND booking_status IN ('pending', 'confirmed')
              AND NOT (end_time <= ? OR start_time >= ?)
            """;
            // Giải thích: 
            // NOT (end_time <= start OR start_time >= end) -> có nghĩa là có sự chồng lắp thời gian

            PreparedStatement psBooked = connection.prepareStatement(sqlBooked);
            psBooked.setInt(1, poolId);
            psBooked.setDate(2, date);
            psBooked.setTime(3, start); // end_time <= start -> không trùng, vậy lấy start để so sánh
            psBooked.setTime(4, end);   // start_time >= end -> không trùng, lấy end để so sánh

            ResultSet rsBooked = psBooked.executeQuery();
            int bookedSlots = 0;
            if (rsBooked.next()) {
                bookedSlots = rsBooked.getInt(1);
            }
            rsBooked.close();
            psBooked.close();

            // So sánh slot còn đủ không
            return (maxSlot - bookedSlots) >= slotCount;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public BigDecimal calculateTotalAmountForBooking(int bookingId) {
        String sql = "SELECT total_amount FROM vw_BookingTotalAmount WHERE booking_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getBigDecimal("total_amount");
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    public Booking getBookingById(int bookingId) {
        Booking booking = null;
        String sql = "SELECT * FROM Booking WHERE booking_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, bookingId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                booking = new Booking();
                booking.setBookingId(rs.getInt("booking_id"));
                booking.setUserId(rs.getInt("user_id"));
                booking.setPoolId(rs.getInt("pool_id"));

                int discountId = rs.getInt("discount_id");
                if (!rs.wasNull()) {
                    booking.setDiscountId(discountId);
                } else {
                    booking.setDiscountId(null);
                }

                booking.setBookingDate(rs.getDate("booking_date"));
                booking.setStartTime(rs.getTime("start_time"));
                booking.setEndTime(rs.getTime("end_time"));
                booking.setSlotCount(rs.getInt("slot_count"));
                booking.setBookingStatus(rs.getString("booking_status"));
                booking.setCreatedAt(rs.getTimestamp("created_at"));
                booking.setUpdatedAt(rs.getTimestamp("updated_at"));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return booking;
    }
}
