/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

/**
 *
 * @author Lenovo
 */
public class UserDetails {
    private int totalAdmin;
    private int totalManager;
    private int totalStaff;
    private int totalCustomer;

    public UserDetails(int totalAdmin, int totalManager, int totalStaff, int totalCustomer) {
        this.totalAdmin = totalAdmin;
        this.totalManager = totalManager;
        this.totalStaff = totalStaff;
        this.totalCustomer = totalCustomer;
    }

    public int getTotalAdmin() {
        return totalAdmin;
    }

    public void setTotalAdmin(int totalAdmin) {
        this.totalAdmin = totalAdmin;
    }

    public int getTotalManager() {
        return totalManager;
    }

    public void setTotalManager(int totalManager) {
        this.totalManager = totalManager;
    }

    public int getTotalStaff() {
        return totalStaff;
    }

    public void setTotalStaff(int totalStaff) {
        this.totalStaff = totalStaff;
    }

    public int getTotalCustomer() {
        return totalCustomer;
    }

    public void setTotalCustomer(int totalCustomer) {
        this.totalCustomer = totalCustomer;
    }

    @Override
    public String toString() {
        return "UserDetails{" + "totalAdmin=" + totalAdmin + ", totalManager=" + totalManager + ", totalStaff=" + totalStaff + ", totalCustomer=" + totalCustomer + '}';
    }
    
    
}
