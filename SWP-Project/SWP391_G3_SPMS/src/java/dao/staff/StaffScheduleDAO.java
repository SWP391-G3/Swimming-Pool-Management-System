package dao.staff;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import model.staff.Attendance;
import model.staff.StaffAssignment;
import model.staff.StaffScheduleRow;

/**
 *
 * @author Tuan Anh
 */
public class StaffScheduleDAO extends DBContext {

    public List<StaffScheduleRow> getStaffScheduleWithAttendance(int userId, LocalDate startOfWeek, LocalDate endOfWeek) throws SQLException {
        List<StaffScheduleRow> list = new ArrayList<>();
        String sql = """
            SELECT sa.assigned_date, p.pool_name, sa.pool_id, sa.shift_name,
                   a.attendance_id, a.check_in, a.check_out
            FROM Staff_Assignment sa
            JOIN Pools p ON sa.pool_id = p.pool_id
            LEFT JOIN Attendance a ON a.user_id = sa.user_id
                                    AND a.pool_id = sa.pool_id
                                    AND a.shift_name = sa.shift_name
                                    AND CAST(a.check_in AS DATE) = sa.assigned_date
            WHERE sa.user_id = ? AND sa.assigned_date BETWEEN ? AND ?
            ORDER BY sa.assigned_date,
                     CASE sa.shift_name
                         WHEN N'Sáng' THEN 1
                         WHEN N'Chiều' THEN 2
                         WHEN N'Tối' THEN 3
                         ELSE 4
                     END
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setDate(2, java.sql.Date.valueOf(startOfWeek));
            ps.setDate(3, java.sql.Date.valueOf(endOfWeek));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StaffScheduleRow row = new StaffScheduleRow();
                row.setDate(rs.getDate("assigned_date").toLocalDate());
                row.setPool(rs.getString("pool_name"));
                row.setPoolId(rs.getInt("pool_id"));
                row.setShift(rs.getString("shift_name"));
                row.setAttendanceId(rs.getObject("attendance_id") != null ? rs.getInt("attendance_id") : null);
                row.setCheckIn(rs.getTimestamp("check_in"));
                row.setCheckOut(rs.getTimestamp("check_out"));
                list.add(row);
            }
        }
        return list;
    }

    public List<StaffAssignment> getStaffAssignments(int userId, LocalDate startOfWeek, LocalDate endOfWeek) throws SQLException {
        List<StaffAssignment> list = new ArrayList<>();
        String sql = """
                   SELECT sa.assignment_id, sa.user_id, sa.pool_id, p.pool_name, sa.shift_name, sa.assigned_date
                   FROM Staff_Assignment sa
                   JOIN Pools p ON sa.pool_id = p.pool_id
                   WHERE sa.user_id = ? AND sa.assigned_date BETWEEN ? AND ?
                   ORDER BY sa.assigned_date,
                   CASE sa.shift_name
                        WHEN N'Sáng' THEN 1
                        WHEN N'Chiều' THEN 2
                        WHEN N'Tối' THEN 3
                        ELSE 4
                   END
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setDate(2, java.sql.Date.valueOf(startOfWeek));
            ps.setDate(3, java.sql.Date.valueOf(endOfWeek));
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StaffAssignment sa = new StaffAssignment();
                sa.setAssignmentId(rs.getInt("assignment_id"));
                sa.setUserId(rs.getInt("user_id"));
                sa.setPoolId(rs.getInt("pool_id"));
                sa.setPoolName(rs.getString("pool_name"));
                sa.setShiftName(rs.getString("shift_name"));
                sa.setAssignedDate(rs.getDate("assigned_date").toLocalDate());
                list.add(sa);
            }
        }
        return list;
    }

    public Attendance getAttendance(int userId, int poolId, String shift, LocalDate date) throws SQLException {
        String sql = """
            SELECT attendance_id, user_id, pool_id, shift_name, check_in, check_out
            FROM Attendance
            WHERE user_id = ? AND pool_id = ? AND shift_name = ? AND CAST(check_in AS DATE) = ?
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, poolId);
            ps.setString(3, shift);
            ps.setDate(4, java.sql.Date.valueOf(date));
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Attendance att = new Attendance();
                att.setAttendanceId(rs.getInt("attendance_id"));
                att.setUserId(rs.getInt("user_id"));
                att.setPoolId(rs.getInt("pool_id"));
                att.setShiftName(rs.getString("shift_name"));
                att.setCheckIn(rs.getTimestamp("check_in"));
                att.setCheckOut(rs.getTimestamp("check_out"));
                return att;
            }
        }
        return null;
    }

    public void insertCheckIn(int userId, int poolId, String shift, Timestamp now) throws SQLException {
    // Kiểm tra đã tồn tại điểm danh chưa
    String checkSql = """
        SELECT 1 FROM Attendance
        WHERE user_id = ? AND pool_id = ? AND shift_name = ? AND CAST(check_in AS DATE) = CAST(? AS DATE)
    """;
    try (PreparedStatement checkPs = connection.prepareStatement(checkSql)) {
        checkPs.setInt(1, userId);
        checkPs.setInt(2, poolId);
        checkPs.setString(3, shift);
        checkPs.setTimestamp(4, now);
        ResultSet rs = checkPs.executeQuery();
        if (rs.next()) {
            // Đã có check-in rồi, không thêm nữa
            return;
        }
    }

    // Nếu chưa có thì thêm
    String insertSql = """
        INSERT INTO Attendance (user_id, pool_id, check_in, shift_name, created_at)
        VALUES (?, ?, ?, ?, ?)
    """;
    try (PreparedStatement ps = connection.prepareStatement(insertSql)) {
        ps.setInt(1, userId);
        ps.setInt(2, poolId);
        ps.setTimestamp(3, now);
        ps.setString(4, shift);
        ps.setTimestamp(5, now);
        ps.executeUpdate();
    }
}


    public void updateCheckOut(int userId, int poolId, String shift, LocalDate date, Timestamp now) throws SQLException {
        String sql = """
            UPDATE Attendance SET check_out = ? 
            WHERE user_id = ? AND pool_id = ? AND shift_name = ? AND CAST(check_in AS DATE) = ?
        """;
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setTimestamp(1, now);
            ps.setInt(2, userId);
            ps.setInt(3, poolId);
            ps.setString(4, shift);
            ps.setDate(5, java.sql.Date.valueOf(date));
            ps.executeUpdate();
        }
    }

    public static void main(String[] args) throws SQLException {
        StaffScheduleDAO dao = new StaffScheduleDAO();
        List<StaffAssignment> assignments = dao.getStaffAssignments(
                3,
                LocalDate.parse("2025-06-01"),
                LocalDate.parse("2025-06-07")
        );

        for (StaffAssignment a : assignments) {
            System.out.println("Assignment ID: " + a.getAssignmentId());
            System.out.println("Pool: " + a.getPoolName());
            System.out.println("Shift: " + a.getShiftName());
            System.out.println("Date: " + a.getAssignedDate());
            System.out.println("-----------------------------");
        }

        String shiftName = "Sáng";
        Timestamp checkIn = Timestamp.valueOf(LocalDateTime.of(2025, 6, 1, 6, 0));
        Timestamp checkOut = Timestamp.valueOf(LocalDateTime.of(2025, 6, 1, 10, 0));

        Attendance a = new Attendance(3, 1, shiftName, checkIn, checkOut);
        System.out.println("Tạo Attendance thủ công:");
        System.out.println(a);

        // Test getStaffScheduleWithAttendance

        
        List<StaffScheduleRow> schedule = dao.getStaffScheduleWithAttendance(
                3,
                LocalDate.parse("2025-06-01"),
                LocalDate.parse("2025-06-07")
        );

        for (StaffScheduleRow row : schedule) {
            System.out.println(row); // Nhờ đã có toString()
        }

    }
}
