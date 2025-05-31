package dao;

import dal.DBContext;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Vector;
import model.User;
import util.PasswordEncryption;

public class UserDAO extends DBContext {

    public Vector<User> getAllUser() {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<User> users = new Vector<>();
        String sql = "SELECT * FROM Users";
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setRoleId(rs.getInt("role_id"));
                u.setStatus(rs.getBoolean("status"));
                u.setDob(rs.getDate("dob"));
                u.setGender(rs.getString("gender"));
                u.setImages(rs.getString("images"));
                u.setCreatedAt(rs.getDate("created_at"));
                u.setUpdatedAt(rs.getDate("updated_at"));
                users.add(u);
            }
            return users;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Vector<User> getUserById(int uid) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<User> users = new Vector<>();
        String sql = "SELECT * FROM Users WHERE user_id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, uid);
            rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setRoleId(rs.getInt("role_id"));
                u.setStatus(rs.getBoolean("status"));
                u.setDob(rs.getDate("dob"));
                u.setGender(rs.getString("gender"));
                u.setImages(rs.getString("images"));
                u.setCreatedAt(rs.getDate("created_at"));
                u.setUpdatedAt(rs.getDate("updated_at"));
                users.add(u);
            }
            return users;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public User getUserByID(int userId) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM Users WHERE user_id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, userId);
            rs = stm.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setRoleId(rs.getInt("role_id"));
                u.setStatus(rs.getBoolean("status"));
                u.setDob(rs.getDate("dob"));
                u.setGender(rs.getString("gender"));
                u.setImages(rs.getString("images"));
                u.setCreatedAt(rs.getDate("created_at"));
                u.setUpdatedAt(rs.getDate("updated_at"));
                return u;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Vector<User> getUserByName(String name) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<User> customers = new Vector<>();
        String sql = "SELECT * FROM Users WHERE full_name LIKE ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + name + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setRoleId(rs.getInt("role_id"));
                u.setStatus(rs.getBoolean("status"));
                u.setDob(rs.getDate("dob"));
                u.setGender(rs.getString("gender"));
                u.setImages(rs.getString("images"));
                u.setCreatedAt(rs.getDate("created_at"));
                u.setUpdatedAt(rs.getDate("updated_at"));
                customers.add(u);
            }
            return customers;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Vector<User> getAllCustomer() {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<User> users = new Vector<>();
        String sql = "SELECT * FROM Users WHERE role_id = 4";
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setRoleId(rs.getInt("role_id"));
                u.setStatus(rs.getBoolean("status"));
                u.setDob(rs.getDate("dob"));
                u.setGender(rs.getString("gender"));
                u.setImages(rs.getString("images"));
                u.setCreatedAt(rs.getDate("created_at"));
                u.setUpdatedAt(rs.getDate("updated_at"));
                users.add(u);
            }
            return users;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Vector<User> getCustomerByName(String name) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<User> customers = new Vector<>();
        String sql = "SELECT * FROM Users WHERE role_id = 4 AND full_name LIKE ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + name + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUserId(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFullName(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setRoleId(rs.getInt("role_id"));
                u.setStatus(rs.getBoolean("status"));
                u.setDob(rs.getDate("dob"));
                u.setGender(rs.getString("gender"));
                u.setImages(rs.getString("images"));
                u.setCreatedAt(rs.getDate("created_at"));
                u.setUpdatedAt(rs.getDate("updated_at"));
                customers.add(u);
            }
            return customers;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void updateUser(User user) {
        String sql = "UPDATE Users SET full_name = ?, email = ?, phone = ?, address = ?, dob = ?, gender = ?, images = ?, updated_at = GETDATE() WHERE user_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, user.getFullName());
            stm.setString(2, user.getEmail());
            stm.setString(3, user.getPhone());
            stm.setString(4, user.getAddress());
            if (user.getDob() != null) {
                stm.setDate(5, new java.sql.Date(user.getDob().getTime()));
            } else {
                stm.setNull(5, java.sql.Types.DATE);
            }
            stm.setString(6, user.getGender());
            stm.setString(7, user.getImages());
            stm.setInt(8, user.getUserId());
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updatePassword(int userId, String newPassword) {
        String sql = "UPDATE Users SET password = ?, updated_at = GETDATE() WHERE user_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            String hash = PasswordEncryption.hashPassword(newPassword);
            stm.setString(1, hash);
            stm.setInt(2, userId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void deleteUser(int userId) {
        PreparedStatement stm = null;
        String sql = "DELETE FROM Users WHERE user_id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, userId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean checkLogin(String username, String inputPassword) {
        String sql = "SELECT password FROM Users WHERE username = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                String storedHash = rs.getString("password");
                return PasswordEncryption.checkPassword(inputPassword, storedHash);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
