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
import utils.HashUtils;

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

        UserDAO dao = new UserDAO();
        User user = dao.getUserByUsername(username); // Lấy user theo username

        if (user != null) {

            String hashedInputPassword = HashUtils.hashPassword(password);

            if (hashedInputPassword.equals(user.getPassword())) {

                HttpSession session = request.getSession();
                session.setAttribute("currentUser", user);

                int roleId = user.getRole_id();

                switch (roleId) {
                    case 1:
                        response.sendRedirect("admin.jsp");
                        break;
                    case 2:
                        response.sendRedirect("manager.jsp");
                        break;
                    case 3:
                        response.sendRedirect("staff.jsp");
                        break;
                    case 4:
                        response.sendRedirect("homepage.jsp");
                        break;
                    default:
                        response.sendRedirect("index.jsp");
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
