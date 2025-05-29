package dao;

import dal.DBContext;
import model.Pools;
import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

public class PoolsDAO extends DBContext {

    // Lấy tất cả hồ bơi từ cơ sở dữ liệu
    public List<Pools> getAllPools() {
        List<Pools> poolsList = new ArrayList<>();
        String sql = "SELECT * FROM Pools";  // Thay bằng tên bảng đúng của bạn

        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {

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
                Timestamp createdTimestamp = rs.getTimestamp("created_at");
                LocalDateTime createdAt = (createdTimestamp != null) ? createdTimestamp.toLocalDateTime() : null;

                Timestamp updatedTimestamp = rs.getTimestamp("updated_at");
                LocalDateTime updatedAt = (updatedTimestamp != null) ? updatedTimestamp.toLocalDateTime() : null;

                pool.setCreated_at(createdAt);
                pool.setUpdated_at(updatedAt);

                poolsList.add(pool);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return poolsList;
    }

    // Lấy hồ bơi theo tên
    public List<Pools> getPoolsByName(String name) {
        List<Pools> poolsList = new ArrayList<>();
        String sql = "SELECT * FROM Pools WHERE pool_name LIKE ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, "%" + name + "%");
            try (ResultSet rs = st.executeQuery()) {
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
                    pool.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
                    pool.setUpdated_at(rs.getTimestamp("updated_at").toLocalDateTime());

                    poolsList.add(pool);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return poolsList;
    }

    // Lấy hồ bơi theo địa chỉ (location)
    public List<Pools> getPoolsByLocation(String location) {
        List<Pools> poolsList = new ArrayList<>();
        String sql = "SELECT * FROM Pools WHERE pool_address LIKE ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, "%" + location + "%");
            try (ResultSet rs = st.executeQuery()) {
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
                    pool.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
                    pool.setUpdated_at(rs.getTimestamp("updated_at").toLocalDateTime());

                    poolsList.add(pool);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return poolsList;
    }

    // Sắp xếp hồ bơi theo số lượng slot tối đa (max_slot)
    public List<Pools> getPoolsSortedByMaxSlot() {
        List<Pools> poolsList = new ArrayList<>();
        String sql = "SELECT * FROM Pools ORDER BY max_slot DESC";  // Sắp xếp giảm dần theo max_slot

        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
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
                pool.setCreated_at(rs.getTimestamp("created_at").toLocalDateTime());
                pool.setUpdated_at(rs.getTimestamp("updated_at").toLocalDateTime());

                poolsList.add(pool);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return poolsList;
    }
}
