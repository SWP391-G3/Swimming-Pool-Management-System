package model.customer;

import java.sql.Date;
import java.sql.Time;
/**
 *
 * @author LAZYVL
 */

public class Booking {

    private int bookingId;
    private int userId;
    private int poolId;
    private Integer discountId;
    private Date bookingDate;
    private Time startTime;
    private Time endTime;
    private int slotCount;
    private String bookingStatus;
    private java.util.Date createdAt;
    private java.util.Date updatedAt;

    public Booking() {
    }

    public Booking(int bookingId, int userId, int poolId, Integer discountId, Date bookingDate, Time startTime, Time endTime,
            int slotCount, String bookingStatus, java.util.Date createdAt, java.util.Date updatedAt) {
        this.bookingId = bookingId;
        this.userId = userId;
        this.poolId = poolId;
        this.discountId = discountId;
        this.bookingDate = bookingDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.slotCount = slotCount;
        this.bookingStatus = bookingStatus;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Booking(int userId, int poolId, Integer discountId, Date bookingDate, Time startTime, Time endTime, int slotCount, String bookingStatus, java.util.Date createdAt, java.util.Date updatedAt) {
        this.userId = userId;
        this.poolId = poolId;
        this.discountId = discountId;
        this.bookingDate = bookingDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.slotCount = slotCount;
        this.bookingStatus = bookingStatus;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Booking(int userId, int poolId, Integer discountId, Date bookingDate, Time startTime, Time endTime, int slotCount, String bookingStatus) {
        this.userId = userId;
        this.poolId = poolId;
        this.discountId = discountId;
        this.bookingDate = bookingDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.slotCount = slotCount;
        this.bookingStatus = bookingStatus;
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

    public Integer getDiscountId() {
        return discountId;
    }

    public void setDiscountId(Integer discountId) {
        this.discountId = discountId;
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

    public java.util.Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(java.util.Date createdAt) {
        this.createdAt = createdAt;
    }

    public java.util.Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(java.util.Date updatedAt) {
        this.updatedAt = updatedAt;
    }
}
