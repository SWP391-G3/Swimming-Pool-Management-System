/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.staff;

import java.time.LocalDate;
import java.sql.Timestamp;

/**
 *
 * @author Tuan Anh
 */
public class StaffScheduleRow {

    public LocalDate date;
    public String pool;
    public int poolId;
    public String shift;
    public Integer attendanceId;
    public Timestamp checkIn;
    public Timestamp checkOut;

    public StaffScheduleRow(LocalDate date, String pool, int poolId, String shift, Integer attendanceId, Timestamp checkIn, Timestamp checkOut) {
        this.date = date;
        this.pool = pool;
        this.poolId = poolId;
        this.shift = shift;
        this.attendanceId = attendanceId;
        this.checkIn = checkIn;
        this.checkOut = checkOut;
    }

    public StaffScheduleRow() {
    }

    public java.util.Date getUtilDate() {   // chú ý
        return java.sql.Date.valueOf(date);
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public String getPool() {
        return pool;
    }

    public void setPool(String pool) {
        this.pool = pool;
    }

    public int getPoolId() {
        return poolId;
    }

    public void setPoolId(int poolId) {
        this.poolId = poolId;
    }

    public String getShift() {
        return shift;
    }

    public void setShift(String shift) {
        this.shift = shift;
    }

    public Integer getAttendanceId() {
        return attendanceId;
    }

    public void setAttendanceId(Integer attendanceId) {
        this.attendanceId = attendanceId;
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
        return "StaffScheduleRow{" + "date=" + date + ", pool=" + pool + ", poolId=" + poolId + ", shift=" + shift + ", attendanceId=" + attendanceId + ", checkIn=" + checkIn + ", checkOut=" + checkOut + '}';
    }

}
