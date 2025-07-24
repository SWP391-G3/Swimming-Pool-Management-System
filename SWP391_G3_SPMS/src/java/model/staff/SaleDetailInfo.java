/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.staff;

import java.util.List;
import model.customer.*;

/**
 *
 * @author LAZYVL
 */
public class SaleDetailInfo {

    private SaleTicketDirectly sale;
    private Booking booking;
    private Payment payment;
    private User customer;
    private List<SaleTicketInfo> tickets;
    private List<SaleServiceInfo> services;

    public SaleDetailInfo() {
    }

    // Getters và Setters
    public SaleTicketDirectly getSale() {
        return sale;
    }

    public void setSale(SaleTicketDirectly sale) {
        this.sale = sale;
    }

    public Booking getBooking() {
        return booking;
    }

    public void setBooking(Booking booking) {
        this.booking = booking;
    }

    public Payment getPayment() {
        return payment;
    }

    public void setPayment(Payment payment) {
        this.payment = payment;
    }

    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }

    public List<SaleTicketInfo> getTickets() {
        return tickets;
    }

    public void setTickets(List<SaleTicketInfo> tickets) {
        this.tickets = tickets;
    }

    public List<SaleServiceInfo> getServices() {
        return services;
    }

    public void setServices(List<SaleServiceInfo> services) {
        this.services = services;
    }
}
