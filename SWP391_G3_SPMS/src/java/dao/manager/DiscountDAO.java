/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.manager;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.manager.Discount;

/**
 *
 * @author Tuan Anh
 */
public class DiscountDAO extends DBContext {

    // Đếm tổng số voucher phù hợp filter
    public int countDiscounts(String keyword, String status, Date fromDate, Date toDate) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Discounts WHERE 1=1";
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.isEmpty()) {
            sql += " AND (discount_code LIKE ? OR description LIKE ?)";
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        if (status != null && !status.equals("all")) {
            if (status.equals("active")) {
                sql += " AND status = 1 AND GETDATE() BETWEEN valid_from AND valid_to";
            } else if (status.equals("inactive")) {
                sql += " AND status = 0";
            } else if (status.equals("expired")) {
                sql += " AND status = 1 AND GETDATE() > valid_to";
            } else if (status.equals("upcoming")) {
                sql += " AND status = 1 AND GETDATE() < valid_from";
            }
        }
        if (fromDate != null && toDate != null) {
            sql += " AND valid_from <= ? AND valid_to >= ?";
            params.add(new java.sql.Timestamp(toDate.getTime()));
            params.add(new java.sql.Timestamp(fromDate.getTime()));
        } else if (fromDate != null) {
            sql += " AND valid_to >= ?";
            params.add(new java.sql.Timestamp(fromDate.getTime()));
        } else if (toDate != null) {
            sql += " AND valid_from <= ?";
            params.add(new java.sql.Timestamp(toDate.getTime()));
        }
        PreparedStatement ps = connection.prepareStatement(sql);
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
        return 0;
    }

    // Lấy danh sách voucher phân trang, lọc, tìm kiếm
    public List<Discount> getDiscountList(String keyword, String status, Date fromDate, Date toDate, int page, int pageSize) throws SQLException {
        List<Discount> list = new ArrayList<>();
        String sql = "SELECT * FROM Discounts WHERE 1=1";
        List<Object> params = new ArrayList<>();
        if (keyword != null && !keyword.isEmpty()) {
            sql += " AND (discount_code LIKE ? OR description LIKE ?)";
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        if (status != null && !status.equals("all")) {
            if (status.equals("active")) {
                sql += " AND status = 1 AND GETDATE() BETWEEN valid_from AND valid_to";
            } else if (status.equals("inactive")) {
                sql += " AND status = 0";
            } else if (status.equals("expired")) {
                sql += " AND status = 1 AND GETDATE() > valid_to";
            } else if (status.equals("upcoming")) {
                sql += " AND status = 1 AND GETDATE() < valid_from";
            }
        }
        if (fromDate != null) {
            sql += " AND valid_from >= ?";
            params.add(new java.sql.Timestamp(fromDate.getTime()));
        }
        if (toDate != null) {
            sql += " AND valid_to <= ?";
            params.add(new java.sql.Timestamp(toDate.getTime()));
        }
        sql += " ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        PreparedStatement ps = connection.prepareStatement(sql);
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            Discount d = new Discount();
            d.setId(rs.getInt("discount_id"));
            d.setCode(rs.getString("discount_code"));
            d.setDescription(rs.getString("description"));
            d.setPercent(rs.getDouble("discount_percent"));
            d.setQuantity(rs.getInt("quantity"));
            d.setValidFrom(rs.getTimestamp("valid_from"));
            d.setValidTo(rs.getTimestamp("valid_to"));
            d.setStatus(rs.getBoolean("status"));
            d.setCreatedAt(rs.getTimestamp("created_at"));
            d.setUpdatedAt(rs.getTimestamp("updated_at"));
            list.add(d);
        }
        return list;
    }

    public static void main(String[] args) {

        // Tạo dữ liệu test
        String keyword = "";
        String status = "active"; // "inactive", "expired", "upcoming", or "all"
        Date fromDate = null; // new SimpleDateFormat("yyyy-MM-dd").parse("2025-06-01");
        Date toDate = null;   // new SimpleDateFormat("yyyy-MM-dd").parse("2025-07-01");
        int page = 1;
        int pageSize = 5;
        try {
            DiscountDAO dao = new DiscountDAO();
            List<Discount> discounts = dao.getDiscountList(keyword, status, fromDate, toDate, page, pageSize);

            // In kết quả ra console
            for (Discount d : discounts) {
                System.out.println("ID: " + d.getId()
                        + ", Code: " + d.getCode()
                        + ", Description: " + d.getDescription()
                        + ", Percent: " + d.getPercent()
                        + ", Quantity: " + d.getQuantity()
                        + ", Valid: " + d.getValidFrom() + " to " + d.getValidTo()
                        + ", Status: " + (d.isStatus() ? "Active" : "Inactive")
                        + ", Created: " + d.getCreatedAt());
            }
        } catch (Exception e) {
        }

    }

}
