/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.Date;

/**
 *
 * @author Lenovo
 */
public class User {
    private int user_id;
    private String username;
    private String password;
    private String full_name;
    private String email;
    private String phone;
    private String address;
    private int role_id;
    private boolean status;
    private LocalDate create_at;
    private LocalDate update_at;

    public User(int user_id, String username, String password, String full_name, String email, String phone, String address, int role_id, boolean status, LocalDate create_at, LocalDate update_at) {
        this.user_id = user_id;
        this.username = username;
        this.password = password;
        this.full_name = full_name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.role_id = role_id;
        this.status = status;
        this.create_at = create_at;
        this.update_at = update_at;
    }

    public User(String username, String password, String full_name, String email, String phone, String address, int role_id, boolean status, LocalDate create_at) {
        this.username = username;
        this.password = password;
        this.full_name = full_name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.role_id = role_id;
        this.status = status;
        this.create_at = create_at;
    }

   

   
  
    public int getUser_id() {
        return user_id;
    }

    public void setUser_id(int user_id) {
        this.user_id = user_id;
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

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public LocalDate getCreate_at() {
        return create_at;
    }

    public void setCreate_at(LocalDate create_at) {
        this.create_at = create_at;
    }

    public LocalDate getUpdate_at() {
        return update_at;
    }

    public void setUpdate_at(LocalDate update_at) {
        this.update_at = update_at;
    }
    
    
}
