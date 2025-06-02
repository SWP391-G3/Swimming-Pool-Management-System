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
        int userId = 2; // lấy cố định
        UserDAO userDAO = new UserDAO();
        User userDetails = userDAO.getUserByID(userId);
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
        
        //User user = (User) session.getAttribute("user");
        //int userId = user.getId();
        
        int userId = 2; // lấy cố định

        // Lấy thông tin từ form
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
            } catch (Exception e) {
                dob = null;
            }
        }

        Part filePart = request.getPart("images");
        String images = null;
        String uploadPath = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadDir = new File(uploadPath);
        
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }

        if (filePart != null && filePart.getSize() > 0 && filePart.getSubmittedFileName() != null && !filePart.getSubmittedFileName().isEmpty()) {
            String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
            String filePath = uploadPath + File.separator + fileName;
            filePart.write(filePath);
            images = "uploads/" + fileName;
        }

        User user = userDAO.getUserByID(userId);
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

            request.setAttribute("updateSuccess", "Cập nhật thông tin thành công!");
            request.setAttribute("user", userDAO.getUserByID(userId));
            request.getRequestDispatcher("customer_account_infor.jsp").forward(request, response);
        } else {
            response.getWriter().println("Not found user in database!");
        }
    }
}
