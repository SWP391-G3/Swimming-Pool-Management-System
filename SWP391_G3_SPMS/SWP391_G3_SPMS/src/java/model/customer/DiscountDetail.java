package model.customer;

import java.math.BigDecimal;
import java.time.LocalDateTime;
/**
 *
 * @author LAZYVL
 */
public class DiscountDetail {

    private int discountId;
    private int userId;
    private String discountCode;
    private String description;
    private BigDecimal discountPercent;
    private Integer quantity; // tổng số lượng voucher
    private LocalDateTime validFrom;
    private LocalDateTime validTo;
    private boolean status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private Boolean usedDiscount;
    private Double usedPercent;

    public DiscountDetail() {
    }

    public DiscountDetail(int discountId, int userId, String discountCode, String description, BigDecimal discountPercent, Integer quantity, LocalDateTime validFrom, LocalDateTime validTo, boolean status, LocalDateTime createdAt, LocalDateTime updatedAt, Boolean usedDiscount, Double usedPercent) {
        this.discountId = discountId;
        this.userId = userId;
        this.discountCode = discountCode;
        this.description = description;
        this.discountPercent = discountPercent;
        this.quantity = quantity;
        this.validFrom = validFrom;
        this.validTo = validTo;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.usedDiscount = usedDiscount;
        this.usedPercent = usedPercent;
    }

    // Các constructor cũ nếu cần
    public DiscountDetail(int discountId, int userId, String discountCode, String description, BigDecimal discountPercent, LocalDateTime validFrom, LocalDateTime validTo, boolean status, LocalDateTime createdAt, LocalDateTime updatedAt) {
        this.discountId = discountId;
        this.userId = userId;
        this.discountCode = discountCode;
        this.description = description;
        this.discountPercent = discountPercent;
        this.validFrom = validFrom;
        this.validTo = validTo;
        this.status = status;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public DiscountDetail(int discountId, int userId, String discountCode, String description, BigDecimal discountPercent, LocalDateTime validFrom, LocalDateTime validTo, boolean status) {
        this.discountId = discountId;
        this.userId = userId;
        this.discountCode = discountCode;
        this.description = description;
        this.discountPercent = discountPercent;
        this.validFrom = validFrom;
        this.validTo = validTo;
        this.status = status;
    }

    public int getDiscountId() {
        return discountId;
    }

    public void setDiscountId(int discountId) {
        this.discountId = discountId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getDiscountCode() {
        return discountCode;
    }

    public void setDiscountCode(String discountCode) {
        this.discountCode = discountCode;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getDiscountPercent() {
        return discountPercent;
    }

    public void setDiscountPercent(BigDecimal discountPercent) {
        this.discountPercent = discountPercent;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
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

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public Boolean getUsedDiscount() {
        return usedDiscount;
    }

    public void setUsedDiscount(Boolean usedDiscount) {
        this.usedDiscount = usedDiscount;
    }

    public Double getUsedPercent() {
        return usedPercent;
    }

    public void setUsedPercent(Double usedPercent) {
        this.usedPercent = usedPercent;
    }
}