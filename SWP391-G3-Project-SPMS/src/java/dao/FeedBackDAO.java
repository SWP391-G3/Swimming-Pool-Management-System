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
import model.FeedBack;

/**
 *
 * @author Lenovo
 */
public class FeedBackDAO extends DBContext {

    public List<FeedBack> list;

    public List<FeedBack> getFeedback() {
        List<FeedBack> list = new ArrayList<>();
        String sql = "select top 3 f.rating,p.pool_name,p.pool_image,f.comment from [dbo].[Feedbacks] as f\n"
                + "join [dbo].[Pools] as p on p.pool_id = f.pool_id\n"
                + "where rating = 5\n"
                + "order by feedback_id asc";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                list.add(new FeedBack(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4)));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
