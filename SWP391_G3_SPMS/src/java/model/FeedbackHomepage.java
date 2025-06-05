/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Lenovo
 */
public class FeedbackHomepage {
    private int rating;
    private String pool_name;
    private String pool_image;
    private String comment;

    public FeedbackHomepage(int rating, String pool_name, String pool_image, String comment) {
        this.rating = rating;
        this.pool_name = pool_name;
        this.pool_image = pool_image;
        this.comment = comment;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getPool_name() {
        return pool_name;
    }

    public void setPool_name(String pool_name) {
        this.pool_name = pool_name;
    }

    public String getPool_image() {
        return pool_image;
    }

    public void setPool_image(String pool_image) {
        this.pool_image = pool_image;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    @Override
    public String toString() {
        return "FeedBack{" + "rating=" + rating + ", pool_name=" + pool_name + ", pool_image=" + pool_image + ", comment=" + comment + '}';
    }

    
}
