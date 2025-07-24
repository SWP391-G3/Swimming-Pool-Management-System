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
import model.customer.Pool;
import model.customer.PoolService;
import model.manager.ServiceReport;

/**
 *
 * @author LAZYVL
 */
public class PoolServiceDAO extends DBContext {

    public List<PoolService> getServicesByPoolId(int poolId) {
        List<PoolService> list = new ArrayList<>();
        String sql = "SELECT * FROM Pool_Service WHERE pool_id = ? AND service_status = 'available'";
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

    public PoolService getServiceById(int serviceId) {
        String sql = "SELECT pool_service_id, pool_id, service_name, description, price, service_image, quantity, service_status "
                + "FROM Pool_Service WHERE pool_service_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, serviceId);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int poolServiceId = rs.getInt("pool_service_id");
                int poolId = rs.getInt("pool_id");
                String serviceName = rs.getString("service_name");
                String description = rs.getString("description");
                BigDecimal price = rs.getBigDecimal("price");
                String image = rs.getString("service_image");
                int quantity = rs.getInt("quantity");
                String status = rs.getString("service_status");

                return new PoolService(poolServiceId, poolId, serviceName, description, price, image, quantity, status);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
      public List<Pool> getAllPoolsByBranch(int branchId) throws SQLException {
        List<Pool> list = new ArrayList<>();
        String sql = "SELECT pool_id, pool_name FROM Pools WHERE branch_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, branchId);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Pool pool = new Pool(
                        rs.getInt("pool_id"),
                        rs.getString("pool_name"),
                        null, null, 0, null, null, false, null, null, null, null, branchId
                );
                list.add(pool);
            }
        }
        return list;
    }
      
       public ServiceReport getReportById(int reportId) throws SQLException {
        String query = "SELECT sr.*, p.pool_name, u.full_name AS staff_name "
                + "FROM service_reports sr "
                + "LEFT JOIN pools p ON sr.pool_id = p.pool_id "
                + "LEFT JOIN Users u ON sr.staff_id = u.user_id "
                + "WHERE sr.report_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, reportId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ServiceReport report = new ServiceReport();
                report.setReportId(rs.getInt("report_id"));
                report.setStaffId(rs.getInt("staff_id"));
                report.setPoolId(rs.getInt("pool_id"));
                report.setBranchId(rs.getInt("branch_id"));
                report.setServiceId(rs.getInt("service_id"));
                report.setServiceName(rs.getString("service_name"));
                report.setReportReason(rs.getString("report_reason"));
                report.setSuggestion(rs.getString("suggestion"));
                report.setStatus(rs.getString("status"));
                report.setReportDate(rs.getTimestamp("report_date"));
                report.setPoolName(rs.getString("pool_name"));
                report.setStaffName(rs.getString("staff_name"));
                report.setManagerNote(rs.getString("manager_note"));
                report.setProcessedAt(rs.getTimestamp("processed_at"));
                report.setProcessedBy(rs.getInt("processed_by"));
                return report;
            }
        }
        return null;
    }
}
