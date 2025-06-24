/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.customer;

import java.math.BigDecimal;

public class PaymentTicket {

    private int paymentTicketId;
    private int paymentId;
    private int ticketId;
    private BigDecimal amount;
    private int quantity;

    public PaymentTicket() {
    }

    public PaymentTicket(int paymentTicketId, int paymentId, int ticketId, BigDecimal amount, int quantity) {
        this.paymentTicketId = paymentTicketId;
        this.paymentId = paymentId;
        this.ticketId = ticketId;
        this.amount = amount;
        this.quantity = quantity;
    }

    public int getPaymentTicketId() {
        return paymentTicketId;
    }

    public void setPaymentTicketId(int paymentTicketId) {
        this.paymentTicketId = paymentTicketId;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getTicketId() {
        return ticketId;
    }

    public void setTicketId(int ticketId) {
        this.ticketId = ticketId;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "PaymentTicket{"
                + "paymentTicketId=" + paymentTicketId
                + ", paymentId=" + paymentId
                + ", ticketId=" + ticketId
                + ", amount=" + amount
                + ", quantity=" + quantity
                + '}';
    }
}
