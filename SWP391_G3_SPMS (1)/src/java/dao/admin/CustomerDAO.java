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
        String sql = "select u.user_id,u.full_name,u.email,u.phone,u.address,u.role_id,u.dob,u.gender,u.images,r.role_name,u.status\n"
                + "from Users as u\n"
                + "join Roles as r on r.role_id = u.role_id\n"
                + "where u.role_id = 4\n"
                + "order by u.user_id\n"
                + "offset ? rows fetch next ? rows only";
        try (PreparedStatement st = connection.prepareCall(sql)) {
            st.setInt(1, start);
            st.setInt(2, perUserPage);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date dobRaw = rs.getDate(7);
                LocalDate dob = (dobRaw != null) ? dobRaw.toLocalDate() : null;

                list.add(new Customer(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getInt(6), dob, rs.getString(8), rs.getString(9), rs.getString(10), rs.getBoolean(11)
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
        String sql = "select u.user_id,u.full_name,u.email,u.phone,u.address,u.role_id,u.dob,u.gender,u.images,r.role_name,u.status\n"
                + "from Users as u\n"
                + "join Roles as r on r.role_id = u.role_id\n"
                + "where u.role_id = 4 and user_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Date dobRaw = rs.getDate(7);
                LocalDate dob = (dobRaw != null) ? dobRaw.toLocalDate() : null;
                return new Customer(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getString(5),
                        rs.getInt(6), dob, rs.getString(8), rs.getString(9), rs.getString(10), rs.getBoolean(11));
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
        try(PreparedStatement st = connection.prepareStatement(sql)) {
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
}
