/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.customer;

import java.math.BigDecimal;
/**
 *
 * @author LAZYVL
 */
public class PoolService {

    private int poolServiceId;
    private int poolId;
    private String serviceName;
    private String description;
    private BigDecimal price;
    private String serviceImage;
    private int quantity;
    private String serviceStatus; // 'available', 'broken', 'maintenance'

    public PoolService() {
    }

    public PoolService(int poolServiceId, int poolId, String serviceName, String description, BigDecimal price,
            String serviceImage, int quantity, String serviceStatus) {
        this.poolServiceId = poolServiceId;
        this.poolId = poolId;
        this.serviceName = serviceName;
        this.description = description;
        this.price = price;
        this.serviceImage = serviceImage;
        this.quantity = quantity;
        this.serviceStatus = serviceStatus;
    }

    public int getPoolServiceId() {
        return poolServiceId;
    }

    public void setPoolServiceId(int poolServiceId) {
        this.poolServiceId = poolServiceId;
    }

    public int getPoolId() {
        return poolId;
    }

    public void setPoolId(int poolId) {
        this.poolId = poolId;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public String getServiceImage() {
        return serviceImage;
    }

    public void setServiceImage(String serviceImage) {
        this.serviceImage = serviceImage;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getServiceStatus() {
        return serviceStatus;
    }

    public void setServiceStatus(String serviceStatus) {
        this.serviceStatus = serviceStatus;
    }

    @Override
    public String toString() {
        return "PoolService{"
                + "poolServiceId=" + poolServiceId
                + ", poolId=" + poolId
                + ", serviceName='" + serviceName + '\''
                + ", description='" + description + '\''
                + ", price=" + price
                + ", serviceImage='" + serviceImage + '\''
                + ", quantity=" + quantity
                + ", serviceStatus='" + serviceStatus + '\''
                + '}';
    }
}
