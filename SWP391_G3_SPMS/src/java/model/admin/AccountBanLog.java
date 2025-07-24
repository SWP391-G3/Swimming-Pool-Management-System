/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

import java.security.Timestamp;

/**
 *
 * @author Lenovo
 */
public class AccountBanLog {

    private int banId;
    private int userId;
    private int bannedBy;
    private String reason;
    private boolean isPermanent;
    private Timestamp createdAt;

    public AccountBanLog() {
    }

    public AccountBanLog(int banId, int userId, int bannedBy, String reason, boolean isPermanent, Timestamp createdAt) {
        this.banId = banId;
        this.userId = userId;
        this.bannedBy = bannedBy;
        this.reason = reason;
        this.isPermanent = isPermanent;
        this.createdAt = createdAt;
    }

    public int getBanId() {
        return banId;
    }

    public void setBanId(int banId) {
        this.banId = banId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getBannedBy() {
        return bannedBy;
    }

    public void setBannedBy(int bannedBy) {
        this.bannedBy = bannedBy;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public boolean isIsPermanent() {
        return isPermanent;
    }

    public void setIsPermanent(boolean isPermanent) {
        this.isPermanent = isPermanent;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    @Override
    public String toString() {
        return "CustomerBanLog{" + "banId=" + banId + ", userId=" + userId + ", bannedBy=" + bannedBy + ", reason=" + reason + ", isPermanent=" + isPermanent + ", createdAt=" + createdAt + '}';
    }
    
    
}
