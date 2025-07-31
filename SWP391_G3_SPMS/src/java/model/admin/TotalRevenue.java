/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

/**
 *
 * @author Lenovo
 */
public class TotalRevenue {
    private String branch_name;
    private double total_revenue;

    public TotalRevenue() {
    }

    public TotalRevenue(String branch_name, double total_revenue) {
        this.branch_name = branch_name;
        this.total_revenue = total_revenue;
    }

    public String getBranch_name() {
        return branch_name;
    }

    public void setBranch_name(String branch_name) {
        this.branch_name = branch_name;
    }

    public double getTotal_revenue() {
        return total_revenue;
    }

    public void setTotal_revenue(double total_revenue) {
        this.total_revenue = total_revenue;
    }

    @Override
    public String toString() {
        return "TotalRevenue{" + "branch_name=" + branch_name + ", total_revenue=" + total_revenue + '}';
    }
    
    
}
