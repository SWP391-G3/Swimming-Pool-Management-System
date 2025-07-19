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
public class TicketType {

    private int id;
    private String code;
    private String name;
    private String description;
    private double basePrice;
    private boolean isCombo;
    private java.sql.Timestamp createdAt;
    private boolean active;
    private List<String> pools; // Tên các hồ bơi áp dụng
    private Double discountPercent;

    public TicketType() {
    }

    public TicketType(int id, String code, String name, String description, double basePrice, boolean isCombo, boolean active, List<String> pools) {
        this.id = id;
        this.code = code;
        this.name = name;
        this.description = description;
        this.basePrice = basePrice;
        this.isCombo = isCombo;
        this.active = active;
        this.pools = pools;
    }

    // 2 tiếng fixx
    public Double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(Double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(double basePrice) {
        this.basePrice = basePrice;
    }

    public boolean isIsCombo() {
        return isCombo;
    }

    public void setIsCombo(boolean isCombo) {
        this.isCombo = isCombo;
    }

    public java.sql.Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(java.sql.Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public boolean isActive() {
        return active;
    }

    public void setActive(boolean active) {
        this.active = active;
    }

    public List<String> getPools() {
        return pools;
    }

    public void setPools(List<String> pools) {
        this.pools = pools;
    }

}
