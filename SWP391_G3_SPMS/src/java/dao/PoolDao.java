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
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), rs.getDate(9).toLocalDate(), rs.getDate(10).toLocalDate()));
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Pool> getPoolByLocation(String pool_address) {
        list = new ArrayList<>();
        String sql = "select * from Pools where pool_address LIKE ?";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, "%" + pool_address + "%");
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), rs.getDate(9).toLocalDate(), rs.getDate(10).toLocalDate()));
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
                list.add(new Pool(rs.getInt(1), rs.getString(2), rs.getString(3),
                        rs.getString(4), rs.getInt(5), rs.getTime(6).toLocalTime(), rs.getTime(7).toLocalTime(),
                        rs.getBoolean(8), rs.getDate(9).toLocalDate(), rs.getDate(10).toLocalDate()));
            }
            return list;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void insertPool(String pool_name, String pool_road, String pool_address, int max_slot, LocalTime open_time, LocalTime close_time) {
        String sql = "INSERT INTO Pools (pool_name, pool_road, pool_address, max_slot, open_time, close_time) VALUES (?,?,?,?,?,?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, pool_name);
            st.setString(2, pool_road);
            st.setString(3, pool_address);
            st.setInt(4, max_slot);
            st.setTime(5, Time.valueOf(open_time));
            st.setTime(6, Time.valueOf(close_time));
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

    public void updatePool(int pool_id, String pool_name, String pool_road, String pool_address,
            int max_slot, LocalTime open_time, LocalTime close_time, boolean pool_status) {
        String sql = "UPDATE Pools SET pool_name = ?, pool_road = ?, pool_address = ?, max_slot = ?, "
                + "open_time = ?, close_time = ?, pool_status = ?, updated_at = ? WHERE pool_id = ?";

        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, pool_name);
            st.setString(2, pool_road);
            st.setString(3, pool_address);
            st.setInt(4, max_slot);
            st.setTime(5, Time.valueOf(open_time));
            st.setTime(6, Time.valueOf(close_time));
            st.setBoolean(7, pool_status);
            st.setTimestamp(8, Timestamp.valueOf(LocalDateTime.now())); 
            st.setInt(9, pool_id); 

            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace(); 
        }
    }
}
