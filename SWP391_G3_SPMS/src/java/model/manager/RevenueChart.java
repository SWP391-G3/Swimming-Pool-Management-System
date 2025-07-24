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
public class RevenueChart {
    
    
    private String label;
    private BigDecimal value;
    private String category;
    private String color;
    private String period;
    private double percentage;
    
    // Constructors
    public RevenueChart() {}
    
    public RevenueChart(String label, BigDecimal value, String category) {
        this.label = label;
        this.value = value;
        this.category = category;
    }
    
    // Getters and Setters
    public String getLabel() { return label; }
    public void setLabel(String label) { this.label = label; }
    
    public BigDecimal getValue() { return value; }
    public void setValue(BigDecimal value) { this.value = value; }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    
    public String getColor() { return color; }
    public void setColor(String color) { this.color = color; }
    
    public String getPeriod() { return period; }
    public void setPeriod(String period) { this.period = period; }
    
    public double getPercentage() { return percentage; }
    public void setPercentage(double percentage) { this.percentage = percentage; }
    
    
}
