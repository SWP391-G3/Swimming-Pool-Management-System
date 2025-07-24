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
public class EmployeeAccount {
    private String username;
    private String password;
    private String fullName;
    private String email;
    private String phone;
    private String gender;
    private LocalDate dob;
    private String address;
    private Boolean status;
    private Integer branchId;
    private Integer poolId;
    private Integer staffTypeId;

    public EmployeeAccount() {
    }

    public EmployeeAccount(String username, String password, String fullName, String email, String phone, String gender, LocalDate dob, String address, Boolean status, Integer branchId, Integer poolId, Integer staffTypeId) {
        this.username = username;
        this.password = password;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.gender = gender;
        this.dob = dob;
        this.address = address;
        this.status = status;
        this.branchId = branchId;
        this.poolId = poolId;
        this.staffTypeId = staffTypeId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
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

    public Integer getPoolId() {
        return poolId;
    }

    public void setPoolId(Integer poolId) {
        this.poolId = poolId;
    }

    public Integer getStaffTypeId() {
        return staffTypeId;
    }

    public void setStaffTypeId(Integer staffTypeId) {
        this.staffTypeId = staffTypeId;
    }

    @Override
    public String toString() {
        return "EmployeeAccount{" + "username=" + username + ", password=" + password + ", fullName=" + fullName + ", email=" + email + ", phone=" + phone + ", gender=" + gender + ", dob=" + dob + ", address=" + address + ", status=" + status + ", branchId=" + branchId + ", poolId=" + poolId + ", staffTypeId=" + staffTypeId + '}';
    }
    
    
}
