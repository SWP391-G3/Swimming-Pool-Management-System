/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.customer;

import dal.DBContext;
import java.math.BigDecimal;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.customer.Ticket;

public class TicketDAO extends DBContext {

    public void addTicket(int bookingId, int ticketTypeId, BigDecimal price, Integer issuedBy) {
        String sql = "INSERT INTO Ticket (booking_id, ticket_type_id, ticket_price, issued_by, issued_at) "
                + "VALUES (?, ?, ?, ?, GETDATE())";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, bookingId);
            st.setInt(2, ticketTypeId);
            st.setBigDecimal(3, price);
            if (issuedBy != null) {
                st.setInt(4, issuedBy);
            } else {
                st.setNull(4, java.sql.Types.INTEGER);
            }
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<Ticket> getTicketsByBookingId(int bookingId) {
        List<Ticket> list = new ArrayList<>();
        String sql = "SELECT ticket_id, booking_id, ticket_type_id, ticket_price, ticket_code, issued_by, issued_at "
                + "FROM Ticket WHERE booking_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, bookingId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Ticket t = new Ticket();
                t.setTicketId(rs.getInt("ticket_id"));
                t.setBookingId(rs.getInt("booking_id"));
                t.setTicketTypeId(rs.getInt("ticket_type_id"));
                t.setTicketPrice(rs.getBigDecimal("ticket_price"));
                t.setTicketCode(rs.getString("ticket_code"));
                t.setIssuedBy((Integer) rs.getObject("issued_by"));
                t.setIssuedAt(rs.getTimestamp("issued_at"));
                list.add(t);
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
