/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.login;

import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import model.User;

/**
 *
 * @author 84823
 */

public class RegisterServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet RegisterServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet RegisterServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }
    
      private String hashPassword(String password) {
        try {
            java.security.MessageDigest md = java.security.MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes(java.nio.charset.StandardCharsets.UTF_8));
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
         String rawPassword = request.getParameter("password");
        String password = hashPassword(rawPassword); 
        String full_name = request.getParameter("full_name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        LocalDate currentDate = LocalDate.now();

        // Kiểm tra định dạng email có đuôi @gmail.com
        if (!email.toLowerCase().endsWith("@gmail.com")) {
            request.setAttribute("error", "Email must form @gmail.com.Please try again!");
            request.setAttribute("enteredUsername", username);
            request.setAttribute("enteredEmail", email);
            request.setAttribute("enteredFullName", full_name);
            request.setAttribute("enteredPhone", phone);
            request.setAttribute("enteredAddress", address);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
         
        UserDAO dao = new UserDAO();
        List<User> userList = dao.getAllUser();

        for (User u : userList) {
            if (u.getUsername() != null && u.getUsername().equalsIgnoreCase(username)) {
                request.setAttribute("error", "Username already exists. Please try again.");
                request.setAttribute("enteredUsername", username);
                request.setAttribute("enteredEmail", email);
                request.setAttribute("enteredFullName", full_name);
                request.setAttribute("enteredPhone", phone);
                request.setAttribute("enteredAddress", address);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }

            if (u.getEmail() != null && u.getEmail().equalsIgnoreCase(email)) {
                request.setAttribute("error", "Email already exists. Please try again.");
                request.setAttribute("enteredUsername", username);
                request.setAttribute("enteredEmail", email);
                request.setAttribute("enteredFullName", full_name);
                request.setAttribute("enteredPhone", phone);
                request.setAttribute("enteredAddress", address);
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
        }
        if (!phone.matches("0[0-9]{8,9}")) {
            request.setAttribute("error", "Phone number must start with 0 and contains max 10 number ");
            request.setAttribute("enteredUsername", username);
            request.setAttribute("enteredEmail", email);
            request.setAttribute("enteredFullName", full_name);
            request.setAttribute("enteredPhone", phone);
            request.setAttribute("enteredAddress", address);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
            
        }

        // Nếu không có lỗi thì thêm người dùng
        User user = new User(0, username, password, full_name, email, phone, address, 4, true, null, null, currentDate, null);
        dao.insertUser(user);
        response.sendRedirect("registersucessfull.jsp");
    }

    // Nếu không trùng thì tạo user mới
    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
