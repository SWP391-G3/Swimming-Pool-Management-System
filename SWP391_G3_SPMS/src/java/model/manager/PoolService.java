/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.manager;


public class PoolService {
    private int poolServiceId;
    private int poolId;
    private String serviceName;
    private String description;
    private double price;
    private String serviceImage;
    private int quantity;
    private String serviceStatus;

    public PoolService() {}

    public PoolService(int poolServiceId, int poolId, String serviceName, String description, double price, String serviceImage, int quantity, String serviceStatus) {
        this.poolServiceId = poolServiceId;
        this.poolId = poolId;
        this.serviceName = serviceName;
        this.description = description;
        this.price = price;
        this.serviceImage = serviceImage;
        this.quantity = quantity;
        this.serviceStatus = serviceStatus;
    }

    // Getter & Setter
    public int getPoolServiceId() { return poolServiceId; }
    public void setPoolServiceId(int poolServiceId) { this.poolServiceId = poolServiceId; }
    public int getPoolId() { return poolId; }
    public void setPoolId(int poolId) { this.poolId = poolId; }
    public String getServiceName() { return serviceName; }
    public void setServiceName(String serviceName) { this.serviceName = serviceName; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public String getServiceImage() { return serviceImage; }
    public void setServiceImage(String serviceImage) { this.serviceImage = serviceImage; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public String getServiceStatus() { return serviceStatus; }
    public void setServiceStatus(String serviceStatus) { this.serviceStatus = serviceStatus; }
}