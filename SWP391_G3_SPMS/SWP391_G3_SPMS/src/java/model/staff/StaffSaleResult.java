/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.staff;

import model.customer.TicketSelection;
import model.customer.PoolServiceSelection;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

/**
 *
 * @author LAZYVL
 */
public class StaffSaleResult {

    private int bookingId;
    private int paymentId;
    private String customerName;
    private String customerPhone;
    private String customerEmail;
    private boolean isExistingCustomer;
    private Integer userId;
    private List<TicketSelection> selectedTickets;
    private List<PoolServiceSelection> selectedServices;
    private BigDecimal totalAmount;
    private String staffName;
    private String poolName;
    private Date saleDate;

    // Constructors
    public StaffSaleResult() {
    }

    public StaffSaleResult(int bookingId, int paymentId, String customerName, String customerPhone, String customerEmail, boolean isExistingCustomer, Integer userId, List<TicketSelection> selectedTickets, List<PoolServiceSelection> selectedServices, BigDecimal totalAmount, String staffName, String poolName, Date saleDate) {
        this.bookingId = bookingId;
        this.paymentId = paymentId;
        this.customerName = customerName;
        this.customerPhone = customerPhone;
        this.customerEmail = customerEmail;
        this.isExistingCustomer = isExistingCustomer;
        this.userId = userId;
        this.selectedTickets = selectedTickets;
        this.selectedServices = selectedServices;
        this.totalAmount = totalAmount;
        this.staffName = staffName;
        this.poolName = poolName;
        this.saleDate = saleDate;
    }

    // Getters and Setters
    public int getBookingId() {
        return bookingId;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public boolean isExistingCustomer() {
        return isExistingCustomer;
    }

    public void setIsExistingCustomer(boolean isExistingCustomer) {
        this.isExistingCustomer = isExistingCustomer;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public List<TicketSelection> getSelectedTickets() {
        return selectedTickets;
    }

    public void setSelectedTickets(List<TicketSelection> selectedTickets) {
        this.selectedTickets = selectedTickets;
    }

    public List<PoolServiceSelection> getSelectedServices() {
        return selectedServices;
    }

    public void setSelectedServices(List<PoolServiceSelection> selectedServices) {
        this.selectedServices = selectedServices;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getStaffName() {
        return staffName;
    }

    public void setStaffName(String staffName) {
        this.staffName = staffName;
    }

    public String getPoolName() {
        return poolName;
    }

    public void setPoolName(String poolName) {
        this.poolName = poolName;
    }

    public Date getSaleDate() {
        return saleDate;
    }

    public void setSaleDate(Date saleDate) {
        this.saleDate = saleDate;
    }
}
