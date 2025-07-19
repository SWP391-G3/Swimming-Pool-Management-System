/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

/**
 *
 * @author Lenovo
 */


public class DeviceStatusStats {

    private int availableCount;
    private int maintenanceCount;
    private int brokenCount;

    public DeviceStatusStats() {
    }

    public DeviceStatusStats(int availableCount, int maintenanceCount, int brokenCount) {
        this.availableCount = availableCount;
        this.maintenanceCount = maintenanceCount;
        this.brokenCount = brokenCount;
    }

    public int getAvailableCount() {
        return availableCount;
    }

    public void setAvailableCount(int availableCount) {
        this.availableCount = availableCount;
    }

    public int getMaintenanceCount() {
        return maintenanceCount;
    }

    public void setMaintenanceCount(int maintenanceCount) {
        this.maintenanceCount = maintenanceCount;
    }

    public int getBrokenCount() {
        return brokenCount;
    }

    public void setBrokenCount(int brokenCount) {
        this.brokenCount = brokenCount;
    }

    @Override
    public String toString() {
        return "DeviceStatusStats{"
                + "availableCount=" + availableCount
                + ", maintenanceCount=" + maintenanceCount
                + ", brokenCount=" + brokenCount
                + '}';
    }
}
