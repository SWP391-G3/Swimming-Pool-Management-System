/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.manager;

/**
 *
 * @author Tuan Anh
 */

public class Device {

    private int deviceId;
    private String deviceImage;
    private String deviceName;
    private int poolId;
    private String poolName; 
    private int quantity;
    private String deviceStatus;
    private String notes;

    public Device() {
    }

    // Constructor với poolName
    public Device(int deviceId, String deviceImage, String deviceName, int poolId, String poolName, int quantity, String deviceStatus, String notes) {
        this.deviceId = deviceId;
        this.deviceImage = deviceImage;
        this.deviceName = deviceName;
        this.poolId = poolId;
        this.poolName = poolName;
        this.quantity = quantity;
        this.deviceStatus = deviceStatus;
        this.notes = notes;
    }

    // Các getter/setter
    public int getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(int deviceId) {
        this.deviceId = deviceId;
    }

    public String getDeviceImage() {
        return deviceImage;
    }

    public void setDeviceImage(String deviceImage) {
        this.deviceImage = deviceImage;
    }

    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    public int getPoolId() {
        return poolId;
    }

    public void setPoolId(int poolId) {
        this.poolId = poolId;
    }

    public String getPoolName() {
        return poolName;
    }

    public void setPoolName(String poolName) {
        this.poolName = poolName;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDeviceStatus() {
        return deviceStatus;
    }

    public void setDeviceStatus(String deviceStatus) {
        this.deviceStatus = deviceStatus;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }
}
