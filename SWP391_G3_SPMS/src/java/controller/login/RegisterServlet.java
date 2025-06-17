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
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.User;
import util.HashUtils;
import util.CheckNewPassword;
import static util.CheckNewPassword.validateRegisterPassword;

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

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");

        // Lấy dữ liệu từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirm_password");
        String fullName = request.getParameter("full_name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");

        // Kiểm tra mật khẩu nhập lại có khớp không
        if (!confirmPassword.equals(password)) {
            request.setAttribute("error", "Mật khẩu nhập lại không khớp!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra mật khẩu theo các quy tắc
        String passwordValidationMessage = validateRegisterPassword(password);
        if (passwordValidationMessage != null) {
            request.setAttribute("error", passwordValidationMessage);
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra sự tồn tại của username, email, phone trong database
        UserDAO dao = new UserDAO();
        if (dao.isUsernameExists(username)) {
            request.setAttribute("error", "Tên người dùng đã tồn tại! Vui lòng thử lại");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        if (dao.isEmailExists(email)) {
            request.setAttribute("error", "Email đã tồn tại! Vui lòng thử lại");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        if (dao.isPhoneExists(phone)) {
            request.setAttribute("error", "Số điện thoại đã tồn tại! Vui lòng thử lại");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Hash mật khẩu SHA-256 trước khi lưu vào cơ sở dữ liệu
        String hashedPassword = HashUtils.hashPassword(password);

        // Tạo đối tượng người dùng và lưu vào DB
        User user = new User(
                0, username, hashedPassword, fullName, email, phone, null,
                4, true, null, null, null,
                java.time.LocalDate.now(), null
        );

        // Lưu vào DB
        dao.insertUser(user);

        // Gửi thông báo đăng ký thành công cho người dùng
        request.setAttribute("mess", "Đăng kí thành công. Bạn có thể đăng nhập ngay");
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
