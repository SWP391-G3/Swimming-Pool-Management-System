/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.admin;

import dal.DBContext;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import model.admin.EmployeeAccount;

/**
 *
 * @author Lenovo
 */
public class EmployeeAccountDAO extends DBContext {

    public void addNewEmployee(EmployeeAccount emp) {
        String insertUserSQL = "INSERT INTO Users "
                + "(username, password, full_name, email, phone, address, role_id, status, dob, gender, images) "
                + "VALUES (?, ?, ?, ?, ?, ?, 3, ?, ?, ?, NULL)";

        String insertStaffSQL = "INSERT INTO Staffs "
                + "(user_id, branch_id, pool_id, staff_type_id) "
                + "VALUES (?, ?, ?, ?)";

        try {
            connection.setAutoCommit(false); // Bắt đầu transaction

            int userId = -1;

            // 1. Insert Users
            try (PreparedStatement st = connection.prepareStatement(insertUserSQL, Statement.RETURN_GENERATED_KEYS)) {
                st.setString(1, emp.getUsername());
                st.setString(2, emp.getPassword()); // hash nếu cần
                st.setString(3, emp.getFullName());
                st.setString(4, emp.getEmail());
                st.setString(5, emp.getPhone());
                st.setString(6, emp.getAddress());
                st.setBoolean(7, emp.getStatus());
                st.setDate(8, Date.valueOf(emp.getDob()));
                st.setString(9, emp.getGender());

                int affectedRows = st.executeUpdate();
                if (affectedRows == 0) {
                    throw new SQLException("Insert Users failed.");
                }

                try (ResultSet rs = st.getGeneratedKeys()) {
                    if (rs.next()) {
                        userId = rs.getInt(1);
                    } else {
                        throw new SQLException("Không lấy được user_id.");
                    }
                }
            }

            // 2. Insert Staffs
            try (PreparedStatement st2 = connection.prepareStatement(insertStaffSQL)) {
                st2.setInt(1, userId);
                st2.setInt(2, emp.getBranchId());
                st2.setInt(3, emp.getPoolId());
                st2.setInt(4, emp.getStaffTypeId());
                st2.executeUpdate();
            }

            connection.commit(); // OK

        } catch (Exception e) {
            try {
                connection.rollback(); // rollback nếu lỗi
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
        }
    }

    public EmployeeAccount getEmployeeAccount(int staffId) {
        String sql = "SELECT u.username, u.password, u.full_name, u.email, u.phone, u.gender, u.dob, u.address, u.status, "
                + "s.staff_id, s.branch_id, s.pool_id, s.staff_type_id "
                + "FROM Staffs s "
                + "JOIN Users u ON s.user_id = u.user_id "
                + "WHERE s.staff_id = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, staffId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                EmployeeAccount emp = new EmployeeAccount();

                emp.setUsername(rs.getString("username"));
                emp.setPassword(rs.getString("password"));
                emp.setFullName(rs.getString("full_name"));
                emp.setEmail(rs.getString("email"));
                emp.setPhone(rs.getString("phone"));
                emp.setGender(rs.getString("gender"));

                Date dob = rs.getDate("dob");
                if (dob != null) {
                    emp.setDob(dob.toLocalDate());
                }

                emp.setAddress(rs.getString("address"));
                emp.setStatus(rs.getBoolean("status"));

                int branchId = rs.getInt("branch_id");
                emp.setBranchId(rs.wasNull() ? null : branchId);

                int poolId = rs.getInt("pool_id");
                emp.setPoolId(rs.wasNull() ? null : poolId);

                int staffTypeId = rs.getInt("staff_type_id");
                emp.setStaffTypeId(rs.wasNull() ? null : staffTypeId);

                return emp;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

}
