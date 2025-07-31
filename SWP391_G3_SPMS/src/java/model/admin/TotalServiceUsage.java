/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

/**
 *
 * @author Lenovo
 */
public class TotalServiceUsage {
    private String service_name;
    private int total_usage;

    public TotalServiceUsage() {
    }

    public TotalServiceUsage(String service_name, int total_usage) {
        this.service_name = service_name;
        this.total_usage = total_usage;
    }

    public String getService_name() {
        return service_name;
    }

    public void setService_name(String service_name) {
        this.service_name = service_name;
    }

    public int getTotal_usage() {
        return total_usage;
    }

    public void setTotal_usage(int total_usage) {
        this.total_usage = total_usage;
    }

    @Override
    public String toString() {
        return "TotalServiceUsage{" + "service_name=" + service_name + ", total_usage=" + total_usage + '}';
    }
    
    
}
