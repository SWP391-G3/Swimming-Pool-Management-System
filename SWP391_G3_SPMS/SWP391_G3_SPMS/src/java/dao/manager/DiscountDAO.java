/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.manager;

import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.manager.Discount;

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
            sql += " AND valid_from >= ? AND valid_to <= ?";
            params.add(new java.sql.Timestamp(fromDate.getTime()));
            params.add(new java.sql.Timestamp(toDate.getTime()));
        }

        if (fromDate != null && toDate != null) {
            sql += " AND valid_to >= ? AND valid_from <= ?";
            params.add(new java.sql.Timestamp(fromDate.getTime()));
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
        String sql = "SELECT d.*, u.username, u.full_name, u.email "
                + "FROM Discounts d "
                + "JOIN Users u ON d.created_by = u.user_id "
                + "WHERE 1=1";
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
            sql += " AND valid_from >= ? AND valid_to <= ?";
            params.add(new java.sql.Timestamp(fromDate.getTime()));
            params.add(new java.sql.Timestamp(toDate.getTime()));
        }

        if (fromDate != null && toDate != null) {
            sql += " AND valid_to >= ? AND valid_from <= ?";
            params.add(new java.sql.Timestamp(fromDate.getTime()));
            params.add(new java.sql.Timestamp(toDate.getTime()));
        }

        sql += " ORDER BY created_at ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
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
            d.setCreatedByUsername(rs.getString("username")); // Bạn cần thêm trường này vào class Discount
            d.setCreatedByFullName(rs.getString("full_name"));
            d.setCreatedByEmail(rs.getString("email"));
            list.add(d);
        }
        return list;
    }

    // Kiểm tra code đã tồn tại
    public boolean isCodeExists(String code) {
        String sql = "SELECT 1 FROM Discounts WHERE discount_code = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, code);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Thêm mới
    // Thêm parameter created_by cho Discount d
    public boolean insert(Discount d, int managerId) {
        String sql = "INSERT INTO Discounts (discount_code, description, discount_percent, quantity, valid_from, valid_to, status, created_at, created_by) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE(), ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, d.getCode());
            ps.setString(2, d.getDescription());
            ps.setDouble(3, d.getPercent());
            ps.setInt(4, d.getQuantity());
            ps.setTimestamp(5, d.getValidFrom() == null ? null : new java.sql.Timestamp(d.getValidFrom().getTime()));
            ps.setTimestamp(6, d.getValidTo() == null ? null : new java.sql.Timestamp(d.getValidTo().getTime()));
            ps.setBoolean(7, d.isStatus());
            ps.setInt(8, managerId);
            int affected = ps.executeUpdate();

            // Lấy discount_id vừa tạo
            int discountId = -1;
            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    discountId = rs.getInt(1);
                }
            }
            // Ghi log
            insertDiscountLog(discountId, managerId, "INSERT", null, d);

            return affected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean canManagerEditDiscount(int discountId, int managerId) {
        String sql = "SELECT 1 FROM Discounts WHERE discount_id = ? AND created_by = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, discountId);
            ps.setInt(2, managerId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy thông tin discount theo ID
    public Discount getDiscountById(int id) {
        String sql = "SELECT * FROM Discounts WHERE discount_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
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
                return d;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Cập nhật voucher
    public boolean update(Discount d, int managerId) {
        // Kiểm tra quyền trước khi update
        if (!canManagerEditDiscount(d.getId(), managerId)) {
            return false; // hoặc throw exception
        }
        // Lấy bản ghi cũ để log
        Discount old = getDiscountById(d.getId());

        String sql = "UPDATE Discounts SET description=?, discount_percent=?, quantity=?, valid_from=?, valid_to=?, status=?, updated_at=GETDATE() WHERE discount_id=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, d.getDescription());
            ps.setDouble(2, d.getPercent());
            ps.setInt(3, d.getQuantity());
            ps.setTimestamp(4, d.getValidFrom() == null ? null : new java.sql.Timestamp(d.getValidFrom().getTime()));
            ps.setTimestamp(5, d.getValidTo() == null ? null : new java.sql.Timestamp(d.getValidTo().getTime()));
            ps.setBoolean(6, d.isStatus());
            ps.setInt(7, d.getId());
            int affected = ps.executeUpdate();
            // Ghi log
            insertDiscountLog(d.getId(), managerId, "UPDATE", old, d);
            return affected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteDiscount(int id, int managerId) {
        // Kiểm tra quyền trước khi xóa
        if (!canManagerEditDiscount(id, managerId)) {
            return false;
        }
        // Lấy bản ghi cũ để log
        Discount old = getDiscountById(id);

        String sql = "DELETE FROM Discounts WHERE discount_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            int affected = ps.executeUpdate();
            // Log xóa
            insertDiscountLog(id, managerId, "DELETE", old, null);
            return affected > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private void insertDiscountLog(int discountId, int managerId, String actionType, Discount oldD, Discount newD) {
        String sql = "INSERT INTO Discount_Audit_Log (discount_id, manager_id, action_type, action_time, "
                + "old_description, new_description, old_discount_percent, new_discount_percent, old_quantity, new_quantity, "
                + "old_valid_from, new_valid_from, old_valid_to, new_valid_to, old_status, new_status) "
                + "VALUES (?, ?, ?, GETDATE(), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, discountId);
            ps.setInt(2, managerId);
            ps.setString(3, actionType);

            ps.setString(4, oldD != null ? oldD.getDescription() : null);
            ps.setString(5, newD != null ? newD.getDescription() : null);
            ps.setObject(6, oldD != null ? oldD.getPercent() : null);
            ps.setObject(7, newD != null ? newD.getPercent() : null);
            ps.setObject(8, oldD != null ? oldD.getQuantity() : null);
            ps.setObject(9, newD != null ? newD.getQuantity() : null);
            ps.setTimestamp(10, oldD != null && oldD.getValidFrom() != null ? new java.sql.Timestamp(oldD.getValidFrom().getTime()) : null);
            ps.setTimestamp(11, newD != null && newD.getValidFrom() != null ? new java.sql.Timestamp(newD.getValidFrom().getTime()) : null);
            ps.setTimestamp(12, oldD != null && oldD.getValidTo() != null ? new java.sql.Timestamp(oldD.getValidTo().getTime()) : null);
            ps.setTimestamp(13, newD != null && newD.getValidTo() != null ? new java.sql.Timestamp(newD.getValidTo().getTime()) : null);
            ps.setObject(14, oldD != null ? oldD.isStatus() : null);
            ps.setObject(15, newD != null ? newD.isStatus() : null);

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Dùng cho AJAX hiển thị chi tiết
    public Discount getDiscountByIdAjax(int id) {
        String sql = "SELECT * FROM Discounts WHERE discount_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
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
                return d;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
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

            System.out.println(discounts);

        } catch (Exception e) {
        }

    }

}
