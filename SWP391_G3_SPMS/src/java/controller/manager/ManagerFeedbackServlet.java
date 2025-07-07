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
import java.lang.System.Logger.Level;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Logger;
import model.customer.User;
import model.manager.Feedback;
import model.manager.PoolFeedBack;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "ManagerFeedbackServlet", urlPatterns = {"/managerFeedbackServlet"})
public class ManagerFeedbackServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagerFeedbackServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerFeedbackServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Kiểm tra session đăng nhập
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy branchId từ user_id
        int branchId = 0;
        switch (currentUser.getUser_id()) {
            case 2:
                branchId = 1;
                break; // Hà Nội
            case 3:
                branchId = 2;
                break; // Hồ Chí Minh
            case 4:
                branchId = 3;
                break; // Đà Nẵng
            case 5:
                branchId = 4;
                break; // Quy Nhơn
            case 6:
                branchId = 5;
                break; // Cần Thơ
            default:
                response.sendRedirect("login.jsp");
                return;
        }

        // Lấy các tham số filter
        String keyword = request.getParameter("keyword");
        String poolIdStr = request.getParameter("poolId");
        String ratingStr = request.getParameter("rating");
        String dateFilter = request.getParameter("dateFilter");
        String pageStr = request.getParameter("page");
        String pageSizeStr = request.getParameter("pageSize");

        // Xử lý tham số poolId
        int poolId = -1;
        if (poolIdStr != null && !poolIdStr.isEmpty() && !"all".equals(poolIdStr)) {
            try {
                poolId = Integer.parseInt(poolIdStr);
            } catch (NumberFormatException e) {
                poolId = -1;
            }
        }

        // Xử lý tham số rating
        int rating = -1;
        if (ratingStr != null && !ratingStr.isEmpty() && !"all".equals(ratingStr)) {
            try {
                rating = Integer.parseInt(ratingStr);
            } catch (NumberFormatException e) {
                rating = -1;
            }
        }

        // Xử lý tham số dateFilter
        if (dateFilter == null || dateFilter.isEmpty()) {
            dateFilter = "all";
        }

        // Xử lý tham số page
        int page = 1;
        if (pageStr != null && !pageStr.isEmpty()) {
            try {
                page = Integer.parseInt(pageStr);
                if (page < 1) page = 1;
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        // Xử lý tham số pageSize
        int pageSize = 10;
        if (pageSizeStr != null && !pageSizeStr.isEmpty()) {
            try {
                pageSize = Integer.parseInt(pageSizeStr);
                if (pageSize < 1) pageSize = 10;
            } catch (NumberFormatException e) {
                pageSize = 10;
            }
        }

        FeedbackDAO feedbackDAO = new FeedbackDAO();
        
        try {
            // Lấy danh sách feedback
            int[] totalRows = new int[1];
            List<Feedback> feedbacks = feedbackDAO.getFeedbacks(
                    keyword, poolId, rating, dateFilter, page, pageSize, totalRows, branchId
            );

            // Lấy danh sách pool cho filter (chỉ pool thuộc branch này)
            List<PoolFeedBack> pools = feedbackDAO.getPoolsByBranch(branchId);

            // Tính toán phân trang
            int totalPages = (int) Math.ceil((double) totalRows[0] / pageSize);

            // Set attributes cho JSP
            request.setAttribute("feedbackList", feedbacks); // Sửa tên attribute
            request.setAttribute("poolList", pools); // Sửa tên attribute
            request.setAttribute("totalPages", totalPages);
            request.setAttribute("currentPage", page);
            request.setAttribute("totalRows", totalRows[0]);
            request.setAttribute("endP", totalPages); // Thêm attribute cho JSP
            request.setAttribute("page", page); // Thêm attribute cho JSP
            request.setAttribute("pageSize", pageSize); // Thêm attribute cho JSP
            
            // Giữ lại các giá trị filter
            request.setAttribute("keyword", keyword);
            request.setAttribute("poolId", poolIdStr); // Giữ nguyên string để so sánh trong JSP
            request.setAttribute("rating", ratingStr); // Giữ nguyên string để so sánh trong JSP
            request.setAttribute("dateFilter", dateFilter);

            // Forward đến JSP
            request.getRequestDispatcher("managerFeedback.jsp").forward(request, response);
            
        } catch (SQLException e) {
            
            request.setAttribute("error", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
