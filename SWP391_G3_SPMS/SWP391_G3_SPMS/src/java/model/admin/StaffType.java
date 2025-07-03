/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.admin;

/**
 *
 * @author Lenovo
 */
public class StaffType {
    private int staffTypeID;
    private String type_name;

    public StaffType() {
    }

    public StaffType(int staffTypeID, String type_name) {
        this.staffTypeID = staffTypeID;
        this.type_name = type_name;
    }

    public int getStaffTypeID() {
        return staffTypeID;
    }

    public void setStaffTypeID(int staffTypeID) {
        this.staffTypeID = staffTypeID;
    }

    public String getType_name() {
        return type_name;
    }

    public void setType_name(String type_name) {
        this.type_name = type_name;
    }

    @Override
    public String toString() {
        return "StaffType{" + "staffTypeID=" + staffTypeID + ", type_name=" + type_name + '}';
    }
    
    
}
