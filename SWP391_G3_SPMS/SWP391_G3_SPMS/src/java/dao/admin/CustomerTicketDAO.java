/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.admin;

import dal.DBContext;
import model.admin.CustomerTicket;
import java.sql.*;
import java.time.LocalDate;

/**
 *
 * @author Lenovo
 */
public class CustomerTicketDAO extends DBContext {

    public CustomerTicket getCustomerTicket(int user_id) {
        String sql = "SELECT TOP 1 \n"
                + "    tt.ticket_type_id,\n"
                + "    tt.type_code,\n"
                + "    tt.type_name,\n"
                + "    COUNT(*) AS usage_count,\n"
                + "    MAX(t.issued_at) AS last_used_date,\n"
                + "    CAST(AVG(t.ticket_price) AS DECIMAL(10,2)) AS average_price\n"
                + "FROM Ticket t\n"
                + "JOIN Ticket_Types tt ON t.ticket_type_id = tt.ticket_type_id\n"
                + "JOIN Booking b ON t.booking_id = b.booking_id\n"
                + "WHERE b.user_id = ? AND t.issued_at IS NOT NULL\n"
                + "GROUP BY tt.ticket_type_id, tt.type_code, tt.type_name\n"
                + "ORDER BY usage_count DESC;";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, user_id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int ticket_type_id = rs.getInt("ticket_type_id");
                String type_code = rs.getString("type_code");
                String type_name = rs.getString("type_name");
                int usage_count = rs.getInt("usage_count");
                LocalDate use_date = rs.getDate("last_used_date").toLocalDate();
                double average_price = rs.getDouble("average_price");

                return new CustomerTicket(ticket_type_id, type_code, type_name, usage_count, use_date, average_price);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
