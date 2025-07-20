package controller.Customer;

import dao.customer.UserDAO;
import model.customer.User;

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

/**
 *
 * @author LAZYVL
 */

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
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("currentUser");
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            int userId = user.getUser_id();

            UserDAO userDAO = new UserDAO();
            User userDetails = userDAO.getUserByID(userId);

            if (userDetails != null) {
                request.setAttribute("user", userDetails);
                request.getRequestDispatcher("EditAccountInfo.jsp").forward(request, response);
            } else {
                response.getWriter().println("Không tìm thấy người dùng trong cơ sở dữ liệu!");
            }
        } else if (service.equals("changePassword")) {
            HttpSession session = request.getSession();
            User currentUser = (User) session.getAttribute("currentUser");
            if (currentUser == null) {
                response.sendRedirect("login.jsp");
                return;
            }

            UserDAO userDAO = new UserDAO();
            User userDetails = userDAO.getUserByID(currentUser.getUser_id());
            request.setAttribute("user", userDetails);
            request.getRequestDispatcher("ChangePassword.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thực tế nên lấy từ session
        HttpSession session = request.getSession();
        User user1 = (User) session.getAttribute("currentUser");
        if (user1 == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int userId = user1.getUser_id();
        String service = request.getParameter("service");
        if (service == null) {
            service = "updateProfile";
        }

        if (service.equals("updateProfile")) {
            UserDAO userDAO = new UserDAO();

            try {
                // Lấy thông tin từ form
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

                if (filePart != null && filePart.getSize() > 0
                        && filePart.getSubmittedFileName() != null
                        && !filePart.getSubmittedFileName().isEmpty()) {

                    String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                    String filePath = uploadPath + File.separator + fileName;
                    filePart.write(filePath);
                    images = "uploads/" + fileName;
                }

                // Cập nhật thông tin user
                User userFromDb = userDAO.getUserByID(userId);
                if (userFromDb != null) {
                    // Validate email/phone
                    if (userDAO.isEmailExistsForOtherUser(email, userId)) {
                        request.setAttribute("user", userFromDb);
                        request.setAttribute("error", "Email đã được sử dụng bởi tài khoản khác. Vui lòng chọn email khác!");
                        request.getRequestDispatcher("EditAccountInfo.jsp").forward(request, response);
                        return;
                    }
                    if (userDAO.isPhoneExistsForOtherUser(phone, userId)) {
                        request.setAttribute("user", userFromDb);
                        request.setAttribute("error", "Số điện thoại đã được sử dụng bởi tài khoản khác. Vui lòng chọn số khác!");
                        request.getRequestDispatcher("EditAccountInfo.jsp").forward(request, response);
                        return;
                    }
                    
                    userFromDb.setFull_name(fullName);
                    userFromDb.setEmail(email);
                    userFromDb.setPhone(phone);
                    userFromDb.setAddress(address);
                    userFromDb.setDob(dob);
                    userFromDb.setGender(gender);

                    if (images != null) {
                        userFromDb.setImages(images);
                    }

                    userDAO.updateUser(userFromDb);

                    // Cập nhật lại session
                    session.setAttribute("currentUser", userFromDb);

                    request.setAttribute("updateSuccess", "Cập nhật thông tin thành công!");
                    request.setAttribute("user", userFromDb);
                    request.getRequestDispatcher("EditAccountInfo.jsp").forward(request, response);
                } else {
                    response.getWriter().println("Không tìm thấy người dùng trong cơ sở dữ liệu!");
                }

            } catch (Exception e) {
                User userFromDb = userDAO.getUserByID(userId);
                request.setAttribute("user", userFromDb);
                request.setAttribute("error", "Có lỗi xảy ra khi cập nhật thông tin: " + e.getMessage());
                request.getRequestDispatcher("EditAccountInfo.jsp").forward(request, response);
            }
        }
    }
}
