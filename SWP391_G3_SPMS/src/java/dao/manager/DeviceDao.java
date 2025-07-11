package dao.manager;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;
import model.manager.Device;
import java.sql.SQLException;
import model.manager.Pooldevice;

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
        List<Device> a = dao.getDevicesByPageAndPool("", "", 1, 5, 2, 6);
        for (Device device : a) {
            System.out.println(device);
        }
    }
}
