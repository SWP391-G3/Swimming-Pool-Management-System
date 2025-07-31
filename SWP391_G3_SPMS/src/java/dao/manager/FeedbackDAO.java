/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
/**
 *
 * @author Tuan Anh
 */
package dao.manager;

import dal.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.manager.Feedback;
import model.manager.PoolFeedBack;

public class FeedbackDAO extends DBContext {

    // Lấy danh sách hồ bơi cho filter, trả về List<PoolFeedBack>
    public List<PoolFeedBack> getAllPools() throws SQLException {
        List<PoolFeedBack> list = new ArrayList<>();
        String sql = "SELECT pool_id, pool_name FROM Pools ORDER BY pool_name";
        try (PreparedStatement stmt = connection.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                PoolFeedBack pool = new PoolFeedBack(rs.getInt("pool_id"), rs.getString("pool_name"));
                list.add(pool);
            }
        }
        return list;
    }

    public List<PoolFeedBack> getPoolsByBranch(int branchId) throws SQLException {
        List<PoolFeedBack> list = new ArrayList<>();
        String sql = "SELECT pool_id, pool_name FROM Pools WHERE branch_id = ? ORDER BY pool_name";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, branchId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                PoolFeedBack pool = new PoolFeedBack(rs.getInt("pool_id"), rs.getString("pool_name"));
                list.add(pool);
            }
        }
        return list;
    }

    // Lấy danh sách feedback theo filter, phân trang
    public List<Feedback> getFeedbacks(
            String keyword, int poolId, int rating, String dateFilter,
            int page, int pageSize, int[] totalRowHolder, int branchId) throws SQLException {

        List<Feedback> list = new ArrayList<>();
        List<Object> params = new ArrayList<>();

        StringBuilder baseWhere = new StringBuilder("WHERE p.branch_id = ? ");
        params.add(branchId);

        if (keyword != null && !keyword.trim().isEmpty()) {
            baseWhere.append("AND (u.full_name LIKE ? OR f.comment LIKE ?) ");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
        }
        if (poolId != -1) {
            baseWhere.append("AND f.pool_id = ? ");
            params.add(poolId);
        }
        if (rating != -1) {
            baseWhere.append("AND f.rating = ? ");
            params.add(rating);
        }
        if (dateFilter != null && !"all".equals(dateFilter)) {
            if ("today".equals(dateFilter)) {
                baseWhere.append("AND CAST(f.created_at AS DATE) = CAST(GETDATE() AS DATE) ");
            } else if ("week".equals(dateFilter)) {
                baseWhere.append("AND f.created_at >= DATEADD(DAY, -7, GETDATE()) ");
            } else if ("month".equals(dateFilter)) {
                baseWhere.append("AND f.created_at >= DATEADD(MONTH, -1, GETDATE()) ");
            }
        }

        StringBuilder sql = new StringBuilder();
        sql.append("SELECT f.feedback_id, f.user_id, f.pool_id, f.rating, f.comment, f.created_at, ")
                .append("u.full_name as user_name, u.images as user_image, u.email as user_email, p.pool_name, f.replied ") // Thêm f.replied
                .append("FROM Feedbacks f ")
                .append("JOIN Users u ON f.user_id = u.user_id ")
                .append("JOIN Pools p ON f.pool_id = p.pool_id ")
                .append(baseWhere)
                .append("ORDER BY f.created_at ASC ")
                .append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try (PreparedStatement stmt = connection.prepareStatement(sql.toString())) {
            int idx = 1;
            for (Object p : params) {
                stmt.setObject(idx++, p);
            }
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Feedback fb = new Feedback();
                fb.setFeedbackId(rs.getInt("feedback_id"));
                fb.setUserId(rs.getInt("user_id"));
                fb.setPoolId(rs.getInt("pool_id"));
                fb.setRating(rs.getInt("rating"));
                fb.setComment(rs.getString("comment"));
                fb.setCreatedAt(rs.getTimestamp("created_at"));
                fb.setUserName(rs.getString("user_name"));
                fb.setUserImage(rs.getString("user_image"));
                fb.setPoolName(rs.getString("pool_name"));
                fb.setUserEmail(rs.getString("user_email"));
                fb.setReplied(rs.getBoolean("replied")); // mapping trường mới
                list.add(fb);
            }
        }

        // Đếm tổng số dòng
        StringBuilder countSql = new StringBuilder();
        countSql.append("SELECT COUNT(*) ")
                .append("FROM Feedbacks f ")
                .append("JOIN Users u ON f.user_id = u.user_id ")
                .append("JOIN Pools p ON f.pool_id = p.pool_id ")
                .append(baseWhere);

        try (PreparedStatement stmt = connection.prepareStatement(countSql.toString())) {
            int idx = 1;
            for (Object p : params.subList(0, params.size() - 2)) { // không dùng offset & pageSize
                stmt.setObject(idx++, p);
            }
            ResultSet rs = stmt.executeQuery();
            if (rs.next() && totalRowHolder != null && totalRowHolder.length > 0) {
                totalRowHolder[0] = rs.getInt(1);
            }
        }

        return list;
    }

    // Chỉ cho phép xóa khi feedback thuộc chi nhánh manager quản lý
    public boolean deleteFeedback(int feedbackId, int branchId) throws SQLException {
        String sql = "DELETE FROM Feedbacks WHERE feedback_id = ? AND pool_id IN (SELECT pool_id FROM Pools WHERE branch_id = ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, feedbackId);
            stmt.setInt(2, branchId);
            return stmt.executeUpdate() > 0;
        }
    }

    public Feedback getFeedbackById(int id, int branchId) throws SQLException {
        String sql = "SELECT f.*, u.full_name as user_name, u.images as user_image, u.email as user_email, p.pool_name "
                + "FROM Feedbacks f "
                + "JOIN Users u ON f.user_id = u.user_id "
                + "JOIN Pools p ON f.pool_id = p.pool_id "
                + "WHERE f.feedback_id = ? AND p.branch_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            stmt.setInt(2, branchId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Feedback fb = new Feedback();
                fb.setFeedbackId(rs.getInt("feedback_id"));
                fb.setUserId(rs.getInt("user_id"));
                fb.setPoolId(rs.getInt("pool_id"));
                fb.setRating(rs.getInt("rating"));
                fb.setComment(rs.getString("comment"));
                fb.setCreatedAt(rs.getTimestamp("created_at"));
                fb.setUserName(rs.getString("user_name"));
                fb.setUserImage(rs.getString("user_image"));
                fb.setUserEmail(rs.getString("user_email"));
                fb.setPoolName(rs.getString("pool_name"));
                fb.setReplied(rs.getBoolean("replied")); // <--- mapping trường mới
                return fb;
            }
        }
        return null;
    }

    public boolean markFeedbackReplied(int feedbackId, String replyContent, int managerId) throws SQLException {
        String sql = "UPDATE Feedbacks SET replied = 1, reply_content = ?, reply_at = GETDATE(), replied_by = ? WHERE feedback_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, replyContent);
            stmt.setInt(2, managerId);
            stmt.setInt(3, feedbackId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean markFeedbackReplied(int feedbackId) throws SQLException {
        String sql = "UPDATE Feedbacks SET replied = 1 WHERE feedback_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, feedbackId);
            return stmt.executeUpdate() > 0;
        }
    }

    public static void main(String[] args) {

        FeedbackDAO dao = new FeedbackDAO();

        int[] totalRows = new int[1];
        try {
            int branchId;
            // Gọi hàm test

            List<Feedback> feedbacks = dao.getFeedbacks(
                    "", // keyword
                    -1, // poolId (-1 để bỏ lọc)
                    -1, // rating (-1 để bỏ lọc)
                    "month", // dateFilter
                    1, // page
                    10, // pageSize
                    totalRows, // total row holder
                    branchId = 1
            );

            // In tổng số dòng
            System.out.println("Tổng số dòng thỏa mãn filter: " + totalRows[0]);

            // In danh sách feedbacks
            for (Feedback fb : feedbacks) {
                System.out.println("FeedbackID: " + fb.getFeedbackId()
                        + ", User: " + fb.getUserName()
                        + ", Email: " + fb.getUserEmail()
                        + ", Pool: " + fb.getPoolName()
                        + ", Rating: " + fb.getRating()
                        + ", Comment: " + fb.getComment()
                        + ", Date: " + fb.getCreatedAt());
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

}
