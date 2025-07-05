/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 *
 * @author Lenovo
 */
public class CustomerService {
    private String customer_name;
    private int booking_id;
    private String service_name;
    private int quantity;
    private double total_service_price;
    private String pool_name;
    private LocalDate booking_date;
    private LocalDateTime start_time;
    private LocalDateTime end_time;

    public CustomerService(String customer_name, int booking_id, String service_name, int quantity, double total_service_price, String pool_name, LocalDate booking_date, LocalDateTime start_time, LocalDateTime end_time) {
        this.customer_name = customer_name;
        this.booking_id = booking_id;
        this.service_name = service_name;
        this.quantity = quantity;
        this.total_service_price = total_service_price;
        this.pool_name = pool_name;
        this.booking_date = booking_date;
        this.start_time = start_time;
        this.end_time = end_time;
    }

    public String getCustomer_name() {
        return customer_name;
    }

    public void setCustomer_name(String customer_name) {
        this.customer_name = customer_name;
    }

    public int getBooking_id() {
        return booking_id;
    }

    public void setBooking_id(int booking_id) {
        this.booking_id = booking_id;
    }

    public String getService_name() {
        return service_name;
    }

    public void setService_name(String service_name) {
        this.service_name = service_name;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getTotal_service_price() {
        return total_service_price;
    }

    public void setTotal_service_price(double total_service_price) {
        this.total_service_price = total_service_price;
    }

    public String getPool_name() {
        return pool_name;
    }

    public void setPool_name(String pool_name) {
        this.pool_name = pool_name;
    }

    public LocalDate getBooking_date() {
        return booking_date;
    }

    public void setBooking_date(LocalDate booking_date) {
        this.booking_date = booking_date;
    }

    public LocalDateTime getStart_time() {
        return start_time;
    }

    public void setStart_time(LocalDateTime start_time) {
        this.start_time = start_time;
    }

    public LocalDateTime getEnd_time() {
        return end_time;
    }

    public void setEnd_time(LocalDateTime end_time) {
        this.end_time = end_time;
    }

    @Override
    public String toString() {
        return "CustomerService{" + "customer_name=" + customer_name + ", booking_id=" + booking_id + ", service_name=" + service_name + ", quantity=" + quantity + ", total_service_price=" + total_service_price + ", pool_name=" + pool_name + ", booking_date=" + booking_date + ", start_time=" + start_time + ", end_time=" + end_time + '}';
    }
    
    
}
