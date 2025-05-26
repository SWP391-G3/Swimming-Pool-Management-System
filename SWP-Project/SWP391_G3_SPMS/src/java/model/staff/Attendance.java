/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.staff;

import java.sql.Timestamp;    


/**
 *
 * @author Tuan Anh
 */
public class Attendance {

    private int attendanceId;
    private int userId;
    private int poolId;
    private String shiftName;
    private Timestamp checkIn;
    private Timestamp checkOut;

    public Attendance(int attendanceId, int userId, int poolId, String shiftName, Timestamp checkIn, Timestamp checkOut) {
        this.attendanceId = attendanceId;
        this.userId = userId;
        this.poolId = poolId;
        this.shiftName = shiftName;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
    }

    public Attendance(int userId, int poolId, String shiftName, Timestamp checkIn, Timestamp checkOut) {
        this.userId = userId;
        this.poolId = poolId;
        this.shiftName = shiftName;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
    }
    

    public Attendance() {
    }
    
    

    public int getAttendanceId() {
        return attendanceId;
    }

    public void setAttendanceId(int attendanceId) {
        this.attendanceId = attendanceId;
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

    public String getShiftName() {
        return shiftName;
    }

    public void setShiftName(String shiftName) {
        this.shiftName = shiftName;
    }

    public Timestamp getCheckIn() {
        return checkIn;
    }

    public void setCheckIn(Timestamp checkIn) {
        this.checkIn = checkIn;
    }

    public Timestamp getCheckOut() {
        return checkOut;
    }

    public void setCheckOut(Timestamp checkOut) {
        this.checkOut = checkOut;
    }

    @Override
    public String toString() {
        return "Attendance{" + "attendanceId=" + attendanceId + ", userId=" + userId + ", poolId=" + poolId + ", shiftName=" + shiftName + ", checkIn=" + checkIn + ", checkOut=" + checkOut + '}';
    }
    
    

}
