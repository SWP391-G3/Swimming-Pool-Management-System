/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.customer;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import model.customer.DiscountDetail;

/**
 *
 * @author LAZYVL
 */
public class DiscountDetailDAO extends DBContext {

    //Get discount by userId
    public List<DiscountDetail> getDiscountByUserID(int userId) throws SQLException {
        List<DiscountDetail> list = new ArrayList<>();
        String sql = "SELECT d.* FROM Discounts d "
                + "JOIN Customer_Discount cd ON d.discount_id = cd.discount_id "
                + "WHERE cd.user_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            try (ResultSet rs = st.executeQuery();) {
                while (rs.next()) {
                    DiscountDetail discount = new DiscountDetail();
                    discount.setDiscountId(rs.getInt("discount_id"));
                    discount.setUserId(userId);
                    discount.setDiscountCode(rs.getString("discount_code"));
                    discount.setDescription(rs.getString("description"));
                    discount.setDiscountPercent(rs.getBigDecimal("discount_percent"));
                    discount.setValidFrom(rs.getTimestamp("valid_from").toLocalDateTime());
                    discount.setValidTo(rs.getTimestamp("valid_to").toLocalDateTime());
                    discount.setStatus(rs.getBoolean("status"));
                    discount.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    Timestamp updated = rs.getTimestamp("updated_at");
                    if (updated != null) {
                        discount.setUpdatedAt(updated.toLocalDateTime());
                    }
                    list.add(discount);
                }
            }
        }
        return list;
    }

    // Get discount by discount_code
    public DiscountDetail getDiscountByCode(String code) {
        String sql = "SELECT * FROM Discounts WHERE discount_code = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, code);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    DiscountDetail discount = new DiscountDetail();
                    discount.setDiscountId(rs.getInt("discount_id"));
                    discount.setDiscountCode(rs.getString("discount_code"));
                    discount.setDescription(rs.getString("description"));
                    discount.setDiscountPercent(rs.getBigDecimal("discount_percent"));
                    discount.setValidFrom(rs.getTimestamp("valid_from").toLocalDateTime());
                    discount.setValidTo(rs.getTimestamp("valid_to").toLocalDateTime());
                    discount.setStatus(rs.getBoolean("status"));
                    discount.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    Timestamp updated = rs.getTimestamp("updated_at");
                    if (updated != null) {
                        discount.setUpdatedAt(updated.toLocalDateTime());
                    }
                    return discount;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<DiscountDetail> getDiscountByUserIDAndStatus(int userId, boolean status) throws SQLException {
        List<DiscountDetail> list = new ArrayList<>();
        String sql = "SELECT d.* FROM Discounts d "
                + "JOIN Customer_Discount cd ON d.discount_id = cd.discount_id "
                + "WHERE cd.user_id = ? AND d.status = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            st.setBoolean(2, status);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    DiscountDetail discount = new DiscountDetail();
                    discount.setDiscountId(rs.getInt("discount_id"));
                    discount.setUserId(userId);
                    discount.setDiscountCode(rs.getString("discount_code"));
                    discount.setDescription(rs.getString("description"));
                    discount.setDiscountPercent(rs.getBigDecimal("discount_percent"));
                    discount.setValidFrom(rs.getTimestamp("valid_from").toLocalDateTime());
                    discount.setValidTo(rs.getTimestamp("valid_to").toLocalDateTime());
                    discount.setStatus(rs.getBoolean("status"));
                    discount.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    Timestamp updated = rs.getTimestamp("updated_at");
                    if (updated != null) {
                        discount.setUpdatedAt(updated.toLocalDateTime());
                    }
                    list.add(discount);
                }
            }
        }
        return list;
    }

}
