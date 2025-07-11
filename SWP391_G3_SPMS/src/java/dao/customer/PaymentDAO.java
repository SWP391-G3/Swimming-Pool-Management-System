/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.customer;

import dal.DBContext;

import java.sql.*;
import model.customer.Payment;

/**
 *
 * @author LAZYVL
 */
public class PaymentDAO extends DBContext {

    public void addPayment(Payment payment) {
        String sql = "INSERT INTO Payments (booking_id, payment_method, payment_status, payment_date, total_amount, discount_amount, transaction_reference, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, GETDATE())";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, payment.getBookingId());
            st.setString(2, payment.getPaymentMethod());
            st.setString(3, payment.getPaymentStatus());
            st.setDate(4, (Date) payment.getPaymentDate());
            st.setBigDecimal(5, payment.getTotalAmount());
            st.setBigDecimal(6, payment.getDiscountAmount());
            st.setString(7, payment.getTransactionReference());
            // created_at dùng GETDATE() trong DB nên không set ở đây

            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getLastPaymentIdByBookingId(int bookingId) {
        int paymentId = -1;
        String sql = "SELECT TOP 1 payment_id FROM Payments WHERE booking_id = ? ORDER BY created_at DESC";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                paymentId = rs.getInt("payment_id");
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return paymentId;
    }

    public void updateTransactionReference(int paymentId, String newReference) {
        String sql = "UPDATE Payments SET transaction_reference = ? WHERE payment_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, newReference);
            st.setInt(2, paymentId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updatePaymentStatus(int paymentId, String newStutus) {
        String sql = "UPDATE Payments SET payment_status = ? WHERE payment_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, newStutus);
            st.setInt(2, paymentId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Payment getPaymentByBookingId(int bookingId) {
        Payment payment = null;
        String sql = "SELECT TOP 1 * FROM Payments WHERE booking_id = ? ORDER BY created_at DESC";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, bookingId);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                payment = new Payment();
                payment.setPaymentId(rs.getInt("payment_id"));
                payment.setBookingId(rs.getInt("booking_id"));
                payment.setPaymentMethod(rs.getString("payment_method"));
                payment.setPaymentStatus(rs.getString("payment_status"));
                payment.setPaymentDate(rs.getTimestamp("payment_date")); // hoặc rs.getDate(...) tùy theo kiểu bạn dùng
                payment.setTotalAmount(rs.getBigDecimal("total_amount"));
                payment.setDiscountAmount(rs.getBigDecimal("discount_amount"));
                payment.setTransactionReference(rs.getString("transaction_reference"));
                payment.setCreatedAt(rs.getTimestamp("created_at"));
            }

            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return payment;
    }
}
