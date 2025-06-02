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
import utils.HashUtils;

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

        String address = request.getParameter("address");

//        Giữ lại giá trị đã nhập khi lỗi
        request.setAttribute("enteredUsername", username);
        request.setAttribute("enteredFullName", fullName);
        request.setAttribute("enteredEmail", email);
        request.setAttribute("enteredPhone", phone);
        request.setAttribute("enteredAddress", address);

        if (username == null || password == null || confirmPassword == null
                || fullName == null || email == null || phone == null
                || address == null
                || username.trim().isEmpty() || password.trim().isEmpty() || confirmPassword.trim().isEmpty()
                || fullName.trim().isEmpty() || email.trim().isEmpty() || phone.trim().isEmpty()
                || address.trim().isEmpty()) {
            request.setAttribute("error", "Tất cả các trường đều là bắt buộc.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!username.matches("^[A-Za-z0-9]{4,32}$")) {
            request.setAttribute("error", "Tên người dùng phải dài từ 4-32 ký tự, chỉ bao gồm chữ cái, số");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!email.matches("^[a-zA-Z0-9._]+@[a-zA-Z0-9]+(\\.[a-zA-Z0-9]+)+$")) {
            request.setAttribute("error", "Email nhập không đúng format");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (!phone.matches("^0\\d{9}$")) {
            request.setAttribute("error", "Số điện thoại phải là số và chứa 10 số");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        if (password.length() < 9) {
            request.setAttribute("error", "Mật khẩu phải đủ 9 kí tự");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu nhập lại  không hợp lệ");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

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

        // 8. Hash password SHA-256
        String hashedPassword = HashUtils.hashPassword(password);

        // 9. Tạo User object, role_id = 4 (customer), status = true, images = null
        User user = new User(
                0, username, hashedPassword, fullName, email, phone, address,
                4, true, null, null, null,
                java.time.LocalDate.now(), null
        );

        // 10. Lưu vào DB
        dao.insertUser(user);

        // 11. Đăng ký thành công -> chuyển sang register success
//        response.sendRedirect("registersuccessfull.jsp");
        request.setAttribute("mess", "Đăng kí thành công");
        request.getRequestDispatcher("register.jsp").forward(request, response);
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
