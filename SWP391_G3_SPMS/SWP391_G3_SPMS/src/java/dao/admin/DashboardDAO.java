/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.admin;

import dal.DBContext;
import model.admin.DashboardStats;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import model.admin.BookingTrendStats;
import model.admin.BranchStaffStats;
import model.admin.CustomerJoinStats;
import model.admin.DeviceStatusStats;
import model.admin.PoolStatusStats;
import model.admin.RevenueByMonth;
import model.admin.ServiceTotalStats;
import model.admin.UserCountByRole;
import model.admin.UserGrowth;

/**
 *
 * @author Lenovo
 */
public class DashboardDAO extends DBContext {

    public DashboardStats getDashboardStats() {
        String sql = "WITH \n"
                + "-- Tổng số người dùng theo tháng\n"
                + "UserStats AS (\n"
                + "    SELECT \n"
                + "        FORMAT(created_at, 'yyyy-MM') AS month,\n"
                + "        COUNT(*) AS user_count\n"
                + "    FROM Users\n"
                + "    GROUP BY FORMAT(created_at, 'yyyy-MM')\n"
                + "),\n"
                + "-- Doanh thu theo tháng\n"
                + "RevenueStats AS (\n"
                + "    SELECT \n"
                + "        FORMAT(payment_date, 'yyyy-MM') AS month,\n"
                + "        SUM(total_amount) AS revenue\n"
                + "    FROM Payments\n"
                + "    WHERE payment_status = 'completed'\n"
                + "    GROUP BY FORMAT(payment_date, 'yyyy-MM')\n"
                + "),\n"
                + "-- Lấy dữ liệu tháng hiện tại và tháng trước\n"
                + "CurrentMonthStats AS (\n"
                + "    SELECT \n"
                + "        (SELECT COUNT(*) FROM Users) AS total_users,\n"
                + "        (SELECT COUNT(*) FROM Pools) AS total_pools,\n"
                + "        (SELECT COUNT(*) FROM Pools WHERE pool_status = 1) AS active_pools,\n"
                + "        (SELECT COUNT(*) FROM Booking WHERE CAST(booking_date AS DATE) = CAST(GETDATE() AS DATE)) AS today_bookings,\n"
                + "        (SELECT COUNT(*) FROM Booking WHERE booking_status = 'pending') AS pending_bookings,\n"
                + "        -- Doanh thu tháng hiện tại\n"
                + "        (SELECT ISNULL(SUM(total_amount), 0)\n"
                + "         FROM Payments\n"
                + "         WHERE payment_status = 'completed'\n"
                + "           AND FORMAT(payment_date, 'yyyy-MM') = FORMAT(GETDATE(), 'yyyy-MM')\n"
                + "        ) AS current_revenue,\n"
                + "        -- Doanh thu tháng trước\n"
                + "        (SELECT ISNULL(SUM(total_amount), 0)\n"
                + "         FROM Payments\n"
                + "         WHERE payment_status = 'completed'\n"
                + "           AND FORMAT(payment_date, 'yyyy-MM') = FORMAT(DATEADD(MONTH, -1, GETDATE()), 'yyyy-MM')\n"
                + "        ) AS previous_revenue,\n"
                + "        -- Người dùng tháng này\n"
                + "        (SELECT COUNT(*) FROM Users\n"
                + "         WHERE FORMAT(created_at, 'yyyy-MM') = FORMAT(GETDATE(), 'yyyy-MM')\n"
                + "        ) AS current_user_count,\n"
                + "        -- Người dùng tháng trước\n"
                + "        (SELECT COUNT(*) FROM Users\n"
                + "         WHERE FORMAT(created_at, 'yyyy-MM') = FORMAT(DATEADD(MONTH, -1, GETDATE()), 'yyyy-MM')\n"
                + "        ) AS previous_user_count\n"
                + ")\n"
                + "SELECT \n"
                + "    total_users,\n"
                + "    total_pools,\n"
                + "    active_pools,\n"
                + "    today_bookings,\n"
                + "    pending_bookings,\n"
                + "    current_revenue,\n"
                + "    previous_revenue,\n"
                + "    -- % Tăng/Giảm Doanh thu\n"
                + "    CASE \n"
                + "        WHEN previous_revenue = 0 THEN NULL\n"
                + "        ELSE ROUND((current_revenue - previous_revenue) * 100.0 / previous_revenue, 2)\n"
                + "    END AS revenue_change_percent,\n"
                + "    -- % Tăng/Giảm Người dùng\n"
                + "    CASE \n"
                + "        WHEN previous_user_count = 0 THEN NULL\n"
                + "        ELSE ROUND((current_user_count - previous_user_count) * 100.0 / previous_user_count, 2)\n"
                + "    END AS user_growth_percent\n"
                + "FROM CurrentMonthStats;";
        try (PreparedStatement st = connection.prepareStatement(sql);) {
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new DashboardStats(rs.getInt(1), rs.getInt(2),
                        rs.getInt(3), rs.getInt(4), rs.getInt(5),
                        rs.getDouble(6), rs.getDouble(7),
                        rs.getDouble(8), rs.getDouble(9)
                );
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error excute query DashboardStats", e);
        }
        return null;
    }

