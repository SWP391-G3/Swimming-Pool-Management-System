/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model.staff;

import model.customer.*;
import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

/**
 *
 * @author LAZYVL
 */
public class StaffSaleData {
    // Thông tin khách hàng

    private User customer; // null nếu khách không có tài khoản
    private String customerPhone;
    private String customerName;
    private String customerEmail;
    private boolean hasAccount;

    // Thông tin nhân viên và bể bơi
    private User staff;
    private Pool pool;
    private List<TicketType> availableTicketTypes;
    private List<PoolService> availableServices;
    private List<Discounts> availableDiscounts;

    // Thông tin đặt vé
    private Date bookingDate;
    private Time startTime;
    private Time endTime;
    private int slotCount;

    // Lựa chọn của khách
    private List<TicketSelection> selectedTickets;
    private List<PoolServiceSelection> selectedRents;
    private Discounts selectedDiscount;

    // Thông tin thanh toán
    private String paymentMethod; // "Cash" hoặc "Bank_transfers"
    private BigDecimal totalTicketAmount;
    private BigDecimal totalServiceAmount;
    private BigDecimal totalAmount;
    private BigDecimal discountAmount;
    private BigDecimal finalAmount;

    // Constructors
    public StaffSaleData() {
        this.hasAccount = false;
        this.totalTicketAmount = BigDecimal.ZERO;
        this.totalServiceAmount = BigDecimal.ZERO;
        this.totalAmount = BigDecimal.ZERO;
        this.discountAmount = BigDecimal.ZERO;
        this.finalAmount = BigDecimal.ZERO;
    }

    public StaffSaleData(User customer, String customerPhone, String customerName, String customerEmail, boolean hasAccount, User staff, Pool pool, List<TicketType> availableTicketTypes, List<PoolService> availableServices, List<Discounts> availableDiscounts, Date bookingDate, Time startTime, Time endTime, int slotCount, List<TicketSelection> selectedTickets, List<PoolServiceSelection> selectedRents, Discounts selectedDiscount, String paymentMethod, BigDecimal totalTicketAmount, BigDecimal totalServiceAmount, BigDecimal totalAmount, BigDecimal discountAmount, BigDecimal finalAmount) {
        this.customer = customer;
        this.customerPhone = customerPhone;
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.hasAccount = hasAccount;
        this.staff = staff;
        this.pool = pool;
        this.availableTicketTypes = availableTicketTypes;
        this.availableServices = availableServices;
        this.availableDiscounts = availableDiscounts;
        this.bookingDate = bookingDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.slotCount = slotCount;
        this.selectedTickets = selectedTickets;
        this.selectedRents = selectedRents;
        this.selectedDiscount = selectedDiscount;
        this.paymentMethod = paymentMethod;
        this.totalTicketAmount = totalTicketAmount;
        this.totalServiceAmount = totalServiceAmount;
        this.totalAmount = totalAmount;
        this.discountAmount = discountAmount;
        this.finalAmount = finalAmount;
    }

    // Getters and Setters
    public User getCustomer() {
        return customer;
    }

    public void setCustomer(User customer) {
        this.customer = customer;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public boolean isHasAccount() {
        return hasAccount;
    }

    public void setHasAccount(boolean hasAccount) {
        this.hasAccount = hasAccount;
    }

    public User getstaff() {
        return staff;
    }

    public void setStaff(User staff) {
        this.staff = staff;
    }

    public Pool getPool() {
        return pool;
    }

    public void setPool(Pool pool) {
        this.pool = pool;
    }

    public List<TicketType> getAvailableTicketTypes() {
        return availableTicketTypes;
    }

    public void setAvailableTicketTypes(List<TicketType> availableTicketTypes) {
        this.availableTicketTypes = availableTicketTypes;
    }

    public List<PoolService> getAvailableServices() {
        return availableServices;
    }

    public void setAvailableServices(List<PoolService> availableServices) {
        this.availableServices = availableServices;
    }

    public List<Discounts> getAvailableDiscounts() {
        return availableDiscounts;
    }

    public void setAvailableDiscounts(List<Discounts> availableDiscounts) {
        this.availableDiscounts = availableDiscounts;
    }

    public Date getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(Date bookingDate) {
        this.bookingDate = bookingDate;
    }

    public Time getStartTime() {
        return startTime;
    }

    public void setStartTime(Time startTime) {
        this.startTime = startTime;
    }

    public Time getEndTime() {
        return endTime;
    }

    public void setEndTime(Time endTime) {
        this.endTime = endTime;
    }

    public int getSlotCount() {
        return slotCount;
    }

    public void setSlotCount(int slotCount) {
        this.slotCount = slotCount;
    }

    public List<TicketSelection> getSelectedTickets() {
        return selectedTickets;
    }

    public void setSelectedTickets(List<TicketSelection> selectedTickets) {
        this.selectedTickets = selectedTickets;
    }

    public List<PoolServiceSelection> getSelectedRents() {
        return selectedRents;
    }

    public void setSelectedRents(List<PoolServiceSelection> selectedRents) {
        this.selectedRents = selectedRents;
    }

    public Discounts getSelectedDiscount() {
        return selectedDiscount;
    }

    public void setSelectedDiscount(Discounts selectedDiscount) {
        this.selectedDiscount = selectedDiscount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public BigDecimal getTotalTicketAmount() {
        return totalTicketAmount;
    }

    public void setTotalTicketAmount(BigDecimal totalTicketAmount) {
        this.totalTicketAmount = totalTicketAmount;
    }

    public BigDecimal getTotalServiceAmount() {
        return totalServiceAmount;
    }

    public void setTotalServiceAmount(BigDecimal totalServiceAmount) {
        this.totalServiceAmount = totalServiceAmount;
    }

    public BigDecimal getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    public BigDecimal getDiscountAmount() {
        return discountAmount;
    }

    public void setDiscountAmount(BigDecimal discountAmount) {
        this.discountAmount = discountAmount;
    }

    public BigDecimal getFinalAmount() {
        return finalAmount;
    }

    public void setFinalAmount(BigDecimal finalAmount) {
        this.finalAmount = finalAmount;
    }

    // Utility methods
    public void calculateTotalAmount() {
        this.totalAmount = this.totalTicketAmount.add(this.totalServiceAmount);
        if (this.selectedDiscount != null && this.hasAccount) {
            this.discountAmount = this.totalAmount.multiply(this.selectedDiscount.getDiscountPercent().divide(BigDecimal.valueOf(100)));
        }
        this.finalAmount = this.totalAmount.subtract(this.discountAmount);
    }
}
