package model.customer;

import java.math.BigDecimal;

public class TicketType {

    private int ticketTypeId;
    private String typeCode;
    private String typeName;
    private String description;
    private BigDecimal basePrice;
    private boolean isCombo;

    public TicketType() {
    }

    public TicketType(int ticketTypeId, String typeCode, String typeName, String description, BigDecimal basePrice, boolean isCombo) {
        this.ticketTypeId = ticketTypeId;
        this.typeCode = typeCode;
        this.typeName = typeName;
        this.description = description;
        this.basePrice = basePrice;
        this.isCombo = isCombo;
    }

    public int getTicketTypeId() {
        return ticketTypeId;
    }

    public void setTicketTypeId(int ticketTypeId) {
        this.ticketTypeId = ticketTypeId;
    }

    public String getTypeCode() {
        return typeCode;
    }

    public void setTypeCode(String typeCode) {
        this.typeCode = typeCode;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public BigDecimal getBasePrice() {
        return basePrice;
    }

    public void setBasePrice(BigDecimal basePrice) {
        this.basePrice = basePrice;
    }

    public boolean isCombo() {
        return isCombo;
    }

    public void setCombo(boolean combo) {
        isCombo = combo;
    }

    @Override
    public String toString() {
        return "TicketType{"
                + "ticketTypeId=" + ticketTypeId
                + ", typeCode='" + typeCode + '\''
                + ", typeName='" + typeName + '\''
                + ", description='" + description + '\''
                + ", basePrice=" + basePrice
                + ", isCombo=" + isCombo
                + '}';
    }
}
