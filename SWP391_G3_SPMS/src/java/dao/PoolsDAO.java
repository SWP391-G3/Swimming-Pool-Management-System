package dao;

import dal.DBContext;
import model.Pools;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import static java.util.Collections.list;
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
                pool.setCreated_at(rs.getTimestamp("created_at") != null
                        ? rs.getTimestamp("created_at").toLocalDateTime().toLocalDate()
                        : null);

                pool.setUpdated_at(rs.getTimestamp("updated_at") != null
                        ? rs.getTimestamp("updated_at").toLocalDateTime().toLocalDate()
                        : null);

                pool.setPool_description(rs.getString("pool_description"));
                return pool;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Pools> getPools(String name, String location, String capacity, String openTime, String closeTime, int page, int pageSize) {
        List<Pools> list = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Pools WHERE 1=1");
        List<Object> params = new ArrayList<>();

        // Filter theo tên
        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND pool_name LIKE ?");
            params.add("%" + name.trim() + "%");
        }
        // Filter theo location
        if (location != null && !location.trim().isEmpty()) {
            sql.append(" AND pool_address LIKE ?");
            params.add("%" + location.trim() + "%");
        }
        // Filter theo capacity
        if (capacity != null && !capacity.isEmpty()) {
            switch (capacity) {
                case "small":
                    sql.append(" AND max_slot < 20");
                    break;
                case "medium":
                    sql.append(" AND max_slot BETWEEN 20 AND 50");
                    break;
                case "large":
                    sql.append(" AND max_slot > 50");
                    break;
            }
        }
        if (openTime != null && !"".equals(openTime)) {
            sql.append(" AND open_time = ?");
            params.add(openTime);
        }
        if (closeTime != null && !"".equals(closeTime)) {
            sql.append(" AND close_time = ?");
            params.add(closeTime);
        }
        

       
        sql.append(" ORDER BY pool_id ASC");
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
                    pool.setCreated_at(createdAt.toLocalDateTime().toLocalDate());
                }
                Timestamp updatedAt = rs.getTimestamp("updated_at");
                if (updatedAt != null) {
                    pool.setUpdated_at(updatedAt.toLocalDateTime().toLocalDate());
                }
                pool.setPool_description(rs.getString("pool_description"));
                list.add(pool);
               
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
       return list;
    }

    public int countFilteredPools(String name, String location, String capacity, String openTime, String closeTime) {
        int count = 0;
        StringBuilder sql = new StringBuilder("SELECT COUNT(*) FROM Pools WHERE 1=1");
        List<Object> params = new ArrayList<>();

        if (name != null && !name.trim().isEmpty()) {
            sql.append(" AND pool_name LIKE ?");
            params.add("%" + name.trim() + "%");
        }
        if (location != null && !location.trim().isEmpty()) {
            sql.append(" AND pool_address LIKE ?");
            params.add("%" + location.trim() + "%");
        }
        if (capacity != null && !capacity.isEmpty()) {
            switch (capacity) {
                case "small":
                    sql.append(" AND max_slot < 20");
                    break;
                case "medium":
                    sql.append(" AND max_slot BETWEEN 20 AND 50");
                    break;
                case "large":
                    sql.append(" AND max_slot > 50");
                    break;
            }
        }
        if (openTime != null && !"".equals(openTime)) {
            sql.append(" AND open_time = ?");
            params.add(openTime);
        }
        if (closeTime != null && !"".equals(closeTime)) {
            sql.append(" AND close_time = ?");
            params.add(closeTime);
        }

        try (PreparedStatement ps = connection.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
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

    public List<Pools> getTop3() {
        List<Pools> list = new ArrayList<>();
        String sql = "select * \n"
                + "from [dbo].[Pools] \n"
                + "order by pool_id\n"
                + "OFFSET 6 ROWS FETCH NEXT 3 ROWS ONLY ";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date createdDate = rs.getDate(10);
                Date updatedDate = rs.getDate(11);
                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;

                list.add(new Pools(
                        rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5),
                        rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), rs.getString(9),
                        createdAt, updatedAt, rs.getString(12)
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Pools> getPoolImage() {
        List<Pools> list = new ArrayList<>();
        String sql = "select top 4 * from Pools";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date createdDate = rs.getDate(10);
                Date updatedDate = rs.getDate(11);
                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;

                list.add(new Pools(
                        rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5),
                        rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), rs.getString(9),
                        createdAt, updatedAt, rs.getString(12)
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}
