/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.login;

import dao.customer.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.customer.User;
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
       

        UserDAO dao = new UserDAO();
        User user = dao.getUserByUsername(username); // Lấy user theo username

        if (user != null && user.isStatus()) {

            String hashedInputPassword = HashUtils.hashPassword(password);

            if (hashedInputPassword.equals(user.getPassword())) {

                HttpSession session = request.getSession();
                session.setAttribute("currentUser", user);
                session.setAttribute("message", "Đăng nhập thành công!"); 
                int roleId = user.getRole_id();

                switch (roleId) {
                    case 1:
                        response.sendRedirect("adminDashBoard");
                        break;
                    case 2:
                        response.sendRedirect("managerPanel.jsp"); 
                        break;
                    case 3:
                        response.sendRedirect("staffManager");
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
