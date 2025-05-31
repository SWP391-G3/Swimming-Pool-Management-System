package dao;

import dal.DBContext;
import model.Feedback;
import model.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO extends DBContext {

    // Lấy danh sách feedback của 1 user theo userId
    public List<Feedback> getFeedbackByUserId(int uid) throws SQLException {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM Feedback WHERE user_id = ? ORDER BY created_at DESC";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, uid);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            Feedback fb = new Feedback(
                    rs.getInt("feedback_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
                    rs.getInt("rating"),
                    rs.getString("comment"),
                    rs.getTimestamp("created_at")
            );
            list.add(fb);
        }
        return list;
    }

    // Gửi feedback mới, truyền vào User và các trường cần thiết của feedback
    public boolean sendFeedback(User user, int poolId, int rating, String comment) throws SQLException {
        String sql = "INSERT INTO Feedback (user_id, pool_id, rating, comment, created_at) VALUES (?, ?, ?, ?, GETDATE())";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, user.getUserId());
        st.setInt(2, poolId);
        st.setInt(3, rating);
        st.setString(4, comment);
        int rows = st.executeUpdate();
        return rows > 0;
    }
}
