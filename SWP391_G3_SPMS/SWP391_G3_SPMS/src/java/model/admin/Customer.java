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
public class Customer {
    private int user_id;
    private String full_name;
    private String email;
    private String phone;
    private String address;
    private int role_id;
    private LocalDate dob;
    private String gender;
    private String images;
    private String role_name;
    private Boolean status;
    private double total_spent;

    public Customer(int user_id, String full_name, String email, String phone, String address, int role_id, LocalDate dob, String gender, String images, String role_name, Boolean status,double total_spent) {
        this.user_id = user_id;
        this.full_name = full_name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.role_id = role_id;
        this.dob = dob;
        this.gender = gender;
        this.images = images;
        this.role_name = role_name;
        this.status = status;
        this.total_spent = total_spent;
    }

    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }

    public String getFull_name() {
        return full_name;
    }

    public void setFull_name(String full_name) {
        this.full_name = full_name;
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

    public int getRole_id() {
        return role_id;
    }

    public void setRole_id(int role_id) {
        this.role_id = role_id;
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

    public String getRole_name() {
        return role_name;
    }

    public void setRole_name(String role_name) {
        this.role_name = role_name;
    }

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public double getTotal_spent() {
        return total_spent;
    }

    public void setTotal_spent(double total_spent) {
        this.total_spent = total_spent;
    }

    @Override
    public String toString() {
        return "Customer{" + "user_id=" + user_id + ", full_name=" + full_name + ", email=" + email + ", phone=" + phone + ", address=" + address + ", role_id=" + role_id + ", dob=" + dob + ", gender=" + gender + ", images=" + images + ", role_name=" + role_name + ", status=" + status + ", total_spent=" + total_spent + '}';
    }
  

    
    
}
