/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.admin;

import dal.DBContext;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import model.admin.Employee;

/**
 *
 * @author Lenovo
 */
public class EmployeeDAO extends DBContext {

    public List<Employee> list;

    public EmployeeDAO() {
        list = new ArrayList<>();
    }

    public List<Employee> getEmployeeByPage(int start, int perRecordEmployee) {
        List<Employee> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    s.staff_id,\n"
                + "    u.full_name,\n"
                + "    u.email,\n"
                + "    u.phone,\n"
                + "    u.address,\n"
                + "    u.dob,\n"
                + "    u.gender,\n"
                + "    u.images,\n"
                + "    u.status,\n"
                + "    b.branch_id,\n"
                + "    b.branch_name,\n"
                + "    p.pool_id,\n"
                + "    p.pool_name,\n"
                + "    st.staff_type_id,\n"
                + "    st.type_name AS staff_type_name,\n"
                + "    st.description AS staff_type_description\n"
                + "FROM Staffs s\n"
                + "JOIN Users u ON s.user_id = u.user_id\n"
                + "LEFT JOIN Branchs b ON s.branch_id = b.branch_id\n"
                + "LEFT JOIN Pools p ON s.pool_id = p.pool_id\n"
                + "LEFT JOIN Staff_Types st ON s.staff_type_id = st.staff_type_id\n"
                + "ORDER BY s.staff_id\n"
                + "OFFSET ? ROWS\n"
                + "FETCH NEXT ? ROWS ONLY;";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, start);
            st.setInt(2, perRecordEmployee);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Employee emp = new Employee();
                emp.setStaffId(rs.getInt("staff_id"));
                emp.setFullName(rs.getString("full_name"));
                emp.setEmail(rs.getString("email"));
                emp.setPhone(rs.getString("phone"));
                emp.setAddress(rs.getString("address"));

                Date dob = rs.getDate("dob");
                if (dob != null) {
                    emp.setDob(dob.toLocalDate());
                }

                emp.setGender(rs.getString("gender"));
                emp.setImages(rs.getString("images"));
                emp.setStatus(rs.getBoolean("status"));

                int branchId = rs.getInt("branch_id");
                emp.setBranchId(rs.wasNull() ? null : branchId);
                emp.setBranchName(rs.getString("branch_name"));

                int poolId = rs.getInt("pool_id");
                emp.setPoolId(rs.wasNull() ? null : poolId);
                emp.setPoolName(rs.getString("pool_name"));

                int staffTypeId = rs.getInt("staff_type_id");
                emp.setStaffTypeId(rs.wasNull() ? null : staffTypeId);
                emp.setStaffTypeName(rs.getString("staff_type_name"));
                emp.setStaffTypeDescription(rs.getString("staff_type_description"));

                list.add(emp);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int getTotalEmployeeCount() {
        String sql = "SELECT COUNT(*) FROM Staffs";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

}
