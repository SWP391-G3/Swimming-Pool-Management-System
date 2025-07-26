/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.admin;

import dal.DBContext;
import model.admin.DashboardStats;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.admin.BookingSummary;
import model.admin.BookingTrendStats;
import model.admin.Branch;
import model.admin.BranchStaffStats;
import model.admin.CustomerJoinStats;
import model.admin.DeviceStatusStats;
import model.admin.CustomerPoolFeedback;
import model.admin.PoolStatusStats;
import model.admin.RevenueBranchByMonth;
import model.admin.RevenueByMonth;
import model.admin.ServiceTotalStats;
import model.admin.TotalRevenue;
import model.admin.TotalServiceUsage;
import model.admin.TotalTicketUsage;
import model.admin.UserCountByRole;
import model.admin.UserDetails;
import model.admin.UserGrowth;
import model.admin.VoucherUsage;
import model.customer.Pool;

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
            throw new RuntimeException("Error execute query", e);
        }
    }

    public CustomerJoinStats getCustomerJoinStats() {
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
        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                return new CustomerJoinStats(rs.getInt(1), rs.getInt(2), rs.getInt(3));
            }
        } catch (SQLException e) {
            throw new RuntimeException("Error execute query", e);
        }
        return null;
    }

    public UserDetails getUserDetails() {
        String sql = """
                     SELECT
                         SUM(CASE WHEN r.role_name = 'Admin' THEN 1 ELSE 0 END) AS TotalAdmin,
                         SUM(CASE WHEN r.role_name = 'Manager' THEN 1 ELSE 0 END) AS TotalManager,
                         SUM(CASE WHEN r.role_name = 'Staff' THEN 1 ELSE 0 END) AS TotalStaff,
                         SUM(CASE WHEN r.role_name = 'Customer' THEN 1 ELSE 0 END) AS TotalCustomer
                     FROM Users u
                     JOIN Roles r ON u.role_id = r.role_id;
                     """;
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return new UserDetails(rs.getInt(1), rs.getInt(2),
                        rs.getInt(3), rs.getInt(4));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
        return null;
    }

    public List<Pool> getActivePools() {
        List<Pool> list = new ArrayList<>();
        String sql = "SELECT * FROM Pools as p WHERE p.pool_status = '1'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date createdDate = rs.getDate(10);
                Date updatedDate = rs.getDate(11);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), rs.getString(9), createdAt, updatedAt,
                        rs.getString(12), rs.getInt(13)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
        return list;
    }

    public List<Pool> getInactivePools() {
        List<Pool> list = new ArrayList<>();
        String sql = "SELECT * FROM Pools as p WHERE p.pool_status = '0'";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date createdDate = rs.getDate(10);
                Date updatedDate = rs.getDate(11);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), rs.getString(9), createdAt, updatedAt,
                        rs.getString(12), rs.getInt(13)));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
        return list;
    }

    public List<RevenueBranchByMonth> getRevenueByBranchAndMonth() {
        List<RevenueBranchByMonth> list = new ArrayList<>();

        String sql = """
            SELECT  
                br.branch_id,
                br.branch_name,
                p.pool_name,
                p.pool_address,
                FORMAT(GETDATE(), 'yyyy-MM') AS revenue_month,
                SUM(
                    CASE 
                        WHEN pay.payment_status = 'completed'
                             AND MONTH(pay.payment_date) = MONTH(GETDATE())
                             AND YEAR(pay.payment_date) = YEAR(GETDATE())
                        THEN ISNULL(pay.total_amount, 0)
                        ELSE 0
                    END
                ) AS total_revenue
            FROM 
                Pools p
            JOIN Branchs br ON p.branch_id = br.branch_id
            LEFT JOIN Booking b ON p.pool_id = b.pool_id 
            LEFT JOIN Payments pay ON b.booking_id = pay.booking_id
            GROUP BY 
                br.branch_id, br.branch_name,
                p.pool_name, p.pool_address
            ORDER BY 
                br.branch_id, p.pool_name;
        """;

        try (PreparedStatement ps = connection.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                RevenueBranchByMonth revenue = new RevenueBranchByMonth();
                revenue.setBranchId(rs.getInt("branch_id"));
                revenue.setBranchName(rs.getString("branch_name"));
                revenue.setPoolName(rs.getString("pool_name"));
                revenue.setPoolAddress(rs.getString("pool_address"));
                revenue.setRevenueMonth(rs.getString("revenue_month"));
                revenue.setTotalRevenue(rs.getBigDecimal("total_revenue"));
                list.add(revenue);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }

        return list;
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
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
        return list;
    }

    public List<BookingSummary> getBookingSummarys() {
        List<BookingSummary> list = new ArrayList<>();
        String sql = """
                    SELECT 
                         b.booking_id,
                         p.pool_name,
                         br.branch_name,
                         u.full_name AS customer_name,
                         b.start_time,
                         b.end_time,
                         COUNT(t.ticket_id) AS total_tickets
                     FROM Booking b
                     JOIN Pools p ON b.pool_id = p.pool_id
                     JOIN Branchs br ON p.branch_id = br.branch_id
                     JOIN Users u ON b.user_id = u.user_id
                     LEFT JOIN Ticket t ON b.booking_id = t.booking_id
                     WHERE b.booking_date >= CAST(GETDATE() AS DATE)
                       AND b.booking_date < DATEADD(DAY, 1, CAST(GETDATE() AS DATE))
                     GROUP BY b.booking_id, p.pool_name, br.branch_name, u.full_name, b.start_time, b.end_time
                     ORDER BY b.booking_id DESC;
                     """;
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                BookingSummary summary = new BookingSummary();
                summary.setBookingId(rs.getInt("booking_id"));
                summary.setPoolName(rs.getString("pool_name"));
                summary.setBranchName(rs.getString("branch_name"));
                summary.setCustomerName(rs.getString("customer_name"));
                summary.setStartTime(rs.getTime("start_time").toLocalTime());
                summary.setEndTime(rs.getTime("end_time").toLocalTime());
                summary.setTotalTickets(rs.getInt("total_tickets"));

                list.add(summary);
            }
            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    public List<VoucherUsage> getVoucherUsageToday() {
        List<VoucherUsage> list = new ArrayList<>();
        String sql = """
                      SELECT 
                                     d.discount_code,
                                     d.description AS voucher_name,
                                     d.discount_percent,
                                     COUNT(cd.customer_discount_id) AS usage_count,
                                     d.valid_from,
                                     d.valid_to
                                 FROM Customer_Discount cd
                                 JOIN Discounts d ON cd.discount_id = d.discount_id
                                 JOIN Booking b ON b.discount_id = d.discount_id AND b.user_id = cd.user_id
                                 JOIN Payments p ON p.booking_id = b.booking_id
                                 WHERE cd.used_discount = 1
                                   AND CAST(p.payment_date AS DATE) = CAST(GETDATE() AS DATE)
                                   AND p.payment_status = 'completed'
                                 GROUP BY 
                                     d.discount_code, d.description, d.discount_percent, d.valid_from, d.valid_to
                     """;
        try(PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {                
                VoucherUsage dto = new VoucherUsage(
                    rs.getString("discount_code"),
                    rs.getString("voucher_name"),
                    rs.getDouble("discount_percent"),
                    rs.getInt("usage_count"),
                    rs.getTimestamp("valid_from").toLocalDateTime(),
                    rs.getTimestamp("valid_to").toLocalDateTime()
                );
                list.add(dto);
            }
            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
    }
    
    public List<TotalServiceUsage> getTotalServiceUsages(){
        List<TotalServiceUsage> list = new ArrayList<>();
        String sql = """
                     SELECT  
                         ps.service_name,
                         SUM(
                             CASE 
                                 WHEN MONTH(b.booking_date) = MONTH(GETDATE()) 
                                  AND YEAR(b.booking_date) = YEAR(GETDATE()) 
                                 THEN ISNULL(bs.quantity, 0)
                                 ELSE 0
                             END
                         ) AS total_usage
                     FROM 
                         Pool_Service ps
                     LEFT JOIN 
                         Booking_Service bs ON ps.pool_service_id = bs.pool_service_id
                     LEFT JOIN 
                         Booking b ON bs.booking_id = b.booking_id
                     GROUP BY 
                         ps.service_name
                     ORDER BY 
                         ps.service_name;
                     """;
        try(PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                TotalServiceUsage ts = new TotalServiceUsage();
                ts.setService_name(rs.getString(1));
                ts.setTotal_usage(rs.getInt(2));
                list.add(ts);
            }
            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
    }
    
    public List<TotalTicketUsage> getTotalTicketUsages(){
        List<TotalTicketUsage> list = new ArrayList<>();
        String sql = """
                     SELECT 
                         tt.type_name,
                         ISNULL(COUNT(t.ticket_id), 0) AS used_ticket_count
                     FROM 
                         Ticket_Types tt
                     LEFT JOIN 
                         Ticket t ON tt.ticket_type_id = t.ticket_type_id
                     LEFT JOIN 
                         Booking b ON t.booking_id = b.booking_id 
                                   AND MONTH(b.booking_date) = MONTH(GETDATE())
                                   AND YEAR(b.booking_date) = YEAR(GETDATE())
                     GROUP BY 
                         tt.type_name
                     ORDER BY 
                         tt.type_name;
                     """;
        try(PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {                
                TotalTicketUsage tt = new TotalTicketUsage();
                tt.setType_name(rs.getString(1));
                tt.setUsed_ticket_count(rs.getInt(2));
                list.add(tt);
            }
            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }      
    }
    
    public List<CustomerPoolFeedback> getPoolFeedbacks(){
        List<CustomerPoolFeedback> list = new ArrayList<>();
        String sql = """
                     	SELECT 
                         p.pool_name,
                         f.rating,
                         f.comment,
                         FORMAT(f.created_at, 'yyyy-MM-dd') AS feedback_date,
                         u.full_name AS feedback_user
                     FROM 
                         Feedbacks f
                     JOIN 
                         Pools p ON f.pool_id = p.pool_id
                     JOIN 
                         Users u ON f.user_id = u.user_id
                     ORDER BY 
                         f.rating DESC
                     """;
        try(PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {                
                CustomerPoolFeedback p = new CustomerPoolFeedback();
                p.setPoolName(rs.getString(1));
                p.setRating(rs.getInt(2));
                p.setComment(rs.getString(3));
                p.setFeedbackDate(rs.getString(4));
                p.setFeedbackUser(rs.getString(5));
                list.add(p);
            }
            return list;
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
    }
    
    public List<TotalRevenue> getTotalRevenue(){
        List<TotalRevenue> listRevenues = new ArrayList<>();
        String sql = """
                     SELECT 
                         ISNULL(br.branch_name, N'TOÀN HỆ THỐNG') AS branch_name,
                         SUM(p.total_amount) AS total_revenue
                     FROM 
                         Payments p
                     JOIN Booking b ON p.booking_id = b.booking_id
                     JOIN Pools po ON b.pool_id = po.pool_id
                     JOIN Branchs br ON po.branch_id = br.branch_id
                     WHERE 
                         p.payment_status = 'completed'
                     GROUP BY 
                         ROLLUP(br.branch_name);
                     """;
        try(PreparedStatement st = connection.prepareStatement(sql)) {
            ResultSet rs = st.executeQuery();
            while (rs.next()) {                
                TotalRevenue tr = new TotalRevenue();
                tr.setBranch_name(rs.getString(1));
                tr.setTotal_revenue(rs.getDouble(2));
                listRevenues.add(tr);
            }
            return listRevenues;
        } catch (SQLException e) {
            throw new RuntimeException(e.getMessage());
        }
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
