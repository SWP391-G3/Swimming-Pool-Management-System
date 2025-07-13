/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

/**
 *
 * @author Lenovo
 */
public class DashboardStats {
    
    private int totalUsers;
    private int totalPools;
    private int activePools;
    private int todayBookings;
    private int pendingBookings;
    private double currentRevenue;
    private double previousRevenue;
    private Double revenueChangePercent;    
    private Double userGrowthPercent;

    public DashboardStats() {
    }

    public DashboardStats(int totalUsers, int totalPools, int activePools, int todayBookings, int pendingBookings, double currentRevenue, double previousRevenue, Double revenueChangePercent, Double userGrowthPercent) {
        this.totalUsers = totalUsers;
        this.totalPools = totalPools;
        this.activePools = activePools;
        this.todayBookings = todayBookings;
        this.pendingBookings = pendingBookings;
        this.currentRevenue = currentRevenue;
        this.previousRevenue = previousRevenue;
        this.revenueChangePercent = revenueChangePercent;
        this.userGrowthPercent = userGrowthPercent;
    }

    public int getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(int totalUsers) {
        this.totalUsers = totalUsers;
    }

    public int getTotalPools() {
        return totalPools;
    }

    public void setTotalPools(int totalPools) {
        this.totalPools = totalPools;
    }

    public int getActivePools() {
        return activePools;
    }

    public void setActivePools(int activePools) {
        this.activePools = activePools;
    }

    public int getTodayBookings() {
        return todayBookings;
    }

    public void setTodayBookings(int todayBookings) {
        this.todayBookings = todayBookings;
    }

    public int getPendingBookings() {
        return pendingBookings;
    }

    public void setPendingBookings(int pendingBookings) {
        this.pendingBookings = pendingBookings;
    }

    public double getCurrentRevenue() {
        return currentRevenue;
    }

    public void setCurrentRevenue(double currentRevenue) {
        this.currentRevenue = currentRevenue;
    }

    public double getPreviousRevenue() {
        return previousRevenue;
    }

    public void setPreviousRevenue(double previousRevenue) {
        this.previousRevenue = previousRevenue;
    }

    public Double getRevenueChangePercent() {
        return revenueChangePercent;
    }

    public void setRevenueChangePercent(Double revenueChangePercent) {
        this.revenueChangePercent = revenueChangePercent;
    }

    public Double getUserGrowthPercent() {
        return userGrowthPercent;
    }

    public void setUserGrowthPercent(Double userGrowthPercent) {
        this.userGrowthPercent = userGrowthPercent;
    }

    @Override
    public String toString() {
        return "DashboardStats{" + "totalUsers=" + totalUsers + ", totalPools=" + totalPools + ", activePools=" + activePools + ", todayBookings=" + todayBookings + ", pendingBookings=" + pendingBookings + ", currentRevenue=" + currentRevenue + ", previousRevenue=" + previousRevenue + ", revenueChangePercent=" + revenueChangePercent + ", userGrowthPercent=" + userGrowthPercent + '}';
    }
    
    

    
    
}
