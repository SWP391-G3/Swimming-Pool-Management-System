package dao.staff;

import dal.DBContext;
import model.customer.*;
import model.staff.*;
import java.sql.*;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

public class SaleTicketDirectlyDAO extends DBContext {

    private SaleTicketDirectly extractSaleFromResultSet(ResultSet rs) throws SQLException {
        SaleTicketDirectly sale = new SaleTicketDirectly();
        sale.setSaleId(rs.getInt("sale_id"));
        sale.setCustomerName(rs.getString("customer_name"));
        sale.setCustomerPhone(rs.getString("customer_phone"));
        sale.setCustomerEmail(rs.getString("customer_email"));

        // ✅ SỬA: Handle NULL userId với SQL Server
        int userIdValue = rs.getInt("user_id");
        if (rs.wasNull()) {
            sale.setUserId(null);
        } else {
            sale.setUserId(userIdValue);
        }

        sale.setStaffId(rs.getInt("staff_id"));
        sale.setPoolId(rs.getInt("pool_id"));
        sale.setBranchId(rs.getInt("branch_id"));
        sale.setBookingId(rs.getInt("booking_id"));
        sale.setTotalAmount(rs.getBigDecimal("total_amount"));
        sale.setPaymentMethod(rs.getString("payment_method"));
        sale.setPaymentStatus(rs.getString("payment_status"));
        sale.setSaleDate(rs.getTimestamp("sale_date"));
        sale.setCreatedAt(rs.getTimestamp("created_at"));
        sale.setNotes(rs.getString("notes"));

        return sale;
    }

    // ✅ Lấy danh sách lịch sử bán vé với tìm kiếm và sắp xếp nâng cao
    public List<SaleTicketDirectly> getSaleHistoryByStaff(int staffId, int poolId, int offset, int limit,
            String search, Date fromDate, Date toDate, String sortBy, String sortOrder) {
        List<SaleTicketDirectly> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT s.*, u.full_name as customer_full_name ");
        sql.append("FROM Sale_Ticket_Directly s ");
        sql.append("LEFT JOIN Users u ON s.user_id = u.user_id ");
        sql.append("WHERE s.staff_id = ? AND s.pool_id = ? ");

        List<Object> params = new ArrayList<>();
        params.add(staffId);
        params.add(poolId);

        // Search filter - mở rộng tìm kiếm
        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND (s.customer_name LIKE ? OR s.customer_phone LIKE ? OR u.full_name LIKE ? OR s.customer_email LIKE ? OR CAST(s.sale_id AS VARCHAR) LIKE ?) ");
            String searchPattern = "%" + search.trim() + "%";
            params.add(searchPattern); // customer_name
            params.add(searchPattern); // customer_phone  
            params.add(searchPattern); // user full_name
            params.add(searchPattern); // customer_email
            params.add(searchPattern); // sale_id
        }

        // Date filter
        if (fromDate != null) {
            sql.append("AND CAST(s.sale_date AS DATE) >= ? ");
            params.add(fromDate);
        }
        if (toDate != null) {
            sql.append("AND CAST(s.sale_date AS DATE) <= ? ");
            params.add(toDate);
        }

        // ✅ Sorting
        sql.append("ORDER BY ");
        switch (sortBy != null ? sortBy : "date") {
            case "date":
                sql.append("s.sale_date");
                break;
            case "amount":
                sql.append("s.total_amount");
                break;
            case "customer":
                sql.append("s.customer_name");
                break;
            case "status":
                sql.append("s.payment_status");
                break;
            default:
                sql.append("s.sale_date");
        }

        // Sort order
        if ("asc".equalsIgnoreCase(sortOrder)) {
            sql.append(" ASC ");
        } else {
            sql.append(" DESC ");
        }

