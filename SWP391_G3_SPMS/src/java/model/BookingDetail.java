/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author LAZYVL
 */
import java.math.BigDecimal;
import java.sql.Date;

public class BookingDetail {
    private int bookingId;
    private int userId;
    private int poolId;
    private String poolName;
    private String poolAddressDetail;
    private Date bookingDate;
    private int slotCount;
    private BigDecimal amount;
    private String bookingStatus;
    private int rating;
    private String comment;

    public BookingDetail() {}

    public BookingDetail(int bookingId, int userId, int poolId, String poolName, String poolAddressDetail, Date bookingDate, int slotCount, BigDecimal amount, String bookingStatus, int rating, String comment) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.poolId = poolId;
        this.poolName = poolName;
        this.poolAddressDetail = poolAddressDetail;
        this.bookingDate = bookingDate;
        this.slotCount = slotCount;
        this.amount = amount;
        this.bookingStatus = bookingStatus;
        this.rating = rating;
        this.comment = comment;
    }

    // Getter & Setter
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
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

    public String getPoolAddressDetail() {
        return poolAddressDetail;
    }

    public void setPoolAddressDetail(String poolAddressDetail) {
        this.poolAddressDetail = poolAddressDetail;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public int getSlotCount() {
        return slotCount;
    }

    public void setSlotCount(int slotCount) {
        this.slotCount = slotCount;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getBookingStatus() {
        return bookingStatus;
    }

    public void setBookingStatus(String bookingStatus) {
        this.bookingStatus = bookingStatus;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }
}
