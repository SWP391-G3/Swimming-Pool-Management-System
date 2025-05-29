package dao;

import dal.DBContext;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.User;

public class UserDAO extends DBContext {

    public List<User> getAllUser() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";

        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Date createdDate = rs.getDate("created_at");
                Date updatedDate = rs.getDate("updated_at");
                Date dob = rs.getDate("dob");

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;

                list.add(new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getInt("role_id"),
                        rs.getBoolean("status"),
                        dob,
                        rs.getString("images"),
                        createdAt,
                        updatedAt
                ));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public User getUserByUsernameAndPassword(String username, String password) {
        String sql = "SELECT * FROM Users WHERE username = ? AND password = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Date createdDate = rs.getDate("created_at");
                Date updatedDate = rs.getDate("updated_at");
                Date dob = rs.getDate("dob");

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;

                return new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getInt("role_id"),
                        rs.getBoolean("status"),
                        dob,
                        rs.getString("images"),
                        createdAt,
                        updatedAt
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insertUser(User user) {
        String sql = "INSERT INTO Users (username, password, full_name, email, phone, address, role_id, status, dob, images, created_at) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getUsername());
            st.setString(2, user.getPassword());
            st.setString(3, user.getFull_name());
            st.setString(4, user.getEmail());
            st.setString(5, user.getPhone());
            st.setString(6, user.getAddress());
            st.setInt(7, user.getRole_id());
            st.setBoolean(8, user.isStatus());
            st.setDate(9, user.getDob() != null ? new java.sql.Date(user.getDob().getTime()) : null);
            st.setString(10, user.getImages());
            st.setDate(11, java.sql.Date.valueOf(user.getCreate_at()));
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE email = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Date createdDate = rs.getDate("created_at");
                Date updatedDate = rs.getDate("updated_at");
                Date dob = rs.getDate("dob");

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;

                return new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getInt("role_id"),
                        rs.getBoolean("status"),
                        dob,
                        rs.getString("images"),
                        createdAt,
                        updatedAt
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
