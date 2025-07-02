/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.customer;

import java.math.BigDecimal;
import java.util.Date;

public class Ticket {

    private int ticketId;
    private int bookingId;
    private int ticketTypeId;
    private BigDecimal ticketPrice;
    private String ticketCode;
    private Integer issuedBy;     // Cho phép null
    private Date issuedAt;        // java.util.Date phù hợp với DATETIME
    private int quantity;          //xử lý BookingDetail

    public Ticket() {
    }

    public Ticket(int ticketId, int bookingId, int ticketTypeId, BigDecimal ticketPrice, String ticketCode, Integer issuedBy, Date issuedAt) {
        this.ticketId = ticketId;
        this.bookingId = bookingId;
        this.ticketTypeId = ticketTypeId;
        this.ticketPrice = ticketPrice;
        this.ticketCode = ticketCode;
        this.issuedBy = issuedBy;
        this.issuedAt = issuedAt;
    }

    public Ticket(BigDecimal ticketPrice, String ticketCode, Date issuedAt, int quantity) {
        this.ticketPrice = ticketPrice;
        this.ticketCode = ticketCode;
        this.issuedAt = issuedAt;
        this.quantity = quantity;
    }

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getTicketTypeId() {
        return ticketTypeId;
    }

    public void setTicketTypeId(int ticketTypeId) {
        this.ticketTypeId = ticketTypeId;
    }

    public BigDecimal getTicketPrice() {
        return ticketPrice;
    }

    public void setTicketPrice(BigDecimal ticketPrice) {
        this.ticketPrice = ticketPrice;
    }

    public String getTicketCode() {
        return ticketCode;
    }

    public void setTicketCode(String ticketCode) {
        this.ticketCode = ticketCode;
    }

    public Integer getIssuedBy() {
        return issuedBy;
    }

    public void setIssuedBy(Integer issuedBy) {
        this.issuedBy = issuedBy;
    }

    public Date getIssuedAt() {
        return issuedAt;
    }

    public void setIssuedAt(Date issuedAt) {
        this.issuedAt = issuedAt;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    
    @Override
    public String toString() {
        return "Ticket{"
                + "ticketId=" + ticketId
                + ", bookingId=" + bookingId
                + ", ticketTypeId=" + ticketTypeId
                + ", ticketPrice=" + ticketPrice
                + ", ticketCode='" + ticketCode + '\''
                + ", issuedBy=" + issuedBy
                + ", issuedAt=" + issuedAt
                + '}';
    }
}
