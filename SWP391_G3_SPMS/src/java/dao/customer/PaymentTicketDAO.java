package dao.customer;

import model.customer.PaymentTicket;
import dal.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentTicketDAO extends DBContext {

    // Thêm một Payment_Ticket mới
    public void addPaymentTicket(int paymentId, int ticketId, java.math.BigDecimal amount, int quantity) {
        String sql = "INSERT INTO Payment_Ticket (payment_id, ticket_id, amount, quantity) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, paymentId);
            st.setInt(2, ticketId);
            st.setBigDecimal(3, amount);
            st.setInt(4, quantity);
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Lấy danh sách PaymentTicket theo payment_id
    public List<PaymentTicket> getPaymentTicketsByPaymentId(int paymentId) {
        List<PaymentTicket> list = new ArrayList<>();
        String sql = "SELECT * FROM Payment_Ticket WHERE payment_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, paymentId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                PaymentTicket pt = new PaymentTicket();
                pt.setPaymentTicketId(rs.getInt("payment_ticket_id"));
                pt.setPaymentId(rs.getInt("payment_id"));
                pt.setTicketId(rs.getInt("ticket_id"));
                pt.setAmount(rs.getBigDecimal("amount"));
                pt.setQuantity(rs.getInt("quantity"));
                list.add(pt);
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Xoá payment_ticket (tùy chọn)
    public void deletePaymentTicket(int paymentTicketId) {
        String sql = "DELETE FROM Payment_Ticket WHERE payment_ticket_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, paymentTicketId);
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
