package controller;

import model.User;
import dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/profile")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 1024 * 1024 * 10,  // 10MB
    maxRequestSize = 1024 * 1024 * 20 // 20MB
)
public class CustomerAccountInforServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        int id = 4; // Lấy id phù hợp
        User userDetails = userDAO.getUserByID(id);
        if (userDetails != null) {
            request.setAttribute("user", userDetails);
            request.getRequestDispatcher("customer_account_infor.jsp").forward(request, response);
        } else {
            response.getWriter().println("Not found user in database!");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        UserDAO userDAO = new UserDAO();
        String service = request.getParameter("service");
        if (service == null) {
            service = "updateProfile";
        }
        if (service.equals("updateProfile")) {
            int id = 4; // Lấy id phù hợp
            String fullName = request.getParameter("full_name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");
            String dobStr = request.getParameter("dob");
            String gender = request.getParameter("gender");
            Date dob = null;
            if (dobStr != null && !dobStr.isEmpty()) {
                try {
                    dob = new SimpleDateFormat("yyyy-MM-dd").parse(dobStr);
                } catch (Exception e) { dob = null; }
            }

            Part filePart = request.getPart("images");
            String images = null;
            String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdir();

            if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
                String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath);
                images = "uploads/" + fileName;
            }

            User user = userDAO.getUserByID(id);
            if (user != null) {
                user.setFullName(fullName);
                user.setEmail(email);
                user.setPhone(phone);
                user.setAddress(address);
                user.setDob(dob);
                user.setGender(gender);

                if (images != null) {
                    user.setImages(images);
                }

                userDAO.updateUser(user);

                request.setAttribute("updateSuccess", "Profile updated successfully!");
                request.setAttribute("user", userDAO.getUserByID(id));
                request.getRequestDispatcher("customer_account_infor.jsp").forward(request, response);
            } else {
                response.getWriter().println("Not found user in database!");
            }
        }
    }
}