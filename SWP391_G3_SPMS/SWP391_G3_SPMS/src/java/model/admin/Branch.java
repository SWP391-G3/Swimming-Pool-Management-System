/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

/**
 *
 * @author Lenovo
 */
public class Branch {
    private int branch_id;
    private String branch_name;
    private int manager_id;

    public Branch() {
    }

    public Branch(int branch_id, String branch_name, int manager_id) {
        this.branch_id = branch_id;
        this.branch_name = branch_name;
        this.manager_id = manager_id;
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

    public int getManager_id() {
        return manager_id;
    }

    public void setManager_id(int manager_id) {
        this.manager_id = manager_id;
    }

    @Override
    public String toString() {
        return "Branch{" + "branch_id=" + branch_id + ", branch_name=" + branch_name + ", manager_id=" + manager_id + '}';
    }
    
    
}
