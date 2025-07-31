/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.staff;

import dal.DBContext;
import java.util.ArrayList;
import java.util.List;
import model.manager.Staff;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import model.manager.PoolTicket;
import model.staff.StaffJoinedTable;

/**
 *
 * @author Tuan Anh
 */
public class StaffDAO extends DBContext {

    public int countStaff(int managerId, String keyword, String status, String poolId) throws SQLException {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(DISTINCT s.user_id) FROM Staffs s "
                + "JOIN Users u ON s.user_id = u.user_id "
                + "JOIN Branchs b ON s.branch_id = b.branch_id "
        );
        List<Object> params = new ArrayList<>();
        sql.append("WHERE b.manager_id = ? ");
        params.add(managerId);

        if (keyword != null && !keyword.isEmpty()) {
            sql.append("AND (u.full_name LIKE ? OR u.email LIKE ? OR u.phone LIKE ?) ");
            String k = "%" + keyword + "%";
            params.add(k);
            params.add(k);
            params.add(k);
        }
        if (status != null && (status.equals("0") || status.equals("1"))) {
            sql.append("AND u.status = ? ");
            params.add(Integer.parseInt(status));
        }
        // Chỉ join Pools khi có lọc poolId
        if (poolId != null && !poolId.equals("all")) {
            sql.append("AND s.pool_id = ? ");
            params.add(Integer.parseInt(poolId));
        }

