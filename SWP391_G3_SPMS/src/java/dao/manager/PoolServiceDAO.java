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
import model.manager.ServiceReport;

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

    public List<PoolService> filterServicesByPoolName(
            String name, Double minPrice, Double maxPrice, String poolName, int offset, int limit
    ) throws SQLException {
        List<PoolService> list = new ArrayList<>();
        if (poolName == null || poolName.trim().isEmpty()) {
            return list;
        }

        StringBuilder sql = new StringBuilder(
                "SELECT s.* "
                + "FROM Pool_Service s "
                + "JOIN Pools p ON s.pool_id = p.pool_id "
                + "WHERE p.pool_name = ? "
        );
        if (name != null && !name.trim().isEmpty()) {
            sql.append("AND s.service_name LIKE ? ");
        }
        if (minPrice != null) {
            sql.append("AND s.price >= ? ");
        }
        if (maxPrice != null) {
            sql.append("AND s.price <= ? ");
        }
        sql.append("ORDER BY s.pool_service_id ASC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            int idx = 1;
            st.setString(idx++, poolName);
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
    
    public List<ServiceReport> filterServiceReportsByStaff(int staffId, String status, int offset, int limit) throws SQLException {
    List<ServiceReport> list = new ArrayList<>();
    StringBuilder sql = new StringBuilder(
        "SELECT sr.*, p.pool_name, b.branch_name " +
        "FROM Service_Reports sr " +
        "JOIN Pools p ON sr.pool_id = p.pool_id " +
        "LEFT JOIN Branchs b ON sr.branch_id = b.branch_id " +
        "WHERE sr.staff_id = ? "
    );
    List<Object> params = new ArrayList<>();
    params.add(staffId);

    if (status != null && !status.trim().isEmpty()) {
        sql.append("AND sr.status = ? ");
        params.add(status.trim());
    }
    sql.append("ORDER BY sr.report_date DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");
    params.add(offset);
    params.add(limit);

    try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
        int idx = 1;
        for (Object param : params) {
            if (param instanceof String) {
                st.setString(idx++, (String) param);
            } else if (param instanceof Integer) {
                st.setInt(idx++, (Integer) param);
            }
        }
        ResultSet rs = st.executeQuery();
        while (rs.next()) {
            ServiceReport r = new ServiceReport();
            r.setReportId(rs.getInt("report_id"));
            r.setStaffId(rs.getInt("staff_id"));
            r.setPoolId(rs.getInt("pool_id"));
            r.setBranchId(rs.getInt("branch_id"));
            r.setServiceId(rs.getInt("service_id"));
            r.setServiceName(rs.getString("service_name"));
            r.setReportReason(rs.getString("report_reason"));
            r.setSuggestion(rs.getString("suggestion"));
            r.setStatus(rs.getString("status"));
            r.setReportDate(rs.getTimestamp("report_date"));
            r.setPoolName(rs.getString("pool_name"));
            r.setBranchName(rs.getString("branch_name"));
            list.add(r);
        }
    }
    return list;
}

public int countServiceReportsByStaff(int staffId, String status) throws SQLException {
    StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Service_Reports WHERE staff_id = ? ");
    List<Object> params = new ArrayList<>();
    params.add(staffId);
    if (status != null && !status.trim().isEmpty()) {
        sql.append("AND status = ? ");
        params.add(status.trim());
    }
    try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
        int idx = 1;
        for (Object param : params) {
            if (param instanceof String) {
                st.setString(idx++, (String) param);
            } else if (param instanceof Integer) {
                st.setInt(idx++, (Integer) param);
            }
        }
        ResultSet rs = st.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
    }
    return 0;
}

    public int countFilteredByPoolName(
            String name, Double minPrice, Double maxPrice, String poolName
    ) throws SQLException {
        if (poolName == null || poolName.trim().isEmpty()) {
            return 0;
        }

        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) "
                + "FROM Pool_Service s "
                + "JOIN Pools p ON s.pool_id = p.pool_id "
                + "WHERE p.pool_name = ? "
        );
        if (name != null && !name.trim().isEmpty()) {
            sql.append("AND s.service_name LIKE ? ");
        }
        if (minPrice != null) {
            sql.append("AND s.price >= ? ");
        }
        if (maxPrice != null) {
            sql.append("AND s.price <= ? ");
        }

        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            int idx = 1;
            st.setString(idx++, poolName);
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

    public List<ServiceReport> filterServiceReports(
            String name, Integer poolId, String status, Integer branchId, int offset, int limit
    ) throws SQLException {
        List<ServiceReport> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT sr.*, p.pool_name, s.full_name AS staff_name, b.branch_name "
                + "FROM Service_Reports sr "
                + "JOIN Pools p ON sr.pool_id = p.pool_id "
                + "LEFT JOIN Users s ON sr.staff_id = s.user_id "
                + "LEFT JOIN Branchs b ON sr.branch_id = b.branch_id "
                + "WHERE 1=1 "
        );
        List<Object> params = new ArrayList<>();

        if (name != null && !name.trim().isEmpty()) {
            sql.append("AND sr.service_name LIKE ? ");
            params.add("%" + name.trim() + "%");
        }
        if (poolId != null) {
            sql.append("AND sr.pool_id = ? ");
            params.add(poolId);
        }
        if (branchId != null) {
            sql.append("AND sr.branch_id = ? ");
            params.add(branchId);
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND sr.status = ? ");
            params.add(status.trim());
        }
        sql.append("ORDER BY sr.report_date DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");
        params.add(offset);
        params.add(limit);

        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            int idx = 1;
            for (Object param : params) {
                if (param instanceof String) {
                    st.setString(idx++, (String) param);
                } else if (param instanceof Integer) {
                    st.setInt(idx++, (Integer) param);
                }
            }
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                ServiceReport r = new ServiceReport();
                r.setReportId(rs.getInt("report_id"));
                r.setStaffId(rs.getInt("staff_id"));
                r.setPoolId(rs.getInt("pool_id"));
                r.setBranchId(rs.getInt("branch_id"));
                r.setServiceId(rs.getInt("service_id"));
                r.setServiceName(rs.getString("service_name"));
                r.setReportReason(rs.getString("report_reason"));
                r.setSuggestion(rs.getString("suggestion"));
                r.setStatus(rs.getString("status"));
                r.setReportDate(rs.getTimestamp("report_date"));
                r.setPoolName(rs.getString("pool_name"));
                r.setStaffName(rs.getString("staff_name"));
                r.setBranchName(rs.getString("branch_name"));
                list.add(r);
            }
        }
        return list;
    }

    public int countServiceReports(String name, Integer poolId, String status, Integer branchId) throws SQLException {
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Service_Reports WHERE 1=1 ");
        List<Object> params = new ArrayList<>();
        if (name != null && !name.trim().isEmpty()) {
            sql.append("AND service_name LIKE ? ");
            params.add("%" + name.trim() + "%");
        }
        if (poolId != null) {
            sql.append("AND pool_id = ? ");
            params.add(poolId);
        }
        if (branchId != null) {
            sql.append("AND branch_id = ? ");
            params.add(branchId);
        }
        if (status != null && !status.trim().isEmpty()) {
            sql.append("AND status = ? ");
            params.add(status.trim());
        }
        try (PreparedStatement st = connection.prepareStatement(sql.toString())) {
            int idx = 1;
            for (Object param : params) {
                if (param instanceof String) {
                    st.setString(idx++, (String) param);
                } else if (param instanceof Integer) {
                    st.setInt(idx++, (Integer) param);
                }
            }
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
        return 0;
    }

    public boolean updateReportStatus(int reportId, String newStatus) throws SQLException {
        String sql = "UPDATE Service_Reports SET status = ? WHERE report_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, newStatus);
            st.setInt(2, reportId);
            return st.executeUpdate() > 0;
        }
    }
}
