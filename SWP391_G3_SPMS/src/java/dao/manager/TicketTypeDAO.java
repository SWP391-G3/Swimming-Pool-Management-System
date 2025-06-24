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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import model.manager.PoolTicket;
import model.manager.TicketType;
import org.apache.tomcat.jni.Pool;

/**
 *
 * @author Tuan Anh
 */
public class TicketTypeDAO extends DBContext {

    // lấy danh sách các loại vé (TicketType) thuộc về các hồ bơi trong một chi nhánh cụ thể, kèm theo các điều kiện lọc và phân trang. 
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

    
    // Đếm số lượng loại vé phù hợp với bộ lọc được chọn (chi nhánh, hồ bơi, trạng thái, từ khóa)
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
    // Phương thức này là cũ khi chưa có discount
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
    
    
    //    public void addTicketTypeToPools(int ticketTypeId, List<Integer> poolIds, String status) throws SQLException {
//    String sql = "INSERT INTO Pool_Ticket_Types (pool_id, ticket_type_id, price, status) VALUES (?, ?, 0, ?)";
//    try (PreparedStatement st = connection.prepareStatement(sql)) {
//        for (Integer poolId : poolIds) {
//            // Xóa trước nếu đã tồn tại
//            String deleteSql = "DELETE FROM Pool_Ticket_Types WHERE pool_id = ? AND ticket_type_id = ?";
//            try (PreparedStatement del = connection.prepareStatement(deleteSql)) {
//                del.setInt(1, poolId);
//                del.setInt(2, ticketTypeId);
//                del.executeUpdate();
//            }
//            st.setInt(1, poolId);
//            st.setInt(2, ticketTypeId);
//            st.setString(3, status);
//            st.addBatch();
//        }
//        st.executeBatch();
//    }
//}
    
    
    
    // Phương thức này là mới để có thể lưu discount
    public int addTicketType(String typeCode, String typeName, String description, double basePrice, boolean isCombo, double discountPercent) throws SQLException {
    String sql = "INSERT INTO Ticket_Types (type_code, type_name, description, base_price, is_combo, discount_percent, created_at) VALUES (?, ?, ?, ?, ?, ?, GETDATE())";
    try (PreparedStatement st = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
        st.setString(1, typeCode);
        st.setString(2, typeName);
        st.setString(3, description);
        st.setDouble(4, basePrice);
        st.setBoolean(5, isCombo);
        st.setDouble(6, discountPercent);
        st.executeUpdate();
        try (ResultSet rs = st.getGeneratedKeys()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        }
    }
    return -1;
}
    
    
    
    
    


    
    
    
    
    // Cập nhập update -- khi chưa có trường discount
//    public TicketType getTicketTypeById(int ticketTypeId) throws SQLException {
//        TicketType ticket = null;
//        String sql = "SELECT tt.ticket_type_id, tt.type_code, tt.type_name, tt.description, tt.base_price, tt.is_combo, tt.created_at, "
//                + "       (SELECT COUNT(*) FROM Pool_Ticket_Types WHERE ticket_type_id = tt.ticket_type_id AND status = 'active') AS active_count "
//                + "FROM Ticket_Types tt WHERE tt.ticket_type_id = ?";
//        try (PreparedStatement ps = connection.prepareStatement(sql)) {
//            ps.setInt(1, ticketTypeId);
//            try (ResultSet rs = ps.executeQuery()) {
//                if (rs.next()) {
//                    System.out.println("DEBUG: Đã lấy được vé id=" + ticketTypeId + ", code=" + rs.getString("type_code") + ", is_combo=" + rs.getBoolean("is_combo"));
//                    ticket = new TicketType();
//                    ticket.setId(rs.getInt("ticket_type_id"));
//                    ticket.setCode(rs.getString("type_code"));
//                    ticket.setName(rs.getString("type_name"));
//                    ticket.setDescription(rs.getString("description"));
//                    ticket.setBasePrice(rs.getDouble("base_price"));
//                    ticket.setIsCombo(rs.getBoolean("is_combo"));
//                    ticket.setCreatedAt(rs.getTimestamp("created_at"));
//                    ticket.setPools(getPoolNamesOfTicketType(ticketTypeId));
//                    int activeCount = rs.getInt("active_count");
//                    ticket.setActive(activeCount > 0);
//                } else {
//                    System.out.println("DEBUG: Không tìm thấy vé với id=" + ticketTypeId);
//                }
//            }
//        }
//        return ticket;
//    }
    