    public RevenueByMonth getRevenueByMonth() {
        RevenueByMonth revenue = new RevenueByMonth();
        String sql = """
        WITH Months AS (
            SELECT 1 AS month UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL
            SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL
            SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL
            SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12
        )
        SELECT m.month, ISNULL(SUM(p.total_amount), 0) AS total_revenue
        FROM Months m
        LEFT JOIN Payments p ON MONTH(p.payment_date) = m.month 
                             AND YEAR(p.payment_date) = YEAR(GETDATE()) 
                             AND p.payment_status = 'completed'
        GROUP BY m.month
        ORDER BY m.month;
    """;

        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                int month = rs.getInt("month");
                double amount = rs.getDouble("total_revenue");
                switch (month) {
                    case 1 ->
                        revenue.setT1(amount);
                    case 2 ->
                        revenue.setT2(amount);
                    case 3 ->
                        revenue.setT3(amount);
                    case 4 ->
                        revenue.setT4(amount);
                    case 5 ->
                        revenue.setT5(amount);
                    case 6 ->
                        revenue.setT6(amount);
                    case 7 ->
                        revenue.setT7(amount);
                    case 8 ->
                        revenue.setT8(amount);
                    case 9 ->
                        revenue.setT9(amount);
                    case 10 ->
                        revenue.setT10(amount);
                    case 11 ->
                        revenue.setT11(amount);
                    case 12 ->
                        revenue.setT12(amount);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error execute query revenue by month", e);
        }
        return revenue;
    }

    public UserGrowth getUserGrowthByMonth() {
        UserGrowth growth = new UserGrowth();
        String sql = """
        WITH Months AS (
            SELECT 1 AS month UNION ALL SELECT 2 UNION ALL SELECT 3 UNION ALL
            SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6 UNION ALL
            SELECT 7 UNION ALL SELECT 8 UNION ALL SELECT 9 UNION ALL
            SELECT 10 UNION ALL SELECT 11 UNION ALL SELECT 12
        )
        SELECT 
            m.month,
            COUNT(u.user_id) AS user_count
        FROM 
            Months m
        LEFT JOIN 
            Users u ON MONTH(u.created_at) = m.month AND YEAR(u.created_at) = YEAR(GETDATE())
        GROUP BY 
            m.month
        ORDER BY 
            m.month;
        """;
        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {

            while (rs.next()) {
                int month = rs.getInt("month");
                int count = rs.getInt("user_count");
                growth.setMonth(month, count);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error execute query user growth", e);
        }
        return growth;
    }

    public PoolStatusStats getPoolStatusStats() {
        String sql = "SELECT \n"
                + "    1 AS status_1,\n"
                + "    0 AS status_0,\n"
                + "    SUM(CASE WHEN pool_status = 1 THEN 1 ELSE 0 END) AS total_active,\n"
                + "    SUM(CASE WHEN pool_status = 0 THEN 1 ELSE 0 END) AS total_inactive\n"
                + "FROM Pools;";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new PoolStatusStats(rs.getInt(1),
                        rs.getInt(2), rs.getInt(3), rs.getInt(4));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error execute query count total pool active", e);
        }
        return null;
    }

