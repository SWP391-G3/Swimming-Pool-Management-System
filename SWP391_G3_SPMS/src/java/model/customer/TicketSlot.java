/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.customer;

/**
 *
 * @author LAZYVL
 */
public class TicketSlot {
    private int ticketTypeId;
    private int ticketSlot;

    public TicketSlot() {
    }

    public TicketSlot(int ticketTypeId, int ticketSlot) {
        this.ticketTypeId = ticketTypeId;
        this.ticketSlot = ticketSlot;
    }

    public int getTicketTypeId() {
        return ticketTypeId;
    }

    public void setTicketTypeId(int ticketTypeId) {
        this.ticketTypeId = ticketTypeId;
    }

    public int getTicketSlot() {
        return ticketSlot;
    }

    public void setTicketSlot(int ticketSlot) {
        this.ticketSlot = ticketSlot;
    }
    
    
}
