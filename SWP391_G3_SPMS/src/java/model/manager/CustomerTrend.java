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
public class CustomerTrend {
    
    private Date date;
    private int newCustomers;
    private int returningCustomers;
    private int totalCustomers;
    private BigDecimal avgSpending;
    private double retentionRate;
    private String period;
    private int branchId;
    private String periodLabel;
    
    // Constructors
    public CustomerTrend() {}
    
    // Getters and Setters
    public Date getDate() { return date; }
    public void setDate(Date date) { this.date = date; }
    
    public int getNewCustomers() { return newCustomers; }
    public void setNewCustomers(int newCustomers) { this.newCustomers = newCustomers; }
    
    public int getReturningCustomers() { return returningCustomers; }
    public void setReturningCustomers(int returningCustomers) { this.returningCustomers = returningCustomers; }
    
    public int getTotalCustomers() { return totalCustomers; }
    public void setTotalCustomers(int totalCustomers) { this.totalCustomers = totalCustomers; }
    
    public BigDecimal getAvgSpending() { return avgSpending; }
    public void setAvgSpending(BigDecimal avgSpending) { this.avgSpending = avgSpending; }
    
    public double getRetentionRate() { return retentionRate; }
    public void setRetentionRate(double retentionRate) { this.retentionRate = retentionRate; }
    
    public String getPeriod() { return period; }
    public void setPeriod(String period) { this.period = period; }
    
    public int getBranchId() { return branchId; }
    public void setBranchId(int branchId) { this.branchId = branchId; }
    
    public String getPeriodLabel() { return periodLabel; }
    public void setPeriodLabel(String periodLabel) { this.periodLabel = periodLabel; }
    
    
}
