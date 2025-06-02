package dao.manager;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;
import model.manager.Device;
import java.sql.SQLException;
import model.manager.Pool;

public class DeviceDao extends DBContext {

    // Lấy tất cả thiết bị theo branch_id (chi nhánh)
    public List<Device> getDevicesByBranchId(int branchId) {
        List<Device> deviceList = new ArrayList<>();
        String sql = "SELECT d.device_id, d.device_image, d.device_name, d.pool_id, p.pool_name, d.quantity, d.device_status, d.notes "
                + "FROM Pool_Device d "
                + "JOIN Pools p ON d.pool_id = p.pool_id "
                + "WHERE p.branch_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, branchId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Device device = new Device(
                        rs.getInt(1), // device_id
                        rs.getString(2), // device_image
                        rs.getString(3), // device_name
                        rs.getInt(4), // pool_id
                        rs.getString(5), // pool_name
                        rs.getInt(6), // quantity
                        rs.getString(7), // device_status
                        rs.getString(8) // notes
                );
                deviceList.add(device);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return deviceList;
    }

    // Lấy tất cả thiết bị theo managerId
    public List<Device> getDevicesByManagerId(int managerId) {
        List<Device> deviceList = new ArrayList<>();
        String sql = "SELECT d.device_id, d.device_image, d.device_name, d.pool_id, p.pool_name, d.quantity, d.device_status, d.notes "
                + "FROM Pool_Device d "
                + "JOIN Pools p ON d.pool_id = p.pool_id "
                + "JOIN Branchs b ON p.branch_id = b.branch_id "
                + "WHERE b.manager_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, managerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Device device = new Device(
                        rs.getInt(1), // device_id
                        rs.getString(2), // device_image
                        rs.getString(3), // device_name
                        rs.getInt(4), // pool_id
                        rs.getString(5), // pool_name
                        rs.getInt(6), // quantity
                        rs.getString(7), // device_status
                        rs.getString(8) // notes
                );
                deviceList.add(device);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return deviceList;
    }

    // Lấy danh sách hồ bơi của 1 chi nhánh
    public List<Pool> getPoolsByBranchId(int branchId) {
        List<Pool> pools = new ArrayList<>();
        String sql = "SELECT pool_id, pool_name FROM Pools WHERE branch_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, branchId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Pool pool = new Pool(rs.getInt(1), rs.getString(2));
                pools.add(pool);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pools;
    }

    // Lấy danh sách thiết bị theo pool_id (nếu muốn lấy poolName thì JOIN Pools)
    public List<Device> getDevicesByPoolId(int poolId) {
        List<Device> devices = new ArrayList<>();
        String sql = "SELECT d.device_id, d.device_image, d.device_name, d.pool_id, p.pool_name, d.quantity, d.device_status, d.notes "
                + "FROM Pool_Device d "
                + "JOIN Pools p ON d.pool_id = p.pool_id "
                + "WHERE d.pool_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, poolId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                devices.add(new Device(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getInt(4),
                        rs.getString(5),
                        rs.getInt(6),
                        rs.getString(7),
                        rs.getString(8)
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return devices;
    }

    // Thêm, sửa, xóa thiết bị: KHÔNG ĐỔI
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

    // Lấy thiết bị theo ID (bao gồm poolName)
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
                        rs.getInt(1), // device_id
                        rs.getString(2), // device_image
                        rs.getString(3), // device_name
                        rs.getInt(4), // pool_id
                        rs.getString(5), // pool_name
                        rs.getInt(6), // quantity
                        rs.getString(7), // device_status
                        rs.getString(8) // notes
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
    //Phân trang 
    // Đếm thiết bị theo branch và pool
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
        if (poolId != null) ps.setInt(idx++, poolId);
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

// Lấy thiết bị phân trang theo branch và pool
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
        if (poolId != null) ps.setInt(idx++, poolId);
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

    public static void main(String[] args) {
        DeviceDao dao = new DeviceDao();
        List<Device> a = dao.getDevicesByBranchId(1);
        for (Device device : a) {
            System.out.println(device);
        }
    }
}
