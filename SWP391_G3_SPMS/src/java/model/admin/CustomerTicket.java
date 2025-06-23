/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

import java.time.LocalDate;

/**
 *
 * @author Lenovo
 */
public class CustomerTicket {
    private int ticket_type_id;
    private String type_code;
    private String type_name;
    private int usage_count;
    private LocalDate use_date;
    private double average_price;

    public CustomerTicket() {
    }

    
    
    public CustomerTicket(int ticket_type_id, String type_code, String type_name, int usage_count, LocalDate use_date, double average_price) {
        this.ticket_type_id = ticket_type_id;
        this.type_code = type_code;
        this.type_name = type_name;
        this.usage_count = usage_count;
        this.use_date = use_date;
        this.average_price = average_price;
    }

    public int getTicket_type_id() {
        return ticket_type_id;
    }

    public void setTicket_type_id(int ticket_type_id) {
        this.ticket_type_id = ticket_type_id;
    }

    public String getType_code() {
        return type_code;
    }

    public void setType_code(String type_code) {
        this.type_code = type_code;
    }

    public String getType_name() {
        return type_name;
    }

    public void setType_name(String type_name) {
        this.type_name = type_name;
    }

    public int getUsage_count() {
        return usage_count;
    }

    public void setUsage_count(int usage_count) {
        this.usage_count = usage_count;
    }

    public LocalDate getUse_date() {
        return use_date;
    }

    public void setUse_date(LocalDate use_date) {
        this.use_date = use_date;
    }

    public double getAverage_price() {
        return average_price;
    }

    public void setAverage_price(double average_price) {
        this.average_price = average_price;
    }

    @Override
    public String toString() {
        return "CustomerTicket{" + "ticket_type_id=" + ticket_type_id + ", type_code=" + type_code + ", type_name=" + type_name + ", usage_count=" + usage_count + ", use_date=" + use_date + ", average_price=" + average_price + '}';
    }
    
    
}
