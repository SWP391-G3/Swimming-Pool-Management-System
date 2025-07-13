/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.manager;

import java.sql.Timestamp; 

/**
 *
 * @author Tuan Anh
 */
public class ManagerDeviceReport {
    
    private int reportId, staffId, poolId, branchId;
    private Integer deviceId; // Có thể null
    private String deviceName, reportReason, suggestion, status;
    private java.sql.Timestamp reportDate;

    // --- Thêm các trường hiển thị ---
    private String poolName;      // Tên hồ bơi
    private String staffName;     // Tên nhân viên tạo báo cáo
    private String branchName;    // Tên chi nhánh

    // Constructor
    public ManagerDeviceReport() {}

    // Getter/Setter cho các trường mới
    public String getPoolName() {
        return poolName;
    }

    public void setPoolName(String poolName) {
        this.poolName = poolName;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    // Getter/Setter cho các trường cơ bản
    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
    }

    public int getPoolId() {
        return poolId;
    }

    public void setPoolId(int poolId) {
        this.poolId = poolId;
    }

    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }

    public Integer getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(Integer deviceId) {
        this.deviceId = deviceId;
    }

    public String getDeviceName() {
        return deviceName;
    }

    public void setDeviceName(String deviceName) {
        this.deviceName = deviceName;
    }

    public String getReportReason() {
        return reportReason;
    }

    public void setReportReason(String reportReason) {
        this.reportReason = reportReason;
    }

    public String getSuggestion() {
        return suggestion;
    }

    public void setSuggestion(String suggestion) {
        this.suggestion = suggestion;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public java.sql.Timestamp getReportDate() {
        return reportDate;
    }

    public void setReportDate(java.sql.Timestamp reportDate) { // Thay vì Timestamp
        this.reportDate = reportDate;
    }

    @Override
    public String toString() {
        return "DeviceReport{" +
                "reportId=" + reportId +
                ", staffId=" + staffId +
                ", poolId=" + poolId +
                ", branchId=" + branchId +
                ", deviceId=" + deviceId +
                ", deviceName='" + deviceName + '\'' +
                ", reportReason='" + reportReason + '\'' +
                ", suggestion='" + suggestion + '\'' +
                ", status='" + status + '\'' +
                ", reportDate=" + reportDate +
                ", poolName='" + poolName + '\'' +
                ", staffName='" + staffName + '\'' +
                ", branchName='" + branchName + '\'' +
                '}';
    }
    
    
    
    
    
    
}
