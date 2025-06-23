/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.admin;

import dal.DBContext;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.time.LocalDate;
import model.admin.CustomerVoucher;

/**
 *
 * @author Lenovo
 */
public class CustomerVoucherDAO extends DBContext {

    public CustomerVoucher getCustomerVoucher(int user_id) {
        String sql = "SELECT TOP 1\n"
                + "    d.discount_id,\n"
                + "    d.discount_code,\n"
                + "    d.description,\n"
                + "    COUNT(*) AS usage_count,\n"
                + "    MAX(b.created_at) AS last_used_date\n"
                + "FROM Booking b\n"
                + "JOIN Discounts d ON b.discount_id = d.discount_id\n"
                + "WHERE b.user_id = ? AND b.discount_id IS NOT NULL\n"
                + "GROUP BY d.discount_id, d.discount_code, d.description\n"
                + "ORDER BY usage_count DESC;";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, user_id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int voucher_id = rs.getInt("discount_id");
                String voucher_name = rs.getString("discount_code");
                String description = rs.getString("description");
                int usage_count = rs.getInt("usage_count");
                LocalDate applied_date = rs.getDate("last_used_date").toLocalDate();

                return new CustomerVoucher(voucher_id, voucher_name, description, usage_count, applied_date);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
