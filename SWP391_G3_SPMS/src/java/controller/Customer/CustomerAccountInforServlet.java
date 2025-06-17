package controller.Customer;

import dao.UserDAO;
import model.User;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/profile")
@MultipartConfig
public class CustomerAccountInforServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String service = request.getParameter("service");
        if (service == null) {
            service = "showProfile";
        }

        if (service.equals("showProfile")) {
            // Thực tế nên lấy từ session
            // HttpSession session = request.getSession();
            // User user = (User) session.getAttribute("user");
            // if (user == null) {
            //     response.sendRedirect("login.jsp");
            //     return;
            // }
            // int userId = user.getId();

            int userId = 2; // Hardcode để test
            UserDAO userDAO = new UserDAO();
            User userDetails = userDAO.getUserByID(userId);

            if (userDetails != null) {
                request.setAttribute("user", userDetails);
                request.getRequestDispatcher("EditAccountInfo.jsp").forward(request, response);
            } else {
                response.getWriter().println("Không tìm thấy người dùng trong cơ sở dữ liệu!");
            }
        } else if (service.equals("changePassword")) {
            // Chuyển đến trang đổi mật khẩu
            int userId = 2; // Hardcode để test
            UserDAO userDAO = new UserDAO();
            User userDetails = userDAO.getUserByID(userId);
            request.setAttribute("user", userDetails);
            request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thực tế nên lấy từ session
        // HttpSession session = request.getSession();
        // User user = (User) session.getAttribute("user");
        // if (user == null) {
        //     response.sendRedirect("login.jsp");
        //     return;
        // }
        // int userId = user.getId();

        String service = request.getParameter("service");
        if (service == null) {
            service = "updateProfile";
        }

        if (service.equals("updateProfile")) {
            UserDAO userDAO = new UserDAO();
            int userId = 2; // Hardcode để test

            try {
                // Lấy thông tin từ form (đã được validate ở client-side)
                String fullName = request.getParameter("full_name");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                String dobStr = request.getParameter("dob");
                String gender = request.getParameter("gender");

                // Chuyển đổi ngày sinh
                Date dob = null;
                if (dobStr != null && !dobStr.trim().isEmpty()) {
                    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                    dob = dateFormat.parse(dobStr);
                }

                // Xử lý upload ảnh
                Part filePart = request.getPart("images");
                String images = null;

                String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
                File uploadDir = new File(uploadPath);

                if (!uploadDir.exists()) {
                    uploadDir.mkdir();
                }

                // Nếu có file upload
                if (filePart != null && filePart.getSize() > 0
                        && filePart.getSubmittedFileName() != null
                        && !filePart.getSubmittedFileName().isEmpty()) {

                    String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                    String filePath = uploadPath + File.separator + fileName;
                    filePart.write(filePath);
                    images = "uploads/" + fileName;
                }

                // Cập nhật thông tin user
                User user = userDAO.getUserByID(userId);
                if (user != null) {
                    user.setFull_name(fullName);
                    user.setEmail(email);
                    user.setPhone(phone);
                    user.setAddress(address);
                    user.setDob(dob);
                    user.setGender(gender);

                    // Chỉ update ảnh nếu có upload ảnh mới
                    if (images != null) {
                        user.setImages(images);
                    }

                    // Cập nhật vào database
                    userDAO.updateUser(user);

                    // Trả về thông báo success
                    request.setAttribute("updateSuccess", "Cập nhật thông tin thành công!");
                    request.setAttribute("user", userDAO.getUserById(userId));
                    request.getRequestDispatcher("EditAccountInfo.jsp").forward(request, response);
                } else {
                    response.getWriter().println("Không tìm thấy người dùng trong cơ sở dữ liệu!");
                }

            } catch (Exception e) {
                // Xử lý lỗi server (parse date, database, etc.)
                User user = userDAO.getUserByID(userId);
                request.setAttribute("user", user);
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật thông tin: " + e.getMessage());
                request.getRequestDispatcher("EditAccountInfo.jsp").forward(request, response);
            }
        }
    }
}
