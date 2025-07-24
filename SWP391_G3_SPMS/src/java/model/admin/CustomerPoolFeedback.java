/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

/**
 *
 * @author Lenovo
 */
public class CustomerPoolFeedback {

    private String poolName;
    private int rating;
    private String comment;
    private String feedbackDate; 
    private String feedbackUser;

    public CustomerPoolFeedback() {
    }
    
    public CustomerPoolFeedback(String poolName, int rating, String comment, String feedbackDate, String feedbackUser) {
        this.poolName = poolName;
        this.rating = rating;
        this.comment = comment;
        this.feedbackDate = feedbackDate;
        this.feedbackUser = feedbackUser;
    }

    public String getPoolName() {
        return poolName;
    }

    public void setPoolName(String poolName) {
        this.poolName = poolName;
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

    public String getFeedbackDate() {
        return feedbackDate;
    }

    public void setFeedbackDate(String feedbackDate) {
        this.feedbackDate = feedbackDate;
    }

    public String getFeedbackUser() {
        return feedbackUser;
    }

    public void setFeedbackUser(String feedbackUser) {
        this.feedbackUser = feedbackUser;
    }

    @Override
    public String toString() {
        return "PoolFeedback{" + "poolName=" + poolName + ", rating=" + rating + ", comment=" + comment + ", feedbackDate=" + feedbackDate + ", feedbackUser=" + feedbackUser + '}';
    }
    
    
    
    
}
