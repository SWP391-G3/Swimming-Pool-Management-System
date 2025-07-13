package dao.manager;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;
import model.manager.Device;
import java.sql.SQLException;
import model.manager.Pooldevice;
import model.staff.DeviceReport;
import model.manager.ManagerDeviceReport;

public class DeviceDao extends DBContext {

    // Lấy danh sách hồ bơi của 1 chi nhánh
    public List<Pooldevice> getPoolsByBranchId(int branchId) {
        List<Pooldevice> pools = new ArrayList<>();
        String sql = "SELECT pool_id, pool_name FROM Pools WHERE branch_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, branchId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Pooldevice pool = new Pooldevice(rs.getInt(1), rs.getString(2));
                pools.add(pool);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pools;
    }

    public void addDevice(Device device) {
        String sql = "INSERT INTO Pool_Device (pool_id, device_image, device_name, quantity, device_status, notes) VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, device.getPoolId());
            ps.setString(2, device.getDeviceImage());
            ps.setString(3, device.getDeviceName());
            ps.setInt(4, device.getQuantity());
            ps.setString(5, device.getDeviceStatus());
            ps.setString(6, device.getNotes());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateDevice(Device device) {
        String sql = "UPDATE Pool_Device SET pool_id = ?, device_image = ?, device_name = ?, quantity = ?, device_status = ?, notes = ? WHERE device_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, device.getPoolId());
            ps.setString(2, device.getDeviceImage());
            ps.setString(3, device.getDeviceName());
            ps.setInt(4, device.getQuantity());
            ps.setString(5, device.getDeviceStatus());
            ps.setString(6, device.getNotes());
            ps.setInt(7, device.getDeviceId());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteDevice(int deviceId) {
        String sql = "DELETE FROM Pool_Device WHERE device_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, deviceId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Lấy thiết bị theo ID 
    public Device getDeviceById(int id) {
        String sql = "SELECT d.device_id, d.device_image, d.device_name, d.pool_id, p.pool_name, d.quantity, d.device_status, d.notes "
                + "FROM Pool_Device d "
                + "JOIN Pools p ON d.pool_id = p.pool_id "
                + "WHERE d.device_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Device(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getString(8)
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    //Phân trang 
    // Đếm thiết bị theo chi nhánh và hồ bơi
    public int countDevicesWithPool(String keyword, String status, int branchId, Integer poolId) {
        int count = 0;
        String sql = "SELECT COUNT(*) "
                + "FROM Pool_Device d "
                + "JOIN Pools p ON d.pool_id = p.pool_id "
                + "WHERE p.branch_id = ? "
                + (poolId != null ? "AND d.pool_id = ? " : "")
                + "AND (? IS NULL OR d.device_name LIKE ?) "
                + "AND (? IS NULL OR d.device_status = ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int idx = 1;
            ps.setInt(idx++, branchId);
            if (poolId != null) {
                ps.setInt(idx++, poolId);
            }
            ps.setString(idx++, (keyword == null || keyword.isEmpty()) ? null : keyword);
            ps.setString(idx++, (keyword == null || keyword.isEmpty()) ? null : "%" + keyword + "%");
            ps.setString(idx++, (status == null || status.isEmpty()) ? null : status);
            ps.setString(idx++, (status == null || status.isEmpty()) ? null : status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

// Lấy danh sách thiết bị theo trang có thể lọc theo hồ bơi , từ khóa , trạng thái
    public List<Device> getDevicesByPageAndPool(String keyword, String status, int page, int pageSize, int branchId, Integer poolId) {
        List<Device> devices = new ArrayList<>();
        String sql = "SELECT d.device_id, d.device_image, d.device_name, d.pool_id, p.pool_name, d.quantity, d.device_status, d.notes "
                + "FROM Pool_Device d "
                + "JOIN Pools p ON d.pool_id = p.pool_id "
                + "WHERE p.branch_id = ? "
                + (poolId != null ? "AND d.pool_id = ? " : "")
                + "AND (? IS NULL OR d.device_name LIKE ?) "
                + "AND (? IS NULL OR d.device_status = ?) "
                + "ORDER BY d.device_id "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int idx = 1;
            ps.setInt(idx++, branchId);
            if (poolId != null) {
                ps.setInt(idx++, poolId);
            }
            ps.setString(idx++, (keyword == null || keyword.isEmpty()) ? null : keyword);
            ps.setString(idx++, (keyword == null || keyword.isEmpty()) ? null : "%" + keyword + "%");
            ps.setString(idx++, (status == null || status.isEmpty()) ? null : status);
            ps.setString(idx++, (status == null || status.isEmpty()) ? null : status);
            ps.setInt(idx++, (page - 1) * pageSize);
            ps.setInt(idx++, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Device device = new Device(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getString(8)
                );
                devices.add(device);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return devices;
    }

    // Phương thức kiểm tra trùng tên khi thêm thiết bị 
    public boolean isDeviceNameExistsInPool(int poolId, String deviceName) {
        String sql = "SELECT COUNT(*) FROM Pool_Device WHERE pool_id = ? AND LOWER(device_name) = LOWER(?)";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, poolId);
            ps.setString(2, deviceName);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static void main(String[] args) {
        DeviceDao dao = new DeviceDao();
////        List<Device> a = dao.getDevicesByPageAndPool("", "", 1, 5, 2, 6);
////        for (Device device : a) {
////            System.out.println(device);
////        }
//
//        Device a1 = dao.getDeviceById(1);
//        System.out.println(a1);

// Test lấy danh sách báo cáo thiết bị
        String keyword = ""; // hoặc từ khóa muốn test
        String status = "";  // hoặc "pending"/"done"
        String poolId = "";  // hoặc poolId cụ thể (vd: "1")
        int page = 1;
        int pageSize = 10;
        int branchId = 1;    // Hà Nội, đổi theo user test

        List<ManagerDeviceReport> reports = dao.getDeviceReports(keyword, status, poolId, page, pageSize, branchId);

        System.out.println("===== TEST getDeviceReports =====");
        System.out.println("Total reports: " + reports.size());
        for (ManagerDeviceReport report : reports) {
            System.out.println(report); // nếu đã override toString() sẽ ra thông tin chi tiết
            // hoặc in từng trường nếu chưa override toString()
            // System.out.println("Report ID: " + report.getReportId() + ", Device: " + report.getDeviceName());
        }

    }

    // của Hùng
    public List<DeviceReport> filterDeviceReportsByStaff(int staffId, String status, int offset, int limit) throws SQLException {
        List<DeviceReport> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT dr.*, p.pool_name, b.branch_name "
                + "FROM Device_Reports dr "
                + "JOIN Pools p ON dr.pool_id = p.pool_id "
                + "LEFT JOIN Branchs b ON dr.branch_id = b.branch_id "
                + "WHERE dr.staff_id = ? "
        );
        List<Object> params = new ArrayList<>();
        params.add(staffId);

        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND dr.status = ? ");
            params.add(status.trim());
        }
        sql.append("ORDER BY dr.report_date DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");
        params.add(offset);
        params.add(limit);

        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            int idx = 1;
            for (Object param : params) {
                if (param instanceof String) {
                    st.setString(idx++, (String) param);
                } else if (param instanceof Integer) {
                    st.setInt(idx++, (Integer) param);
                }
            }
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                DeviceReport r = new DeviceReport();
                r.setReportId(rs.getInt("report_id"));
                r.setStaffId(rs.getInt("staff_id"));
                r.setPoolId(rs.getInt("pool_id"));
                r.setBranchId(rs.getInt("branch_id"));
                r.setDeviceId(rs.getInt("device_id"));
                r.setDeviceName(rs.getString("device_name"));
                r.setReportReason(rs.getString("report_reason"));
                r.setSuggestion(rs.getString("suggestion"));
                r.setStatus(rs.getString("status"));
                r.setReportDate(rs.getTimestamp("report_date"));
                list.add(r);
            }
        }
        return list;
    }

    // của Hùng
    public int countDeviceReportsByStaff(int staffId, String status) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Device_Reports WHERE staff_id = ? ");
        List<Object> params = new ArrayList<>();
        params.add(staffId);
        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND status = ? ");
            params.add(status.trim());
        }
        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            int idx = 1;
            for (Object param : params) {
                if (param instanceof String) {
                    st.setString(idx++, (String) param);
                } else if (param instanceof Integer) {
                    st.setInt(idx++, (Integer) param);
                }
            }
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }
    // của Hùng

    public int countDevicesWithPoolName(String keyword, String status, int branchId, String PoolName) {
        int count = 0;
        String sql = "SELECT COUNT(*) "
                + "FROM Pool_Device d "
                + "JOIN Pools p ON d.pool_id = p.pool_id "
                + "WHERE p.branch_id = ? "
                + (PoolName != null ? "AND p.pool_name = ? " : "")
                + "AND (? IS NULL OR d.device_name LIKE ?) "
                + "AND (? IS NULL OR d.device_status = ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int idx = 1;
            ps.setInt(idx++, branchId);
            if (PoolName != null) {
                ps.setString(idx++, PoolName);
            }
            ps.setString(idx++, (keyword == null || keyword.isEmpty()) ? null : keyword);
            ps.setString(idx++, (keyword == null || keyword.isEmpty()) ? null : "%" + keyword + "%");
            ps.setString(idx++, (status == null || status.isEmpty()) ? null : status);
            ps.setString(idx++, (status == null || status.isEmpty()) ? null : status);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }

    // của Hùng
    public List<Device> getDevicesByPageAndPoolName(String keyword, String status, int page, int pageSize, int branchId, String PoolName) {
        List<Device> devices = new ArrayList<>();
        String sql = "SELECT d.device_id, d.device_image, d.device_name, d.pool_id, p.pool_name, d.quantity, d.device_status, d.notes "
                + "FROM Pool_Device d "
                + "JOIN Pools p ON d.pool_id = p.pool_id "
                + "WHERE p.branch_id = ? "
                + (PoolName != null ? "AND p.pool_name = ? " : "")
                + "AND (? IS NULL OR d.device_name LIKE ?) "
                + "AND (? IS NULL OR d.device_status = ?) "
                + "ORDER BY d.device_id "
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            int idx = 1;
            ps.setInt(idx++, branchId);
            if (PoolName != null) {
                ps.setString(idx++, PoolName);
            }
            ps.setString(idx++, (keyword == null || keyword.isEmpty()) ? null : keyword);
            ps.setString(idx++, (keyword == null || keyword.isEmpty()) ? null : "%" + keyword + "%");
            ps.setString(idx++, (status == null || status.isEmpty()) ? null : status);
            ps.setString(idx++, (status == null || status.isEmpty()) ? null : status);
            ps.setInt(idx++, (page - 1) * pageSize);
            ps.setInt(idx++, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Device device = new Device(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getString(8)
                );
                devices.add(device);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return devices;
    }

    // Thêm của Tuấn Anh báo cáo thiết bị
    // Lấy danh sách báo cáo thiết bị với phân trang và tìm kiếm cho manager
    public List<ManagerDeviceReport> getDeviceReports(String keyword, String status, String poolId,
            int page, int pageSize, int branchId) {
        List<ManagerDeviceReport> reports = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT dr.report_id, dr.staff_id, dr.pool_id, dr.branch_id, ")
                .append("dr.device_id, dr.device_name, dr.report_reason, dr.suggestion, ")
                .append("dr.report_date, dr.status, ")
                .append("u.full_name as staff_name, p.pool_name, b.branch_name ")
                .append("FROM Device_Reports dr ")
                .append("LEFT JOIN Staffs s ON dr.staff_id = s.staff_id ")
                .append("LEFT JOIN Users u ON s.user_id = u.user_id ")
                .append("LEFT JOIN Pools p ON dr.pool_id = p.pool_id ")
                .append("LEFT JOIN Branchs b ON dr.branch_id = b.branch_id ")
                .append("WHERE dr.branch_id = ? ");

        List<Object> params = new ArrayList<>();
        params.add(branchId);

        // Thêm điều kiện tìm kiếm
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (dr.device_name LIKE ? OR dr.report_reason LIKE ? OR s.full_name LIKE ?) ");
            String searchKeyword = "%" + keyword.trim() + "%";
            params.add(searchKeyword);
            params.add(searchKeyword);
            params.add(searchKeyword);
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND dr.status = ? ");
            params.add(status);
        }

        if (poolId != null && !poolId.trim().isEmpty()) {
            sql.append("AND dr.pool_id = ? ");
            params.add(Integer.parseInt(poolId));
        }

        sql.append("ORDER BY dr.report_date DESC ")
                .append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            System.out.println("SQL Query: " + sql.toString()); // Debug
            System.out.println("Parameters: " + params); // Debug
            System.out.println("Branch ID being used: " + branchId); // Debug

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ManagerDeviceReport report = new ManagerDeviceReport(); // Đổi từ DeviceReport
                report.setReportId(rs.getInt("report_id"));
                report.setStaffId(rs.getInt("staff_id"));
                report.setPoolId(rs.getInt("pool_id"));
                report.setBranchId(rs.getInt("branch_id"));

                // Xử lý device_id có thể null
                Object deviceIdObj = rs.getObject("device_id");
                if (deviceIdObj != null) {
                    report.setDeviceId((Integer) deviceIdObj);
                }

                report.setDeviceName(rs.getString("device_name"));
                report.setReportReason(rs.getString("report_reason"));
                report.setSuggestion(rs.getString("suggestion"));
                report.setReportDate(rs.getTimestamp("report_date"));
                report.setStatus(rs.getString("status"));

                // Set thông tin join
                report.setStaffName(rs.getString("staff_name"));
                report.setPoolName(rs.getString("pool_name"));
                report.setBranchName(rs.getString("branch_name"));

                reports.add(report);

                System.out.println("Found report: " + report.getReportId() + " - " + report.getDeviceName() + " - Staff: " + report.getStaffName()); // Debug
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        System.out.println("Total reports found in method: " + reports.size()); // Debug
        return reports;
    }

// Đếm tổng số báo cáo cho manager
    public int getTotalReports(String keyword, String status, String poolId, int branchId) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) FROM Device_Reports dr ")
                .append("LEFT JOIN Staffs s ON dr.staff_id = s.staff_id ")
                .append("WHERE dr.branch_id = ? ");

