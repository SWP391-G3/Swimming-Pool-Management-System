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
public class CustomerFeedback {
    private String customer_name;
    private String pool_name;
    private int rating;
    private String comment;
    private LocalDate create_at;

    public CustomerFeedback(String customer_name, String pool_name, int rating, String comment, LocalDate create_at) {
        this.customer_name = customer_name;
        this.pool_name = pool_name;
        this.rating = rating;
        this.comment = comment;
        this.create_at = create_at;
    }

    public String getCustomer_name() {
        return customer_name;
    }

    public void setCustomer_name(String customer_name) {
        this.customer_name = customer_name;
    }

    public String getPool_name() {
        return pool_name;
    }

    public void setPool_name(String pool_name) {
        this.pool_name = pool_name;
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

    public LocalDate getCreate_at() {
        return create_at;
    }

    public void setCreate_at(LocalDate create_at) {
        this.create_at = create_at;
    }

    @Override
    public String toString() {
        return "CustomerFeedback{" + "customer_name=" + customer_name + ", pool_name=" + pool_name + ", rating=" + rating + ", comment=" + comment + ", create_at=" + create_at + '}';
    }
    
    
}
