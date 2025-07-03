/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.customer;

/**
 *
 * @author LAZYVL
 */
import java.math.BigDecimal;
import java.sql.Time;
import java.util.List;
import java.sql.Date;

public class BookingDetails {

    private int bookingId;
    private int userId;
    private int poolId;
    private String poolName;
    private String poolAddressDetail;
    private Date bookingDate;
    private int slotCount;
    private BigDecimal amount;
    private String bookingStatus;
    private Integer rating;
    private String comment;

    // Các thuộc tính bổ sung
    private int ticketCount;
    private Time startTime;
    private Time endTime;
    private String discountCode;
    private BigDecimal discountPercent;
    private List<Ticket> tickets;

    public BookingDetails() {
    }

    public BookingDetails(int bookingId, int userId, int poolId, String poolName, String poolAddressDetail, Date bookingDate, int slotCount, BigDecimal amount, String bookingStatus, Integer rating, String comment) {
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

    public BookingDetails(int bookingId, int userId, int poolId, String poolName, String poolAddressDetail, Date bookingDate, int slotCount, BigDecimal amount, String bookingStatus, Integer rating, String comment, int ticketCount, Time startTime, Time endTime, String discountCode, BigDecimal discountPercent, List<Ticket> tickets) {
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
        this.ticketCount = ticketCount;
        this.startTime = startTime;
        this.endTime = endTime;
        this.discountCode = discountCode;
        this.discountPercent = discountPercent;
        this.tickets = tickets;
    }

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

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public int getTicketCount() {
        return ticketCount;
    }

    public void setTicketCount(int ticketCount) {
        this.ticketCount = ticketCount;
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

    public String getDiscountCode() {
        return discountCode;
    }

    public void setDiscountCode(String discountCode) {
        this.discountCode = discountCode;
    }

    public BigDecimal getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(BigDecimal discountPercent) {
        this.discountPercent = discountPercent;
    }

    public List<Ticket> getTickets() {
        return tickets;
    }

    public void setTickets(List<Ticket> tickets) {
        this.tickets = tickets;
    }

    @Override
    public String toString() {
        return "BookingDetails{" + "bookingId=" + bookingId + ", userId=" + userId + ", poolId=" + poolId + ", poolName=" + poolName + ", poolAddressDetail=" + poolAddressDetail + ", bookingDate=" + bookingDate + ", slotCount=" + slotCount + ", amount=" + amount + ", bookingStatus=" + bookingStatus + ", rating=" + rating + ", comment=" + comment + ", ticketCount=" + ticketCount + ", startTime=" + startTime + ", endTime=" + endTime + ", discountCode=" + discountCode + ", discountPercent=" + discountPercent + ", tickets=" + tickets + '}';
    }

    
}
