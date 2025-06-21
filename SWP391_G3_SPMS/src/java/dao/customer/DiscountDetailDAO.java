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

    // Lấy danh sách voucher theo user, phân trang, có lọc/tìm kiếm/sắp xếp
    public List<DiscountDetail> getVoucherListByUserId(
            int userId, String search, String expiry, String sort,
            int page, int pageSize
    ) throws SQLException {
        List<DiscountDetail> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT d.*, cd.used_discount, "
                + " (SELECT COUNT(*) FROM Customer_Discount WHERE discount_id = d.discount_id AND used_discount = 1) AS used_count, "
                + " ISNULL(d.quantity, 0) AS total_quantity "
                + "FROM Discounts d "
                + "JOIN Customer_Discount cd ON d.discount_id = cd.discount_id "
                + "WHERE cd.user_id = ?"
        );

        if (search != null && !search.isEmpty()) {
            sql.append(" AND (d.discount_code LIKE ? OR d.description LIKE ?)");
        }
        if (expiry != null && !expiry.isEmpty()) {
            sql.append(" AND CONVERT(date, d.valid_to) = CONVERT(date, ?)");
        }

        if ("expiry".equals(sort)) {
            sql.append(" ORDER BY d.valid_to ASC");
        } else if ("value".equals(sort)) {
            sql.append(" ORDER BY d.discount_percent DESC");
        } else {
            sql.append(" ORDER BY d.created_at DESC");
        }

        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            int idx = 1;
            st.setInt(idx++, userId);
            if (search != null && !search.isEmpty()) {
                st.setString(idx++, "%" + search + "%");
                st.setString(idx++, "%" + search + "%");
            }
            if (expiry != null && !expiry.isEmpty()) {
                st.setString(idx++, expiry);
            }
            st.setInt(idx++, (page - 1) * pageSize);
            st.setInt(idx++, pageSize);

            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    DiscountDetail discount = new DiscountDetail();
                    discount.setDiscountId(rs.getInt("discount_id"));
                    discount.setUserId(userId);
                    discount.setDiscountCode(rs.getString("discount_code"));
                    discount.setDescription(rs.getString("description"));
                    discount.setDiscountPercent(rs.getBigDecimal("discount_percent"));
                    discount.setQuantity(rs.getObject("quantity") == null ? null : rs.getInt("quantity"));
                    discount.setValidFrom(rs.getTimestamp("valid_from").toLocalDateTime());
                    discount.setValidTo(rs.getTimestamp("valid_to").toLocalDateTime());
                    discount.setStatus(rs.getBoolean("status"));
                    discount.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    Timestamp updated = rs.getTimestamp("updated_at");
                    if (updated != null) {
                        discount.setUpdatedAt(updated.toLocalDateTime());
                    }
                    discount.setUsedDiscount(rs.getBoolean("used_discount"));
                    int used = rs.getInt("used_count");
                    int total = rs.getInt("total_quantity");
                    discount.setUsedPercent((total == 0) ? 0.0 : used * 100.0 / total);
                    list.add(discount);
                }
            }
        }
        return list;
    }

    // Đếm tổng số voucher cho user (để phân trang)
    public int countVoucherByUserId(int userId, String search, String expiry) throws SQLException {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) FROM Discounts d "
                + "JOIN Customer_Discount cd ON d.discount_id = cd.discount_id "
                + "WHERE cd.user_id = ?"
        );
        if (search != null && !search.isEmpty()) {
            sql.append(" AND (d.discount_code LIKE ? OR d.description LIKE ?)");
        }
        if (expiry != null && !expiry.isEmpty()) {
            sql.append(" AND CONVERT(date, d.valid_to) = CONVERT(date, ?)");
        }
        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            int idx = 1;
            st.setInt(idx++, userId);
            if (search != null && !search.isEmpty()) {
                st.setString(idx++, "%" + search + "%");
                st.setString(idx++, "%" + search + "%");
            }
            if (expiry != null && !expiry.isEmpty()) {
                st.setString(idx++, expiry);
            }
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
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
    
    public DiscountDetail getVoucherDetailByUserIdAndCode(int userId, String code) throws SQLException {
        String sql = "SELECT d.*, cd.used_discount, "
                + " (SELECT COUNT(*) FROM Customer_Discount WHERE discount_id = d.discount_id AND used_discount = 1) AS used_count, "
                + " ISNULL(d.quantity, 0) AS total_quantity "
                + "FROM Discounts d "
                + "JOIN Customer_Discount cd ON d.discount_id = cd.discount_id "
                + "WHERE cd.user_id = ? AND d.discount_code = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            st.setString(2, code);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    DiscountDetail discount = new DiscountDetail();
                    discount.setDiscountId(rs.getInt("discount_id"));
                    discount.setUserId(userId);
                    discount.setDiscountCode(rs.getString("discount_code"));
                    discount.setDescription(rs.getString("description"));
                    discount.setDiscountPercent(rs.getBigDecimal("discount_percent"));
                    discount.setQuantity(rs.getObject("quantity") == null ? null : rs.getInt("quantity"));
                    discount.setValidFrom(rs.getTimestamp("valid_from").toLocalDateTime());
                    discount.setValidTo(rs.getTimestamp("valid_to").toLocalDateTime());
                    discount.setStatus(rs.getBoolean("status"));
                    discount.setCreatedAt(rs.getTimestamp("created_at").toLocalDateTime());
                    Timestamp updated = rs.getTimestamp("updated_at");
                    if (updated != null) {
                        discount.setUpdatedAt(updated.toLocalDateTime());
                    }
                    discount.setUsedDiscount(rs.getBoolean("used_discount"));
                    int used = rs.getInt("used_count");
                    int total = rs.getInt("total_quantity");
                    discount.setUsedPercent((total == 0) ? 0.0 : used * 100.0 / total);
                    return discount;
                }
            }
        }
        return null;
    }

}
