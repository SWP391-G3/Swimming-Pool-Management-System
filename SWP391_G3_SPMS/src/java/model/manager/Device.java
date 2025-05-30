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
    private String poolName;
    private int poolId;
    private int quantity;
    private String deviceStatus;
    private String notes;

    
    public Device(int deviceId, String deviceImage, String deviceName, String poolName, int quantity, String deviceStatus, String notes) {
        this.deviceId = deviceId;
        this.deviceImage = deviceImage;
        this.deviceName = deviceName;
        this.poolName = poolName;
        this.quantity = quantity;
        this.deviceStatus = deviceStatus;
        this.notes = notes;
    }

   
    public Device() {
    }

    // Getter/Setter đầy đủ
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

    public String getPoolName() {
        return poolName;
    }

    public void setPoolName(String poolName) {
        this.poolName = poolName;
    }

    public int getPoolId() {
        return poolId;
    }

    public void setPoolId(int poolId) {
        this.poolId = poolId;
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

    @Override
    public String toString() {
        return "Device{" + "deviceId=" + deviceId + ", deviceImage=" + deviceImage + ", deviceName=" + deviceName + ", poolName=" + poolName + ", poolId=" + poolId + ", quantity=" + quantity + ", deviceStatus=" + deviceStatus + ", notes=" + notes + '}';
    }
    
    
    
    
    
}