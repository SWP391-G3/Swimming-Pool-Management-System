/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.staff;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 *
 * @author LAZYVL
 */
public class SaleTicketDirectly {

    private int saleId;
    private String customerName;
    private String customerPhone;
    private String customerEmail;
    private Integer userId;
    private int staffId;
    private int poolId;
    private int branchId;
    private int bookingId;
    private BigDecimal totalAmount;        // ✅ Thêm field này
    private String paymentMethod;          // ✅ Thêm field này
    private String paymentStatus;          // ✅ Thêm field này
    private Timestamp saleDate;            // ✅ Timestamp, không phải Date
    private Timestamp createdAt;
    private String notes;

    // Constructors
    public SaleTicketDirectly() {
    }

    public SaleTicketDirectly(int saleId, String customerName, String customerPhone, String customerEmail, Integer userId, int staffId, int poolId, int branchId, int bookingId, BigDecimal totalAmount, String paymentMethod, String paymentStatus, Timestamp saleDate, Timestamp createdAt, String notes) {
        this.saleId = saleId;
        this.customerName = customerName;
        this.customerPhone = customerPhone;
        this.customerEmail = customerEmail;
        this.userId = userId;
        this.staffId = staffId;
        this.poolId = poolId;
        this.branchId = branchId;
        this.bookingId = bookingId;
        this.totalAmount = totalAmount;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.saleDate = saleDate;
        this.createdAt = createdAt;
        this.notes = notes;
    }

    public int getSaleId() {
        return saleId;
    }

    public void setSaleId(int saleId) {
        this.saleId = saleId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
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

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public Timestamp getSaleDate() {
        return saleDate;
    }

    public void setSaleDate(Timestamp saleDate) {
        this.saleDate = saleDate;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

}
