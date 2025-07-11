/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.admin;

import dal.DBContext;
import java.util.ArrayList;
import java.util.List;
import model.admin.Customer;
import java.sql.*;
import java.time.LocalDate;

/**
 *
 * @author Lenovo
 */
public class CustomerDAO extends DBContext {

    private List<Customer> list;

    public CustomerDAO() {
        list = new ArrayList<>();
    }

    public int getTotalCustomer() {
        int total;
        String sql = "select count(*)\n"
                + "from Users\n"
                + "where role_id = 4";
        try (PreparedStatement st = connection.prepareCall(sql)) {
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
                return total;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return -1;
    }

    public List<Customer> getCustomersAndPage(int start, int perUserPage) {
        String sql = "SELECT \n"
                + "    u.user_id,\n"
                + "    u.full_name,\n"
                + "    u.email,\n"
                + "    u.phone,\n"
                + "    u.address,\n"
                + "    u.role_id,\n"
                + "    u.dob,\n"
                + "    u.gender,\n"
                + "    u.images,\n"
                + "    r.role_name,\n"
                + "    u.status,\n"
                + "    ISNULL(SUM(p.total_amount), 0) AS total_spent\n"
                + "FROM Users AS u\n"
                + "JOIN Roles AS r ON r.role_id = u.role_id\n"
                + "LEFT JOIN Booking AS b ON u.user_id = b.user_id\n"
                + "LEFT JOIN Payments AS p ON b.booking_id = p.booking_id AND p.payment_status = 'completed'\n"
                + "WHERE u.role_id = 4\n"
                + "GROUP BY \n"
                + "    u.user_id, u.full_name, u.email, u.phone, u.address,\n"
                + "    u.role_id, u.dob, u.gender, u.images, r.role_name, u.status\n"
                + "ORDER BY u.user_id\n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        try (PreparedStatement st = connection.prepareCall(sql)) {
            st.setInt(1, start);
            st.setInt(2, perUserPage);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date dobRaw = rs.getDate(7);
                LocalDate dob = (dobRaw != null) ? dobRaw.toLocalDate() : null;

                list.add(new Customer(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getInt(6), dob, rs.getString(8), rs.getString(9), rs.getString(10), rs.getBoolean(11), rs.getDouble(12)
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public void lockCustomer(int customerId, Boolean status) {
        String sql = "update Users\n"
                + "set status = ?\n"
                + "where user_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            int bitStatus;
            if (status) {
                bitStatus = 1;
            } else {
                bitStatus = 0;
            }
            st.setInt(1, bitStatus);
            st.setInt(2, customerId);
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public Customer getCustomerById(int id) {
        String sql = "SELECT \n"
                + "    u.user_id,\n"
                + "    u.full_name,\n"
                + "    u.email,\n"
                + "    u.phone,\n"
                + "    u.address,\n"
                + "    u.role_id,\n"
                + "    u.dob,\n"
                + "    u.gender,\n"
                + "    u.images,\n"
                + "    r.role_name,\n"
                + "    u.status,\n"
                + "    ISNULL(SUM(p.total_amount), 0) AS total_spent\n"
                + "FROM Users AS u\n"
                + "JOIN Roles AS r ON r.role_id = u.role_id\n"
                + "LEFT JOIN Booking AS b ON u.user_id = b.user_id\n"
                + "LEFT JOIN Payments AS p ON b.booking_id = p.booking_id AND p.payment_status = 'completed'\n"
                + "WHERE u.role_id = 4 AND u.user_id = ?\n"
                + "GROUP BY \n"
                + "    u.user_id, u.full_name, u.email, u.phone, u.address,\n"
                + "    u.role_id, u.dob, u.gender, u.images, r.role_name, u.status;";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Date dobRaw = rs.getDate(7);
                LocalDate dob = (dobRaw != null) ? dobRaw.toLocalDate() : null;
                return new Customer(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getInt(6), dob, rs.getString(8), rs.getString(9), rs.getString(10), rs.getBoolean(11), rs.getDouble(12));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updateCustomer(Customer customer) {
        String sql = "UPDATE Users\n"
                + "SET \n"
                + "    full_name = ?,\n"
                + "    email = ?,\n"
                + "    phone = ?,\n"
                + "    dob = ?,\n"
                + "    gender = ?,\n"
                + "    status = ?\n"
                + "WHERE user_id = ?;";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, customer.getFull_name());
            st.setString(2, customer.getEmail());
            st.setString(3, customer.getPhone());
            st.setDate(4, java.sql.Date.valueOf(customer.getDob()));
            st.setString(5, customer.getGender());
            st.setBoolean(6, customer.getStatus());
            st.setInt(7, customer.getUser_id());
            st.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Filter customers by keyword, status, sortAmount, and paging
    public List<Customer> filterCustomers(String keyword, String status, String sortAmount, Integer userIdFilter, int start, int perPage) {
        List<Customer> result = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("""
        SELECT u.user_id, u.full_name, u.email, u.phone, u.address, u.role_id, u.dob, u.gender, u.images,
               r.role_name, u.status, ISNULL(SUM(p.total_amount), 0) AS total_spent
        FROM Users u
        JOIN Roles r ON u.role_id = r.role_id
        LEFT JOIN Booking b ON u.user_id = b.user_id
        LEFT JOIN Payments p ON b.booking_id = p.booking_id AND p.payment_status = 'completed'
        WHERE u.role_id = 4
    """);

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append(" AND (LOWER(u.full_name) LIKE LOWER(?) OR LOWER(u.email) LIKE LOWER(?)) ");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
        }

        if (status != null) {
            if (status.equalsIgnoreCase("active")) {
                sql.append(" AND u.status = 1 ");
            } else if (status.equalsIgnoreCase("blocked")) {
                sql.append(" AND u.status = 0 ");
            }
        }

        if (userIdFilter != null) {
            sql.append(" AND u.user_id = ? ");
            params.add(userIdFilter);
        }

        sql.append("""
        GROUP BY u.user_id, u.full_name, u.email, u.phone, u.address,
                 u.role_id, u.dob, u.gender, u.images, r.role_name, u.status
    """);

        if ("asc".equalsIgnoreCase(sortAmount)) {
            sql.append(" ORDER BY total_spent ASC ");
        } else if ("desc".equalsIgnoreCase(sortAmount)) {
            sql.append(" ORDER BY total_spent DESC ");
        } else {
            sql.append(" ORDER BY u.user_id ASC ");
        }

        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");
        params.add(start);
        params.add(perPage);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int idx = 1;
            for (Object param : params) {
                ps.setObject(idx++, param);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                LocalDate dob = rs.getDate("dob") != null ? rs.getDate("dob").toLocalDate() : null;
                Customer c = new Customer(
                        rs.getInt("user_id"),
                        rs.getString("full_name"),
                        rs.getString("email"),
                        rs.getString("phone"),
                        rs.getString("address"),
                        rs.getInt("role_id"),
                        dob,
                        rs.getString("gender"),
                        rs.getString("images"),
                        rs.getString("role_name"),
                        rs.getBoolean("status"),
                        rs.getDouble("total_spent")
                );
                result.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public int countFilteredCustomers(String keyword, String status) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) FROM Users u WHERE u.role_id = 4 ");

        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (LOWER(u.full_name) LIKE LOWER(?) OR LOWER(u.email) LIKE LOWER(?)) ");
            params.add("%" + keyword.trim() + "%");
            params.add("%" + keyword.trim() + "%");
        }

        if (status != null) {
            if (status.equalsIgnoreCase("active")) {
                sql.append(" AND u.status = 1 ");
            } else if (status.equalsIgnoreCase("blocked")) {
                sql.append(" AND u.status = 0 ");
            }
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int idx = 1;
            for (Object param : params) {
                ps.setObject(idx++, param);
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

    public static void main(String[] args) {
        CustomerDAO dao = new CustomerDAO();
        int result = dao.countFilteredCustomers("nguyen", "");
        List<Customer> list = dao.filterCustomers("%nguyen%", "", "", null, 0, 5);
        for (Customer customer : list) {
            System.out.println(customer.toString());
        }
        System.out.println(result);
    }
}
