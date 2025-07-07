/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.manager;

import java.util.Date;

/**
 *
 * @author Tuan Anh
 */
public class Feedback {
 
    private int feedbackId;
    private int userId;
    private int poolId;
    private int rating;
    private String comment;
    private Date createdAt;
    // Thông tin bổ sung cho hiển thị
    private String userName;
    private String userImage;
    private String poolName;
    private String userEmail;

    public Feedback() {
    }

    public Feedback(int feedbackId, int userId, int poolId, int rating, String comment, Date createdAt, String userName, String userImage, String poolName, String userEmail) {
        this.feedbackId = feedbackId;
        this.userId = userId;
        this.poolId = poolId;
        this.rating = rating;
        this.comment = comment;
        this.createdAt = createdAt;
        this.userName = userName;
        this.userImage = userImage;
        this.poolName = poolName;
        this.userEmail = userEmail;
    }

    public int getFeedbackId() {
        return feedbackId;
    }

    public void setFeedbackId(int feedbackId) {
        this.feedbackId = feedbackId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getPoolId() {
        return poolId;
    }

    public void setPoolId(int poolId) {
        this.poolId = poolId;
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

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getUserImage() {
        return userImage;
    }

    public void setUserImage(String userImage) {
        this.userImage = userImage;
    }

    public String getPoolName() {
        return poolName;
    }

    public void setPoolName(String poolName) {
        this.poolName = poolName;
    }

    public String getUserEmail() {
        return userEmail;
    }

    public void setUserEmail(String userEmail) {
        this.userEmail = userEmail;
    }

    @Override
    public String toString() {
        return "Feedback{" + "feedbackId=" + feedbackId + ", userId=" + userId + ", poolId=" + poolId + ", rating=" + rating + ", comment=" + comment + ", createdAt=" + createdAt + ", userName=" + userName + ", userImage=" + userImage + ", poolName=" + poolName + ", userEmail=" + userEmail + '}';
    }
  
    
    
    
    
}
