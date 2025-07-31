/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

import java.math.BigDecimal;

/**
 *
 * @author Lenovo
 */
public class RevenueBranchByMonth {
    private int branchId;
    private String branchName;
    private String poolName;
    private String poolAddress;
    private String revenueMonth;
    private BigDecimal totalRevenue;

    public RevenueBranchByMonth() {
    }

    public RevenueBranchByMonth(int branchId, String branchName, String poolName, String poolAddress, String revenueMonth, BigDecimal totalRevenue) {
        this.branchId = branchId;
        this.branchName = branchName;
        this.poolName = poolName;
        this.poolAddress = poolAddress;
        this.revenueMonth = revenueMonth;
        this.totalRevenue = totalRevenue;
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

    public String getPoolName() {
        return poolName;
    }

    public void setPoolName(String poolName) {
        this.poolName = poolName;
    }

    public String getPoolAddress() {
        return poolAddress;
    }

    public void setPoolAddress(String poolAddress) {
        this.poolAddress = poolAddress;
    }

    public String getRevenueMonth() {
        return revenueMonth;
    }

    public void setRevenueMonth(String revenueMonth) {
        this.revenueMonth = revenueMonth;
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    @Override
    public String toString() {
        return "RevenueBranchByMonth{" + "branchId=" + branchId + ", branchName=" + branchName + ", poolName=" + poolName + ", poolAddress=" + poolAddress + ", revenueMonth=" + revenueMonth + ", totalRevenue=" + totalRevenue + '}';
    }
    
    
}
