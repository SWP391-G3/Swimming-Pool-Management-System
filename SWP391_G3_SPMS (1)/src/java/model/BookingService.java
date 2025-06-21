/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

public class BookingService {
    private int bookingServiceId;
    private int bookingId;
    private int poolServiceId;
    private int branchId;
    private int quantity;
    private double totalServicePrice;

    public BookingService(int bookingServiceId, int bookingId, int poolServiceId, int branchId, int quantity, double totalServicePrice) {
        this.bookingServiceId = bookingServiceId;
        this.bookingId = bookingId;
        this.poolServiceId = poolServiceId;
        this.branchId = branchId;
        this.quantity = quantity;
        this.totalServicePrice = totalServicePrice;
    }

    public int getBookingServiceId() {
        return bookingServiceId;
    }

    public void setBookingServiceId(int bookingServiceId) {
        this.bookingServiceId = bookingServiceId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getPoolServiceId() {
        return poolServiceId;
    }

    public void setPoolServiceId(int poolServiceId) {
        this.poolServiceId = poolServiceId;
    }

    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotalServicePrice() {
        return totalServicePrice;
    }

    public void setTotalServicePrice(double totalServicePrice) {
        this.totalServicePrice = totalServicePrice;
    }

    
}