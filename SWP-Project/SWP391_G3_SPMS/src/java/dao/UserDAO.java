/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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

/**
 *
 * @author Lenovo
 */
public class UserDAO extends DBContext {

    public List<User> getAllUser() {
        List<User> list = new ArrayList<>();
        String sql = "SELECT * FROM Users";

        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                Date createdDate = rs.getDate(10); // chỉnh đúng index cột nếu cần
                Date updatedDate = rs.getDate(11);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;

                list.add(new User(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(3),
                        rs.getString(4),
                        rs.getString(5),
                        rs.getString(6),
                        rs.getString(7),
                        rs.getInt(8),
                        rs.getBoolean(9), // giả sử cột boolean là cột 11, sửa theo bảng
                        createdAt,
                        updatedAt));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public User getUserByUsernameAndPassword(String username, String password) {
        String sql = "select * from Users\n"
                + "where username = ? and password = ? ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, username);
            st.setString(2, password);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Date createdDate = rs.getDate(10);
                Date updatedDate = rs.getDate(11);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                User u = new User(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getString(5), rs.getString(6),
                        rs.getString(7), rs.getInt(8), rs.getBoolean(9),
                        createdAt, updatedAt);
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insertUser(User user) {
        String sql = "insert into Users(username,password,full_name,email,phone,address,role_id,status,created_at) values (\n"
                + "	?,?,?,?,?,?,?,?,?\n"
                + ")";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getUsername());
            st.setString(2, user.getPassword());
            st.setString(3, user.getFull_name());
            st.setString(4, user.getEmail());
            st.setString(5, user.getPhone());
            st.setString(6, user.getAddress());
            st.setInt(7, user.getRole_id());
            int bitStatus;
            if (user.isStatus()) {
                bitStatus = 1;
            } else {
                bitStatus = 0;
            }
            st.setInt(8, bitStatus);
            st.setDate(9, java.sql.Date.valueOf(user.getCreate_at()));
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
