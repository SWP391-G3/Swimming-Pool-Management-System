/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.customer;

import java.math.BigDecimal;

public class PoolServiceSelection {

    private int poolServiceId;
    private String serviceName;
    private BigDecimal price;
    private int quantity;

    public PoolServiceSelection() {
    }

    public PoolServiceSelection(int poolServiceId, String serviceName, BigDecimal price, int quantity) {
        this.poolServiceId = poolServiceId;
        this.serviceName = serviceName;
        this.price = price;
        this.quantity = quantity;
    }

    public int getPoolServiceId() {
        return poolServiceId;
    }

    public void setPoolServiceId(int poolServiceId) {
        this.poolServiceId = poolServiceId;
    }

    public String getServiceName() {
        return serviceName;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
}
