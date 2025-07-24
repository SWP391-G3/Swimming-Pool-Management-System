/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.manager;

import java.math.BigDecimal;
import java.util.Date;

/**
 *
 * @author Tuan Anh
 */
public class DashboardStats {
    
    
    private int branchId;
    private String branchName;
    private BigDecimal totalRevenue;
    private int totalBookings;
    private int totalCustomers;
    private int totalPools;
    private BigDecimal avgRating;
    private Date reportDate;
    private String period;
    private BigDecimal previousRevenue;
    private int previousBookings;
    private int previousCustomers;
    private BigDecimal revenueGrowth;
    private BigDecimal bookingGrowth;
    private BigDecimal customerGrowth;
    
    // Constructors
    public DashboardStats() {}
    
    // Getters and Setters
    public int getBranchId() { return branchId; }
    public void setBranchId(int branchId) { this.branchId = branchId; }
    
    public String getBranchName() { return branchName; }
    public void setBranchName(String branchName) { this.branchName = branchName; }
    
    public BigDecimal getTotalRevenue() { return totalRevenue; }
    public void setTotalRevenue(BigDecimal totalRevenue) { this.totalRevenue = totalRevenue; }
    
    public int getTotalBookings() { return totalBookings; }
    public void setTotalBookings(int totalBookings) { this.totalBookings = totalBookings; }
    
    public int getTotalCustomers() { return totalCustomers; }
    public void setTotalCustomers(int totalCustomers) { this.totalCustomers = totalCustomers; }
    
    public int getTotalPools() { return totalPools; }
    public void setTotalPools(int totalPools) { this.totalPools = totalPools; }
    
    public BigDecimal getAvgRating() { return avgRating; }
    public void setAvgRating(BigDecimal avgRating) { this.avgRating = avgRating; }
    
    public Date getReportDate() { return reportDate; }
    public void setReportDate(Date reportDate) { this.reportDate = reportDate; }
    
    public String getPeriod() { return period; }
    public void setPeriod(String period) { this.period = period; }
    
    public BigDecimal getPreviousRevenue() { return previousRevenue; }
    public void setPreviousRevenue(BigDecimal previousRevenue) { this.previousRevenue = previousRevenue; }
    
    public int getPreviousBookings() { return previousBookings; }
    public void setPreviousBookings(int previousBookings) { this.previousBookings = previousBookings; }
    
    public int getPreviousCustomers() { return previousCustomers; }
    public void setPreviousCustomers(int previousCustomers) { this.previousCustomers = previousCustomers; }
    
    public BigDecimal getRevenueGrowth() { return revenueGrowth; }
    public void setRevenueGrowth(BigDecimal revenueGrowth) { this.revenueGrowth = revenueGrowth; }
    
    public BigDecimal getBookingGrowth() { return bookingGrowth; }
    public void setBookingGrowth(BigDecimal bookingGrowth) { this.bookingGrowth = bookingGrowth; }
    
    public BigDecimal getCustomerGrowth() { return customerGrowth; }
    public void setCustomerGrowth(BigDecimal customerGrowth) { this.customerGrowth = customerGrowth; }
    
    
    
}
