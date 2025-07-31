package model.manager;

import java.sql.Timestamp;

public class ManagerDeviceReport {
    private int reportId, staffId, poolId, branchId;
    private Integer deviceId; // Có thể null
    private String deviceName, reportReason, suggestion, status;
    private Timestamp reportDate;

    // --- Các trường hiển thị ---
    private String poolName;      // Tên hồ bơi
    private String staffName;     // Tên nhân viên tạo báo cáo
    private String branchName;    // Tên chi nhánh

    // --- Trường xử lý báo cáo ---
    private String managerNote;   // Ghi chú xử lý
    private Timestamp processedAt; // Thời gian xử lý
    private Integer processedBy;   // ID người xử lý
    private String processedByName; // Tên manager xử lý

    // Constructor
    public ManagerDeviceReport() {}

    // Getter/Setter cho các trường mới (manager xử lý)
    public String getManagerNote() {
        return managerNote;
    }
    public void setManagerNote(String managerNote) {
        this.managerNote = managerNote;
    }

    public Timestamp getProcessedAt() {
        return processedAt;
    }
    public void setProcessedAt(Timestamp processedAt) {
        this.processedAt = processedAt;
    }

    public Integer getProcessedBy() {
        return processedBy;
    }
    public void setProcessedBy(Integer processedBy) {
        this.processedBy = processedBy;
    }

    public String getProcessedByName() {
        return processedByName;
    }
    public void setProcessedByName(String processedByName) {
        this.processedByName = processedByName;
    }

    // Getter/Setter cho các trường hiển thị
    public String getPoolName() { return poolName; }
    public void setPoolName(String poolName) { this.poolName = poolName; }

    public String getStaffName() { return staffName; }
    public void setStaffName(String staffName) { this.staffName = staffName; }

    public String getBranchName() { return branchName; }
    public void setBranchName(String branchName) { this.branchName = branchName; }

    // Getter/Setter cho các trường cơ bản
    public int getReportId() { return reportId; }
    public void setReportId(int reportId) { this.reportId = reportId; }

    public int getStaffId() { return staffId; }
    public void setStaffId(int staffId) { this.staffId = staffId; }

    public int getPoolId() { return poolId; }
    public void setPoolId(int poolId) { this.poolId = poolId; }

    public int getBranchId() { return branchId; }
    public void setBranchId(int branchId) { this.branchId = branchId; }

    public Integer getDeviceId() { return deviceId; }
    public void setDeviceId(Integer deviceId) { this.deviceId = deviceId; }

    public String getDeviceName() { return deviceName; }
    public void setDeviceName(String deviceName) { this.deviceName = deviceName; }

    public String getReportReason() { return reportReason; }
    public void setReportReason(String reportReason) { this.reportReason = reportReason; }

    public String getSuggestion() { return suggestion; }
    public void setSuggestion(String suggestion) { this.suggestion = suggestion; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public Timestamp getReportDate() { return reportDate; }
    public void setReportDate(Timestamp reportDate) { this.reportDate = reportDate; }

    @Override
    public String toString() {
        return "ManagerDeviceReport{" +
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
                ", managerNote='" + managerNote + '\'' +
                ", processedAt=" + processedAt +
                ", processedBy=" + processedBy +
                ", processedByName='" + processedByName + '\'' +
                '}';
    }
}