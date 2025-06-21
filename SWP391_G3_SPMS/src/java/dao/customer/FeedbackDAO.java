package dao.customer;

import dal.DBContext;
import model.customer.Feedback;
import model.customer.User;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FeedbackDAO extends DBContext {

    public List<Feedback> list;

    // Get feedback by userId
    public List<Feedback> getFeedbackByUserId(int uid) throws SQLException {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM Feedbacks WHERE user_id = ? ORDER BY created_at DESC";
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

    // Send feedback by user
    public boolean sendFeedback(User user, int poolId, int rating, String comment) throws SQLException {
        String sql = "INSERT INTO Feedbacks (user_id, pool_id, rating, comment, created_at) VALUES (?, ?, ?, ?, GETDATE())";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, user.getUser_id());
        st.setInt(2, poolId);
        st.setInt(3, rating);
        st.setString(4, comment);
        int rows = st.executeUpdate();
        return rows > 0;
    }

    //Get all feedback
    public List<Feedback> getFeedback() {
        List<Feedback> list = new ArrayList<>();
        String sql = "SELECT * FROM Feedbacks";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                // Giả sử có các cột id, comment, rating
                list.add(new Feedback(
                        rs.getInt("feedback_id"),
                    rs.getInt("user_id"),
                    rs.getInt("pool_id"),
                    rs.getInt("rating"),
                    rs.getString("comment"),
                    rs.getTimestamp("created_at")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }
}
