/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dao.manager.FeedbackDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.customer.User;
import java.sql.SQLException;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "ManagerDeleteFeedbackServlet", urlPatterns = {"/managerDeleteFeedbackServlet"})
public class ManagerDeleteFeedbackServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagerDeleteFeedbackServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerDeleteFeedbackServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Only allow delete by logged-in user
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
       if (currentUser == null) {
            response.getWriter().println("<div class='error-message'>Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại!</div>");
            return;
        }

        // Lấy branchId theo quy ước user_id
        int branchId = 0;
        int currentUser_id = currentUser.getUser_id();
        switch (currentUser_id) {
            case 2:
                branchId = 1;
                break;
            case 3:
                branchId = 2;
                break;
            case 4:
                branchId = 3;
                break;
            case 5:
                branchId = 4;
                break;
            case 6:
                branchId = 5;
                break;
            default:
                // Không cho phép user không hợp lệ xóa
                response.sendRedirect("managerFeedbackServlet?error=Không có quyền xóa phản hồi này!");
                return;
        }

        // Lấy các tham số filter để giữ trạng thái phân trang/lọc
        String feedbackIdStr = request.getParameter("id");
        String page = request.getParameter("page");
        String pageSize = request.getParameter("pageSize");
        String keyword = request.getParameter("keyword");
        String rating = request.getParameter("rating");
        String dateFilter = request.getParameter("dateFilter");
        String poolId = request.getParameter("poolId");

        String redirectUrl = "managerFeedbackServlet?page=" + (page != null ? page : "1")
                + "&pageSize=" + (pageSize != null ? pageSize : "10")
                + "&keyword=" + java.net.URLEncoder.encode(keyword != null ? keyword : "", "UTF-8")
                + "&rating=" + (rating != null ? rating : "all")
                + "&dateFilter=" + (dateFilter != null ? dateFilter : "all")
                + "&poolId=" + (poolId != null ? poolId : "all");

        if (feedbackIdStr == null || feedbackIdStr.trim().isEmpty()) {
            response.sendRedirect(redirectUrl + "&error=" + java.net.URLEncoder.encode("Thiếu thông tin phản hồi cần xóa!", "UTF-8"));
            return;
        }

        try {
            int feedbackId = Integer.parseInt(feedbackIdStr);
            FeedbackDAO dao = new FeedbackDAO();
            boolean deleted = dao.deleteFeedback(feedbackId, branchId);

            if (deleted) {
                response.sendRedirect(redirectUrl + "&success=" + java.net.URLEncoder.encode("Đã xóa phản hồi thành công!", "UTF-8"));
            } else {
                response.sendRedirect(redirectUrl + "&error=" + java.net.URLEncoder.encode("Không tìm thấy hoặc không có quyền xóa phản hồi này!", "UTF-8"));
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(redirectUrl + "&error=" + java.net.URLEncoder.encode("ID phản hồi không hợp lệ!", "UTF-8"));
        } catch (SQLException e) {
            response.sendRedirect(redirectUrl + "&error=" + java.net.URLEncoder.encode("Lỗi xóa phản hồi: " + e.getMessage(), "UTF-8"));
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