    public BookingTrendStats getBookingTrendThisWeek() {
        BookingTrendStats stats = new BookingTrendStats();
        String sql = """
            SELECT 
                SUM(CASE WHEN DATEPART(WEEKDAY, booking_date) = 2 THEN 1 ELSE 0 END) AS t2,
                SUM(CASE WHEN DATEPART(WEEKDAY, booking_date) = 3 THEN 1 ELSE 0 END) AS t3,
                SUM(CASE WHEN DATEPART(WEEKDAY, booking_date) = 4 THEN 1 ELSE 0 END) AS t4,
                SUM(CASE WHEN DATEPART(WEEKDAY, booking_date) = 5 THEN 1 ELSE 0 END) AS t5,
                SUM(CASE WHEN DATEPART(WEEKDAY, booking_date) = 6 THEN 1 ELSE 0 END) AS t6,
                SUM(CASE WHEN DATEPART(WEEKDAY, booking_date) = 7 THEN 1 ELSE 0 END) AS t7,
                SUM(CASE WHEN DATEPART(WEEKDAY, booking_date) = 1 THEN 1 ELSE 0 END) AS cn
            FROM Booking
            WHERE DATEPART(WEEK, booking_date) = DATEPART(WEEK, GETDATE())
              AND YEAR(booking_date) = YEAR(GETDATE())
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                stats.setT2(rs.getInt("t2"));
                stats.setT3(rs.getInt("t3"));
                stats.setT4(rs.getInt("t4"));
                stats.setT5(rs.getInt("t5"));
                stats.setT6(rs.getInt("t6"));
                stats.setT7(rs.getInt("t7"));
                stats.setCn(rs.getInt("cn"));
            }

        } catch (SQLException e) {
            throw new RuntimeException("Error excetu query", e);
        }
        return stats;
    }

    public UserCountByRole getUserCountByRole() {
        String sql = "SELECT\n"
                + "    SUM(CASE WHEN r.role_name = N'Admin' THEN 1 ELSE 0 END) AS Admin,\n"
                + "    SUM(CASE WHEN r.role_name = N'Manager' THEN 1 ELSE 0 END) AS Manager,\n"
                + "    SUM(CASE WHEN r.role_name = N'Staff' THEN 1 ELSE 0 END) AS Staff,\n"
                + "    SUM(CASE WHEN r.role_name = N'Customer' THEN 1 ELSE 0 END) AS Customer\n"
                + "FROM Users u\n"
                + "JOIN Roles r ON u.role_id = r.role_id;";
        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                return new UserCountByRole(rs.getInt(1), rs.getInt(2),
                        rs.getInt(3), rs.getInt(4));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error execute count user by role", e);
        }
        return null;
    }

    public DeviceStatusStats getDeviceStatusStats() {
        String sql = """
            SELECT
                COUNT(CASE WHEN device_status = 'available' THEN 1 END) AS available_count,
                COUNT(CASE WHEN device_status = 'maintenance' THEN 1 END) AS maintenance_count,
                COUNT(CASE WHEN device_status = 'broken' THEN 1 END) AS broken_count
            FROM Pool_Device
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                int available = rs.getInt("available_count");
                int maintenance = rs.getInt("maintenance_count");
                int broken = rs.getInt("broken_count");

                return new DeviceStatusStats(available, maintenance, broken);
            }

        } catch (Exception e) {
            throw new RuntimeException("Error execute query", e);
        }

        return null;
    }

    public List<ServiceTotalStats> getAllService() {
        List<ServiceTotalStats> list = new ArrayList<>();
        String sql = """                   
                     SELECT service_name, SUM(quantity) AS total_quantity
                     FROM Pool_Service
                     GROUP BY service_name;
                     
                     """;
        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                ServiceTotalStats ser = new ServiceTotalStats();
                ser.setService_name(rs.getString(1));
                ser.setTotal_quantity(rs.getInt(2));
                list.add(ser);
            }
            return list;
        } catch (SQLException e) {
            throw new RuntimeException("Error execute query all service", e);
        }
    }

    public List<BranchStaffStats> getBranchStaffStatses() {
        List<BranchStaffStats> list = new ArrayList<>();
        String sql = """
                     SELECT 
                         b.branch_id,
                         b.branch_name,
                         u.status,
                         COUNT(s.staff_id) AS total_staff
                     FROM Branchs b
                     JOIN Staffs s ON b.branch_id = s.branch_id
                     JOIN Users u ON s.user_id = u.user_id
                     GROUP BY b.branch_id, b.branch_name, u.status
                     ORDER BY b.branch_id, u.status;
                     
                     """;
        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {
                BranchStaffStats stats = new BranchStaffStats();
                stats.setBranch_id(rs.getInt(1));
                stats.setBranch_name(rs.getString(2));
                stats.setStaff_status(rs.getBoolean(3));
                stats.setTotal_staff(rs.getInt(4));
                list.add(stats);
            }
            return list;
        } catch (SQLException e) {
            throw new RuntimeException("Error execute query",e);
        }
    }
    
    public CustomerJoinStats getCustomerJoinStats(){
        String sql = """
        SELECT
            (SELECT COUNT(*) 
             FROM Users u 
             JOIN Roles r ON u.role_id = r.role_id 
             WHERE r.role_name = 'Customer' AND u.status = 1) AS total_customers,
        
            (SELECT AVG(CAST(rating AS FLOAT)) 
             FROM Feedbacks) AS average_rating,
        
            (SELECT SUM(bs.quantity)
             FROM Booking_Service bs
             JOIN Booking b ON bs.booking_id = b.booking_id
             WHERE CAST(b.created_at AS DATE) = CAST(GETDATE() AS DATE)) AS total_service_used_today;
                     
                     """;
        try(PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                return new CustomerJoinStats(rs.getInt(1), rs.getInt(2), rs.getInt(3));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error execute query",e);
        }
        return null;
    }

    public static void main(String[] args) {
        DashboardDAO dao = new DashboardDAO();
        PoolStatusStats r = dao.getPoolStatusStats();
        List<ServiceTotalStats> st = dao.getAllService();
        String[] service_name = new String[st.size()];
        int[] service_total = new int[st.size()];
        for (int i = 0; i < st.size(); i++) {
            service_name[i] = st.get(i).getService_name();
        }
        for (int i = 0; i < st.size(); i++) {
            service_total[i] = st.get(i).getTotal_quantity();
        }
        for (int i : service_total) {
            System.out.println(i);
        }
    }

}
