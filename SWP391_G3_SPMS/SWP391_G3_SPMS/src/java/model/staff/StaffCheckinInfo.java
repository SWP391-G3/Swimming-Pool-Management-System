/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.staff;

/**
 *
 * @author LAZYVL
 */
public class StaffCheckinInfo {

    private int bookingId;
    private String userName;
    private String bookingDate; // yyyy-MM-dd
    private String startTime;
    private String endTime;
    private String checkinTime; // null nếu chưa checkin
    private boolean checked;    // true nếu đã checkin

    public StaffCheckinInfo() {
    }

    public StaffCheckinInfo(int bookingId, String userName, String bookingDate, String startTime, String endTime, String checkinTime, boolean checked) {
        this.bookingId = bookingId;
        this.userName = userName;
        this.bookingDate = bookingDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.checkinTime = checkinTime;
        this.checked = checked;
    }

    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(String bookingDate) {
        this.bookingDate = bookingDate;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getCheckinTime() {
        return checkinTime;
    }

    public void setCheckinTime(String checkinTime) {
        this.checkinTime = checkinTime;
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }
    
    
}
