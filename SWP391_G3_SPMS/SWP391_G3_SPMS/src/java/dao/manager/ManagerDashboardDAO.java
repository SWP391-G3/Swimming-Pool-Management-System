package dao.manager;

import dal.DBContext;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import model.manager.Branch;
import model.manager.CustomerTrend;
import model.manager.DashboardStats;
import model.manager.PoolStats;
import model.manager.RevenueChart;

public class ManagerDashboardDAO extends DBContext {

    // Lấy thông tin chi nhánh của manager
    public Branch getBranchByManager(int managerId) throws SQLException {
        String sql = """
            SELECT b.branch_id, b.branch_name, b.manager_id, u.full_name as manager_name
            FROM Branchs b
            LEFT JOIN Users u ON b.manager_id = u.user_id
            WHERE b.manager_id = ?
        """;
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, managerId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Branch branch = new Branch();
                branch.setBranchId(rs.getInt("branch_id"));
                branch.setBranchName(rs.getString("branch_name"));
                branch.setManagerId(rs.getInt("manager_id"));
                branch.setManagerName(rs.getString("manager_name"));
                return branch;
            }
        }
        return null;
    }

    // Thống kê tổng quan chi nhánh
    public DashboardStats getBranchStats(int branchId, String period) throws SQLException {
        String sql = """
            WITH CurrentPeriodStats AS (
                SELECT 
                    b.branch_id,
                    b.branch_name,
                    COALESCE(SUM(p.total_amount), 0) as total_revenue,
                    COUNT(DISTINCT bk.booking_id) as total_bookings,
                    COUNT(DISTINCT bk.user_id) as total_customers,
                    COUNT(DISTINCT po.pool_id) as total_pools,
                    COALESCE(AVG(CAST(f.rating AS DECIMAL(3,2))), 0) as avg_rating
                FROM Branchs b
                LEFT JOIN Pools po ON b.branch_id = po.branch_id AND po.pool_status = 1
                LEFT JOIN Booking bk ON po.pool_id = bk.pool_id
                    AND bk.booking_date >= ?
                    AND bk.booking_status IN ('confirmed', 'completed')
                LEFT JOIN Payments p ON bk.booking_id = p.booking_id 
                    AND p.payment_status = 'completed'
                LEFT JOIN Feedbacks f ON po.pool_id = f.pool_id
                    AND f.created_at >= ?
                WHERE b.branch_id = ?
                GROUP BY b.branch_id, b.branch_name
            ),
            PreviousPeriodStats AS (
                SELECT 
                    b.branch_id,
                    COALESCE(SUM(p.total_amount), 0) as previous_revenue,
                    COUNT(DISTINCT bk.booking_id) as previous_bookings,
                    COUNT(DISTINCT bk.user_id) as previous_customers
                FROM Branchs b
                LEFT JOIN Pools po ON b.branch_id = po.branch_id
                LEFT JOIN Booking bk ON po.pool_id = bk.pool_id
                    AND bk.booking_date >= ? AND bk.booking_date < ?
                    AND bk.booking_status IN ('confirmed', 'completed')
                LEFT JOIN Payments p ON bk.booking_id = p.booking_id 
                    AND p.payment_status = 'completed'
                WHERE b.branch_id = ?
                GROUP BY b.branch_id
            )
            SELECT 
                cps.*,
                pps.previous_revenue,
                pps.previous_bookings,
                pps.previous_customers,
                CASE 
                    WHEN pps.previous_revenue > 0 THEN
                        CAST((cps.total_revenue - pps.previous_revenue) * 100.0 / pps.previous_revenue AS DECIMAL(5,2))
                    ELSE 0
                END as revenue_growth,
                CASE 
                    WHEN pps.previous_bookings > 0 THEN
                        CAST((cps.total_bookings - pps.previous_bookings) * 100.0 / pps.previous_bookings AS DECIMAL(5,2))
                    ELSE 0
                END as booking_growth,
                CASE 
                    WHEN pps.previous_customers > 0 THEN
                        CAST((cps.total_customers - pps.previous_customers) * 100.0 / pps.previous_customers AS DECIMAL(5,2))
                    ELSE 0
                END as customer_growth
            FROM CurrentPeriodStats cps
            LEFT JOIN PreviousPeriodStats pps ON cps.branch_id = pps.branch_id
        """;

        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            Date[] dates = getPeriodDates(period);
            stmt.setDate(1, new java.sql.Date(dates[0].getTime())); // current start
            stmt.setDate(2, new java.sql.Date(dates[0].getTime())); // current start for feedback
            stmt.setInt(3, branchId);
            stmt.setDate(4, new java.sql.Date(dates[1].getTime())); // previous start
            stmt.setDate(5, new java.sql.Date(dates[0].getTime())); // previous end (current start)
            stmt.setInt(6, branchId);

            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                DashboardStats stats = new DashboardStats();
                stats.setBranchId(rs.getInt("branch_id"));
                stats.setBranchName(rs.getString("branch_name"));
                stats.setTotalRevenue(rs.getBigDecimal("total_revenue"));
                stats.setTotalBookings(rs.getInt("total_bookings"));
                stats.setTotalCustomers(rs.getInt("total_customers"));
                stats.setTotalPools(rs.getInt("total_pools"));
                stats.setAvgRating(rs.getBigDecimal("avg_rating"));
                stats.setPreviousRevenue(rs.getBigDecimal("previous_revenue"));
                stats.setPreviousBookings(rs.getInt("previous_bookings"));
                stats.setPreviousCustomers(rs.getInt("previous_customers"));
                stats.setRevenueGrowth(rs.getBigDecimal("revenue_growth"));
                stats.setBookingGrowth(rs.getBigDecimal("booking_growth"));
                stats.setCustomerGrowth(rs.getBigDecimal("customer_growth"));
                stats.setPeriod(period);
                stats.setReportDate(new Date());
                return stats;
            }
        }
        return null;
    }

    // Xu hướng doanh thu theo thời gian
    public List<RevenueChart> getRevenueByPeriod(int branchId, String period) throws SQLException {
        String sql = "";
        if ("daily".equalsIgnoreCase(period)) {
            sql = """
                SELECT 
                    FORMAT(CAST(p.payment_date AS DATE), 'dd/MM') as label,
                    SUM(p.total_amount) as value,
                    'daily' as category,
                    CAST(p.payment_date AS DATE) as sort_date
                FROM Payments p
                JOIN Booking b ON p.booking_id = b.booking_id
                JOIN Pools po ON b.pool_id = po.pool_id
                WHERE po.branch_id = ? 
                    AND p.payment_status = 'completed'
                    AND p.payment_date >= DATEADD(day, -30, GETDATE())
                GROUP BY CAST(p.payment_date AS DATE)
                ORDER BY CAST(p.payment_date AS DATE)
            """;
        } else if ("weekly".equalsIgnoreCase(period)) {
            sql = """
                SELECT 
                    'Tuần ' + CAST(DATEPART(week, p.payment_date) AS NVARCHAR) + '/' + CAST(DATEPART(year, p.payment_date) AS NVARCHAR) as label,
                    SUM(p.total_amount) as value,
                    'weekly' as category,
                    MIN(p.payment_date) as sort_date
                FROM Payments p
                JOIN Booking b ON p.booking_id = b.booking_id
                JOIN Pools po ON b.pool_id = po.pool_id
                WHERE po.branch_id = ? 
                    AND p.payment_status = 'completed'
                    AND p.payment_date >= DATEADD(week, -12, GETDATE())
                GROUP BY DATEPART(year, p.payment_date), DATEPART(week, p.payment_date)
                ORDER BY DATEPART(year, p.payment_date), DATEPART(week, p.payment_date)
            """;
        } else {
            // default monthly
            sql = """
                SELECT
                    FORMAT(MIN(p.payment_date), 'MM/yyyy') as label,
                    SUM(p.total_amount) as value,
                    'monthly' as category,
                    MIN(p.payment_date) as sort_date
                FROM Payments p
                JOIN Booking b ON p.booking_id = b.booking_id
                JOIN Pools po ON b.pool_id = po.pool_id
                WHERE po.branch_id = ?
                  AND p.payment_status = 'completed'
                  AND p.payment_date >= DATEADD(month, -12, GETDATE())
                GROUP BY YEAR(p.payment_date), MONTH(p.payment_date)
                ORDER BY YEAR(MIN(p.payment_date)), MONTH(MIN(p.payment_date))
            """;
        }

        List<RevenueChart> result = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, branchId);
            ResultSet rs = stmt.executeQuery();
            int rowCount = 0;
            while (rs.next()) {
                RevenueChart chart = new RevenueChart();
                chart.setLabel(rs.getString("label"));
                chart.setValue(rs.getBigDecimal("value"));
                chart.setCategory(rs.getString("category"));
                chart.setPeriod(period);
                result.add(chart);
                // Debug:
                System.out.println("RevenueChart: Label=" + chart.getLabel() + ", Value=" + chart.getValue());
                rowCount++;
            }
            System.out.println("Total rows in revenueData: " + rowCount);
        }
        return result;
    }

    // Thống kê từng hồ bơi trong chi nhánh
    public List<PoolStats> getPoolStatsInBranch(int branchId, String period) throws SQLException {
        String sql = """
            SELECT 
                p.pool_id,
                p.pool_name,
                p.pool_address,
                p.max_slot,
                p.open_time,
                p.close_time,
                p.pool_image,
                p.pool_description,
                CASE WHEN p.pool_status = 1 THEN 'Active' ELSE 'InActive' END as status,
                COALESCE(SUM(pay.total_amount), 0) as revenue,
                COUNT(DISTINCT b.booking_id) as total_bookings,
                COUNT(DISTINCT b.user_id) as total_customers,
                COALESCE(AVG(CAST(f.rating AS DECIMAL(3,2))), 0) as avg_rating,
                CASE 
                    WHEN p.max_slot > 0 AND DATEDIFF(day, ?, GETDATE()) > 0 THEN 
                        CAST(COUNT(DISTINCT b.booking_id) * 100.0 / (p.max_slot * DATEDIFF(day, ?, GETDATE())) AS DECIMAL(5,2))
                    ELSE 0 
                END as utilization_rate
            FROM Pools p
            LEFT JOIN Booking b ON p.pool_id = b.pool_id
                AND b.booking_date >= ?
                AND b.booking_status IN ('confirmed', 'completed')
            LEFT JOIN Payments pay ON b.booking_id = pay.booking_id
                AND pay.payment_status = 'completed'
            LEFT JOIN Feedbacks f ON p.pool_id = f.pool_id
                AND f.created_at >= ?
            WHERE p.branch_id = ?
            GROUP BY p.pool_id, p.pool_name, p.pool_address, p.max_slot, 
                     p.open_time, p.close_time, p.pool_status, p.pool_image, p.pool_description
            ORDER BY revenue DESC
        """;

        List<PoolStats> poolStats = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            Date startDate = getStartDateByPeriod(period);
            stmt.setDate(1, new java.sql.Date(startDate.getTime()));
            stmt.setDate(2, new java.sql.Date(startDate.getTime()));
            stmt.setDate(3, new java.sql.Date(startDate.getTime()));
            stmt.setDate(4, new java.sql.Date(startDate.getTime()));
            stmt.setInt(5, branchId);

            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                PoolStats pool = new PoolStats();
                pool.setPoolId(rs.getInt("pool_id"));
                pool.setPoolName(rs.getString("pool_name"));
                pool.setPoolAddress(rs.getString("pool_address"));
                pool.setMaxSlot(rs.getInt("max_slot"));
                pool.setOpenTime(rs.getString("open_time"));
                pool.setCloseTime(rs.getString("close_time"));
                pool.setPoolImage(rs.getString("pool_image"));
                pool.setPoolDescription(rs.getString("pool_description"));
                pool.setStatus(rs.getString("status"));
                pool.setRevenue(rs.getBigDecimal("revenue"));
                pool.setTotalBookings(rs.getInt("total_bookings"));
                pool.setTotalCustomers(rs.getInt("total_customers"));
                pool.setAvgRating(rs.getBigDecimal("avg_rating"));
                pool.setUtilizationRate(Math.min(rs.getDouble("utilization_rate"), 100.0));
                poolStats.add(pool);
            }
        }
        return poolStats;
    }

    // So sánh hiệu suất các hồ bơi
    public List<RevenueChart> getPoolPerformanceComparison(int branchId, String period) throws SQLException {
        String sql = """
            SELECT 
                p.pool_name as label,
                COALESCE(SUM(pay.total_amount), 0) as value,
                'performance' as category,
                CASE 
                    WHEN SUM(SUM(pay.total_amount)) OVER() > 0 THEN
                        CAST(SUM(pay.total_amount) * 100.0 / SUM(SUM(pay.total_amount)) OVER() AS DECIMAL(5,2))
                    ELSE 0
                END as percentage
            FROM Pools p
            LEFT JOIN Booking b ON p.pool_id = b.pool_id
                AND b.booking_date >= ?
                AND b.booking_status IN ('confirmed', 'completed')
            LEFT JOIN Payments pay ON b.booking_id = pay.booking_id
                AND pay.payment_status = 'completed'
            WHERE p.branch_id = ?
            GROUP BY p.pool_id, p.pool_name
            ORDER BY value DESC
        """;

        List<RevenueChart> result = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            Date startDate = getStartDateByPeriod(period);
            stmt.setDate(1, new java.sql.Date(startDate.getTime()));
            stmt.setInt(2, branchId);

            ResultSet rs = stmt.executeQuery();
            String[] colors = {"#FF6384", "#36A2EB", "#FFCE56", "#4BC0C0", "#9966FF"};
            int colorIndex = 0;

            while (rs.next()) {
                RevenueChart chart = new RevenueChart();
                chart.setLabel(rs.getString("label"));
                chart.setValue(rs.getBigDecimal("value"));
                chart.setCategory(rs.getString("category"));
                chart.setColor(colors[colorIndex % colors.length]);
                chart.setPercentage(rs.getDouble("percentage"));
                colorIndex++;
                result.add(chart);
            }
        }
        return result;
    }

