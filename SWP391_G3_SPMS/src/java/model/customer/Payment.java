/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.customer;

import java.math.BigDecimal;
import java.util.Date;

public class Payment {

    private int paymentId;
    private int bookingId;
    private String paymentMethod;      // 'Bank_transfers' hoặc 'Cash'
    private String paymentStatus;      // 'pending', 'completed', 'canceled', 'refunded'
    private Date paymentDate;
    private BigDecimal totalAmount;
    private BigDecimal discountAmount;
    private String transactionReference;
    private Date createdAt;

    public Payment() {
    }

    public Payment(int paymentId, int bookingId, String paymentMethod, String paymentStatus, Date paymentDate,
            BigDecimal totalAmount, BigDecimal discountAmount, String transactionReference, Date createdAt) {
        this.paymentId = paymentId;
        this.bookingId = bookingId;
        this.paymentMethod = paymentMethod;
        this.paymentStatus = paymentStatus;
        this.paymentDate = paymentDate;
        this.totalAmount = totalAmount;
        this.discountAmount = discountAmount;
        this.transactionReference = transactionReference;
        this.createdAt = createdAt;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
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

    public Date getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(Date paymentDate) {
        this.paymentDate = paymentDate;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public String getTransactionReference() {
        return transactionReference;
    }

    public void setTransactionReference(String transactionReference) {
        this.transactionReference = transactionReference;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "Payment{"
                + "paymentId=" + paymentId
                + ", bookingId=" + bookingId
                + ", paymentMethod='" + paymentMethod + '\''
                + ", paymentStatus='" + paymentStatus + '\''
                + ", paymentDate=" + paymentDate
                + ", totalAmount=" + totalAmount
                + ", discountAmount=" + discountAmount
                + ", transactionReference='" + transactionReference + '\''
                + ", createdAt=" + createdAt
                + '}';
    }
}
