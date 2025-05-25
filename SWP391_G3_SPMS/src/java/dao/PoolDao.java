/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.*;
import dal.DBContext;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;
import model.Pool;

/**
 *
 * @author Lenovo
 */
public class PoolDao extends DBContext {

    private List<Pool> list;

    public List<Pool> getAllPool() {
        list = new ArrayList<>();
        String sql = "select * from Pools";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date createdDate = rs.getDate(9);
                Date updatedDate = rs.getDate(10);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), createdAt, updatedAt));
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Pool> getPoolByStatus(boolean pool_status) {
        list = new ArrayList<>();
        String sql = "select * from Pools where pool_status = ?";
        int result;
        if (pool_status) {
            result = 1;
        } else {
            result = 0;
        }
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, result);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date createdDate = rs.getDate(9);
                Date updatedDate = rs.getDate(10);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), createdAt, updatedAt));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Pool> getPoolByLocation(String pool_address) {
        list = new ArrayList<>();
        String sql = "select * from Pools where pool_address = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, pool_address);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date createdDate = rs.getDate(9);
                Date updatedDate = rs.getDate(10);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), createdAt, updatedAt));
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Pool> getPoolByName(String pool_name) {
        list = new ArrayList<>();
        String sql = "select * from Pools where pool_name LIKE ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + pool_name + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date createdDate = rs.getDate(9);
                Date updatedDate = rs.getDate(10);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), createdAt, updatedAt));
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insertPool(Pool pool) {
        String sql = "INSERT INTO Pools (pool_name, pool_road, pool_address, max_slot, open_time, close_time,created_at) VALUES (?,?,?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, pool.getPool_name());
            st.setString(2, pool.getPool_road());
            st.setString(3, pool.getPool_address());
            st.setInt(4, pool.getMax_slot());
            st.setTime(5, Time.valueOf(pool.getOpen_time()));
            st.setTime(6, java.sql.Time.valueOf(pool.getClose_time()));
            st.setDate(7, java.sql.Date.valueOf(pool.getCreated_at()));
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deletePool(int id) {
        String sql = "delete from Pools where pool_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, id);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updatePool(Pool p) {
        String sql = "UPDATE Pools SET pool_name = ?, pool_road = ?, pool_address = ?, max_slot = ?, "
                + "open_time = ?, close_time = ?, pool_status = ?, updated_at = ? WHERE pool_id = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, p.getPool_name());
            st.setString(2, p.getPool_road());
            st.setString(3, p.getPool_address());
            st.setInt(4, p.getMax_slot());
            st.setTime(5, Time.valueOf(p.getOpen_time()));
            st.setTime(6, Time.valueOf(p.getClose_time()));
            int bitStatus;
            if (p.isPool_status()) {
                bitStatus = 1;
            } else{
                bitStatus = 0;
            }
            st.setInt(7, bitStatus);
            st.setTimestamp(8, Timestamp.valueOf(LocalDateTime.now()));
            st.setInt(9, p.getPool_id());

            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public int getTotalRecord() {
        String sql = "SELECT COUNT(*) FROM Pools";
        int totalRecord = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                totalRecord = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalRecord;
    }

    public int getTotalRecordMaxSlot() {
        String sql = "SELECT COUNT(*) FROM Pools";
        int totalRecord = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                totalRecord = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalRecord;
    }

    public int getTotalRecordLocation(String pool_address) {
        String sql = "SELECT COUNT(*) FROM Pools where pool_address = ?";
        int totalRecord = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, pool_address);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                totalRecord = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalRecord;
    }

    public int getTotalRecordStatus(boolean pool_status) {
        String sql = "SELECT COUNT(*) FROM Pools where pool_status = ?";
        int totalRecord = 0;
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            int bitStatus;
            if (pool_status) {
                bitStatus = 1;
            } else {
                bitStatus = 0;
            }
            st.setInt(1, bitStatus);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                totalRecord = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return totalRecord;
    }

    public Pool getPoolByID(int pool_id) {
        String sql = "select * from Pools where pool_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, pool_id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Date createdDate = rs.getDate(9);
                Date updatedDate = rs.getDate(10);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                return new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(),
                        rs.getTime(7).toLocalTime(), rs.getBoolean(8),
                        createdAt, updatedAt);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Pool> getPoolByPage(int start, int recordPerPage) {
        list = new ArrayList<>();
        String sql = "SELECT * FROM Pools \n"
                + "ORDER BY pool_id \n"
                + "OFFSET ? ROWS\n"
                + "FETCH NEXT ? ROWS ONLY;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, start);
            st.setInt(2, recordPerPage);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date createdDate = rs.getDate(9);
                Date updatedDate = rs.getDate(10);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), createdAt, updatedAt));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Pool> getPoolByPageLocation(String pool_address, int start, int recordPerPage) {
        list = new ArrayList<>();
        String sql = "SELECT * FROM Pools\n"
                + "WHERE pool_address COLLATE Latin1_General_CI_AI LIKE ?\n"
                + "ORDER BY pool_id\n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, pool_address);
            st.setInt(2, start);
            st.setInt(3, recordPerPage);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date createdDate = rs.getDate(9);
                Date updatedDate = rs.getDate(10);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), createdAt, updatedAt));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Pool> getPoolByPageStatus(boolean pool_status, int start, int recordPerPage) {
        list = new ArrayList<>();
        String sql = "SELECT * FROM Pools\n"
                + "WHERE pool_status = ?\n"
                + "ORDER BY pool_id\n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            int bitStatus;
            if (pool_status) {
                bitStatus = 1;
            } else {
                bitStatus = 0;
            }
            st.setInt(1, bitStatus);
            st.setInt(2, start);
            st.setInt(3, recordPerPage);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date createdDate = rs.getDate(9);
                Date updatedDate = rs.getDate(10);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), createdAt, updatedAt));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Pool> getPoolByPageMaxSlotASC(int start, int recordPerPage) {
        list = new ArrayList<>();
        String sql = "SELECT * FROM Pools\n"
                + "ORDER BY max_slot asc\n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, start);
            st.setInt(2, recordPerPage);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date createdDate = rs.getDate(9);
                Date updatedDate = rs.getDate(10);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), createdAt, updatedAt));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Pool> getPoolByPageMaxSlotDESC(int start, int recordPerPage) {
        list = new ArrayList<>();
        String sql = "SELECT * FROM Pools\n"
                + "ORDER BY max_slot desc\n"
                + "OFFSET ? ROWS FETCH NEXT ? ROWS ONLY;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, start);
            st.setInt(2, recordPerPage);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date createdDate = rs.getDate(9);
                Date updatedDate = rs.getDate(10);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), createdAt, updatedAt));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Pool> sortPoolByMaxSlotASC() {
        list = new ArrayList<>();
        String sql = "SELECT * FROM Pools ORDER BY max_slot ASC;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date createdDate = rs.getDate(9);
                Date updatedDate = rs.getDate(10);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), createdAt, updatedAt));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Pool> sortPoolByMaxSlotDESC() {
        list = new ArrayList<>();
        String sql = "SELECT * FROM Pools ORDER BY max_slot DESC;";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date createdDate = rs.getDate(9);
                Date updatedDate = rs.getDate(10);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), createdAt, updatedAt));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

}
