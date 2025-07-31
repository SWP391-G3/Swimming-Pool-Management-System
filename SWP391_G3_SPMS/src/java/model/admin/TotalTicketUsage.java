/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

/**
 *
 * @author Lenovo
 */
public class TotalTicketUsage {
    private String type_name;
    private int used_ticket_count;

    public TotalTicketUsage() {
    }

    public TotalTicketUsage(String type_name, int used_ticket_count) {
        this.type_name = type_name;
        this.used_ticket_count = used_ticket_count;
    }

    public String getType_name() {
        return type_name;
    }

    public void setType_name(String type_name) {
        this.type_name = type_name;
    }

    public int getUsed_ticket_count() {
        return used_ticket_count;
    }

    public void setUsed_ticket_count(int used_ticket_count) {
        this.used_ticket_count = used_ticket_count;
    }

    @Override
    public String toString() {
        return "TotalTicketUsage{" + "type_name=" + type_name + ", used_ticket_count=" + used_ticket_count + '}';
    }
    
    
}
