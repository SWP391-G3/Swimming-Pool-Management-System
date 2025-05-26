/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.staff;

import java.time.LocalDate;

/**
 *
 * @author Tuan Anh
 */
public class StaffAssignment {

    private int assignmentId;
    private int userId;
    private int poolId;
    private String poolName;
    private String shiftName;
    private LocalDate assignedDate;

    public StaffAssignment(int assignmentId, int userId, int poolId, String poolName, String shiftName, LocalDate assignedDate) {
        this.assignmentId = assignmentId;
        this.userId = userId;
        this.poolId = poolId;
        this.poolName = poolName;
        this.shiftName = shiftName;
        this.assignedDate = assignedDate;
    }

    public StaffAssignment() {
    }

    
    public int getAssignmentId() {
        return assignmentId;
    }

    public void setAssignmentId(int assignmentId) {
        this.assignmentId = assignmentId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public String getShiftName() {
        return shiftName;
    }

    public void setShiftName(String shiftName) {
        this.shiftName = shiftName;
    }

    public LocalDate getAssignedDate() {
        return assignedDate;
    }

    public void setAssignedDate(LocalDate assignedDate) {
        this.assignedDate = assignedDate;
    }

    @Override
    public String toString() {
        return "StaffAssignment{" + "assignmentId=" + assignmentId + ", userId=" + userId + ", poolId=" + poolId + ", poolName=" + poolName + ", shiftName=" + shiftName + ", assignedDate=" + assignedDate + '}';
    }

}
