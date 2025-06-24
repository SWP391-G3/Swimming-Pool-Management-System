/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.customer;

import dal.DBContext;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.customer.TicketType;

/**
 *
 * @author LAZYVL
 */
public class TicketTypeDAO extends DBContext {

    public List<TicketType> getTicketTypesByPoolId(int poolId) {
        List<TicketType> list = new ArrayList<>();
        String sql = "SELECT t.ticket_type_id, t.type_code, t.type_name, t.description, t.base_price, t.is_combo "
                + "FROM Ticket_Types t "
                + "JOIN Pool_Ticket_Type pt ON t.ticket_type_id = pt.ticket_type_id "
                + "WHERE pt.pool_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, poolId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int ticketTypeId = rs.getInt(1);
                String typeCode = rs.getString(2);
                String typeName = rs.getString(3);
                String description = rs.getString(4);
                BigDecimal basePrice = rs.getBigDecimal(5);
                boolean isCombo = rs.getBoolean(6);

                TicketType ticketType = new TicketType(ticketTypeId, typeCode, typeName, description, basePrice, isCombo);
                list.add(ticketType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public TicketType getTicketTypeByName(String typeName) {
        String sql = "SELECT ticket_type_id, type_code, type_name, description, base_price, is_combo "
                + "FROM Ticket_Types WHERE type_name = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, typeName);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int id = rs.getInt("ticket_type_id");
                String code = rs.getString("type_code");
                String name = rs.getString("type_name");
                String description = rs.getString("description");
                BigDecimal price = rs.getBigDecimal("base_price");
                boolean isCombo = rs.getBoolean("is_combo");

                return new TicketType(id, code, name, description, price, isCombo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public TicketType getTicketTypeById(int ticketTypeId) {
        String sql = "SELECT * FROM Ticket_Types WHERE ticket_type_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, ticketTypeId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new TicketType(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getBigDecimal(5),
                        rs.getBoolean(6)
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<TicketType> getAllTicketTypes() {
        List<TicketType> list = new ArrayList<>();
        String sql = "SELECT * FROM Ticket_Types";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                // Các cột theo đúng thứ tự như khi tạo bảng Ticket_Types
                int ticketTypeId = rs.getInt(1);
                String typeCode = rs.getString(2);
                String typeName = rs.getString(3);
                String description = rs.getString(4);
                BigDecimal basePrice = rs.getBigDecimal(5);
                boolean isCombo = rs.getBoolean(6);

                TicketType ticketType = new TicketType(ticketTypeId, typeCode, typeName, description, basePrice, isCombo);
                list.add(ticketType);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
