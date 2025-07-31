/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

import java.time.LocalTime;

/**
 *
 * @author Lenovo
 */
public class BookingSummary {

    private int bookingId;
    private String poolName;
    private String branchName;
    private String customerName;
    private LocalTime startTime;
    private LocalTime endTime;
    private int totalTickets;

    public BookingSummary() {
    }

    public BookingSummary(int bookingId, String poolName, String branchName, String customerName, LocalTime startTime, LocalTime endTime, int totalTickets) {
        this.bookingId = bookingId;
        this.poolName = poolName;
        this.branchName = branchName;
        this.customerName = customerName;
        this.startTime = startTime;
        this.endTime = endTime;
        this.totalTickets = totalTickets;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public String getPoolName() {
        return poolName;
    }

    public void setPoolName(String poolName) {
        this.poolName = poolName;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public LocalTime getStartTime() {
        return startTime;
    }

    public void setStartTime(LocalTime startTime) {
        this.startTime = startTime;
    }

    public LocalTime getEndTime() {
        return endTime;
    }

    public void setEndTime(LocalTime endTime) {
        this.endTime = endTime;
    }

    public int getTotalTickets() {
        return totalTickets;
    }

    public void setTotalTickets(int totalTickets) {
        this.totalTickets = totalTickets;
    }

    @Override
    public String toString() {
        return "BookingSummary{" + "bookingId=" + bookingId + ", poolName=" + poolName + ", branchName=" + branchName + ", customerName=" + customerName + ", startTime=" + startTime + ", endTime=" + endTime + ", totalTickets=" + totalTickets + '}';
    }
    
    
}
