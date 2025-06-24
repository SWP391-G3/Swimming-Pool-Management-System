package model.customer;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Time;
import java.util.List;

public class BookingPageData{

    private User user;
    private Pool pool;
    private List<TicketType> ticketTypes;
    private List<PoolService> poolServices;
    private List<Discounts> discounts;
    private Date bookingDate;
    private Time startTime;
    private Time endTime;
    private int slotCount;
    private List<TicketSelection> selectedTickets;
    private List<PoolServiceSelection> selectedRents;
    private Discounts selectedDiscount;
    private BigDecimal totalAmount;
    private BigDecimal discountAmount;
    private BigDecimal finalAmount;

    public BookingPageData() {
    }

    public BookingPageData(User user, Pool pool, List<TicketType> ticketTypes, List<PoolService> poolServices, List<Discounts> discounts, Date bookingDate, Time startTime, Time endTime, int slotCount, List<TicketSelection> selectedTickets, List<PoolServiceSelection> selectedRents, Discounts selectedDiscount, BigDecimal totalAmount, BigDecimal discountAmount, BigDecimal finalAmount) {
        this.user = user;
        this.pool = pool;
        this.ticketTypes = ticketTypes;
        this.poolServices = poolServices;
        this.discounts = discounts;
        this.bookingDate = bookingDate;
        this.startTime = startTime;
        this.endTime = endTime;
        this.slotCount = slotCount;
        this.selectedTickets = selectedTickets;
        this.selectedRents = selectedRents;
        this.selectedDiscount = selectedDiscount;
        this.totalAmount = totalAmount;
        this.discountAmount = discountAmount;
        this.finalAmount = finalAmount;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Pool getPool() {
        return pool;
    }

    public void setPool(Pool pool) {
        this.pool = pool;
    }

    public List<TicketType> getTicketTypes() {
        return ticketTypes;
    }

    public void setTicketTypes(List<TicketType> ticketTypes) {
        this.ticketTypes = ticketTypes;
    }

    public List<PoolService> getPoolServices() {
        return poolServices;
    }

    public void setPoolServices(List<PoolService> poolServices) {
        this.poolServices = poolServices;
    }

    public List<Discounts> getDiscounts() {
        return discounts;
    }

    public void setDiscounts(List<Discounts> discounts) {
        this.discounts = discounts;
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
}
