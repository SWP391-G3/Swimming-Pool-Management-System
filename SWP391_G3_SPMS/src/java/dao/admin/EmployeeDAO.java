/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.admin;

import dal.DBContext;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import model.admin.AccountBanLog;
import model.admin.Branch;
import model.admin.Employee;
import model.admin.StaffType;

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
            throw new RuntimeException(e.getMessage());
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
            throw new RuntimeException(e.getMessage());
        }
        return 0;
    }

    public List<Branch> getAllBranches() {
        List<Branch> listBranch = new ArrayList<>();
        String sql = "SELECT branch_id, branch_name FROM Branchs";

        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Branch b = new Branch();
                b.setBranch_id(rs.getInt("branch_id"));
                b.setBranch_name(rs.getString("branch_name"));
                listBranch.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listBranch;
    }

    public List<StaffType> getAllStaffTypes() {
        List<StaffType> listStaffTypes = new ArrayList<>();
        String sql = "SELECT Distinct\n"
                + "    st.staff_type_id,\n"
                + "    st.type_name\n"
                + "FROM Staff_Types st\n"
                + "LEFT JOIN Staffs s ON st.staff_type_id = s.staff_type_id\n"
                + "order by st.staff_type_id";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                StaffType s = new StaffType();
                s.setStaffTypeID(rs.getInt(1));
                s.setType_name(rs.getString(2));
                listStaffTypes.add(s);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
        return listStaffTypes;
    }

    public List<Employee> getFilteredEmployeesByPage(String keyword, String branchName, String staffTypeName, String status, int start, int perPage) {
        StringBuilder sql = new StringBuilder(
                "SELECT s.staff_id, u.full_name, u.email, u.phone, u.address, u.dob, u.gender, u.images, u.status, \n"
                + "b.branch_id, b.branch_name, p.pool_id, p.pool_name, st.staff_type_id, st.type_name AS staff_type_name, st.description AS staff_type_description \n"
                + "FROM Staffs s \n"
                + "JOIN Users u ON s.user_id = u.user_id \n"
                + "LEFT JOIN Branchs b ON s.branch_id = b.branch_id \n"
                + "LEFT JOIN Pools p ON s.pool_id = p.pool_id \n"
                + "LEFT JOIN Staff_Types st ON s.staff_type_id = st.staff_type_id \n"
                + "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (u.full_name LIKE ? OR u.email LIKE ?) ");
            String kw = "%" + keyword.trim() + "%";
            params.add(kw);
            params.add(kw);
        }

        if (branchName != null && !branchName.trim().isEmpty()) {
            sql.append("AND b.branch_name = ? ");
            params.add(branchName.trim());
        }

        if (staffTypeName != null && !staffTypeName.trim().isEmpty()) {
            sql.append("AND st.type_name = ? ");
            params.add(staffTypeName.trim());
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND u.status = ? ");
            params.add(Boolean.parseBoolean(status.trim()));
        }

        sql.append("ORDER BY s.staff_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(start);
        params.add(perPage);

        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }

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
            throw new RuntimeException(e.getMessage());
        }

        return list;
    }

    public int getFilteredEmployeeCount(String keyword, String branchName, String staffTypeName, String status) {
        int count = 0;
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) \n"
                + "FROM Staffs s \n"
                + "JOIN Users u ON s.user_id = u.user_id \n"
                + "LEFT JOIN Branchs b ON s.branch_id = b.branch_id \n"
                + "LEFT JOIN Staff_Types st ON s.staff_type_id = st.staff_type_id \n"
                + "WHERE 1=1 "
        );

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (u.full_name LIKE ? OR u.email LIKE ?) ");
            String kw = "%" + keyword.trim() + "%";
            params.add(kw);
            params.add(kw);
        }

        if (branchName != null && !branchName.trim().isEmpty()) {
            sql.append("AND b.branch_name = ? ");
            params.add(branchName.trim());
        }

        if (staffTypeName != null && !staffTypeName.trim().isEmpty()) {
            sql.append("AND st.type_name = ? ");
            params.add(staffTypeName.trim());
        }

        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND u.status = ? ");
            params.add(Boolean.parseBoolean(status.trim()));
        }

        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }

        return count;
    }

    public Employee getEmployeeById(int id) {
        String sql = "SELECT s.staff_id, u.full_name, u.email, u.phone, u.address, u.dob, u.gender, u.images, u.status,\n"
                + "     b.branch_id, b.branch_name, p.pool_id, p.pool_name, st.staff_type_id, st.type_name AS staff_type_name, st.description AS staff_type_description \n"
                + "              FROM Staffs s \n"
                + "                JOIN Users u ON s.user_id = u.user_id \n"
                + "                LEFT JOIN Branchs b ON s.branch_id = b.branch_id \n"
                + "                LEFT JOIN Pools p ON s.pool_id = p.pool_id \n"
                + "                LEFT JOIN Staff_Types st ON s.staff_type_id = st.staff_type_id \n"
                + "                WHERE s.staff_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
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
                return emp;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
        return null;
    }

    public boolean updateStaffStatus(int id, boolean status) {
        String sql = "UPDATE Users SET status = ? WHERE role_id = 3 and user_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setBoolean(1, status);
            st.setInt(2, id);
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public int getUserIdByStaffId(int staffId) {
        int result;
        String sql = "  select u.user_id\n"
                + "  from Users u\n"
                + "  join Staffs s on s.user_id = u.user_id\n"
                + "  where s.staff_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, staffId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                result = rs.getInt(1);
                return result;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
        return 0;
    }

    public boolean editUserByStaffId(String fullName, String email, String phone, Date dob,
            String gender, String address, int staffId) {
        String sql = """
        UPDATE Users
        SET full_name = ?, email = ?, phone = ?, dob = ?, gender = ?, address = ?, updated_at = GETDATE()
        WHERE user_id = (SELECT user_id FROM Staffs WHERE staff_id = ?)
    """;
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, fullName);
            st.setString(2, email);
            st.setString(3, phone);
            st.setDate(4, dob);
            st.setString(5, gender);
            st.setString(6, address);
            st.setInt(7, staffId);

            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public boolean editStaffInfo(int branchId, int poolId, int staffTypeId, int staffId) {
        String sql = """
        UPDATE Staffs
        SET branch_id = ?, pool_id = ?, staff_type_id = ?
        WHERE staff_id = ?
    """;
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, branchId);
            st.setInt(2, poolId);
            st.setInt(3, staffTypeId);
            st.setInt(4, staffId);

            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE role_id = 3 and email = ? ";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, email);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0; // true nếu trùng
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
        return false;
    }

    public boolean isEmailExistsForOtherUser(String email, int currentUserId) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ? AND user_id != ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setInt(2, currentUserId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
        return false;
    }

    public void insert(AccountBanLog banLog) {
        String sql = "INSERT INTO Account_Ban_Log (user_id, banned_by, reason, is_permanent) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, banLog.getUserId());
            ps.setInt(2, banLog.getBannedBy());
            ps.setString(3, banLog.getReason());
            ps.setBoolean(4, banLog.isIsPermanent());
            ps.executeUpdate();
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public static void main(String[] args) {
        EmployeeDAO dao = new EmployeeDAO();
        Employee e = dao.getEmployeeById(16);
        int count = dao.getUserIdByStaffId(17);
        System.out.println(count);
    }

}
