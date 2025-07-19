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
public class PaymentRentItem {

    private int paymentRentId;
    private int paymentId;
    private int serviceId;
    private BigDecimal amount;
    private int quantity;

    public PaymentRentItem() {
    }

    public PaymentRentItem(int paymentRentId, int paymentId, int serviceId, BigDecimal amount, int quantity) {
        this.paymentRentId = paymentRentId;
        this.paymentId = paymentId;
        this.serviceId = serviceId;
        this.amount = amount;
        this.quantity = quantity;
    }

    public int getPaymentRentId() {
        return paymentRentId;
    }

    public void setPaymentRentId(int paymentRentId) {
        this.paymentRentId = paymentRentId;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "PaymentRentItem{"
                + "paymentRentId=" + paymentRentId
                + ", paymentId=" + paymentId
                + ", serviceId=" + serviceId
                + ", amount=" + amount
                + ", quantity=" + quantity
                + '}';
    }
}
