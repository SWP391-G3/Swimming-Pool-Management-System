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
import java.time.LocalDateTime;
import model.admin.CustomerService;

/**
 *
 * @author Lenovo
 */
public class CustomerServiceDAO extends DBContext {

    public List<CustomerService> getLastService(int user_id) {
        List<CustomerService> list = new ArrayList<>();
        String sql = "SELECT top 1 \n"
                + "    u.full_name AS customer_name,\n"
                + "    b.booking_id,\n"
                + "    ps.service_name,\n"
                + "    bs.quantity,\n"
                + "    bs.total_service_price,\n"
                + "    p.pool_name,\n"
                + "    b.booking_date,\n"
                + "    b.start_time,\n"
                + "    b.end_time\n"
                + "FROM Booking_Service bs\n"
                + "JOIN Booking b ON bs.booking_id = b.booking_id\n"
                + "JOIN Users u ON b.user_id = u.user_id\n"
                + "JOIN Pool_Service ps ON bs.pool_service_id = ps.pool_service_id\n"
                + "JOIN Pools p ON ps.pool_id = p.pool_id\n"
                + "WHERE u.user_id = ? -- truyền vào user_id khách hàng\n"
                + "ORDER BY b.booking_date DESC, b.start_time DESC;";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, user_id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                String customerName = rs.getString("customer_name");
                int bookingId = rs.getInt("booking_id");
                String serviceName = rs.getString("service_name");
                int quantity = rs.getInt("quantity");
                double totalServicePrice = rs.getDouble("total_service_price");
                String poolName = rs.getString("pool_name");
                LocalDate bookingDate = rs.getDate("booking_date").toLocalDate();
                LocalDateTime startTime = rs.getTimestamp("start_time").toLocalDateTime();
                LocalDateTime endTime = rs.getTimestamp("end_time").toLocalDateTime();

                CustomerService cs = new CustomerService(customerName, bookingId, serviceName,
                        quantity, totalServicePrice, poolName, bookingDate, startTime, endTime);
                list.add(cs);
                
            }
            return list;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void main(String[] args) {
        CustomerServiceDAO dao = new CustomerServiceDAO();
        List<CustomerService> list = dao.getLastService(32);
        for (CustomerService customerService : list) {
            System.out.println(customerService.toString());
        }
    }
}
