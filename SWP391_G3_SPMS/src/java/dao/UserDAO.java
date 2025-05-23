/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.User;

/**
 *
 * @author Lenovo
 */
public class UserDAO extends DBContext{
    
    public List<User> list;
    
    public List<User> getAllUser() throws SQLException{
        list = new ArrayList<>();
        String sql = "Select * from Users";
        PreparedStatement st = connection.prepareStatement(sql);
        ResultSet rs = st.executeQuery();
        while(rs.next()){
            list.add(new User(rs.getInt(1), rs.getString(2), rs.getString(3),
                    rs.getString(4), rs.getString(5), rs.getString(6),
                    rs.getString(7), rs.getInt(8), 
                    rs.getBoolean(9), rs.getDate(10), rs.getDate(11)));
        }
        return list;
    }
}
