package dao;

import dal.DBContext;
import model.Pools;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PoolsDAO extends DBContext {

    public Pools getPoolById(int poolId) {
        String sql = "SELECT * FROM Pools WHERE pool_id = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, poolId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Pools pool = new Pools();
                pool.setPool_id(rs.getInt("pool_id"));
                pool.setPool_name(rs.getString("pool_name"));
                pool.setPool_road(rs.getString("pool_road"));
                pool.setPool_address(rs.getString("pool_address"));
                pool.setMax_slot(rs.getInt("max_slot"));
                pool.setOpen_time(rs.getTime("open_time").toLocalTime());
                pool.setClose_time(rs.getTime("close_time").toLocalTime());
                pool.setPool_status(rs.getBoolean("pool_status"));
                pool.setPool_image(rs.getString("pool_image"));
                pool.setCreated_at(rs.getTimestamp("created_at") != null ? rs.getTimestamp("created_at").toLocalDateTime() : null);
                pool.setUpdated_at(rs.getTimestamp("updated_at") != null ? rs.getTimestamp("updated_at").toLocalDateTime() : null);
                pool.setPool_description(rs.getString("pool_description"));
                return pool;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Pools> getPools(String name, String location, String sortBy, int page, int pageSize) {
        List<Pools> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Pools WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND pool_name LIKE ?");
            params.add("%" + name.trim() + "%");
        }
        if (location != null && !location.trim().isEmpty()) {
            sql.append(" AND pool_address LIKE ?");
            params.add("%" + location.trim() + "%");
        }

        if (sortBy != null && !sortBy.isEmpty()) {
            sql.append(" ORDER BY max_slot ").append("asc".equalsIgnoreCase(sortBy) ? "ASC" : "DESC");
        } else {
            sql.append(" ORDER BY pool_id DESC");
        }

        sql.append(" OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        params.add((page - 1) * pageSize);
        params.add(pageSize);

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Pools pool = new Pools();
                pool.setPool_id(rs.getInt("pool_id"));
                pool.setPool_name(rs.getString("pool_name"));
                pool.setPool_road(rs.getString("pool_road"));
                pool.setPool_address(rs.getString("pool_address"));
                pool.setMax_slot(rs.getInt("max_slot"));
                pool.setOpen_time(rs.getTime("open_time").toLocalTime());
                pool.setClose_time(rs.getTime("close_time").toLocalTime());
                pool.setPool_status(rs.getBoolean("pool_status"));
                pool.setPool_image(rs.getString("pool_image"));
                Timestamp createdAt = rs.getTimestamp("created_at");
                if (createdAt != null) {
                    pool.setCreated_at(createdAt.toLocalDateTime());
                }
                Timestamp updatedAt = rs.getTimestamp("updated_at");
                if (updatedAt != null) {
                    pool.setUpdated_at(updatedAt.toLocalDateTime());
                }
                pool.setPool_description(rs.getString("pool_description"));
                list.add(pool);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countFilteredPools(String name, String location) {
        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Pools WHERE 1=1");
        if (name != null && !name.isEmpty()) {
            sql.append(" AND pool_name LIKE ?");
        }
        if (location != null && !location.isEmpty()) {
            sql.append(" AND pool_address LIKE ?");
        }
        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            int idx = 0;
           
            if (name != null && !name.isEmpty()) {
                 idx++;
                ps.setString(idx, "%" + name + "%");
            }
            if (location != null && !location.isEmpty()) {
                 idx++;
                ps.setString(idx, "%" + location + "%");
            }
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return count;
    }
    
    
//  SELECT * FROM Pools
//
//ORDER BY max_slot DESC
//OFFSET 0 ROWS FETCH NEXT 6 ROWS ONLY;
}
