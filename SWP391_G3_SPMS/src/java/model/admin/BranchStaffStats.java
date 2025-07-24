/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

/**
 *
 * @author Lenovo
 */
public class BranchStaffStats {
    private int branch_id;
    private String branch_name;
    private Boolean staff_status;
    private int total_staff;

    public BranchStaffStats() {
    }

    public BranchStaffStats(int branch_id, String branch_name, Boolean staff_status, int total_staff) {
        this.branch_id = branch_id;
        this.branch_name = branch_name;
        this.staff_status = staff_status;
        this.total_staff = total_staff;
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

    public Boolean getStaff_status() {
        return staff_status;
    }

    public void setStaff_status(Boolean staff_status) {
        this.staff_status = staff_status;
    }

    public int getTotal_staff() {
        return total_staff;
    }

    public void setTotal_staff(int total_staff) {
        this.total_staff = total_staff;
    }

    @Override
    public String toString() {
        return "BranchStaffStats{" + "branch_id=" + branch_id + ", branch_name=" + branch_name + ", staff_status=" + staff_status + ", total_staff=" + total_staff + '}';
    }
    
    
}