        List<Object> params = new ArrayList<>();
        params.add(branchId);

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (dr.device_name LIKE ? OR dr.report_reason LIKE ? OR s.full_name LIKE ?) ");
            String searchKeyword = "%" + keyword.trim() + "%";
            params.add(searchKeyword);
            params.add(searchKeyword);
            params.add(searchKeyword);
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND dr.status = ? ");
            params.add(status);
        }

        if (poolId != null && !poolId.trim().isEmpty()) {
            sql.append("AND dr.pool_id = ? ");
            params.add(Integer.parseInt(poolId));
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return 0;
    }

// Cập nhật device_id cho báo cáo
    public boolean updateDeviceId(int reportId, int deviceId) {
        String sql = "UPDATE Device_Reports SET device_id = ? WHERE report_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, deviceId);
            ps.setInt(2, reportId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

// Cập nhật trạng thái báo cáo thành 'done'
    public boolean approveReport(int reportId) {
        String sql = "UPDATE Device_Reports SET status = 'done' WHERE report_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reportId);

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

// Lấy thông tin báo cáo theo ID
    public ManagerDeviceReport getReportById(int reportId) {
        String sql = "SELECT dr.*, s.full_name as staff_name, p.pool_name, b.branch_name "
                + "FROM Device_Reports dr "
                + "LEFT JOIN Staffs s ON dr.staff_id = s.staff_id "
                + "LEFT JOIN Pools p ON dr.pool_id = p.pool_id "
                + "LEFT JOIN Branchs b ON dr.branch_id = b.branch_id "
                + "WHERE dr.report_id = ?";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, reportId);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ManagerDeviceReport report = new ManagerDeviceReport(); // Đổi từ DeviceReport
                report.setReportId(rs.getInt("report_id"));
                report.setStaffId(rs.getInt("staff_id"));
                report.setPoolId(rs.getInt("pool_id"));
                report.setBranchId(rs.getInt("branch_id"));
                report.setDeviceId(rs.getObject("device_id", Integer.class));
                report.setDeviceName(rs.getString("device_name"));
                report.setReportReason(rs.getString("report_reason"));
                report.setSuggestion(rs.getString("suggestion"));
                report.setReportDate(rs.getTimestamp("report_date"));
                report.setStatus(rs.getString("status"));

                // Set thông tin join
                report.setStaffName(rs.getString("staff_name"));
                report.setPoolName(rs.getString("pool_name"));
                report.setBranchName(rs.getString("branch_name"));

                return report;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

}
