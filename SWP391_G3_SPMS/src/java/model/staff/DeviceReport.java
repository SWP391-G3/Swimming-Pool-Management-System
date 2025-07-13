/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.staff;


import java.util.Date;

public class DeviceReport {
    private int reportId;
    private int staffId;
    private int poolId;
    private int branchId;
    private int deviceId;
    private String deviceName;
    private String reportReason;
    private String suggestion;
    private Date reportDate;
    private String status;

    // Constructors
    public DeviceReport() {}

    public DeviceReport(int reportId, int staffId, int poolId, int branchId, int deviceId, String deviceName,
                        String reportReason, String suggestion, Date reportDate, String status) {
        this.reportId = reportId;
        this.staffId = staffId;
        this.poolId = poolId;
        this.branchId = branchId;
        this.deviceId = deviceId;
        this.deviceName = deviceName;
        this.reportReason = reportReason;
        this.suggestion = suggestion;
        this.reportDate = reportDate;
        this.status = status;
    }

    // Getter & Setter
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

    public int getDeviceId() {
        return deviceId;
    }
    public void setDeviceId(int deviceId) {
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

    public Date getReportDate() {
        return reportDate;
    }
    public void setReportDate(Date reportDate) {
        this.reportDate = reportDate;
    }

    public String getStatus() {
        return status;
    }
    public void setStatus(String status) {
        this.status = status;
    }
}