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
import java.sql.*;
import java.time.LocalDateTime;
import model.customer.Discounts;

/**
 *
 * @author LAZYVL
 */
public class DiscountDAO extends DBContext {

    public List<Discounts> getAvailableDiscountsForUser(int userId) {
        List<Discounts> list = new ArrayList<>();
        String sql = """
        SELECT D.discount_id, D.discount_code, D.description, D.discount_percent,
               D.valid_from, D.valid_to, D.status, D.created_at, D.updated_at
        FROM Discounts D
        JOIN Customer_Discount CD ON D.discount_id = CD.discount_id
        WHERE CD.user_id = ? AND D.status = 1 AND CD.used_discount = 1 AND D.valid_to >= GETDATE()
    """;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, userId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int discountId = rs.getInt(1);
                String discountCode = rs.getString(2);
                String description = rs.getString(3);
                BigDecimal discountPercent = rs.getBigDecimal(4);

                Timestamp validFromTS = rs.getTimestamp(5);
                Timestamp validToTS = rs.getTimestamp(6);
                boolean status = rs.getBoolean(7);
                Timestamp createdAtTS = rs.getTimestamp(8);
                Timestamp updatedAtTS = rs.getTimestamp(9);

                LocalDateTime validFrom = (validFromTS != null) ? validFromTS.toLocalDateTime() : null;
                LocalDateTime validTo = (validToTS != null) ? validToTS.toLocalDateTime() : null;
                LocalDateTime createdAt = (createdAtTS != null) ? createdAtTS.toLocalDateTime() : null;
                LocalDateTime updatedAt = (updatedAtTS != null) ? updatedAtTS.toLocalDateTime() : null;

                Discounts discount = new Discounts(discountId, discountCode, description, discountPercent,
                        validFrom, validTo, status, createdAt, updatedAt);
                list.add(discount);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public Discounts getDiscountByCode(String discountCode) {
        String sql = "SELECT discount_id, discount_code, description, discount_percent, valid_from, valid_to, "
                + "status, created_at, updated_at "
                + "FROM Discounts WHERE discount_code = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, discountCode);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int discountId = rs.getInt("discount_id");
                String code = rs.getString("discount_code");
                String description = rs.getString("description");
                BigDecimal discountPercent = rs.getBigDecimal("discount_percent");

                Timestamp validFromTs = rs.getTimestamp("valid_from");
                Timestamp validToTs = rs.getTimestamp("valid_to");
                boolean status = rs.getBoolean("status");
                Timestamp createdAtTs = rs.getTimestamp("created_at");
                Timestamp updatedAtTs = rs.getTimestamp("updated_at");

                LocalDateTime validFrom = (validFromTs != null) ? validFromTs.toLocalDateTime() : null;
                LocalDateTime validTo = (validToTs != null) ? validToTs.toLocalDateTime() : null;
                LocalDateTime createdAt = (createdAtTs != null) ? createdAtTs.toLocalDateTime() : null;
                LocalDateTime updatedAt = (updatedAtTs != null) ? updatedAtTs.toLocalDateTime() : null;

                return new Discounts(discountId, code, description, discountPercent,
                        validFrom, validTo, status, createdAt, updatedAt);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public BigDecimal calculateDiscountAmount(int discountId, BigDecimal totalAmount) {
        String sql = "SELECT discount_percent FROM Discounts WHERE discount_id = ? AND status = 1 AND valid_from <= GETDATE() AND valid_to >= GETDATE()";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, discountId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                BigDecimal percent = rs.getBigDecimal("discount_percent");
                if (percent != null && totalAmount != null) {
                    BigDecimal discountAmount = totalAmount.multiply(percent).divide(BigDecimal.valueOf(100));
                    return discountAmount;
                }
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }

    public boolean markDiscountAsUsed(int userId, int discountId) {
        String sql = "UPDATE Customer_Discount SET used_discount = 0 WHERE user_id = ? AND discount_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            st.setInt(2, discountId);
            int affected = st.executeUpdate();
            return affected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
