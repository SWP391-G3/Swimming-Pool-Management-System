/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

/**
 *
 * @author Lenovo
 */
public class ServiceTotalStats {
    private String service_name;
    private int total_quantity;

    public String getService_name() {
        return service_name;
    }

    public void setService_name(String service_name) {
        this.service_name = service_name;
    }

    public int getTotal_quantity() {
        return total_quantity;
    }

    public void setTotal_quantity(int total_quantity) {
        this.total_quantity = total_quantity;
    }

    public ServiceTotalStats() {
    }

    public ServiceTotalStats(String service_name, int total_quantity) {
        this.service_name = service_name;
        this.total_quantity = total_quantity;
    }

    @Override
    public String toString() {
        return "ServiceTotalStats{" + "service_name=" + service_name + ", total_quantity=" + total_quantity + '}';
    }
    
    
}
