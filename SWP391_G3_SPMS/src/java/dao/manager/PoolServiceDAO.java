/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.manager;

import dal.DBContext;
import model.manager.PoolService;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PoolServiceDAO extends DBContext {

    public List<PoolService> getAll() throws SQLException {
        List<PoolService> list = new ArrayList<>();
        String sql = "SELECT * FROM Pool_Service";
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            list.add(new PoolService(
                    rs.getInt("pool_service_id"),
                    rs.getInt("pool_id"),
                    rs.getString("service_name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getString("service_image"),
                    rs.getInt("quantity"),
                    rs.getString("service_status")
            ));
        }
        return list;
    }

    public PoolService getById(int id) throws SQLException {
        String sql = "SELECT * FROM Pool_Service WHERE pool_service_id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, id);
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            return new PoolService(
                    rs.getInt("pool_service_id"),
                    rs.getInt("pool_id"),
                    rs.getString("service_name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getString("service_image"),
                    rs.getInt("quantity"),
                    rs.getString("service_status")
            );
        }
        return null;
    }

    public boolean add(PoolService ps) throws SQLException {
        String sql = "INSERT INTO Pool_Service (pool_id, service_name, description, price, service_image, quantity, service_status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, ps.getPoolId());
        st.setString(2, ps.getServiceName());
        st.setString(3, ps.getDescription());
        st.setDouble(4, ps.getPrice());
        st.setString(5, ps.getServiceImage());
        st.setInt(6, ps.getQuantity());
        st.setString(7, ps.getServiceStatus());
        return st.executeUpdate() > 0;
    }

    public boolean update(PoolService ps) throws SQLException {
        String sql = "UPDATE Pool_Service SET pool_id=?, service_name=?, description=?, price=?, service_image=?, quantity=?, service_status=? WHERE pool_service_id=?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, ps.getPoolId());
        st.setString(2, ps.getServiceName());
        st.setString(3, ps.getDescription());
        st.setDouble(4, ps.getPrice());
        st.setString(5, ps.getServiceImage());
        st.setInt(6, ps.getQuantity());
        st.setString(7, ps.getServiceStatus());
        st.setInt(8, ps.getPoolServiceId());
        return st.executeUpdate() > 0;
    }

    public boolean delete(int id) throws SQLException {
        String sql = "DELETE FROM Pool_Service WHERE pool_service_id = ?";
        PreparedStatement st = connection.prepareStatement(sql);
        st.setInt(1, id);
        return st.executeUpdate() > 0;
    }
// Lấy danh sách dịch vụ theo poolIds, filter nâng cao

    public List<PoolService> filterServicesWithPoolIds(
            String name, Double minPrice, Double maxPrice, Integer poolId, int offset, int limit, List<Integer> allowedPoolIds
    ) throws SQLException {
        List<PoolService> list = new ArrayList<>();
        if (allowedPoolIds == null || allowedPoolIds.isEmpty()) {
            return list;
        }

        StringBuilder sql = new StringBuilder("SELECT * FROM Pool_Service WHERE ");
        if (poolId != null) {
            // Chỉ lọc 1 pool cụ thể (và phải thuộc allowedPoolIds)
            if (!allowedPoolIds.contains(poolId)) {
                return list;
            }
            sql.append("pool_id = ?");
        } else {
            sql.append("pool_id IN (");
            for (int i = 0; i < allowedPoolIds.size(); i++) {
                sql.append("?");
                if (i < allowedPoolIds.size() - 1) {
                    sql.append(",");
                }
            }
            sql.append(")");
        }
        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND service_name LIKE ?");
        }
        if (minPrice != null) {
            sql.append(" AND price >= ?");
        }
        if (maxPrice != null) {
            sql.append(" AND price <= ?");
        }
        sql.append(" ORDER BY pool_service_id ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            int idx = 1;
            if (poolId != null) {
                st.setInt(idx++, poolId);
            } else {
                for (Integer id : allowedPoolIds) {
                    st.setInt(idx++, id);
                }
            }
            if (name != null && !name.trim().isEmpty()) {
                st.setString(idx++, "%" + name + "%");
            }
            if (minPrice != null) {
                st.setDouble(idx++, minPrice);
            }
            if (maxPrice != null) {
                st.setDouble(idx++, maxPrice);
            }
            st.setInt(idx++, offset);
            st.setInt(idx++, limit);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new PoolService(
                        rs.getInt("pool_service_id"),
                        rs.getInt("pool_id"),
                        rs.getString("service_name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getString("service_image"),
                        rs.getInt("quantity"),
                        rs.getString("service_status")
                ));
            }
        }
        return list;
    }

// Đếm số lượng dịch vụ theo poolIds, filter nâng cao
    public int countFilteredWithPoolIds(
            String name, Double minPrice, Double maxPrice, Integer poolId, List<Integer> allowedPoolIds
    ) throws SQLException {
        if (allowedPoolIds == null || allowedPoolIds.isEmpty()) {
            return 0;
        }
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Pool_Service WHERE ");
        if (poolId != null) {
            if (!allowedPoolIds.contains(poolId)) {
                return 0;
            }
            sql.append("pool_id = ?");
        } else {
            sql.append("pool_id IN (");
            for (int i = 0; i < allowedPoolIds.size(); i++) {
                sql.append("?");
                if (i < allowedPoolIds.size() - 1) {
                    sql.append(",");
                }
            }
            sql.append(")");
        }
        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND service_name LIKE ?");
        }
        if (minPrice != null) {
            sql.append(" AND price >= ?");
        }
        if (maxPrice != null) {
            sql.append(" AND price <= ?");
        }

        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            int idx = 1;
            if (poolId != null) {
                st.setInt(idx++, poolId);
            } else {
                for (Integer id : allowedPoolIds) {
                    st.setInt(idx++, id);
                }
            }
            if (name != null && !name.trim().isEmpty()) {
                st.setString(idx++, "%" + name + "%");
            }
            if (minPrice != null) {
                st.setDouble(idx++, minPrice);
            }
            if (maxPrice != null) {
                st.setDouble(idx++, maxPrice);
            }
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

}
