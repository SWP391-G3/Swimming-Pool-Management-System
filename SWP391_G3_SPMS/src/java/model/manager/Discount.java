/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.manager;

import java.util.Date;

/**
 *
 * @author Tuan Anh
 */
public class Discount {

    private int id;
    private String code;
    private String description;
    private double percent;
    private int quantity;
    private Date validFrom;
    private Date validTo;
    private boolean status;
    private Date createdAt;
    private Date updatedAt;
    private String createdByUsername;
    private String createdByFullName;
    private String createdByEmail;

    public Discount() {
    }

    public Discount(int id, String code, String description, double percent, int quantity, Date validFrom, Date validTo, boolean status, Date createdAt, Date updatedAt, String createdByUsername, String createdByFullName, String createdByEmail) {
        this.id = id;
        this.code = code;
        this.description = description;
        this.percent = percent;
        this.quantity = quantity;
        this.validFrom = validFrom;
        this.validTo = validTo;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.createdByUsername = createdByUsername;
        this.createdByFullName = createdByFullName;
        this.createdByEmail = createdByEmail;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPercent() {
        return percent;
    }

    public void setPercent(double percent) {
        this.percent = percent;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Date getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(Date validFrom) {
        this.validFrom = validFrom;
    }

    public Date getValidTo() {
        return validTo;
    }

    public void setValidTo(Date validTo) {
        this.validTo = validTo;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
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

    public String getCreatedByUsername() {
        return createdByUsername;
    }

    public void setCreatedByUsername(String createdByUsername) {
        this.createdByUsername = createdByUsername;
    }

    public String getCreatedByFullName() {
        return createdByFullName;
    }

    public void setCreatedByFullName(String createdByFullName) {
        this.createdByFullName = createdByFullName;
    }

    public String getCreatedByEmail() {
        return createdByEmail;
    }

    public void setCreatedByEmail(String createdByEmail) {
        this.createdByEmail = createdByEmail;
    }

    @Override
    public String toString() {
        return "Discount{" + "id=" + id + ", code=" + code + ", description=" + description + ", percent=" + percent + ", quantity=" + quantity + ", validFrom=" + validFrom + ", validTo=" + validTo + ", status=" + status + ", createdAt=" + createdAt + ", updatedAt=" + updatedAt + ", createdByUsername=" + createdByUsername + ", createdByFullName=" + createdByFullName + ", createdByEmail=" + createdByEmail + '}';
    }
}