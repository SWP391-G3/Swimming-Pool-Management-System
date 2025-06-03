/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.manager;

import java.util.List;

/**
 *
 * @author Tuan Anh
 */
public class Branch {

    private int branchId;
    private String branchName;
    private int managerId;
    private List<Pool> pools; // mỗi chi nhánh có các hồ bơi

    public Branch() {
    }

    public Branch(int branchId, String branchName, int managerId, List<Pool> pools) {
        this.branchId = branchId;
        this.branchName = branchName;
        this.managerId = managerId;
        this.pools = pools;
    }

    // getter/setter các trường
    public int getBranchId() {
        return branchId;
    }

    public void setBranchId(int branchId) {
        this.branchId = branchId;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public int getManagerId() {
        return managerId;
    }

    public void setManagerId(int managerId) {
        this.managerId = managerId;
    }

    public List<Pool> getPools() {
        return pools;
    }

    public void setPools(List<Pool> pools) {
        this.pools = pools;
    }

    @Override
    public String toString() {
        return "Branch{"
                + "branchId=" + branchId
                + ", branchName='" + branchName + '\''
                + ", managerId=" + managerId
                + ", pools=" + pools
                + '}';
    }
}
