/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.manager;

/**
 *
 * @author Tuan Anh
 */
public class Staff {
    
    
    private int userId;
    private String fullName;
    private String email;
    private String phone;
    private String images;
    private int status;
    private String branchName; // tên chi nhánh
    private String poolName;   // tên hồ bơi (nếu cần)
    private int branchId;
    

    public Staff() {
    }

    public Staff(int userId, String fullName, String email, String phone, String images, int status, String branchName, String poolName, int branchId) {
        this.userId = userId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.images = images;
        this.status = status;
        this.branchName = branchName;
        this.poolName = poolName;
        this.branchId = branchId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public String getPoolName() {
        return poolName;
    }

    public void setPoolName(String poolName) {
        this.poolName = poolName;
    }

    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }

    @Override
    public String toString() {
        return "Staff{" + "userId=" + userId + ", fullName=" + fullName + ", email=" + email + ", phone=" + phone + ", images=" + images + ", status=" + status + ", branchName=" + branchName + ", poolName=" + poolName + ", branchId=" + branchId + '}';
    }
    
    
}
