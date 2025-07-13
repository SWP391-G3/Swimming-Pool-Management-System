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
public class Employee {
    private int staffId;
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private LocalDate dob;
    private String gender;
    private String images;
    private Boolean status;
    private Integer branchId;
    private String branchName;
    private Integer poolId;
    private String poolName;
    private Integer staffTypeId;
    private String staffTypeName;
    private String staffTypeDescription;

    public Employee() {
    }

    public Employee(int staffId, String fullName, String email, String phone, String address, LocalDate dob, String gender, String images, Boolean status, Integer branchId, String branchName, Integer poolId, String poolName, Integer staffTypeId, String staffTypeName, String staffTypeDescription) {
        this.staffId = staffId;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.dob = dob;
        this.gender = gender;
        this.images = images;
        this.status = status;
        this.branchId = branchId;
        this.branchName = branchName;
        this.poolId = poolId;
        this.poolName = poolName;
        this.staffTypeId = staffTypeId;
        this.staffTypeName = staffTypeName;
        this.staffTypeDescription = staffTypeDescription;
    }

    public int getStaffId() {
        return staffId;
    }

    public void setStaffId(int staffId) {
        this.staffId = staffId;
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

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getImages() {
        return images;
    }

    public void setImages(String images) {
        this.images = images;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public Integer getBranchId() {
        return branchId;
    }

    public void setBranchId(Integer branchId) {
        this.branchId = branchId;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public Integer getPoolId() {
        return poolId;
    }

    public void setPoolId(Integer poolId) {
        this.poolId = poolId;
    }

    public String getPoolName() {
        return poolName;
    }

    public void setPoolName(String poolName) {
        this.poolName = poolName;
    }

    public Integer getStaffTypeId() {
        return staffTypeId;
    }

    public void setStaffTypeId(Integer staffTypeId) {
        this.staffTypeId = staffTypeId;
    }

    public String getStaffTypeName() {
        return staffTypeName;
    }

    public void setStaffTypeName(String staffTypeName) {
        this.staffTypeName = staffTypeName;
    }

    public String getStaffTypeDescription() {
        return staffTypeDescription;
    }

    public void setStaffTypeDescription(String staffTypeDescription) {
        this.staffTypeDescription = staffTypeDescription;
    }

    @Override
    public String toString() {
        return "Employee{" + "staffId=" + staffId + ", fullName=" + fullName + ", email=" + email + ", phone=" + phone + ", address=" + address + ", dob=" + dob + ", gender=" + gender + ", images=" + images + ", status=" + status + ", branchId=" + branchId + ", branchName=" + branchName + ", poolId=" + poolId + ", poolName=" + poolName + ", staffTypeId=" + staffTypeId + ", staffTypeName=" + staffTypeName + ", staffTypeDescription=" + staffTypeDescription + '}';
    }
    
    
}
