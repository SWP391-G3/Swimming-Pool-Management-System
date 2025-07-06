/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.customer;

import dal.DBContext;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.customer.PoolService;
/**
 *
 * @author LAZYVL
 */
public class PoolServiceDAO extends DBContext {

    public List<PoolService> getServicesByPoolId(int poolId) {
        List<PoolService> list = new ArrayList<>();
        String sql = "SELECT * FROM Pool_Service WHERE pool_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, poolId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int poolServiceId = rs.getInt(1);
                int poolIdDb = rs.getInt(2);
                String serviceName = rs.getString(3);
                String description = rs.getString(4);
                BigDecimal price = rs.getBigDecimal(5);
                String serviceImage = rs.getString(6);
                int quantity = rs.getInt(7);
                String serviceStatus = rs.getString(8);

                PoolService service = new PoolService(poolServiceId, poolIdDb, serviceName, description, price, serviceImage, quantity, serviceStatus);
                list.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public PoolService getServiceByName(int poolId, String rentName) {
        String sql = "SELECT pool_service_id, pool_id, service_name, description, price, service_image, quantity, service_status "
                + "FROM Pool_Service WHERE pool_id = ? AND service_name = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, poolId);
            st.setString(2, rentName);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int poolServiceId = rs.getInt("pool_service_id");
                int poolIdDb = rs.getInt("pool_id");
                String serviceName = rs.getString("service_name");
                String description = rs.getString("description");
                BigDecimal price = rs.getBigDecimal("price");
                String image = rs.getString("service_image");
                int quantity = rs.getInt("quantity");
                String status = rs.getString("service_status");

                return new PoolService(poolServiceId, poolIdDb, serviceName, description, price, image, quantity, status);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
}
