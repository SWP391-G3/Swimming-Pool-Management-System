/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.staff;


import dao.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "StaffAccountServlet", urlPatterns = {"/StaffAccountServlet"})
public class StaffAccountServlet extends HttpServlet {

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
            out.println("<title>Servlet StaffAccountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffAccountServlet at " + request.getContextPath() + "</h1>");
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
        //String userIdParam = request.getParameter("3");
        String userIdParam = 3 + "";
        UserDAO userDAO = new UserDAO();
        Integer userId = null;
        if (userIdParam != null) {
            try {
                userId = Integer.parseInt(userIdParam);
            } catch (NumberFormatException e) {
                // Nếu user_id truyền lên không hợp lệ
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "user_id không hợp lệ");
                return;
            }
        }
//        if (userId == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }

        User user = userDAO.getUserById(userId);
        System.out.println("User lấy từ DB: " + user);

        if (user == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Không tìm thấy nhân viên");
            return;
        }

        //Kiểm tra role_id (ví dụ: 3 là staff)
//        if (user.getRole_id() != 3) {
//            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Bạn không có quyền truy cập chức năng này");
//            return;
//        }
        // Nếu đúng là staff
        request.setAttribute("user", user);
        request.getRequestDispatcher("staff_information.jsp").forward(request, response);
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

        request.setCharacterEncoding("UTF-8"); // Hỗ trợ tiếng Việt
        UserDAO userDAO = new UserDAO();
        int userId = 3; // TODO: lấy từ session trong thực tế

        String fullName = request.getParameter("full_name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        // Validation
        StringBuilder error = new StringBuilder();

        if (fullName == null || fullName.trim().isEmpty()) {
            error.append("Họ và tên không được để trống.<br>");
        }

        if (email == null || !email.matches("^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            error.append("Email không hợp lệ.<br>");
        }

        if (phone == null || !phone.matches("^0\\d{9,10}$")) {
            error.append("Số điện thoại không hợp lệ (bắt đầu bằng 0 và có 10 chữ số).<br>");
        }

        if (address == null || address.trim().length() < 5) {
            error.append("Địa chỉ phải có ít nhất 5 ký tự.<br>");
        }

        // Nếu có lỗi → gửi lại form kèm thông báo
        if (error.length() > 0) {
            User user = userDAO.getUserById(userId);
            request.setAttribute("user", user);
            request.setAttribute("message", error.toString());
            request.getRequestDispatcher("staff_information.jsp").forward(request, response);
            return;
        }

        // Nếu dữ liệu hợp lệ → thực hiện cập nhật
        boolean updated = userDAO.updateUserInfo(userId, fullName, email, phone, address);
        String message = updated ? "Cập nhật thành công!" : "Cập nhật thất bại!";

        // Lấy lại user mới nhất để hiển thị
        User user = userDAO.getUserById(userId);
        request.setAttribute("user", user);
        request.setAttribute("message", message);
        request.getRequestDispatcher("staff_information.jsp").forward(request, response);

    }

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
