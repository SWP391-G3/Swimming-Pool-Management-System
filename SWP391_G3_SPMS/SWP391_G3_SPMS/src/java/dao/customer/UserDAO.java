package dao.customer;

import dal.DBContext;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.Vector;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.customer.User;
import util.PasswordEncryption;

public class UserDAO extends DBContext {

    public List<User> list;
   
    public User getUserByID(int userId) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        String sql = "SELECT * FROM Users WHERE user_id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, userId);
            rs = stm.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setUser_id(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFull_name(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setRole_id(rs.getInt("role_id"));
                u.setStatus(rs.getBoolean("status"));
                u.setDob(rs.getDate("dob"));
                u.setGender(rs.getString("gender"));
                u.setImages(rs.getString("images"));

                // Xử lý an toàn created_at
                java.sql.Date createdDate = rs.getDate("created_at");
                if (createdDate != null) {
                    u.setCreate_at(createdDate.toLocalDate());
                } else {
                    u.setCreate_at(null);
                }

                // Xử lý an toàn updated_at
                java.sql.Date updatedDate = rs.getDate("updated_at");
                if (updatedDate != null) {
                    u.setUpdate_at(updatedDate.toLocalDate());
                } else {
                    u.setUpdate_at(null);
                }

                return u;
            }
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Vector<User> getCustomerByName(String name) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<User> customers = new Vector<>();
        String sql = "SELECT * FROM Users WHERE role_id = 4 AND full_name LIKE ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + name + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUser_id(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFull_name(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setRole_id(rs.getInt("role_id"));
                u.setStatus(rs.getBoolean("status"));
                u.setDob(rs.getDate("dob"));
                u.setGender(rs.getString("gender"));
                u.setImages(rs.getString("images"));

                // Xử lý an toàn created_at
                java.sql.Date createdDate = rs.getDate("created_at");
                if (createdDate != null) {
                    u.setCreate_at(createdDate.toLocalDate());
                } else {
                    u.setCreate_at(null);
                }

                // Xử lý an toàn updated_at
                java.sql.Date updatedDate = rs.getDate("updated_at");
                if (updatedDate != null) {
                    u.setUpdate_at(updatedDate.toLocalDate());
                } else {
                    u.setUpdate_at(null);
                }

                customers.add(u);
            }
            return customers;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM Users WHERE email = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int user_id = rs.getInt("user_id");
                String username = rs.getString("username");
                String password = rs.getString("password");
                String full_name = rs.getString("full_name");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                int role_id = rs.getInt("role_id");
                boolean status = rs.getBoolean("status");
                java.sql.Date dob = rs.getDate("dob");
                String gender = rs.getString("gender");
                String images = rs.getString("images");

                java.sql.Date createdAtDate = rs.getDate("created_at");
                java.sql.Date updatedAtDate = rs.getDate("updated_at");
                java.time.LocalDate create_at = createdAtDate != null ? createdAtDate.toLocalDate() : null;
                java.time.LocalDate update_at = updatedAtDate != null ? updatedAtDate.toLocalDate() : null;