    // Cập nhập update khi đã thêm trường discount
    public TicketType getTicketTypeById(int ticketTypeId) throws SQLException {
        TicketType ticket = null;
        String sql = "SELECT tt.ticket_type_id, tt.type_code, tt.type_name, tt.description, tt.base_price, tt.is_combo,tt.discount_percent , tt.created_at, "
                + "       (SELECT COUNT(*) FROM Pool_Ticket_Types WHERE ticket_type_id = tt.ticket_type_id AND status = 'active') AS active_count "
                + "FROM Ticket_Types tt WHERE tt.ticket_type_id = ?";
        
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, ticketTypeId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    System.out.println("DEBUG: Đã lấy được vé id=" + ticketTypeId + ", code=" + rs.getString("type_code") + ", is_combo=" + rs.getBoolean("is_combo"));
                    ticket = new TicketType();
                    ticket.setId(rs.getInt("ticket_type_id"));
                    ticket.setCode(rs.getString("type_code"));
                    ticket.setName(rs.getString("type_name"));
                    ticket.setDescription(rs.getString("description"));
                    ticket.setBasePrice(rs.getDouble("base_price"));
                    ticket.setIsCombo(rs.getBoolean("is_combo"));
                    ticket.setDiscountPercent(rs.getDouble("discount_percent"));
                    ticket.setCreatedAt(rs.getTimestamp("created_at"));
                    ticket.setPools(getPoolNamesOfTicketType(ticketTypeId));
                    int activeCount = rs.getInt("active_count");
                    ticket.setActive(activeCount > 0);
                } else {
                    System.out.println("DEBUG: Không tìm thấy vé với id=" + ticketTypeId);
                }
            }
        }
        return ticket;
    }
    
    // Hàm này cập nhập cho vé 
    public void updateTicketType(int id, String typeName, String description, double basePrice, boolean isCombo, double discountPercent) throws SQLException {
    String sql = "UPDATE Ticket_Types SET type_name=?, description=?, base_price=?, is_combo=?, discount_percent=? WHERE ticket_type_id=?";
    try (PreparedStatement st = connection.prepareStatement(sql)) {
        st.setString(1, typeName);
        st.setString(2, description);
        st.setDouble(3, basePrice);
        st.setBoolean(4, isCombo);
        st.setDouble(5, discountPercent);
        st.setInt(6, id);
        st.executeUpdate();
    }
}
    
    

// Xóa và cập nhật lại danh sách pool áp dụng cho loại vé
    public void updateTicketTypePools(int ticketTypeId, List<Integer> poolIds, String status) throws SQLException {
        // Xóa cũ
        String deleteSql = "DELETE FROM Pool_Ticket_Types WHERE ticket_type_id = ?";
        try (PreparedStatement del = connection.prepareStatement(deleteSql)) {
            del.setInt(1, ticketTypeId);
            del.executeUpdate();
        }
        // Thêm mới
        String insertSql = "INSERT INTO Pool_Ticket_Types (pool_id, ticket_type_id, price, status) VALUES (?, ?, 0, ?)";
        try (PreparedStatement ins = connection.prepareStatement(insertSql)) {
            for (Integer poolId : poolIds) {
                ins.setInt(1, poolId);
                ins.setInt(2, ticketTypeId);
                ins.setString(3, status);
                ins.addBatch();
            }
            ins.executeBatch();
        }
    }

    // Trả về danh sách của các hồ bơi đang áp dụng một loại vé 
    public List<String> getPoolIdsOfTicketType(int ticketTypeId) throws SQLException {
        List<String> poolIds = new ArrayList<>();
        String sql = "SELECT pool_id FROM Pool_Ticket_Types WHERE ticket_type_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, ticketTypeId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    poolIds.add(String.valueOf(rs.getInt("pool_id")));
                }
            }
        }
        return poolIds;
    }

// Lấy danh sách tên hồ bơi theo id loại vé (cho model TicketType)
    public List<String> getPoolNamesOfTicketType(int ticketTypeId) throws SQLException {
        List<String> poolNames = new ArrayList<>();
        String sql = "SELECT p.pool_name FROM Pools p JOIN Pool_Ticket_Types ptt ON p.pool_id = ptt.pool_id WHERE ptt.ticket_type_id = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, ticketTypeId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    poolNames.add(rs.getString("pool_name"));
                }
            }
        }
        return poolNames;
    }

    // Hết phần Cập nhập
    
    // Xóa vé
    public void deleteTicketTypeFromPool(int ticketTypeId, int poolId) throws SQLException {
    String sql = "DELETE FROM Pool_Ticket_Types WHERE ticket_type_id = ? AND pool_id = ?";
    try (PreparedStatement st = connection.prepareStatement(sql)) {
        st.setInt(1, ticketTypeId);
        st.setInt(2, poolId);
        st.executeUpdate();
    }
}

    // Phần Add Ticket lấy vé đơn 
    public List<TicketType> getAllSingleTypes() throws SQLException {
        List<TicketType> list = new ArrayList<>();
        String sql = "SELECT ticket_type_id, type_code, type_name, base_price FROM Ticket_Types WHERE is_combo = 0";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    TicketType t = new TicketType();
                    t.setId(rs.getInt("ticket_type_id"));
                    t.setCode(rs.getString("type_code"));
                    t.setName(rs.getString("type_name"));
                    t.setBasePrice(rs.getDouble("base_price"));
                    list.add(t);
                }
            }
        }
        return list;
    }

    public void addComboDetail(int comboTypeId, Map<Integer, Integer> comboMap) throws SQLException {
        String sql = "INSERT INTO Combo_Detail (combo_type_id, included_type_id, quantity) VALUES (?, ?, ?)";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            for (Map.Entry<Integer, Integer> entry : comboMap.entrySet()) {
                st.setInt(1, comboTypeId);
                st.setInt(2, entry.getKey());
                st.setInt(3, entry.getValue());
                st.addBatch();
            }
            st.executeBatch();
        }
    }

    // Phần cập nhập khi sửa combo
    // Lấy thành phần combo
    public Map<Integer, Integer> getComboDetail(int comboTypeId) throws SQLException {
        Map<Integer, Integer> comboDetail = new HashMap<>();
        String sql = "SELECT included_type_id, quantity FROM Combo_Detail WHERE combo_type_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, comboTypeId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    comboDetail.put(rs.getInt("included_type_id"), rs.getInt("quantity"));
                }
            }
        }
        return comboDetail;
    }
