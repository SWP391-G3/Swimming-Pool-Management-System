/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.manager;

import java.math.BigDecimal;

/**
 *
 * @author Tuan Anh
 */
public class PoolStats {
    
    
    private int poolId;
    private String poolName;
    private String poolAddress;
    private int maxSlot;
    private BigDecimal revenue;
    private int totalBookings;
    private int totalCustomers;
    private BigDecimal avgRating;
    private double utilizationRate;
    private String status;
    private String openTime;
    private String closeTime;
    private String poolImage;
    private String poolDescription;
    
    // Constructors
    public PoolStats() {}
    
    // Getters and Setters
    public int getPoolId() { return poolId; }
    public void setPoolId(int poolId) { this.poolId = poolId; }
    
    public String getPoolName() { return poolName; }
    public void setPoolName(String poolName) { this.poolName = poolName; }
    
    public String getPoolAddress() { return poolAddress; }
    public void setPoolAddress(String poolAddress) { this.poolAddress = poolAddress; }
    
    public int getMaxSlot() { return maxSlot; }
    public void setMaxSlot(int maxSlot) { this.maxSlot = maxSlot; }
    
    public BigDecimal getRevenue() { return revenue; }
    public void setRevenue(BigDecimal revenue) { this.revenue = revenue; }
    
    public int getTotalBookings() { return totalBookings; }
    public void setTotalBookings(int totalBookings) { this.totalBookings = totalBookings; }
    
    public int getTotalCustomers() { return totalCustomers; }
    public void setTotalCustomers(int totalCustomers) { this.totalCustomers = totalCustomers; }
    
    public BigDecimal getAvgRating() { return avgRating; }
    public void setAvgRating(BigDecimal avgRating) { this.avgRating = avgRating; }
    
    public double getUtilizationRate() { return utilizationRate; }
    public void setUtilizationRate(double utilizationRate) { this.utilizationRate = utilizationRate; }
    
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    
    public String getOpenTime() { return openTime; }
    public void setOpenTime(String openTime) { this.openTime = openTime; }
    
    public String getCloseTime() { return closeTime; }
    public void setCloseTime(String closeTime) { this.closeTime = closeTime; }
    
    public String getPoolImage() { return poolImage; }
    public void setPoolImage(String poolImage) { this.poolImage = poolImage; }
    
    public String getPoolDescription() { return poolDescription; }
    public void setPoolDescription(String poolDescription) { this.poolDescription = poolDescription; }
    
    
    
}
