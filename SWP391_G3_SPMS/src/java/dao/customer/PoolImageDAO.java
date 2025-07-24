package dao.customer;

import dal.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;


public class PoolImageDAO extends DBContext {

    public List<String> getImagesByPoolId(int pool_id) {
        List<String> imageList = new ArrayList<>();
        String sql = "SELECT pool_image FROM PoolImage WHERE pool_id = ?";

        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setInt(1, pool_id);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                String image = rs.getString("pool_image");
                if (image != null && !image.trim().isEmpty()) {
                    imageList.add(image);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return imageList;
    }
}
