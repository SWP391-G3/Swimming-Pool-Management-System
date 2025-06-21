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
public class Pooldevice {

    private int poolId;
    private String poolName;
    private int branchId; 
    private List<Device> devices; 

    public Pooldevice() {}

    public Pooldevice(int poolId, String poolName) {
        this.poolId = poolId;
        this.poolName = poolName;
    }

    
    
    
    public Pooldevice(int poolId, String poolName, int branchId, List<Device> devices) {
        this.poolId = poolId;
        this.poolName = poolName;
        this.branchId = branchId;
        this.devices = devices;
    }

    // getter/setter
    public int getPoolId() { return poolId; }
    public void setPoolId(int poolId) { this.poolId = poolId; }
    public String getPoolName() { return poolName; }
    public void setPoolName(String poolName) { this.poolName = poolName; }
    public int getBranchId() { return branchId; }
    public void setBranchId(int branchId) { this.branchId = branchId; }
    public List<Device> getDevices() { return devices; }
    public void setDevices(List<Device> devices) { this.devices = devices; }

    @Override
    public String toString() {
        return "Pool{" +
                "poolId=" + poolId +
                ", poolName='" + poolName + '\'' +
                ", branchId=" + branchId +
                ", devices=" + devices +
                '}';
    }
}
