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
public class ContactWithAdminDAO extends DBContext {

    public List<ContactWithAdmin> list;

    public ContactWithAdminDAO() {
        this.list = new ArrayList<>();
    }

    public List<ContactWithAdmin> getAllContact(int start, int totalSize) {
        String sql = """
                     Select * from Contacts as c
                     ORDER BY c.created_at DESC
                     OFFSET ? ROWS
                     FETCH NEXT ? ROWS ONLY;
                     """;
        try (PreparedStatement st = connection.prepareStatement(sql);) {
            st.setInt(1, start);
            st.setInt(2, totalSize);
            ResultSet rs = st.executeQuery();
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
            throw new RuntimeException("Can't query all of contact", e);
        }

    }

    public int getTotalRecordOfContact() {
        String sql = """
                     select count(*) from Contacts
                     """;
        int count = 0;
        try (PreparedStatement st = connection.prepareStatement(sql); ResultSet rs = st.executeQuery()) {
            if (rs.next()) {
                count = rs.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException("Can't query total record of contact", e);
        }
        return count;
    }

    public List<ContactWithAdmin> searchContacts(String keyword, String status, String subject, int page, int pageSize) {
        String sql = "SELECT * FROM Contacts WHERE 1=1";
        try (PreparedStatement st = connection.prepareStatement(sql)) {

            List<Object> params = new ArrayList<>();

            if (keyword != null && !keyword.trim().isEmpty()) {
                sql += " AND (customer_name LIKE ? OR customer_email LIKE ?)";
                params.add("%" + keyword + "%");
                params.add("%" + keyword + "%");
            }

            if (status != null && (status.equals("0") || status.equals("1"))) {
                sql += " AND is_resolved = ?";
                params.add(status);
            }

            if (subject != null && !subject.isEmpty()) {
                sql += " AND subject = ?";
                params.add(subject);
            }

            sql += " ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
            params.add((page - 1) * pageSize);
            params.add(pageSize);

            for (int i = 0; i < params.size(); i++) {
                st.setObject(i + 1, params.get(i));
            }
            ResultSet rs = st.executeQuery();
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

        } catch (Exception e) {
            throw new RuntimeException("Can't query for search contact",e);
        }

        return list;
    }

    public int countFilteredContacts(String keyword, String status, String subject) {
        int count = 0;
        String sql = "SELECT COUNT(*) FROM Contacts WHERE 1=1";
        List<Object> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {
            sql += " AND (customer_name LIKE ? OR customer_email LIKE ?)";
            params.add("%" + keyword + "%");
            params.add("%" + keyword + "%");
        }

        if (status != null && (status.equals("0") || status.equals("1"))) {
            sql += " AND is_resolved = ?";
            params.add(status);
        }

        if (subject != null && !subject.isEmpty()) {
            sql += " AND subject = ?";
            params.add(subject);
        }

        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            for (int i = 0; i < params.size(); i++) {
                ps.setObject(i + 1, params.get(i));
            }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }

        } catch (SQLException e) {
            throw new RuntimeException("Can't query for search contacts", e);
        }
        return count;
    }

}