                // Tạo User object theo đúng constructor của bạn
                return new User(
                        user_id,
                        username,
                        password,
                        full_name,
                        email,
                        phone,
                        address,
                        role_id,
                        status,
                        dob,
                        gender,
                        images,
                        create_at,
                        update_at
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // 1. Kiểm tra username đã tồn tại chưa
    public boolean isUsernameExists(String username) {
        String sql = "SELECT user_id FROM Users WHERE username = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            ResultSet rs = st.executeQuery();
            boolean exists = rs.next();
            rs.close();
            return exists;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // 2. Kiểm tra email đã tồn tại chưa
    public boolean isEmailExists(String email) {
        String sql = "SELECT user_id FROM Users WHERE email = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, email);
            ResultSet rs = st.executeQuery();
            boolean exists = rs.next();
            rs.close();
            return exists;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public User getUserByUsername(String username) {
        String sql = "SELECT * FROM Users WHERE username = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, username);
            try (ResultSet rs = st.executeQuery()) {
                if (rs.next()) {
                    // Đọc các trường cần thiết, nhớ lấy cả password đã hash để so sánh!
                    int user_id = rs.getInt("user_id");
                    String password = rs.getString("password");
                    String full_name = rs.getString("full_name");
                    String email = rs.getString("email");
                    String phone = rs.getString("phone");
                    String address = rs.getString("address");
                    int role_id = rs.getInt("role_id");
                    boolean status = rs.getBoolean("status");
                    Date dob = rs.getDate("dob");
                    String gender = rs.getString("gender");
                    String images = rs.getString("images");
                    LocalDate create_at = rs.getDate("created_at") != null ? rs.getDate("created_at").toLocalDate() : null;
                    LocalDate update_at = rs.getDate("updated_at") != null ? rs.getDate("updated_at").toLocalDate() : null;

                    // Khởi tạo User đúng với constructor bạn đang dùng
                    return new User(user_id, username, password, full_name, email, phone, address,
                            role_id, status, dob, gender, images, create_at, update_at);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean isPhoneExists(String phone) {
        try {
            String sql = "SELECT * FROM Users WHERE phone = ?";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            return rs.next();  // Nếu có kết quả, tức là số điện thoại đã tồn tại
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public void insertUser(User user) {
        String sql = "INSERT INTO Users (username, password, full_name, email, phone, address, role_id, status, dob, gender, images, created_at) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement st = connection.prepareStatement(sql);
            st.setString(1, user.getUsername());
            st.setString(2, user.getPassword());
            st.setString(3, user.getFull_name());
            st.setString(4, user.getEmail());
            st.setString(5, user.getPhone());
            st.setString(6, user.getAddress());
            st.setInt(7, user.getRole_id());
            st.setBoolean(8, user.isStatus());
            st.setDate(9, user.getDob() != null ? new java.sql.Date(user.getDob().getTime()) : null);
            st.setString(10, user.getGender());
            st.setString(11, user.getImages());
            st.setDate(12, java.sql.Date.valueOf(user.getCreate_at()));
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Vector<User> getAllUser() {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<User> users = new Vector<>();
        String sql = "SELECT * FROM Users";
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUser_id(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFull_name(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setRole_id(rs.getInt("role_id"));
                u.setStatus(rs.getBoolean("status"));
                u.setDob(rs.getDate("dob"));
                u.setGender(rs.getString("gender"));
                u.setImages(rs.getString("images"));

                // Xử lý an toàn created_at
                java.sql.Date createdDate = rs.getDate("created_at");
                if (createdDate != null) {
                    u.setCreate_at(createdDate.toLocalDate());
                } else {
                    u.setCreate_at(null);
                }

                // Xử lý an toàn updated_at
                java.sql.Date updatedDate = rs.getDate("updated_at");
                if (updatedDate != null) {
                    u.setUpdate_at(updatedDate.toLocalDate());
                } else {
                    u.setUpdate_at(null);
                }

                users.add(u);
            }
            return users;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Vector<User> getUserById(int uid) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<User> users = new Vector<>();
        String sql = "SELECT * FROM Users WHERE user_id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, uid);
            rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUser_id(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFull_name(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setRole_id(rs.getInt("role_id"));
                u.setStatus(rs.getBoolean("status"));
                u.setDob(rs.getDate("dob"));
                u.setGender(rs.getString("gender"));
                u.setImages(rs.getString("images"));

                // Xử lý an toàn created_at
                java.sql.Date createdDate = rs.getDate("created_at");
                if (createdDate != null) {
                    u.setCreate_at(createdDate.toLocalDate());
                } else {
                    u.setCreate_at(null);
                }

                // Xử lý an toàn updated_at
                java.sql.Date updatedDate = rs.getDate("updated_at");
                if (updatedDate != null) {
                    u.setUpdate_at(updatedDate.toLocalDate());
                } else {
                    u.setUpdate_at(null);
                }

                users.add(u);
            }
            return users;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Vector<User> getUserByName(String name) {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<User> customers = new Vector<>();
        String sql = "SELECT * FROM Users WHERE full_name LIKE ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setString(1, "%" + name + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUser_id(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFull_name(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setRole_id(rs.getInt("role_id"));
                u.setStatus(rs.getBoolean("status"));
                u.setDob(rs.getDate("dob"));
                u.setGender(rs.getString("gender"));
                u.setImages(rs.getString("images"));

                // Xử lý an toàn created_at
                java.sql.Date createdDate = rs.getDate("created_at");
                if (createdDate != null) {
                    u.setCreate_at(createdDate.toLocalDate());
                } else {
                    u.setCreate_at(null);
                }

                // Xử lý an toàn updated_at
                java.sql.Date updatedDate = rs.getDate("updated_at");
                if (updatedDate != null) {
                    u.setUpdate_at(updatedDate.toLocalDate());
                } else {
                    u.setUpdate_at(null);
                }

                customers.add(u);
            }
            return customers;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Vector<User> getAllCustomer() {
        PreparedStatement stm = null;
        ResultSet rs = null;
        Vector<User> users = new Vector<>();
        String sql = "SELECT * FROM Users WHERE role_id = 4";
        try {
            stm = connection.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                User u = new User();
                u.setUser_id(rs.getInt("user_id"));
                u.setUsername(rs.getString("username"));
                u.setPassword(rs.getString("password"));
                u.setFull_name(rs.getString("full_name"));
                u.setEmail(rs.getString("email"));
                u.setPhone(rs.getString("phone"));
                u.setAddress(rs.getString("address"));
                u.setRole_id(rs.getInt("role_id"));
                u.setStatus(rs.getBoolean("status"));
                u.setDob(rs.getDate("dob"));
                u.setGender(rs.getString("gender"));
                u.setImages(rs.getString("images"));

                // Xử lý an toàn created_at
                java.sql.Date createdDate = rs.getDate("created_at");
                if (createdDate != null) {
                    u.setCreate_at(createdDate.toLocalDate());
                } else {
                    u.setCreate_at(null);
                }

                // Xử lý an toàn updated_at
                java.sql.Date updatedDate = rs.getDate("updated_at");
                if (updatedDate != null) {
                    u.setUpdate_at(updatedDate.toLocalDate());
                } else {
                    u.setUpdate_at(null);
                }

                users.add(u);
            }
            return users;
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public void updateUser(User user) {
        String sql = "UPDATE Users SET full_name = ?, email = ?, phone = ?, address = ?, dob = ?, gender = ?, images = ?, updated_at = GETDATE() WHERE user_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, user.getFull_name());
            stm.setString(2, user.getEmail());
            stm.setString(3, user.getPhone());
            stm.setString(4, user.getAddress());
            if (user.getDob() != null) {
                stm.setDate(5, new java.sql.Date(user.getDob().getTime()));
            } else {
                stm.setNull(5, java.sql.Types.DATE);
            }
            stm.setString(6, user.getGender());
            stm.setString(7, user.getImages());
            stm.setInt(8, user.getUser_id());
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void updatePassword(int userId, String newPassword) {
        String sql = "UPDATE Users SET password = ?, updated_at = GETDATE() WHERE user_id = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            String hash = PasswordEncryption.hashPassword(newPassword);
            stm.setString(1, hash);
            stm.setInt(2, userId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public void deleteUser(int userId) {
        PreparedStatement stm = null;
        String sql = "DELETE FROM Users WHERE user_id = ?";
        try {
            stm = connection.prepareStatement(sql);
            stm.setInt(1, userId);
            stm.executeUpdate();
        } catch (SQLException ex) {
            Logger.getLogger(UserDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public boolean checkLogin(String username, String inputPassword) {
        String sql = "SELECT password FROM Users WHERE username = ?";
        try (PreparedStatement stm = connection.prepareStatement(sql)) {
            stm.setString(1, username);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {
                String storedHash = rs.getString("password");
                return PasswordEncryption.checkPassword(inputPassword, storedHash);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateUserInfo(int userId, String fullName, String email, String phone, String address) {
        try (
                PreparedStatement ps = connection.prepareStatement(
                        "UPDATE Users SET full_name=?, email=?, phone=?, address=?, updated_at=GETDATE() WHERE user_id=?")) {
            ps.setString(1, fullName);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, address);
            ps.setInt(5, userId);
            return ps.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updatePasswordByEmail(String email, String newPassword) {
        String sql = "UPDATE Users SET password = ? WHERE email = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, newPassword); // Có thể thêm hash nếu cần bảo mật hơn
            st.setString(2, email);

            int rowsUpdated = st.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
