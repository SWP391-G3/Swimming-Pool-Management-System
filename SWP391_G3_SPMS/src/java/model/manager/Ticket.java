/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.manager;

import java.security.Timestamp;

/**
 *
 * @author Tuan Anh
 */
public class Ticket {

    private int ticketId;
    private int bookingId;
    private int ticketTypeId;
    private double ticketPrice;
    private String ticketCode;
    private int issuedBy;
    private Timestamp issuedAt;

    public Ticket() {
    }

    public Ticket(int ticketId, int bookingId, int ticketTypeId, double ticketPrice, String ticketCode, int issuedBy, Timestamp issuedAt) {
        this.ticketId = ticketId;
        this.bookingId = bookingId;
        this.ticketTypeId = ticketTypeId;
        this.ticketPrice = ticketPrice;
        this.ticketCode = ticketCode;
        this.issuedBy = issuedBy;
        this.issuedAt = issuedAt;
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

    public double getTicketPrice() {
        return ticketPrice;
    }

    public void setTicketPrice(double ticketPrice) {
        this.ticketPrice = ticketPrice;
    }

    public String getTicketCode() {
        return ticketCode;
    }

    public void setTicketCode(String ticketCode) {
        this.ticketCode = ticketCode;
    }

    public int getIssuedBy() {
        return issuedBy;
    }

    public void setIssuedBy(int issuedBy) {
        this.issuedBy = issuedBy;
    }

    public Timestamp getIssuedAt() {
        return issuedAt;
    }

    public void setIssuedAt(Timestamp issuedAt) {
        this.issuedAt = issuedAt;
    }

}
