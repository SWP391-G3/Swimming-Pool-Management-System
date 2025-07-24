/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

/**
 *
 * @author Lenovo
 */
public class PoolStatusStats {
    private int status_1;
    private int status_0;
    private int total_active;
    private int total_inactive;

    public PoolStatusStats() {
    }

    public PoolStatusStats(int status_1, int status_0, int total_active, int total_inactive) {
        this.status_1 = status_1;
        this.status_0 = status_0;
        this.total_active = total_active;
        this.total_inactive = total_inactive;
    }
    
    

    public int getStatus_1() {
        return status_1;
    }

    public void setStatus_1(int status_1) {
        this.status_1 = status_1;
    }

    public int getStatus_0() {
        return status_0;
    }

    public void setStatus_0(int status_0) {
        this.status_0 = status_0;
    }

    public int getTotal_active() {
        return total_active;
    }

    public void setTotal_active(int total_active) {
        this.total_active = total_active;
    }

    public int getTotal_inactive() {
        return total_inactive;
    }

    public void setTotal_inactive(int total_inactive) {
        this.total_inactive = total_inactive;
    }

    @Override
    public String toString() {
        return "PoolStatusStats{" + "status_1=" + status_1 + ", status_0=" + status_0 + ", total_active=" + total_active + ", total_inactive=" + total_inactive + '}';
    }
    
    
}
