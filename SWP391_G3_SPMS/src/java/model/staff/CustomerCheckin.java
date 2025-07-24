/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.staff;

import java.security.Timestamp;

/**
 *
 * @author LAZYVL
 */
public class CustomerCheckin {
    private int checkinId;
    private int userId;
    private int bookingId;
    private int checkinStatus; // 0: chưa check-in, 1: đã check-in
    private Timestamp checkinTime;

    public CustomerCheckin() {}

    public CustomerCheckin(int checkinId, int userId, int bookingId, int checkinStatus, Timestamp checkinTime) {
        this.checkinId = checkinId;
        this.userId = userId;
        this.bookingId = bookingId;
        this.checkinStatus = checkinStatus;
        this.checkinTime = checkinTime;
    }

    public int getCheckinId() {
        return checkinId;
    }

    public void setCheckinId(int checkinId) {
        this.checkinId = checkinId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getCheckinStatus() {
        return checkinStatus;
    }

    public void setCheckinStatus(int checkinStatus) {
        this.checkinStatus = checkinStatus;
    }

    public Timestamp getCheckinTime() {
        return checkinTime;
    }

    public void setCheckinTime(Timestamp checkinTime) {
        this.checkinTime = checkinTime;
    }

    @Override
    public String toString() {
        return "CustomerCheckin{" + "checkinId=" + checkinId + ", userId=" + userId + ", bookingId=" + bookingId + ", checkinStatus=" + checkinStatus + ", checkinTime=" + checkinTime + '}';
    }
    
    
}
