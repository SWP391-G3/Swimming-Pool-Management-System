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
import okhttp3.Connection;

/**
 *
 * @author Tuan Anh
 */
public class DeviceDao extends DBContext {

    public List<Device> getAllDevices(String keyword, String status) {

        List<Device> devices = new ArrayList<>();
        String sql = "SELECT * FROM Pool_Device WHERE device_name LIKE ? AND (device_status = ? OR ? = '')";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + (keyword == null ? "" : keyword) + "%");
            ps.setString(2, status == null ? "" : status);
            ps.setString(3, status == null ? "" : status);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                devices.add(new Device(
                        rs.getInt("device_id"),
                        rs.getInt("pool_id"),
                        rs.getString("device_image"),
                        rs.getString("device_name"),
                        rs.getInt("quantity"),
                        rs.getString("device_status"),
                        rs.getString("notes")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return devices;
    }

// Lấy thiết bị theo ID
    public Device getDeviceById(int id) {
        String sql = "SELECT * FROM Pool_Device WHERE device_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
                ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Device(
                            rs.getInt("device_id"),
                            rs.getInt("pool_id"),
                            rs.getString("device_image"),
                            rs.getString("device_name"),
                            rs.getInt("quantity"),
                            rs.getString("device_status"),
                            rs.getString("notes")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
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

// Cập nhật thiết bị
    public void updateDevice(Device device) {
        String sql = "UPDATE Pool_Device SET device_image = ?, device_name = ?, quantity = ?, device_status = ?, notes = ? WHERE device_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, device.getDeviceImage());
            ps.setString(2, device.getDeviceName());
            ps.setInt(3, device.getQuantity());
            ps.setString(4, device.getDeviceStatus());
            ps.setString(5, device.getNotes());
            ps.setInt(6, device.getDeviceId());
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
    
    
    public static void main(String[] args) {
       
     
        DeviceDao dao = new DeviceDao();
        List<Device> a1 = dao.getAllDevices("", "");
        Device b = dao.getDeviceById(2);
        
        System.out.println(b);
        
//        for (Device device : a1) {
//            System.out.println(device);
//            
//        }
        
        
        
        
    }

}
