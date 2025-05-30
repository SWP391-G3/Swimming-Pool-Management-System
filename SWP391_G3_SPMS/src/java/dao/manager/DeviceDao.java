/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.manager;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;
import java.sql.ResultSet;
import model.manager.Device;
import java.sql.SQLException;
import java.util.AbstractList;
import model.manager.Pool;

/**
 *
 * @author Tuan Anh
 */
public class DeviceDao extends DBContext {

    public List<Device> getAllDevices(String keyword, String status) {
        List<Device> deviceList = new ArrayList<>();
        String sql = "SELECT d.device_id ,d.device_image ,d.device_name,p.pool_name ,d.quantity , d.device_status , d.notes "
                + "FROM Pool_Device d JOIN Pools p ON d.pool_id = p.pool_id "
                + "WHERE d.device_name LIKE ? AND (d.device_status = ? OR ? = '')";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + (keyword == null ? "" : keyword) + "%");
            ps.setString(2, status == null ? "" : status);
            ps.setString(3, status == null ? "" : status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                deviceList.add(new Device(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
                        rs.getInt(5), rs.getString(6), rs.getString(7)));
            }
        } catch (SQLException e) {
            e.printStackTrace(); // cần thêm tính năng validate các thứ

        }
        return deviceList;
    }

    // Lấy danh sách hồ bơi (Pool)
    public List<Pool> getAllPools() {
        List<Pool> pools = new ArrayList<>();
        String sql = "SELECT pool_id, pool_name FROM Pools";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                pools.add(new Pool(rs.getInt(1), rs.getString(2)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return pools;
    }

    // Thêm thiết bị mới
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

    // Lấy thiết bị theo ID
    public Device getDeviceById(int id) {
        String sql = "SELECT d.device_id, d.device_image, d.device_name, p.pool_name, d.quantity, d.device_status, d.notes, d.pool_id "
                + "FROM Pool_Device d JOIN Pools p ON d.pool_id = p.pool_id WHERE d.device_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Device d = new Device(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4),
                        rs.getInt(5), rs.getString(6), rs.getString(7));
                d.setPoolId(rs.getInt(8));
                return d;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật thiết bị
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

    // Xóa thiết bị theo ID
    public void deleteDevice(int deviceId) {
        String sql = "DELETE FROM Pool_Device WHERE device_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, deviceId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Phân trang 
    public int countDevices(String keyword, String status) {
        String sql = "SELECT COUNT(*) FROM Pool_Device WHERE device_name LIKE ? AND (device_status = ? OR ? = '')";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + (keyword == null ? "" : keyword.trim()) + "%");
            ps.setString(2, status == null ? "" : status.trim());
            ps.setString(3, status == null ? "" : status.trim());
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Device> getDevicesByPage(String keyword, String status, int page) {
        List<Device> deviceList = new ArrayList<>();
        String sql = "SELECT d.device_id, d.device_image, d.device_name, p.pool_name, d.quantity, d.device_status, d.notes "
                + "FROM Pool_Device d JOIN Pools p ON d.pool_id = p.pool_id "
                + "WHERE d.device_name LIKE ? AND (d.device_status = ? OR ? = '') "
                + "ORDER BY d.device_id OFFSET ? ROWS FETCH NEXT 6 ROWS ONLY";

        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + (keyword == null ? "" : keyword.trim()) + "%");
            ps.setString(2, status == null ? "" : status.trim());
            ps.setString(3, status == null ? "" : status.trim());
            ps.setInt(4, (page - 1) * 7);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Device device = new Device(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getInt(5),
                        rs.getString(6),
                        rs.getString(7)
                );
                deviceList.add(device);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return deviceList;
    }

    public static void main(String[] args) {

        DeviceDao dao = new DeviceDao();

        List<Device> a = dao.getDevicesByPage("", "", 1);

        for (Device device : a) {
            System.out.println(device);
        }

    }

}
