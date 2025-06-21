/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Time;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import model.FeedbackHomepage;
import model.Pool;

/**
 *
 * @author Lenovo
 */
public class PoolDAO extends DBContext {

    private List<Pool> list;

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

    public int getTotalFilteredPools(String search, String location, Boolean status) {
        String sql = "SELECT COUNT(*) FROM Pools WHERE 1=1 ";
        int count = 0;

        if (search != null && !search.trim().isEmpty()) {
            sql += " AND pool_name LIKE ? ";
        }
        if (location != null && !location.trim().isEmpty()) {
            sql += " AND pool_address = ? ";
        }
        if (status != null) {
            sql += " AND pool_status = ? ";
        }

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            if (search != null && !search.trim().isEmpty()) {
                st.setString(++count, "%" + search + "%");
            }
            if (location != null && !location.trim().isEmpty()) {
                st.setString(++count, location);
            }
            if (status != null) {
                st.setInt(++count, status ? 1 : 0);
            }

            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
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
                Date createdDate = rs.getDate(10);
                Date updatedDate = rs.getDate(11);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), rs.getString(9), createdAt, updatedAt,
                        rs.getString(12), rs.getInt(13)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public static void main(String[] args) {
        PoolDAO dao = new PoolDAO();
        List<Pool> list = new ArrayList<>();
        list = dao.getPoolByPage(0, 4);
        for (Pool pool : list) {
            System.out.println(pool);
        }
    }

    public void insertPool(Pool pool) {
        String sql = "INSERT INTO Pools (pool_name, pool_road, pool_address, max_slot, open_time, close_time,created_at,pool_image,branch_id,pool_description) VALUES (?,?,?,?,?,?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, pool.getPool_name());
            st.setString(2, pool.getPool_road());
            st.setString(3, pool.getPool_address());
            st.setInt(4, pool.getMax_slot());
            st.setTime(5, Time.valueOf(pool.getOpen_time()));
            st.setTime(6, java.sql.Time.valueOf(pool.getClose_time()));
            st.setDate(7, java.sql.Date.valueOf(pool.getCreated_at()));
            st.setString(8, pool.getPool_image());
            st.setInt(9, pool.getBranch_id());
            st.setString(10, pool.getPool_description());
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Pool getPoolByID(int pool_id) {
        String sql = "select * from Pools where pool_id = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, pool_id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                Date createdDate = rs.getDate(10);
                Date updatedDate = rs.getDate(11);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                return new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), rs.getString(9), createdAt, updatedAt,
                        rs.getString(12), rs.getInt(13));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void updatePool(Pool p) {
        String sql = "UPDATE Pools SET pool_name = ?, pool_road = ?, pool_address = ?, max_slot = ?, "
                + "open_time = ?, close_time = ?, pool_status = ?, updated_at = ?,pool_image = ?,pool_description = ?,branch_id = ? WHERE pool_id = ?";

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
            } else {
                bitStatus = 0;
            }
            st.setInt(7, bitStatus);
            st.setTimestamp(8, Timestamp.valueOf(LocalDateTime.now()));
            st.setString(9, p.getPool_image());
            st.setString(10, p.getPool_description());
            st.setInt(11, p.getBranch_id());
            st.setInt(12, p.getPool_id());

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

    public List<Pool> searchPools(String search, String location, Boolean status, String sort, int start, int recordPerPage) {
        list = new ArrayList<>();
        String sql = "SELECT * FROM Pools WHERE 1=1 ";
        int count = 0;

        if (search != null && !search.trim().isEmpty()) {
            sql += " AND pool_name LIKE ? ";
        }

        if (location != null && !location.trim().isEmpty()) {
            sql += " AND pool_address = ? ";
        }

        if (status != null) {
            sql += " AND pool_status = ? ";
        }

        if (sort != null && !sort.trim().isEmpty()) {
            if (sort.equals("capacity_asc")) {
                sql += " ORDER BY max_slot ASC ";
            } else {
                sql += " ORDER BY max_slot DESC ";
            }
        } else {
            sql += " ORDER BY pool_id ASC ";
        }

        sql += " OFFSET ? ROWS FETCH NEXT ? ROWS ONLY ";

        try {
            PreparedStatement st = connection.prepareStatement(sql);

            // Đặt giá trị tham số theo thứ tự đã thêm
            if (search != null && !search.trim().isEmpty()) {
                st.setString(++count, "%" + search + "%");
            }

            if (location != null && !location.trim().isEmpty()) {
                st.setString(++count, location);
            }

            if (status != null) {
                st.setInt(++count, status ? 1 : 0);
            }
            st.setInt(++count, start);
            st.setInt(++count, recordPerPage);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date createdDate = rs.getDate(10);
                Date updatedDate = rs.getDate(11);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), rs.getString(9), createdAt, updatedAt,
                        rs.getString(12), rs.getInt(13)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return list;
    }

    public List<Pool> getTop3() {
        list = new ArrayList<>();
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
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), rs.getString(9), createdAt, updatedAt,
                        rs.getString(12), rs.getInt(13)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Pool> getPoolImage() {
        list = new ArrayList<>();
        String sql = "select top 4 * from Pools";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date createdDate = rs.getDate(10);
                Date updatedDate = rs.getDate(11);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), rs.getString(9), createdAt, updatedAt,
                        rs.getString(12), rs.getInt(13)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<Pool> searchPoolByAddress(String address) {
        list = new ArrayList<>();
        String sql = "SELECT * FROM Pools WHERE pool_address = ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, address);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Date createdDate = rs.getDate(10);
                Date updatedDate = rs.getDate(11);

                LocalDate createdAt = (createdDate != null) ? createdDate.toLocalDate() : null;
                LocalDate updatedAt = (updatedDate != null) ? updatedDate.toLocalDate() : null;
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), rs.getString(9), createdAt, updatedAt,
                        rs.getString(12), rs.getInt(13)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
   
}
