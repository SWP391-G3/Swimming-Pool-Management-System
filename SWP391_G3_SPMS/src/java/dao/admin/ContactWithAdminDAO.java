/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao.admin;

import dal.DBContext;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.time.LocalDate;
import model.admin.ContactWithAdmin;

/**
 *
 * @author Lenovo
 */
public class ContactWithAdminDAO extends DBContext{
    public List<ContactWithAdmin> list;

    public ContactWithAdminDAO() {
        this.list = new ArrayList<>();
    }
    
    public List<ContactWithAdmin> getAllContact(){
        String sql = """
                     Select * from Contacts
                     """;
        try(PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            while (rs.next()) {                
                ContactWithAdmin c = new ContactWithAdmin();
                c.setContact_id(rs.getInt(1));
                c.setCustomer_id(rs.getInt(2));
                c.setCustomer_name(rs.getString(3));
                c.setCustomer_email(rs.getString(4));
                c.setSubject(rs.getString(5));
                c.setContent(rs.getString(6));
                Date date = rs.getDate(7);
                LocalDate createDate = (date != null) ? date.toLocalDate() : null;
                c.setCreated_at(createDate);
                c.setIs_resolved(rs.getBoolean(8));
                list.add(c);
            }
            return list;
        } catch (SQLException e) {
            throw new RuntimeException("Can't query all ò contact",e);
        }
        
    }
    
    public int getTotalRecordOfContact(){
        String sql = """
                     select count(*) from Contacts
                     """;
        int count = 0;
        try(PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);           
            }        
        } catch (SQLException e) {
            throw new RuntimeException("Can't query total record of contact",e);
        }
        return count;
    }
    
    
}