        PreparedStatement ps = connection.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
        ResultSet rs = ps.executeQuery();
        rs.next();
        return rs.getInt(1);
    }

    public Staff getStaffById(int userId) {
        String sql = """
            SELECT s.*, u.full_name, u.email, u.phone, u.images, u.status, b.branch_name,
                   p.pool_name, st.type_name
            FROM Staffs s
            JOIN Staff_Types st ON st.staff_type_id = s.staff_type_id
            JOIN Users u ON s.user_id = u.user_id
            JOIN Branchs b ON s.branch_id = b.branch_id
            LEFT JOIN Pools p ON s.pool_id = p.pool_id
            WHERE s.user_id = ?
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Staff staff = new Staff();
                staff.setUserId(rs.getInt("user_id"));
                staff.setFullName(rs.getString("full_name"));
                staff.setEmail(rs.getString("email"));
                staff.setPhone(rs.getString("phone"));
                staff.setImages(rs.getString("images"));
                staff.setStatus(rs.getInt("status"));
                staff.setBranchName(rs.getString("branch_name"));
                staff.setPoolName(rs.getString("pool_name")); // lấy tên hồ bơi
                staff.setTypeName(rs.getString("type_name"));
                staff.setBranchId(rs.getInt("branch_id"));
                return staff;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Staff> getStaffs(
            int managerId, String keyword, String status, String poolId, int offset, int limit
    ) throws SQLException {
        StringBuilder sql = new StringBuilder(
                "SELECT u.user_id, u.full_name, u.email, u.phone, u.images, u.status, b.branch_name, b.branch_id, \n"
                + "       p.pool_id, p.pool_name, st.type_name \n"
                + "FROM Staffs s \n"
                + "JOIN Staff_Types st ON s.staff_type_id = st.staff_type_id\n"
                + "JOIN Users u ON s.user_id = u.user_id \n"
                + "JOIN Branchs b ON s.branch_id = b.branch_id \n"
                + "LEFT JOIN Pools p ON s.pool_id = p.pool_id \n"
                + "WHERE b.manager_id = ?"
        );
        List<Object> params = new ArrayList<>();
        params.add(managerId);

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (u.full_name LIKE ? OR u.email LIKE ? OR u.phone LIKE ?)");
            String k = "%" + keyword + "%";
            params.add(k);
            params.add(k);
            params.add(k);
        }
        if (status != null && (status.equals("0") || status.equals("1"))) {
            sql.append(" AND u.status = ?");
            params.add(Integer.parseInt(status));
        }
        if (poolId != null && !poolId.equals("all")) {
            sql.append(" AND p.pool_id = ?");
            params.add(Integer.parseInt(poolId));
        }
        sql.append(" ORDER BY u.user_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        PreparedStatement ps = connection.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
        ResultSet rs = ps.executeQuery();
        List<Staff> list = new ArrayList<>();
        while (rs.next()) {
            Staff s = new Staff();
            s.setUserId(rs.getInt("user_id"));
            s.setFullName(rs.getString("full_name"));
            s.setEmail(rs.getString("email"));
            s.setPhone(rs.getString("phone"));
            s.setImages(rs.getString("images"));
            s.setStatus(rs.getInt("status"));
            s.setBranchName(rs.getString("branch_name"));
            s.setBranchId(rs.getInt("branch_id"));
            s.setPoolName(rs.getString("pool_name")); // <<< Lấy tên bể bơi
            s.setTypeName(rs.getString("type_name"));
            list.add(s);
        }
        return list;
    }

    public List<PoolTicket> getPoolsByManager(int managerId) throws SQLException {
        String sql = "SELECT pool_id, pool_name FROM Pools WHERE branch_id IN "
                + "(SELECT branch_id FROM Branchs WHERE manager_id = ?)";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, managerId);
        ResultSet rs = ps.executeQuery();
        List<PoolTicket> pools = new ArrayList<>();
        while (rs.next()) {
            pools.add(new PoolTicket(rs.getInt("pool_id"), rs.getString("pool_name")));
        }
        return pools;
    }

    public static void main(String[] args) {

        StaffDAO dao = new StaffDAO();

//        // Dữ liệu test
//        int managerId = 2; // Ví dụ: manager_id của bạn (phải có trong DB)
//        String keyword = ""; // hoặc "Nguyễn"
//        String status = "";  // "", "1", "0"
//        String poolId = "all";
//        int offset = 0;
//        int limit = 10;
//
//        try {
//
//            List<Staff> staffList = dao.getStaffs(managerId, keyword, status, poolId, offset, limit);
//            for (Staff s : staffList) {
//                System.out.println("ID: " + s.getUserId());
//                System.out.println("Tên: " + s.getFullName());
//                System.out.println("Email: " + s.getEmail());
//                System.out.println("Điện thoại: " + s.getPhone());
//                System.out.println("Ảnh: " + s.getImages());
//                System.out.println("Trạng thái: " + (s.getStatus() == 1 ? "Đang hoạt động" : "Đã khóa"));
//                System.out.println("Chi nhánh: " + s.getBranchName());
//                System.out.println("BranchId: " + s.getBranchId());
//                System.out.println("--------------------------");
//            }
//
//        } catch (Exception e) {
//
//        }
        Staff a = dao.getStaffById(7);
        System.out.println(a);

    }

    public boolean addDeviceReport(
            int staffId, int poolId, int branchId,
            int deviceId, String deviceName,
            String reportReason, String suggestion
    ) {
        String sql = "INSERT INTO Device_Reports "
                + "(staff_id, pool_id, branch_id, device_id, device_name, report_reason, suggestion, report_date, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE(), ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ps.setInt(2, poolId);
            ps.setInt(3, branchId);
            ps.setInt(4, deviceId);
            ps.setString(5, deviceName);
            ps.setString(6, reportReason);
            ps.setString(7, suggestion);
            ps.setString(8, "pending");   // <-- sửa lại ở đây
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addServiceReport(
            int staffId, int poolId, int branchId,
            int serviceId, String serviceName,
            String reportReason, String suggestion
    ) {
        String sql = "INSERT INTO Service_Reports "
                + "(staff_id, pool_id, branch_id, service_id, service_name, report_reason, suggestion, report_date, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE(), ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, staffId);
            ps.setInt(2, poolId);
            ps.setInt(3, branchId);
            ps.setInt(4, serviceId);
            ps.setString(5, serviceName);
            ps.setString(6, reportReason);
            ps.setString(7, suggestion);
            ps.setString(8, "pending");   // giống device
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
   public StaffJoinedTable getStaffByUserId(int userId) {
        String sql = "SELECT s.staff_id, s.user_id, s.branch_id, b.branch_name, s.pool_id, p.pool_name, " +
                     "s.staff_type_id, st.type_name, st.description " +
                     "FROM Staffs s " +
                     "JOIN Staff_Types st ON s.staff_type_id = st.staff_type_id " +
                     "JOIN Branchs b ON s.branch_id = b.branch_id " +
                     "JOIN Pools p ON s.pool_id = p.pool_id " +
                     "WHERE s.user_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                StaffJoinedTable staff = new StaffJoinedTable();
                staff.setStaffId(rs.getInt("staff_id"));
                staff.setUserId(rs.getInt("user_id"));
                staff.setBranchId(rs.getInt("branch_id"));
                staff.setBranchName(rs.getString("branch_name"));
                staff.setPoolId(rs.getInt("pool_id"));
                staff.setPoolName(rs.getString("pool_name"));
                staff.setStaffTypeId(rs.getInt("staff_type_id"));
                staff.setTypeName(rs.getString("type_name"));
                staff.setTypeDescription(rs.getString("description"));
                return staff;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
