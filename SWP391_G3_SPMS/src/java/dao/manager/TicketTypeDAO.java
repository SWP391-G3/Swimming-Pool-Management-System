/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.manager;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;
import model.manager.PoolTicket;
import model.manager.TicketType;
import org.apache.tomcat.jni.Pool;

/**
 *
 * @author Tuan Anh
 */
public class TicketTypeDAO extends DBContext {

    public List<TicketType> filterTicketsByBranch(int branchId, String poolId, String status, String keyword, int offset, int pageSize) throws SQLException {
        List<TicketType> tickets = new ArrayList<>();
        StringBuilder sql = new StringBuilder(
                "SELECT tt.ticket_type_id, tt.type_code, tt.type_name, tt.description, tt.base_price, tt.is_combo, "
                + "       ptt.status, "
                + "       p.pool_name, "
                + "       tt.created_at "
                + "FROM Ticket_Types tt "
                + "JOIN Pool_Ticket_Types ptt ON tt.ticket_type_id = ptt.ticket_type_id "
                + "JOIN Pools p ON ptt.pool_id = p.pool_id "
                + "WHERE p.branch_id = ? "
        );

        List<Object> params = new ArrayList<>();
        params.add(branchId);

        if (poolId != null && !poolId.equals("all")) {
            sql.append("AND p.pool_id = ? ");
            params.add(Integer.parseInt(poolId));
        }
        // Điều kiện lọc trạng thái
        if (status != null && !status.equals("all")) {
            sql.append("AND ptt.status = ? ");
            params.add(status);
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (tt.type_code LIKE ? OR tt.type_name LIKE ?) ");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        sql.append("ORDER BY tt.ticket_type_id, p.pool_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ");
        params.add(offset);
        params.add(pageSize);

        PreparedStatement ps = connection.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            TicketType t = new TicketType();
            t.setId(rs.getInt("ticket_type_id"));
            t.setCode(rs.getString("type_code"));
            t.setName(rs.getString("type_name"));
            t.setDescription(rs.getString("description"));
            t.setBasePrice(rs.getDouble("base_price"));
            t.setCreatedAt(rs.getTimestamp("created_at"));
            t.setIsCombo(rs.getBoolean("is_combo"));
            // Mapping trạng thái
            String statusStr = rs.getString("status");
            t.setActive("active".equalsIgnoreCase(statusStr));
            List<String> pools = new ArrayList<>();
            pools.add(rs.getString("pool_name"));
            t.setPools(pools);
            tickets.add(t);
        }
        return tickets;
    }

    public int countTicketsByBranch(int branchId, String poolId, String status, String keyword) throws SQLException {
        StringBuilder sql = new StringBuilder(
                "SELECT COUNT(*) AS total "
                + "FROM Ticket_Types tt "
                + "JOIN Pool_Ticket_Types ptt ON tt.ticket_type_id = ptt.ticket_type_id "
                + "JOIN Pools p ON ptt.pool_id = p.pool_id "
                + "WHERE p.branch_id = ? "
        );
        List<Object> params = new ArrayList<>();
        params.add(branchId);

        if (poolId != null && !poolId.equals("all")) {
            sql.append("AND p.pool_id = ? ");
            params.add(Integer.parseInt(poolId));
        }
        if (keyword != null && !keyword.trim().isEmpty()) {
            sql.append("AND (tt.type_code LIKE ? OR tt.type_name LIKE ?) ");
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }
        // Nếu có lọc trạng thái, INNER JOIN đã đảm bảo chỉ lấy active
        PreparedStatement ps = connection.prepareStatement(sql.toString());
        for (int i = 0; i < params.size(); i++) {
            ps.setObject(i + 1, params.get(i));
        }
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt("total");
        }
        return 0;
    }

    public List<PoolTicket> getPoolsByBranch(int branchId) throws SQLException {
        List<PoolTicket> pools = new ArrayList<>();
        String sql = "SELECT pool_id, pool_name FROM Pools WHERE branch_id = ?";
        PreparedStatement ps = connection.prepareStatement(sql);
        ps.setInt(1, branchId);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            PoolTicket p = new PoolTicket();
            p.setId(rs.getInt("pool_id"));
            p.setName(rs.getString("pool_name"));
            pools.add(p);
        }
        return pools;
    }

    // Thêm mới loại vé, trả về id vừa insert (auto-increment)
    public int addTicketType(String typeCode, String typeName, String description, double basePrice, boolean isCombo) throws SQLException {
        String sql = "INSERT INTO Ticket_Types (type_code, type_name, description, base_price, is_combo, created_at) VALUES (?, ?, ?, ?, ?, GETDATE())";
        try (PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            st.setString(1, typeCode);
            st.setString(2, typeName);
            st.setString(3, description);
            st.setDouble(4, basePrice);
            st.setBoolean(5, isCombo);
            st.executeUpdate();
            try (ResultSet rs = st.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        return -1; // lỗi
    }

    // Gán loại vé vào các pool, trạng thái mặc định 'active'
    public void addTicketTypeToPools(int ticketTypeId, List<Integer> poolIds, String status) throws SQLException {
        String sql = "INSERT INTO Pool_Ticket_Types (pool_id, ticket_type_id, price, status) VALUES (?, ?, 0, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            for (Integer poolId : poolIds) {
                st.setInt(1, poolId);
                st.setInt(2, ticketTypeId);
                st.setString(3, status); // thường là 'active'
                st.addBatch();
            }
            st.executeBatch();
        }
    }

    public static void main(String[] args) {
        int branchId = 1; // ví dụ branch id
//        String poolId = "all";
//        String status = "active";
//        String keyword = "";
//        int page = 1; // trang bạn muốn test
//        int pageSize = 25; // số dòng mỗi trang
//        int offset = (page - 1) * pageSize;
//
//        TicketTypeDAO dao = new TicketTypeDAO();
//
//        try {
//            // Dùng hàm phân trang
//            List<TicketType> tickets = dao.filterTicketsByBranch(branchId, poolId, status, keyword, offset, pageSize);
//
//            if (tickets.isEmpty()) {
//                System.out.println("Không tìm thấy loại vé nào phù hợp.");
//            } else {
//                for (TicketType t : tickets) {
//                    System.out.println("ID: " + t.getId());
//                    System.out.println("Mã: " + t.getCode());
//                    System.out.println("Tên: " + t.getName());
//                    System.out.println("Giá: " + t.getBasePrice());
//                    System.out.println("Trạng thái: " + (t.isActive() ? "Đang bán" : "Ngừng bán"));
//                    System.out.println("Áp dụng tại: " + String.join(", ", t.getPools()));
//                    System.out.println("--------------");
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }

        TicketTypeDAO dao = new TicketTypeDAO();
        try {
            List<PoolTicket> list = dao.getPoolsByBranch(branchId);
             for (PoolTicket poolTicket : list) {
            System.out.println(poolTicket);
        }
        } catch (Exception e) {
        }
      
      
       


    }


}

