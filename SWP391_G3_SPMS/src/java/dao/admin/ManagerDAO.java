/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.admin;

import dal.DBContext;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.time.LocalDate;
import model.admin.Manager;

/**
 *
 * @author Lenovo
 */
public class ManagerDAO extends DBContext {

    public List<Manager> getAllManager() {
        List<Manager> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    u.user_id, \n"
                + "    u.full_name, \n"
                + "    u.email, \n"
                + "    u.phone, \n"
                + "    u.address, \n"
                + "    u.status, \n"
                + "    u.created_at, \n"
                + "    u.updated_at,\n"
                + "    b.branch_id, \n"
                + "    b.branch_name \n"
                + "FROM Users u\n"
                + "JOIN Roles r ON u.role_id = r.role_id\n"
                + "LEFT JOIN Branchs b ON b.manager_id = u.user_id\n"
                + "WHERE r.role_name = 'Manager';";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int manager_id = rs.getInt("user_id");
                String full_name = rs.getString("full_name");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                Boolean status = rs.getBoolean("status");
                LocalDate created_at = rs.getDate("created_at").toLocalDate();
                int branch_id = rs.getInt("branch_id");
                String branch_name = rs.getString("branch_name");

                Manager manager = new Manager(manager_id, full_name, email, phone, address, status, created_at, branch_id, branch_name);
                list.add(manager);
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}
