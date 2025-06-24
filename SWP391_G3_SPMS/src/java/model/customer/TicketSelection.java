/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.customer;

import java.math.BigDecimal;

public class TicketSelection {

    private int ticketTypeId;
    private String typeName;
    private BigDecimal price;
    private int quantity;

    public TicketSelection() {
    }

    public TicketSelection(int ticketTypeId, String typeName, BigDecimal price, int quantity) {
        this.ticketTypeId = ticketTypeId;
        this.typeName = typeName;
        this.price = price;
        this.quantity = quantity;
    }

    public int getTicketTypeId() {
        return ticketTypeId;
    }

    public void setTicketTypeId(int ticketTypeId) {
        this.ticketTypeId = ticketTypeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
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
