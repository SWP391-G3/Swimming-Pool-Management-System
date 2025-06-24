package dao.customer;

import model.customer.PaymentRentItem;
import dal.DBContext;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentRentItemDAO extends DBContext {

    // Thêm một Payment_RentItem mới
    public void addPaymentRentItem(int paymentId, int serviceId, java.math.BigDecimal amount, int quantity) {
        String sql = "INSERT INTO Payment_RentItem (payment_id, service_id, amount, quantity) VALUES (?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, paymentId);
            st.setInt(2, serviceId);
            st.setBigDecimal(3, amount);
            st.setInt(4, quantity);
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Lấy danh sách PaymentRentItem theo payment_id
    public List<PaymentRentItem> getPaymentRentItemsByPaymentId(int paymentId) {
        List<PaymentRentItem> list = new ArrayList<>();
        String sql = "SELECT * FROM Payment_RentItem WHERE payment_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, paymentId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                PaymentRentItem item = new PaymentRentItem();
                item.setPaymentRentId(rs.getInt("payment_rent_id"));
                item.setPaymentId(rs.getInt("payment_id"));
                item.setServiceId(rs.getInt("service_id"));
                item.setAmount(rs.getBigDecimal("amount"));
                item.setQuantity(rs.getInt("quantity"));
                list.add(item);
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Xoá payment_rent_item (tùy chọn)
    public void deletePaymentRentItem(int paymentRentId) {
        String sql = "DELETE FROM Payment_RentItem WHERE payment_rent_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, paymentRentId);
            st.executeUpdate();
            st.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
