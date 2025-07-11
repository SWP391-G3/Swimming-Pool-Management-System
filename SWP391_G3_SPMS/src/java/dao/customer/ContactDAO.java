/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.customer;

import dal.DBContext;
import model.customer.Contact;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
/**
 *
 * @author LAZYVL
 */
public class ContactDAO extends DBContext{
    // Thêm liên hệ mới
    public void insertContact(Contact contact) {
        String sql = "INSERT INTO Contacts (user_id, name, email, subject, content, created_at, is_resolved) "
                   + "VALUES (?, ?, ?, ?, ?, GETDATE(), 0)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            if (contact.getUserId() != null) {
                ps.setInt(1, contact.getUserId());
            } else {
                ps.setNull(1, Types.INTEGER);
            }
            ps.setString(2, contact.getName());
            ps.setString(3, contact.getEmail());
            ps.setString(4, contact.getSubject());
            ps.setString(5, contact.getContent());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
