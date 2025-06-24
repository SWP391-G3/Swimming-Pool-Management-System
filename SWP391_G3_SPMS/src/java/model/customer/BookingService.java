/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.customer;

import java.math.BigDecimal;

public class BookingService {

    private int bookingServiceId;    // booking_service_id
    private int bookingId;           // booking_id
    private int poolServiceId;       // pool_service_id
    private int branchId;            // branch_id
    private int quantity;            // quantity
    private BigDecimal totalServicePrice;  // total_service_price

    public BookingService() {
    }
    // Constructor có bookingServiceId (khi lấy dữ liệu từ DB)
    public BookingService(int bookingServiceId, int bookingId, int poolServiceId, int branchId, int quantity, BigDecimal totalServicePrice) {
        this.bookingServiceId = bookingServiceId;
        this.bookingId = bookingId;
        this.poolServiceId = poolServiceId;
        this.branchId = branchId;
        this.quantity = quantity;
        this.totalServicePrice = totalServicePrice;
    }
    
    // Constructor không có bookingServiceId (thường dùng khi tạo mới, vì ID tự tăng)
    public BookingService(int bookingId, int poolServiceId, int branchId, int quantity, BigDecimal totalServicePrice) {
        this.bookingId = bookingId;
        this.poolServiceId = poolServiceId;
        this.branchId = branchId;
        this.quantity = quantity;
        this.totalServicePrice = totalServicePrice;
    }

    // Getter và Setter
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

    public BigDecimal getTotalServicePrice() {
        return totalServicePrice;
    }

    public void setTotalServicePrice(BigDecimal totalServicePrice) {
        this.totalServicePrice = totalServicePrice;
    }

    @Override
    public String toString() {
        return "BookingService{"
                + "bookingServiceId=" + bookingServiceId
                + ", bookingId=" + bookingId
                + ", poolServiceId=" + poolServiceId
                + ", branchId=" + branchId
                + ", quantity=" + quantity
                + ", totalServicePrice=" + totalServicePrice
                + '}';
    }
}