// Xu hướng khách hàng: trả về số khách mới/quay lại/tổng... theo từng ngày/tuần/tháng
// Xu hướng khách hàng: trả về số khách mới/quay lại/tổng... theo từng ngày/tuần/tháng
public List<CustomerTrend> getCustomerTrendByBranch(int branchId, String period) throws SQLException {
    String groupBy, periodLabel, periodValue;
    switch (period.toLowerCase()) {
        case "daily":
            groupBy = "CAST(bk.booking_date AS DATE)";
            periodLabel = "FORMAT(bk.booking_date, 'dd/MM')";
            periodValue = "CAST(bk.booking_date AS DATE) AS period_value";
            break;
        case "weekly":
            groupBy = "DATEPART(year, bk.booking_date), DATEPART(week, bk.booking_date)";
            periodLabel = "'Tuần ' + CAST(DATEPART(week, bk.booking_date) AS NVARCHAR) + '/' + CAST(DATEPART(year, bk.booking_date) AS NVARCHAR)";
            periodValue = "DATEPART(year, bk.booking_date) AS period_year, DATEPART(week, bk.booking_date) AS period_week";
            break;
        case "monthly":
            groupBy = "YEAR(bk.booking_date), MONTH(bk.booking_date)";
            periodLabel = "FORMAT(bk.booking_date, 'MM/yyyy')";
            periodValue = "YEAR(bk.booking_date) AS period_year, MONTH(bk.booking_date) AS period_month";
            break;
        default: throw new IllegalArgumentException("Invalid period: " + period);
    }

    // Xây dựng phần select CTE, luôn đặt tên cho từng cột!
    String cteSelect;
    if ("daily".equalsIgnoreCase(period)) {
        cteSelect = String.format(
            "%s, %s AS period_label, bk.user_id, MIN(bk.booking_date) AS booking_date, COUNT(*) AS user_bookings, SUM(p.total_amount) AS user_spending, " +
            "CASE WHEN MIN(bk.booking_date) > fb.first_booking_date THEN 'returning' ELSE 'new' END AS customer_type",
            periodValue, periodLabel
        );
    } else if ("weekly".equalsIgnoreCase(period)) {
        cteSelect = String.format(
            "%s, %s AS period_label, bk.user_id, MIN(bk.booking_date) AS booking_date, COUNT(*) AS user_bookings, SUM(p.total_amount) AS user_spending, " +
            "CASE WHEN MIN(bk.booking_date) > fb.first_booking_date THEN 'returning' ELSE 'new' END AS customer_type",
            periodValue, periodLabel
        );
    } else {
        cteSelect = String.format(
            "%s, %s AS period_label, bk.user_id, MIN(bk.booking_date) AS booking_date, COUNT(*) AS user_bookings, SUM(p.total_amount) AS user_spending, " +
            "CASE WHEN MIN(bk.booking_date) > fb.first_booking_date THEN 'returning' ELSE 'new' END AS customer_type",
            periodValue, periodLabel
        );
    }

    // GROUP BY đầy đủ các trường đã đặt tên trong SELECT
    String cteGroup;
    if ("daily".equalsIgnoreCase(period)) {
        cteGroup = "CAST(bk.booking_date AS DATE), FORMAT(bk.booking_date, 'dd/MM'), bk.user_id, po.branch_id, fb.first_booking_date";
    } else if ("weekly".equalsIgnoreCase(period)) {
        cteGroup = "DATEPART(year, bk.booking_date), DATEPART(week, bk.booking_date), 'Tuần ' + CAST(DATEPART(week, bk.booking_date) AS NVARCHAR) + '/' + CAST(DATEPART(year, bk.booking_date) AS NVARCHAR), bk.user_id, po.branch_id, fb.first_booking_date";
    } else {
        cteGroup = "YEAR(bk.booking_date), MONTH(bk.booking_date), FORMAT(bk.booking_date, 'MM/yyyy'), bk.user_id, po.branch_id, fb.first_booking_date";
    }

    // GROUP BY ngoài cùng chỉ cần period_label!
    String sql = String.format("""
        WITH FirstBooking AS (
            SELECT po.branch_id, bk.user_id, MIN(bk.booking_date) AS first_booking_date
            FROM Booking bk
            JOIN Pools po ON bk.pool_id = po.pool_id
            WHERE po.branch_id = ?
              AND bk.booking_status IN ('confirmed', 'completed')
            GROUP BY po.branch_id, bk.user_id
        ),
        CustomerBookings AS (
            SELECT 
                %s
            FROM Booking bk
            JOIN Pools po ON bk.pool_id = po.pool_id
            LEFT JOIN Payments p ON bk.booking_id = p.booking_id AND p.payment_status = 'completed'
            JOIN FirstBooking fb ON fb.branch_id = po.branch_id AND fb.user_id = bk.user_id
            WHERE po.branch_id = ?
                AND bk.booking_date >= ?
                AND bk.booking_status IN ('confirmed', 'completed')
            GROUP BY %s
        )
        SELECT 
            period_label,
            MIN(booking_date) AS booking_date,
            COUNT(DISTINCT CASE WHEN customer_type = 'new' THEN user_id END) AS new_customers,
            COUNT(DISTINCT CASE WHEN customer_type = 'returning' THEN user_id END) AS returning_customers,
            COUNT(DISTINCT user_id) AS total_customers,
            COALESCE(AVG(user_spending), 0) AS avg_spending,
            CASE 
                WHEN COUNT(DISTINCT user_id) > 0 THEN
                    CAST(COUNT(DISTINCT CASE WHEN customer_type = 'returning' THEN user_id END) * 100.0 / COUNT(DISTINCT user_id) AS DECIMAL(5,2))
                ELSE 0
            END AS retention_rate
        FROM CustomerBookings
        GROUP BY period_label
        ORDER BY MIN(booking_date)
    """, cteSelect, cteGroup);

    List<CustomerTrend> result = new ArrayList<>();
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setInt(1, branchId); // FirstBooking
        stmt.setInt(2, branchId); // CustomerBookings
        Date startDate = getStartDateByPeriod(period);
        stmt.setDate(3, new java.sql.Date(startDate.getTime())); // CustomerBookings

        ResultSet rs = stmt.executeQuery();
        while (rs.next()) {
            CustomerTrend trend = new CustomerTrend();
            trend.setDate(rs.getDate("booking_date"));
            trend.setNewCustomers(rs.getInt("new_customers"));
            trend.setReturningCustomers(rs.getInt("returning_customers"));
            trend.setTotalCustomers(rs.getInt("total_customers"));
            trend.setAvgSpending(rs.getBigDecimal("avg_spending"));
            trend.setRetentionRate(rs.getDouble("retention_rate"));
            trend.setPeriodLabel(rs.getString("period_label"));
            trend.setPeriod(period);
            trend.setBranchId(branchId);
            result.add(trend);
        }
    }
    return result;
}

    // Phân tích khung giờ cao điểm
    public List<RevenueChart> getPeakHourAnalysis(int branchId) throws SQLException {
        String sql = """
            SELECT 
                CASE 
                    WHEN DATEPART(hour, b.start_time) BETWEEN 6 AND 9 THEN 'Sáng sớm (6-9h)'
                    WHEN DATEPART(hour, b.start_time) BETWEEN 9 AND 12 THEN 'Buổi sáng (9-12h)'
                    WHEN DATEPART(hour, b.start_time) BETWEEN 12 AND 15 THEN 'Buổi trưa (12-15h)'
                    WHEN DATEPART(hour, b.start_time) BETWEEN 15 AND 18 THEN 'Chiều (15-18h)'
                    WHEN DATEPART(hour, b.start_time) BETWEEN 18 AND 21 THEN 'Tối (18-21h)'
                    ELSE 'Ngoài giờ'
                END as label,
                COUNT(*) as value,
                'peak_hour' as category
            FROM Booking b
            JOIN Pools p ON b.pool_id = p.pool_id
            WHERE p.branch_id = ?
                AND b.booking_date >= DATEADD(month, -1, GETDATE())
                AND b.booking_status IN ('confirmed', 'completed')
            GROUP BY 
                CASE 
                    WHEN DATEPART(hour, b.start_time) BETWEEN 6 AND 9 THEN 'Sáng sớm (6-9h)'
                    WHEN DATEPART(hour, b.start_time) BETWEEN 9 AND 12 THEN 'Buổi sáng (9-12h)'
                    WHEN DATEPART(hour, b.start_time) BETWEEN 12 AND 15 THEN 'Buổi trưa (12-15h)'
                    WHEN DATEPART(hour, b.start_time) BETWEEN 15 AND 18 THEN 'Chiều (15-18h)'
                    WHEN DATEPART(hour, b.start_time) BETWEEN 18 AND 21 THEN 'Tối (18-21h)'
                    ELSE 'Ngoài giờ'
                END
            ORDER BY value DESC
        """;

        List<RevenueChart> result = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, branchId);
            ResultSet rs = stmt.executeQuery();

            String[] colors = {"#FF6384", "#36A2EB", "#FFCE56", "#4BC0C0", "#9966FF", "#FF9F40"};
            int colorIndex = 0;

            while (rs.next()) {
                RevenueChart chart = new RevenueChart();
                chart.setLabel(rs.getString("label"));
                chart.setValue(rs.getBigDecimal("value"));
                chart.setCategory(rs.getString("category"));
                chart.setColor(colors[colorIndex % colors.length]);
                colorIndex++;
                result.add(chart);
            }
        }
        return result;
    }

    // Top khách hàng VIP
    public List<RevenueChart> getTopCustomers(int branchId, int limit) throws SQLException {
        String sql = """
            SELECT TOP (?) 
                u.full_name as label,
                SUM(p.total_amount) as value,
                'customer' as category,
                COUNT(DISTINCT b.booking_id) as booking_count
            FROM Users u
            JOIN Booking b ON u.user_id = b.user_id
            JOIN Pools po ON b.pool_id = po.pool_id
            JOIN Payments p ON b.booking_id = p.booking_id
            WHERE po.branch_id = ? 
                AND p.payment_status = 'completed'
                AND p.payment_date >= DATEADD(month, -3, GETDATE())
                AND b.booking_status IN ('confirmed', 'completed')
            GROUP BY u.user_id, u.full_name
            ORDER BY value DESC
        """;

        List<RevenueChart> result = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, limit);
            stmt.setInt(2, branchId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                RevenueChart chart = new RevenueChart();
                chart.setLabel(rs.getString("label"));
                chart.setValue(rs.getBigDecimal("value"));
                chart.setCategory(rs.getString("category"));
                result.add(chart);
            }
        }
        return result;
    }

    // Thống kê trạng thái booking
    public List<RevenueChart> getBookingStatusStats(int branchId) throws SQLException {
        String sql = """
            SELECT 
                b.booking_status as label,
                COUNT(*) as value,
                'status' as category
            FROM Booking b
            JOIN Pools p ON b.pool_id = p.pool_id
            WHERE p.branch_id = ?
                AND b.booking_date >= DATEADD(month, -1, GETDATE())
            GROUP BY b.booking_status
            ORDER BY value DESC
        """;

        List<RevenueChart> result = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, branchId);
            ResultSet rs = stmt.executeQuery();

            // Optional: Map status to color
            java.util.Map<String, String> statusColors = java.util.Map.of(
                    "pending", "#FFC107",
                    "confirmed", "#28A745",
                    "completed", "#17A2B8",
                    "canceled", "#DC3545"
            );

            while (rs.next()) {
                RevenueChart chart = new RevenueChart();
                chart.setLabel(rs.getString("label"));
                chart.setValue(rs.getBigDecimal("value"));
                chart.setCategory(rs.getString("category"));
                chart.setColor(statusColors.getOrDefault(rs.getString("label"), "#6C757D"));
                result.add(chart);
            }
        }
        return result;
    }

    // Utility methods
    private Date[] getPeriodDates(String period) {
        LocalDate now = LocalDate.now();
        LocalDate currentStart, previousStart;
        switch (period.toLowerCase()) {
            case "daily":
                currentStart = now.minusDays(30);
                previousStart = now.minusDays(60);
                break;
            case "weekly":
                currentStart = now.minusWeeks(12);
                previousStart = now.minusWeeks(24);
                break;
            case "monthly":
                currentStart = now.minusMonths(12);
                previousStart = now.minusMonths(24);
                break;
            default:
                currentStart = now.minusMonths(1);
                previousStart = now.minusMonths(2);
        }
        return new Date[]{
            java.sql.Date.valueOf(currentStart),
            java.sql.Date.valueOf(previousStart)
        };
    }

    private Date getStartDateByPeriod(String period) {
        LocalDate now = LocalDate.now();
        switch (period.toLowerCase()) {
            case "daily":
                return java.sql.Date.valueOf(now.minusDays(30));
            case "weekly":
                return java.sql.Date.valueOf(now.minusWeeks(12));
            case "monthly":
                return java.sql.Date.valueOf(now.minusMonths(12));
            default:
                return java.sql.Date.valueOf(now.minusMonths(1));
        }
    }

    // Kiểm tra quyền truy cập
    public boolean isManagerAuthorized(int managerId, int branchId) throws SQLException {
        String sql = "SELECT COUNT(*) FROM Branchs WHERE manager_id = ? AND branch_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, managerId);
            stmt.setInt(2, branchId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        }
        return false;
    }
}