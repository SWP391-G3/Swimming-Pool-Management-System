/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.admin;

import dal.DBContext;
import java.util.ArrayList;
import java.sql.*;
import java.time.LocalDate;
import java.util.List;
import model.admin.CustomerFeedback;

/**
 *
 * @author Lenovo
 */
public class CustomerFeedbackDAO extends DBContext {

    public CustomerFeedback getLastFeedback(int user_id) {
        String sql = "SELECT \n"
                + "    u.full_name AS customer_name,\n"
                + "    p.pool_name,\n"
                + "    f.rating,\n"
                + "    f.comment,\n"
                + "    f.created_at\n"
                + "FROM Feedbacks f\n"
                + "JOIN Users u ON f.user_id = u.user_id\n"
                + "JOIN Pools p ON f.pool_id = p.pool_id\n"
                + "WHERE u.user_id = ?\n"
                + "ORDER BY f.created_at DESC;";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, user_id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                String customer_name = rs.getString("customer_name");
                String pool_name = rs.getString("pool_name");
                int rating = rs.getInt("rating");
                String comment = rs.getString("comment");
                LocalDate created_at = rs.getDate("created_at").toLocalDate();

                return new CustomerFeedback(customer_name, pool_name, rating, comment, created_at);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
    
    
    public static void main(String[] args) {
        CustomerFeedbackDAO dao = new CustomerFeedbackDAO();
        CustomerFeedback c = dao.getLastFeedback(32);
        System.out.println(c.toString());
    }
}
