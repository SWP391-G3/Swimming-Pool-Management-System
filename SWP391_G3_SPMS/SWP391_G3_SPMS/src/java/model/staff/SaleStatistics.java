/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.staff;

import java.math.BigDecimal;

/**
 *
 * @author LAZYVL
 */
public class SaleStatistics {

    private int totalTransactions;
    private BigDecimal totalRevenue;
    private BigDecimal avgTransactionValue;
    private BigDecimal maxTransactionValue;
    private BigDecimal minTransactionValue;

    public SaleStatistics() {
        this.totalTransactions = 0;
        this.totalRevenue = BigDecimal.ZERO;
        this.avgTransactionValue = BigDecimal.ZERO;
        this.maxTransactionValue = BigDecimal.ZERO;
        this.minTransactionValue = BigDecimal.ZERO;
    }

    // Getters và Setters
    public int getTotalTransactions() {
        return totalTransactions;
    }

    public void setTotalTransactions(int totalTransactions) {
        this.totalTransactions = totalTransactions;
    }

    public BigDecimal getTotalRevenue() {
        return totalRevenue;
    }

    public void setTotalRevenue(BigDecimal totalRevenue) {
        this.totalRevenue = totalRevenue;
    }

    public BigDecimal getAvgTransactionValue() {
        return avgTransactionValue;
    }

    public void setAvgTransactionValue(BigDecimal avgTransactionValue) {
        this.avgTransactionValue = avgTransactionValue;
    }

    public BigDecimal getMaxTransactionValue() {
        return maxTransactionValue;
    }

    public void setMaxTransactionValue(BigDecimal maxTransactionValue) {
        this.maxTransactionValue = maxTransactionValue;
    }

    public BigDecimal getMinTransactionValue() {
        return minTransactionValue;
    }

    public void setMinTransactionValue(BigDecimal minTransactionValue) {
        this.minTransactionValue = minTransactionValue;
    }
}
