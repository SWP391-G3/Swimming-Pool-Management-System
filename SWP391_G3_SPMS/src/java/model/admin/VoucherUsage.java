/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

import java.time.LocalDateTime;

/**
 *
 * @author Lenovo
 */
public class VoucherUsage {

    private String discountCode;
    private String voucherName;
    private double discountPercent;
    private int usageCount;
    private LocalDateTime validFrom;
    private LocalDateTime validTo;

    public VoucherUsage() {
    }

    public VoucherUsage(String discountCode, String voucherName, double discountPercent, int usageCount, LocalDateTime validFrom, LocalDateTime validTo) {
        this.discountCode = discountCode;
        this.voucherName = voucherName;
        this.discountPercent = discountPercent;
        this.usageCount = usageCount;
        this.validFrom = validFrom;
        this.validTo = validTo;
    }

    public String getDiscountCode() {
        return discountCode;
    }

    public void setDiscountCode(String discountCode) {
        this.discountCode = discountCode;
    }

    public String getVoucherName() {
        return voucherName;
    }

    public void setVoucherName(String voucherName) {
        this.voucherName = voucherName;
    }

    public double getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(double discountPercent) {
        this.discountPercent = discountPercent;
    }

    public int getUsageCount() {
        return usageCount;
    }

    public void setUsageCount(int usageCount) {
        this.usageCount = usageCount;
    }

    public LocalDateTime getValidFrom() {
        return validFrom;
    }

    public void setValidFrom(LocalDateTime validFrom) {
        this.validFrom = validFrom;
    }

    public LocalDateTime getValidTo() {
        return validTo;
    }

    public void setValidTo(LocalDateTime validTo) {
        this.validTo = validTo;
    }

    @Override
    public String toString() {
        return "VoucherUsage{" + "discountCode=" + discountCode + ", voucherName=" + voucherName + ", discountPercent=" + discountPercent + ", usageCount=" + usageCount + ", validFrom=" + validFrom + ", validTo=" + validTo + '}';
    }
    
    
}
