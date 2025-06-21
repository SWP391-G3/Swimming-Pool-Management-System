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
    private List<Pooldevice> pools; 

    public Branch() {
    }

    public Branch(int branchId, String branchName, int managerId, List<Pooldevice> pools) {
        this.branchId = branchId;
        this.branchName = branchName;
        this.managerId = managerId;
        this.pools = pools;
    }

    
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

    public List<Pooldevice> getPools() {
        return pools;
    }

    public void setPools(List<Pooldevice> pools) {
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
