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
public class CustomerBooking {
    private String customer_name;
    private int booking_id;
    private String pool_name;
    private LocalDate booking_date;
    private LocalDateTime start_time;
    private LocalDateTime end_time;
    private int slot_count;
    private String booking_status;
    private double total_spent;
    private String payment_status;
    private LocalDate create_at;

    public CustomerBooking(String customer_name, int booking_id, String pool_name, LocalDate booking_date, LocalDateTime start_time, LocalDateTime end_time, int slot_count, String booking_status, double total_spent, String payment_status, LocalDate create_at) {
        this.customer_name = customer_name;
        this.booking_id = booking_id;
        this.pool_name = pool_name;
        this.booking_date = booking_date;
        this.start_time = start_time;
        this.end_time = end_time;
        this.slot_count = slot_count;
        this.booking_status = booking_status;
        this.total_spent = total_spent;
        this.payment_status = payment_status;
        this.create_at = create_at;
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

    public int getSlot_count() {
        return slot_count;
    }

    public void setSlot_count(int slot_count) {
        this.slot_count = slot_count;
    }

    public String getBooking_status() {
        return booking_status;
    }

    public void setBooking_status(String booking_status) {
        this.booking_status = booking_status;
    }

    public double getTotal_spent() {
        return total_spent;
    }

    public void setTotal_spent(double total_spent) {
        this.total_spent = total_spent;
    }

    public String getPayment_status() {
        return payment_status;
    }

    public void setPayment_status(String payment_status) {
        this.payment_status = payment_status;
    }

    public LocalDate getCreate_at() {
        return create_at;
    }

    public void setCreate_at(LocalDate create_at) {
        this.create_at = create_at;
    }

    @Override
    public String toString() {
        return "CustomerBooking{" + "customer_name=" + customer_name + ", booking_id=" + booking_id + ", pool_name=" + pool_name + ", booking_date=" + booking_date + ", start_time=" + start_time + ", end_time=" + end_time + ", slot_count=" + slot_count + ", booking_status=" + booking_status + ", total_spent=" + total_spent + ", payment_status=" + payment_status + ", create_at=" + create_at + '}';
    }

    

    
}
