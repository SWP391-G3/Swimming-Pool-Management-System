package dao;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.User;

public class UserDAO extends DBContext {

    public List<User> getAllUser() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";

        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE email = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int user_id = rs.getInt("user_id");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String full_name = rs.getString("full_name");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                int role_id = rs.getInt("role_id");
                boolean status = rs.getBoolean("status");
                java.sql.Date dob = rs.getDate("dob");
                String gender = rs.getString("gender");
                String images = rs.getString("images");

                java.sql.Date createdAtDate = rs.getDate("created_at");
                java.sql.Date updatedAtDate = rs.getDate("updated_at");
                java.time.LocalDate create_at = createdAtDate != null ? createdAtDate.toLocalDate() : null;
                java.time.LocalDate update_at = updatedAtDate != null ? updatedAtDate.toLocalDate() : null;

                // Tạo User object theo đúng constructor của bạn
                return new User(
                        user_id,
                        username,
                        password,
                        full_name,
                        email,
                        phone,
                        address,
                        role_id,
                        status,
                        dob,
                        gender,
                        images,
                        create_at,
                        update_at
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 1. Kiểm tra username đã tồn tại chưa
    public boolean isUsernameExists(String username) {
        String sql = "SELECT user_id FROM Users WHERE username = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            boolean exists = rs.next();
            rs.close();
            return exists;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. Kiểm tra email đã tồn tại chưa
    public boolean isEmailExists(String email) {
        String sql = "SELECT user_id FROM Users WHERE email = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            boolean exists = rs.next();
            rs.close();
            return exists;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM Users WHERE username = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    // Đọc các trường cần thiết, nhớ lấy cả password đã hash để so sánh!
                    int user_id = rs.getInt("user_id");
                    String password = rs.getString("password");
                    String full_name = rs.getString("full_name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    int role_id = rs.getInt("role_id");
                    boolean status = rs.getBoolean("status");
                    Date dob = rs.getDate("dob");
                    String gender = rs.getString("gender");
                    String images = rs.getString("images");
                    LocalDate create_at = rs.getDate("created_at") != null ? rs.getDate("created_at").toLocalDate() : null;
                    LocalDate update_at = rs.getDate("updated_at") != null ? rs.getDate("updated_at").toLocalDate() : null;

                    // Khởi tạo User đúng với constructor bạn đang dùng
                    return new User(user_id, username, password, full_name, email, phone, address,
                            role_id, status, dob, gender, images, create_at, update_at);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insertUser(User user) {
        String sql = "INSERT INTO Users (username, password, full_name, email, phone, address, role_id, status, dob, gender, images, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
            st.setString(10, user.getGender());
            st.setString(11, user.getImages());
            st.setDate(12, java.sql.Date.valueOf(user.getCreate_at()));
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
