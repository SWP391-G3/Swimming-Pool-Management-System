/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

/**
 *
 * @author Lenovo
 */
public class CustomerJoinStats {
    private int tota_customer;
    private int average_feedking;
    private int total_service_today;

    public CustomerJoinStats() {
    }

    public CustomerJoinStats(int tota_customer, int average_feedking, int total_service_today) {
        this.tota_customer = tota_customer;
        this.average_feedking = average_feedking;
        this.total_service_today = total_service_today;
    }

    public int getTota_customer() {
        return tota_customer;
    }

    public void setTota_customer(int tota_customer) {
        this.tota_customer = tota_customer;
    }

    public int getAverage_feedking() {
        return average_feedking;
    }

    public void setAverage_feedking(int average_feedking) {
        this.average_feedking = average_feedking;
    }

    public int getTotal_service_today() {
        return total_service_today;
    }

    public void setTotal_service_today(int total_service_today) {
        this.total_service_today = total_service_today;
    }

    @Override
    public String toString() {
        return "CustomerJoinStats{" + "tota_customer=" + tota_customer + ", average_feedking=" + average_feedking + ", total_service_today=" + total_service_today + '}';
    }
    
    
            
}
