/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

import dao.admin.*;
import java.time.LocalDate;

/**
 *
 * @author Lenovo
 */
public class Manager {
    private int manager_id;
    private String full_name;
    private String email;
    private String phone;
    private String address;
    private Boolean status;
    private LocalDate create_at;
    private int branch_id;
    private String branch_name;

    public Manager(int manager_id, String full_name, String email, String phone, String address, Boolean status, LocalDate create_at, int branch_id, String branch_name) {
        this.manager_id = manager_id;
        this.full_name = full_name;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.status = status;
        this.create_at = create_at;
        this.branch_id = branch_id;
        this.branch_name = branch_name;
    }

    public int getManager_id() {
        return manager_id;
    }

    public void setManager_id(int manager_id) {
        this.manager_id = manager_id;
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

    public Boolean getStatus() {
        return status;
    }

    public void setStatus(Boolean status) {
        this.status = status;
    }

    public LocalDate getCreate_at() {
        return create_at;
    }

    public void setCreate_at(LocalDate create_at) {
        this.create_at = create_at;
    }

    public int getBranch_id() {
        return branch_id;
    }

    public void setBranch_id(int branch_id) {
        this.branch_id = branch_id;
    }

    public String getBranch_name() {
        return branch_name;
    }

    public void setBranch_name(String branch_name) {
        this.branch_name = branch_name;
    }

    @Override
    public String toString() {
        return "Manager{" + "manager_id=" + manager_id + ", full_name=" + full_name + ", email=" + email + ", phone=" + phone + ", address=" + address + ", status=" + status + ", create_at=" + create_at + ", branch_id=" + branch_id + ", branch_name=" + branch_name + '}';
    }
    
    
}
