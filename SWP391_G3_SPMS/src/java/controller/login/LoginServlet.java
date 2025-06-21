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
import model.User;
import util.HashUtils;

/**
 *
 * @author 84823
 */
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8"); // Đảm bảo lấy được ký tự Unicode từ form
        response.setContentType("text/html;charset=UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        if (username.trim().isEmpty() || password.trim().isEmpty()) {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không được bỏ trống");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        UserDAO dao = new UserDAO();
        User user = dao.getUserByUsername(username); // Lấy user theo username

        if (user.isStatus() == false) {
            request.setAttribute("error", "Tài khoản của bạn đã bị khóa, liên hệ admin để được mở khóa!");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        if (user != null && user.isStatus()) {

            String hashedInputPassword = HashUtils.hashPassword(password);

            if (hashedInputPassword.equals(user.getPassword())) {

                HttpSession session = request.getSession();
                session.setAttribute("currentUser", user);

                int roleId = user.getRole_id();

                switch (roleId) {
                    case 1:
                        response.sendRedirect("adminPoolManagement");
                        break;
                    case 2:
                        response.sendRedirect("managerPanel.jsp");
                        break;
                    case 3:
                        response.sendRedirect("staff.jsp");
                        break;
                    case 4:
                        response.sendRedirect("customerHome");
                        break;
                    default:
                        response.sendRedirect("LandingPage.jsp");
                        break;
                }
            } else {
                // Sai password   
                request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } else {
            // Không tồn tại user  
            request.setAttribute("error", "Sai tên đăng nhập hoặc mật khẩu");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }

}