// Xóa thành phần combo cũ

    public void deleteComboDetail(int comboTypeId) throws SQLException {
        String sql = "DELETE FROM Combo_Detail WHERE combo_type_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, comboTypeId);
            ps.executeUpdate();
        }
    }
// Thêm lại thành phần combo mới
//public void addComboDetail(int comboTypeId, Map<Integer, Integer> comboMap) throws SQLException {
//    String sql = "INSERT INTO Combo_Detail (combo_type_id, included_type_id, quantity) VALUES (?, ?, ?)";
//    try (PreparedStatement st = connection.prepareStatement(sql)) {
//        for (Map.Entry<Integer, Integer> entry : comboMap.entrySet()) {
//            st.setInt(1, comboTypeId);
//            st.setInt(2, entry.getKey());
//            st.setInt(3, entry.getValue());
//            st.addBatch();
//        }
//        st.executeBatch();
//    }
//}

    
    public String getTicketStatus(int ticketTypeId, int poolId) throws SQLException {
    String sql = "SELECT status FROM Pool_Ticket_Types WHERE ticket_type_id = ? AND pool_id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setInt(1, ticketTypeId);
        ps.setInt(2, poolId);
        try (ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getString("status"); // "active" hoặc "inactive"
            }
        }
    }
    return null;
}
    
    
    
    
    public static void main(String[] args) {
//        int branchId = 1; // ví dụ branch id
//        String poolId = "all";
//        String status = "active";
//        String keyword = "";
//        int page = 1; // trang bạn muốn test
//        int pageSize = 25; // số dòng mỗi trang
//        int offset = (page - 1) * pageSize;
//
//        TicketTypeDAO dao = new TicketTypeDAO();
//
////        try {
////            // Dùng hàm phân trang
////            List<TicketType> tickets = dao.filterTicketsByBranch(branchId, poolId, status, keyword, offset, pageSize);
////
////            if (tickets.isEmpty()) {
////                System.out.println("Không tìm thấy loại vé nào phù hợp.");
////            } else {
////                for (TicketType t : tickets) {
////                    System.out.println("ID: " + t.getId());
////                    System.out.println("Mã: " + t.getCode());
////                    System.out.println("Tên: " + t.getName());
////                    System.out.println("Giá: " + t.getBasePrice());
////                    System.out.println("Trạng thái: " + (t.isActive() ? "Đang bán" : "Ngừng bán"));
////                    System.out.println("Áp dụng tại: " + String.join(", ", t.getPools()));
////                    System.out.println("--------------");
////                }
////            }
////        } catch (Exception e) {
////            e.printStackTrace();
////        }
////    }
////        TicketTypeDAO dao = new TicketTypeDAO();
////        try {
////            List<PoolTicket> list = dao.getPoolsByBranch(branchId);
////            for (PoolTicket poolTicket : list) {
////                System.out.println(poolTicket);
////            }
////        } catch (Exception e) {
////        }
//        try {
//            TicketType a = dao.getTicketTypeById(8);
//            System.out.println(a);
//        } catch (Exception e) {
//            System.out.println("Vé này combo mà đéo thấy");
//        }


TicketTypeDAO dao = new TicketTypeDAO();
    try {
        int comboTypeId = 5; // Thay bằng ID vé combo bạn muốn test
        Map<Integer, Integer> comboDetail = dao.getComboDetail(comboTypeId);
        System.out.println("Combo Detail for comboTypeId=" + comboTypeId + ":");
        if (comboDetail.isEmpty()) {
            System.out.println("Không có thành phần combo nào.");
        } else {
            for (Map.Entry<Integer, Integer> entry : comboDetail.entrySet()) {
                System.out.println("Included type id: " + entry.getKey() + ", Quantity: " + entry.getValue());
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }


    }

}
