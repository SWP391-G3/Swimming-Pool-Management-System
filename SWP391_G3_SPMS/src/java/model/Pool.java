/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;
import java.sql.Time;

/**
 *
 * @author LAZYVL
 */
public class Pool {
    private int poolId;
    private String poolName;
    private String poolRoad;
    private String poolAddress;
    private int maxSlot;
    private Time openTime;
    private Time closeTime;
    private boolean poolStatus;
    private String poolImage;
    private Date createdAt;
    private Date updatedAt;

    public Pool() {
    }

    public Pool(int poolId, String poolName, String poolRoad, String poolAddress, int maxSlot, Time openTime, Time closeTime, boolean poolStatus, String poolImage, Date createdAt, Date updatedAt) {
        this.poolId = poolId;
        this.poolName = poolName;
        this.poolRoad = poolRoad;
        this.poolAddress = poolAddress;
        this.maxSlot = maxSlot;
        this.openTime = openTime;
        this.closeTime = closeTime;
        this.poolStatus = poolStatus;
        this.poolImage = poolImage;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
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

    public String getPoolRoad() {
        return poolRoad;
    }

    public void setPoolRoad(String poolRoad) {
        this.poolRoad = poolRoad;
    }

    public String getPoolAddress() {
        return poolAddress;
    }

    public void setPoolAddress(String poolAddress) {
        this.poolAddress = poolAddress;
    }

    public int getMaxSlot() {
        return maxSlot;
    }

    public void setMaxSlot(int maxSlot) {
        this.maxSlot = maxSlot;
    }

    public Time getOpenTime() {
        return openTime;
    }

    public void setOpenTime(Time openTime) {
        this.openTime = openTime;
    }

    public Time getCloseTime() {
        return closeTime;
    }

    public void setCloseTime(Time closeTime) {
        this.closeTime = closeTime;
    }

    public boolean isPoolStatus() {
        return poolStatus;
    }

    public void setPoolStatus(boolean poolStatus) {
        this.poolStatus = poolStatus;
    }

    public String getPoolImage() {
        return poolImage;
    }

    public void setPoolImage(String poolImage) {
        this.poolImage = poolImage;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Date createdAt) {
        this.createdAt = createdAt;
    }

    public Date getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Date updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    
}