        sql.append("OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add(offset);
        params.add(limit);

        try {
            PreparedStatement st = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                SaleTicketDirectly sale = extractSaleFromResultSet(rs);
                list.add(sale);
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ✅ Đếm tổng số records với cùng filter
    public int countSaleHistoryByStaff(int staffId, int poolId, String search, Date fromDate, Date toDate) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT COUNT(*) FROM Sale_Ticket_Directly s ");
        sql.append("LEFT JOIN Users u ON s.user_id = u.user_id ");
        sql.append("WHERE s.staff_id = ? AND s.pool_id = ? ");

        List<Object> params = new ArrayList<>();
        params.add(staffId);
        params.add(poolId);

        // Search filter - giống với query chính
        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND (s.customer_name LIKE ? OR s.customer_phone LIKE ? OR u.full_name LIKE ? OR s.customer_email LIKE ? OR CAST(s.sale_id AS VARCHAR) LIKE ?) ");
            String searchPattern = "%" + search.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        // Date filter
        if (fromDate != null) {
            sql.append("AND CAST(s.sale_date AS DATE) >= ? ");
            params.add(fromDate);
        }
        if (toDate != null) {
            sql.append("AND CAST(s.sale_date AS DATE) <= ? ");
            params.add(toDate);
        }

        try {
            PreparedStatement st = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // SỬA: Method getSaleStatistics
    public SaleStatistics getSaleStatistics(int staffId, int poolId, String search, Date fromDate, Date toDate) {
        StringBuilder sql = new StringBuilder();
        sql.append("SELECT ");
        sql.append("COUNT(*) as total_transactions, ");
        sql.append("ISNULL(SUM(s.total_amount), 0) as total_revenue, ");
        sql.append("ISNULL(AVG(s.total_amount), 0) as avg_transaction_value, ");
        sql.append("ISNULL(MAX(s.total_amount), 0) as max_transaction_value, ");
        sql.append("ISNULL(MIN(s.total_amount), 0) as min_transaction_value ");
        sql.append("FROM Sale_Ticket_Directly s ");
        sql.append("LEFT JOIN Users u ON s.user_id = u.user_id ");
        sql.append("WHERE s.staff_id = ? AND s.pool_id = ? AND s.payment_status = 'completed' ");

        List<Object> params = new ArrayList<>();
        params.add(staffId);
        params.add(poolId);

        // Search filter
        if (search != null && !search.trim().isEmpty()) {
            sql.append("AND (s.customer_name LIKE ? OR s.customer_phone LIKE ? OR u.full_name LIKE ? OR s.customer_email LIKE ? OR CAST(s.sale_id AS VARCHAR) LIKE ?) ");
            String searchPattern = "%" + search.trim() + "%";
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
            params.add(searchPattern);
        }

        // Date filter
        if (fromDate != null) {
            sql.append("AND CAST(s.sale_date AS DATE) >= ? ");
            params.add(fromDate);
        }
        if (toDate != null) {
            sql.append("AND CAST(s.sale_date AS DATE) <= ? ");
            params.add(toDate);
        }

        try {
            PreparedStatement st = connection.prepareStatement(sql.toString());
            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                SaleStatistics stats = new SaleStatistics();
                stats.setTotalTransactions(rs.getInt("total_transactions"));

                // ✅ SỬA: Xử lý BigDecimal an toàn hơn
                BigDecimal totalRevenue = rs.getBigDecimal("total_revenue");
                stats.setTotalRevenue(totalRevenue != null ? totalRevenue : BigDecimal.ZERO);

                BigDecimal avgValue = rs.getBigDecimal("avg_transaction_value");
                stats.setAvgTransactionValue(avgValue != null ? avgValue : BigDecimal.ZERO);

                BigDecimal maxValue = rs.getBigDecimal("max_transaction_value");
                stats.setMaxTransactionValue(maxValue != null ? maxValue : BigDecimal.ZERO);

                BigDecimal minValue = rs.getBigDecimal("min_transaction_value");
                stats.setMinTransactionValue(minValue != null ? minValue : BigDecimal.ZERO);

                return stats;
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new SaleStatistics(); // Return empty stats if error
    }

    // Lấy chi tiết đầy đủ giao dịch
    public SaleDetailInfo getSaleDetailInfo(int saleId) {
        try {
            // 1. Lấy thông tin Sale
            SaleTicketDirectly sale = getSaleWithDetails(saleId);
            if (sale == null) {
                System.out.println("Sale not found for ID: " + saleId);
                return null;
            }

            SaleDetailInfo detailInfo = new SaleDetailInfo();
            detailInfo.setSale(sale);

            // 2. Lấy thông tin Booking (optional)
            try {
                dao.customer.BookingDAO bookingDAO = new dao.customer.BookingDAO();
                Booking booking = bookingDAO.getBookingById(sale.getBookingId());
                detailInfo.setBooking(booking);
            } catch (Exception e) {
                System.out.println("Error loading booking: " + e.getMessage());
                // Continue without booking info
            }

            // 3. Lấy thông tin Payment (optional)
            try {
                dao.customer.PaymentDAO paymentDAO = new dao.customer.PaymentDAO();
                Payment payment = paymentDAO.getPaymentByBookingId(sale.getBookingId());
                detailInfo.setPayment(payment);

                // 4. Lấy tickets và services nếu có payment
                if (payment != null) {
                    List<SaleTicketInfo> tickets = getSaleTicketInfo(payment.getPaymentId());
                    detailInfo.setTickets(tickets);

                    List<SaleServiceInfo> services = getSaleServiceInfo(payment.getPaymentId());
                    detailInfo.setServices(services);
                }
            } catch (Exception e) {
                System.out.println("Error loading payment info: " + e.getMessage());
                // Continue without payment info
            }

            // 5. Lấy thông tin Customer (optional)
            if (sale.getUserId() != null) {
                try {
                    dao.customer.UserDAO userDAO = new dao.customer.UserDAO();
                    User customer = userDAO.getUser(sale.getUserId());
                    detailInfo.setCustomer(customer);
                } catch (Exception e) {
                    System.out.println("Error loading customer: " + e.getMessage());
                    // Continue without customer info
                }
            }

            return detailInfo;

        } catch (Exception e) {
            System.out.println("Error in getSaleDetailInfo: " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    // Lấy thông tin tickets đã bán
    private List<SaleTicketInfo> getSaleTicketInfo(int paymentId) {
        List<SaleTicketInfo> tickets = new ArrayList<>();
        String sql = "SELECT pt.ticket_id, pt.amount, pt.quantity, t.ticket_type_id, "
                + "tt.type_name, t.ticket_code "
                + "FROM Payment_Ticket pt "
                + "JOIN Ticket t ON pt.ticket_id = t.ticket_id "
                + "JOIN Ticket_Type tt ON t.ticket_type_id = tt.ticket_type_id "
                + "WHERE pt.payment_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, paymentId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                SaleTicketInfo ticket = new SaleTicketInfo();
                ticket.setTicketId(rs.getInt("ticket_id"));
                ticket.setTicketTypeId(rs.getInt("ticket_type_id"));
                ticket.setTicketTypeName(rs.getString("type_name"));
                ticket.setTicketPrice(rs.getBigDecimal("amount"));
                ticket.setQuantity(rs.getInt("quantity"));
                ticket.setTicketCode(rs.getString("ticket_code"));
                tickets.add(ticket);
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return tickets;
    }

    // Lấy thông tin services đã bán
    private List<SaleServiceInfo> getSaleServiceInfo(int paymentId) {
        List<SaleServiceInfo> services = new ArrayList<>();
        String sql = "SELECT pri.service_id, pri.amount, pri.quantity, "
                + "ps.service_name, ps.description "
                + "FROM Payment_RentItem pri "
                + "JOIN Pool_Service ps ON pri.service_id = ps.pool_service_id "
                + "WHERE pri.payment_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, paymentId);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                SaleServiceInfo service = new SaleServiceInfo();
                service.setServiceId(rs.getInt("service_id"));
                service.setServiceName(rs.getString("service_name"));
                service.setServicePrice(rs.getBigDecimal("amount"));
                service.setQuantity(rs.getInt("quantity"));
                service.setDescription(rs.getString("description"));
                services.add(service);
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return services;
    }

    public int createSaleTicketDirectly(SaleTicketDirectly sale) {
        String sql = "INSERT INTO Sale_Ticket_Directly (customer_name, customer_phone, customer_email, "
                + "user_id, staff_id, pool_id, branch_id, booking_id, total_amount, "
                + "payment_method, payment_status, sale_date, notes) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try {
            PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
            st.setString(1, sale.getCustomerName());
            st.setString(2, sale.getCustomerPhone());
            st.setString(3, sale.getCustomerEmail());

            // ✅ SỬA: Xử lý NULL userId
            if (sale.getUserId() != null) {
                st.setInt(4, sale.getUserId());
            } else {
                st.setNull(4, java.sql.Types.INTEGER);
            }

            st.setInt(5, sale.getStaffId());
            st.setInt(6, sale.getPoolId());
            st.setInt(7, sale.getBranchId());
            st.setInt(8, sale.getBookingId());
            st.setBigDecimal(9, sale.getTotalAmount());
            st.setString(10, sale.getPaymentMethod());
            st.setString(11, sale.getPaymentStatus());
            st.setTimestamp(12, sale.getSaleDate());
            st.setString(13, sale.getNotes());

            int result = st.executeUpdate();
            if (result > 0) {
                ResultSet rs = st.getGeneratedKeys();
                if (rs.next()) {
                    int generatedId = rs.getInt(1);
                    rs.close();
                    st.close();
                    return generatedId;
                }
                rs.close();
            }
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }

    // Lấy thông tin bán hàng với chi tiết
    public SaleTicketDirectly getSaleWithDetails(int saleId) {
        String sql = "SELECT * FROM Sale_Ticket_Directly WHERE sale_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, saleId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                SaleTicketDirectly sale = extractSaleFromResultSet(rs);
                rs.close();
                st.close();
                return sale;
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Thống kê doanh thu theo pool
    public BigDecimal getTotalSalesByPool(int poolId, Date fromDate, Date toDate) {
        String sql = "SELECT SUM(total_amount) as total "
                + "FROM Sale_Ticket_Directly "
                + "WHERE pool_id = ? AND sale_date BETWEEN ? AND ? "
                + "AND payment_status = 'completed'";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, poolId);
            st.setDate(2, fromDate);
            st.setDate(3, toDate);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                BigDecimal result = rs.getBigDecimal("total");
                return result != null ? result : BigDecimal.ZERO;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
}
