/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

/**
 *
 * @author Lenovo
 */

public class UserCountByRole {
    private int admin;
    private int manager;
    private int staff;
    private int customer;

    public UserCountByRole() {
    }

    public UserCountByRole(int admin, int manager, int staff, int customer) {
        this.admin = admin;
        this.manager = manager;
        this.staff = staff;
        this.customer = customer;
    }

    public int getAdmin() {
        return admin;
    }

    public void setAdmin(int admin) {
        this.admin = admin;
    }

    public int getManager() {
        return manager;
    }

    public void setManager(int manager) {
        this.manager = manager;
    }

    public int getStaff() {
        return staff;
    }

    public void setStaff(int staff) {
        this.staff = staff;
    }

    public int getCustomer() {
        return customer;
    }

    public void setCustomer(int customer) {
        this.customer = customer;
    }

    @Override
    public String toString() {
        return "UserCountByRole{" +
                "admin=" + admin +
                ", manager=" + manager +
                ", staff=" + staff +
                ", customer=" + customer +
                '}';
    }
}

