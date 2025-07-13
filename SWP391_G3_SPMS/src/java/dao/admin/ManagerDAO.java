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
import model.admin.AccountBanLog;
import model.customer.User;
import model.admin.Branch;
import model.admin.Manager;

/**
 *
 * @author Lenovo
 */
public class ManagerDAO extends DBContext {

    public List<Manager> getAllManagersWithPaging(int page, int pageSize) {
        List<Manager> list = new ArrayList<>();
        String sql = "SELECT \n"
                + "    u.user_id, \n"
                + "    u.full_name, \n"
                + "    u.email, \n"
                + "    u.phone, \n"
                + "    u.address, \n"
                + "    u.status, \n"
                + "    u.created_at, \n"
                + "    u.updated_at, \n"
                + "    b.branch_id, \n"
                + "    b.branch_name \n"
                + "FROM Users u \n"
                + "JOIN Roles r ON u.role_id = r.role_id \n"
                + "LEFT JOIN Branchs b ON b.manager_id = u.user_id \n"
                + "WHERE r.role_name = 'Manager' \n"
                + "ORDER BY u.created_at DESC \n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            int offset = (page - 1) * pageSize;
            st.setInt(1, offset);
            st.setInt(2, pageSize);

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
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countTotalManagers() {
        String sql = "SELECT COUNT(*) FROM Users u JOIN Roles r ON u.role_id = r.role_id WHERE r.role_name = 'Manager'";
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

    public int countManagers(String keyword, String branch, String status) {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) "
                + "FROM Users u "
                + "JOIN Roles r ON u.role_id = r.role_id "
                + "LEFT JOIN Branchs b ON u.user_id = b.manager_id "
                + "WHERE r.role_name = 'Manager' ");

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (u.full_name LIKE ? OR u.email LIKE ?) ");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        if (branch != null && !branch.isEmpty()) {
            sql.append(" AND b.branch_name = ? ");
            params.add(branch);
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND u.status = ? ");
            params.add(Boolean.parseBoolean(status));
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<Manager> searchManagers(String keyword, String branch, String status, int offset, int limit) {
        List<Manager> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT u.user_id, u.full_name, u.email, u.phone, u.address, u.status, u.created_at, "
                + "b.branch_id, b.branch_name "
                + "FROM Users u "
                + "JOIN Roles r ON u.role_id = r.role_id "
                + "LEFT JOIN Branchs b ON u.user_id = b.manager_id "
                + "WHERE r.role_name = 'Manager' ");

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.isEmpty()) {
            sql.append(" AND (u.full_name LIKE ? OR u.email LIKE ?) ");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        if (branch != null && !branch.isEmpty()) {
            sql.append(" AND b.branch_name = ? ");
            params.add(branch);
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND u.status = ? ");
            params.add(Boolean.parseBoolean(status));
        }

        sql.append(" ORDER BY u.created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");
        params.add(offset);
        params.add(limit);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Manager m = new Manager();
                m.setManager_id(rs.getInt("user_id"));
                m.setFull_name(rs.getString("full_name"));
                m.setEmail(rs.getString("email"));
                m.setPhone(rs.getString("phone"));
                m.setAddress(rs.getString("address"));
                m.setStatus(rs.getBoolean("status"));
                m.setCreate_at(rs.getDate("created_at").toLocalDate());

                int branchId = rs.getInt("branch_id");
                m.setBranch_id(rs.wasNull() ? -1 : branchId);

                String branchName = rs.getString("branch_name");
                m.setBranch_name(branchName != null ? branchName : "Chưa phân công");

                list.add(m);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean updateManagerStatus(int id, boolean status) {
        String sql = "UPDATE Users SET status = ? WHERE role_id = 2 and user_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setBoolean(1, status);
            st.setInt(2, id);
            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (Exception e) {
            e.printStackTrace(); // hoặc log ra logger nếu có
            return false;
        }
    }

    public boolean updateManager(Manager manager) {
        String updateUserSQL = "UPDATE Users SET full_name = ?, email = ?, phone = ?, address = ?, status = ?, updated_at = GETDATE() WHERE user_id = ?";
        String resetOldBranchSQL = "UPDATE Branchs SET manager_id = NULL WHERE manager_id = ?";
        String updateBranchSQL = "UPDATE Branchs SET manager_id = ? WHERE branch_id = ?";

        try (
                PreparedStatement psUser = connection.prepareStatement(updateUserSQL); PreparedStatement psReset = connection.prepareStatement(resetOldBranchSQL); PreparedStatement psBranch = connection.prepareStatement(updateBranchSQL)) {
            // Update Users
            psUser.setString(1, manager.getFull_name());
            psUser.setString(2, manager.getEmail());
            psUser.setString(3, manager.getPhone());
            psUser.setString(4, manager.getAddress());
            psUser.setBoolean(5, manager.getStatus());
            psUser.setInt(6, manager.getManager_id());
            psUser.executeUpdate();

            // Gỡ liên kết cũ
            psReset.setInt(1, manager.getManager_id());
            psReset.executeUpdate();

            // Gán manager mới cho chi nhánh
            psBranch.setInt(1, manager.getManager_id());
            psBranch.setInt(2, manager.getBranch_id());
            psBranch.executeUpdate();

            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public Manager getManagerById(int id) {
        String sql = """
        SELECT u.user_id, u.full_name, u.email, u.phone, u.address, 
               u.status, u.created_at, b.branch_id, b.branch_name
        FROM Users u
        LEFT JOIN Branchs b ON u.user_id = b.manager_id
        WHERE u.user_id = ?
    """;

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    Manager m = new Manager();
                    m.setManager_id(rs.getInt("user_id"));
                    m.setFull_name(rs.getString("full_name"));
                    m.setEmail(rs.getString("email"));
                    m.setPhone(rs.getString("phone"));
                    m.setAddress(rs.getString("address"));
                    m.setStatus(rs.getBoolean("status"));
                    m.setCreate_at(rs.getDate("created_at").toLocalDate());

                    // Có thể NULL nên phải check
                    int branchId = rs.getInt("branch_id");
                    if (!rs.wasNull()) {
                        m.setBranch_id(branchId);
                        m.setBranch_name(rs.getString("branch_name"));
                    }

                    return m;
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Branch> getAllBranches() {
        List<Branch> list = new ArrayList<>();
        String sql = "SELECT branch_id, branch_name FROM Branchs";

        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                Branch b = new Branch();
                b.setBranch_id(rs.getInt("branch_id"));
                b.setBranch_name(rs.getString("branch_name"));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int insertManagerUser(User user) {
        int userId = -1;
        String sql = """
        INSERT INTO Users (username, password, full_name, email, phone, address, dob, gender, role_id, status, created_at)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?, 
                (SELECT role_id FROM Roles WHERE role_name = 'Manager'), 1, GETDATE())
    """;

        try (PreparedStatement ps = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getUsername());
            ps.setString(2, user.getPassword());
            ps.setString(3, user.getFull_name());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone());
            ps.setString(6, user.getAddress());
            Date dobDate = (Date) user.getDob();
            ps.setDate(7, dobDate); // dob
            ps.setString(8, user.getGender());           // gender

            ps.executeUpdate();
            ResultSet rs = ps.getGeneratedKeys();
            if (rs.next()) {
                userId = rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return userId;
    }

    public boolean assignManagerToBranch(int userId, int branchId) {
        String sql = "UPDATE Branchs SET manager_id = ? WHERE branch_id = ? AND manager_id IS NULL";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, branchId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Branch> getAvailableBranches() {
        List<Branch> list = new ArrayList<>();
        String sql = "SELECT branch_id, branch_name FROM Branchs WHERE manager_id IS NULL";

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Branch b = new Branch();
                b.setBranch_id(rs.getInt("branch_id"));
                b.setBranch_name(rs.getString("branch_name"));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public boolean isEmailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE role_id = 2 and email = ? ";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, email);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0; // true nếu trùng
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
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
        ManagerDAO dao = new ManagerDAO();
        int count = dao.countManagers("manager", "Hà Nội", "true");
        System.out.println(count);
    }

}
