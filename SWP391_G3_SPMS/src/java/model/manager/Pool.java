/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.manager;

/**
 *
 * @author Tuan Anh
 */
public class Pool {

    public int poolId;
    public String poolName;

    public Pool() {
    }

    public Pool(int poolId, String poolName) {
        this.poolId = poolId;
        this.poolName = poolName;
    }

    public int getPoolId() {
        return poolId;
    }

    public void setPoolId(int poolId) {
        this.poolId = poolId;
    }

    public String getPoolName() {
        return poolName;
    }

    public void setPoolName(String poolName) {
        this.poolName = poolName;
    }

    @Override
    public String toString() {
        return "Pool{" + "poolId=" + poolId + ", poolName=" + poolName + '}';
    }
}
