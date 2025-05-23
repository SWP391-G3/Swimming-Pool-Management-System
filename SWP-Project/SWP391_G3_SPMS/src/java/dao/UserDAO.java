/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.User;

/**
 *
 * @author Lenovo
 */
public class UserDAO extends DBContext {

    public List<User> list;

    public List<User> getAllUser() throws SQLException {
        list = new ArrayList<>();
        String sql = "Select * from Users";
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            list.add(new User(rs.getInt(1), rs.getString(2), rs.getString(3),
                    rs.getString(4), rs.getString(5), rs.getString(6),
                    rs.getString(7), rs.getInt(8),
                    rs.getBoolean(9), rs.getDate(10), rs.getDate(11)));
        }
        return list;
    }

    public  User getUserById(int user_id) {
        User user = null;
        try {

            String sql = "SELECT * FROM Users WHERE user_id = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, user_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User(
                        rs.getInt("user_id"),
                        rs.getString("username"),
                        rs.getString("password"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getInt("role_id"),
                        rs.getBoolean("status"),
                        rs.getTimestamp("created_at"),
                        rs.getTimestamp("updated_at")
                );
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    public boolean updateUserInfo(int userId, String fullName, String email, String phone, String address) {
        try ( 
             PreparedStatement ps = connection.prepareStatement(
                 "UPDATE Users SET full_name=?, email=?, phone=?, address=?, updated_at=GETDATE() WHERE user_id=?")) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setInt(5, userId);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    
    
    public static void main(String[] args) {
        
        
        UserDAO dao = new UserDAO();
        
        User user1 = dao.getUserById(3);
        
        System.out.println(user1);
        
        
                
               
    }

}

 
        
        
     
        

