/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;
import java.sql.Time;

/**
 *
 * @author LAZYVL
 */
public class Booking {
    private int bookingId;
    private String customerName;
    private String phone;
    private String email;
    private String poolName;
    private Date bookingDate;
    private Time startTime;
    private Time endTime;
    private int slotCount;
    private String bookingStatus;

    public Booking() {
    }

    public Booking(int bookingId, String customerName, String phone, String email, String poolName, Date bookingDate, Time startTime, Time endTime, int slotCount, String bookingStatus) {
        this.bookingId = bookingId;
        this.customerName = customerName;
        this.phone = phone;
        this.email = email;
        this.poolName = poolName;
        this.bookingDate = bookingDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.slotCount = slotCount;
        this.bookingStatus = bookingStatus;
    }

    public Booking(String customerName, String phone, String email, String poolName, Date bookingDate, Time startTime, Time endTime, int slotCount, String bookingStatus) {
        this.customerName = customerName;
        this.phone = phone;
        this.email = email;
        this.poolName = poolName;
        this.bookingDate = bookingDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.slotCount = slotCount;
        this.bookingStatus = bookingStatus;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPoolName() {
        return poolName;
    }

    public void setPoolName(String poolName) {
        this.poolName = poolName;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }

    public int getSlotCount() {
        return slotCount;
    }

    public void setSlotCount(int slotCount) {
        this.slotCount = slotCount;
    }

    public String getBookingStatus() {
        return bookingStatus;
    }

    public void setBookingStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
    }
    
    
}
