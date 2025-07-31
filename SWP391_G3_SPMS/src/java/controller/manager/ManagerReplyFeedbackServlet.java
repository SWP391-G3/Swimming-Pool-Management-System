/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dao.manager.FeedbackDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.customer.User;
import model.manager.Feedback;
import util.EmailFeedbackUtil;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "ManagerReplyFeedbackServlet", urlPatterns = {"/managerReplyFeedbackServlet"})
public class ManagerReplyFeedbackServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagerReplyFeedbackServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerReplyFeedbackServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("managerAccount");

        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

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
                throw new AssertionError();
        }

        String feedbackIdStr = request.getParameter("id");
        if (feedbackIdStr == null || feedbackIdStr.isEmpty()) {
            response.sendRedirect("managerFeedbackServlet?error=Invalid feedback ID");
            return;
        }

        // Lấy lại filter để giữ trạng thái khi quay về
        String page = request.getParameter("page");
        String pageSize = request.getParameter("pageSize");
        String keyword = request.getParameter("keyword");
        String rating = request.getParameter("rating");
        String dateFilter = request.getParameter("dateFilter");
        String poolId = request.getParameter("poolId");

        try {
            int feedbackId = Integer.parseInt(feedbackIdStr);
            FeedbackDAO dao = new FeedbackDAO();
            Feedback feedback = dao.getFeedbackById(feedbackId, branchId);

            if (feedback == null) {
                response.sendRedirect("managerFeedbackServlet?error=Feedback not found");
                return;
            }

            // Truyền lại các filter về JSP để giữ trạng thái
            request.setAttribute("feedback", feedback);
            request.setAttribute("page", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("keyword", keyword);
            request.setAttribute("rating", rating);
            request.setAttribute("dateFilter", dateFilter);
            request.setAttribute("poolId", poolId);
            request.getRequestDispatcher("managerReplyFeedback.jsp").forward(request, response);

        } catch (NumberFormatException | SQLException e) {
            response.sendRedirect("managerFeedbackServlet?error=Error: " + e.getMessage());
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("managerAccount");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

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
                throw new AssertionError();
        }

        request.setCharacterEncoding("UTF-8");

        // Lấy lại các filter
        String page = request.getParameter("page");
        String pageSize = request.getParameter("pageSize");
        String keyword = request.getParameter("keyword");
        String rating = request.getParameter("rating");
        String dateFilter = request.getParameter("dateFilter");
        String poolId = request.getParameter("poolId");

        String feedbackIdStr = request.getParameter("feedbackId");
        String subject = request.getParameter("subject");
        String responseContent = request.getParameter("responseContent");

        if (feedbackIdStr == null || subject == null || responseContent == null
                || feedbackIdStr.trim().isEmpty() || subject.trim().isEmpty() || responseContent.trim().isEmpty()) {
            String redirectUrl = "managerFeedbackServlet?page=" + (page != null ? page : "1")
                    + "&pageSize=" + (pageSize != null ? pageSize : "10")
                    + "&keyword=" + java.net.URLEncoder.encode(keyword != null ? keyword : "", "UTF-8")
                    + "&rating=" + (rating != null ? rating : "all")
                    + "&dateFilter=" + (dateFilter != null ? dateFilter : "all")
                    + "&poolId=" + (poolId != null ? poolId : "all")
                    + "&error=" + java.net.URLEncoder.encode("Vui lòng điền đầy đủ thông tin", "UTF-8");
            response.sendRedirect(redirectUrl);
            return;
        }

        try {
            int feedbackId = Integer.parseInt(feedbackIdStr);
            FeedbackDAO dao = new FeedbackDAO();
            Feedback feedback = dao.getFeedbackById(feedbackId, branchId);

            if (feedback == null) {
                String redirectUrl = "managerFeedbackServlet?page=" + (page != null ? page : "1")
                        + "&pageSize=" + (pageSize != null ? pageSize : "10")
                        + "&keyword=" + java.net.URLEncoder.encode(keyword != null ? keyword : "", "UTF-8")
                        + "&rating=" + (rating != null ? rating : "all")
                        + "&dateFilter=" + (dateFilter != null ? dateFilter : "all")
                        + "&poolId=" + (poolId != null ? poolId : "all")
                        + "&error=" + java.net.URLEncoder.encode("Feedback not found", "UTF-8");
                response.sendRedirect(redirectUrl);
                return;
            }

            if (feedback.getUserEmail() == null || feedback.getUserEmail().trim().isEmpty()) {
                request.setAttribute("feedback", feedback);
                request.setAttribute("errorMsg", "Email người nhận bị thiếu hoặc không hợp lệ!");
                request.getRequestDispatcher("managerReplyFeedback.jsp").forward(request, response);
                return;
            }

            String emailContent = EmailFeedbackUtil.createResponseTemplate(
                    feedback.getUserName(),
                    feedback.getPoolName(),
                    feedback.getComment(),
                    responseContent.trim()
            );

            boolean emailSent = EmailFeedbackUtil.sendEmail(
                    feedback.getUserEmail(),
                    subject.trim(),
                    emailContent
            );

            if (emailSent) {
                // Gọi update trạng thái đã phản hồi
                dao.markFeedbackReplied(feedbackId);
                
                String redirectUrl = "managerFeedbackServlet?page=" + (page != null ? page : "1")
                        + "&pageSize=" + (pageSize != null ? pageSize : "10")
                        + "&keyword=" + java.net.URLEncoder.encode(keyword != null ? keyword : "", "UTF-8")
                        + "&rating=" + (rating != null ? rating : "all")
                        + "&dateFilter=" + (dateFilter != null ? dateFilter : "all")
                        + "&poolId=" + (poolId != null ? poolId : "all")
                        + "&success=" + java.net.URLEncoder.encode("Đã gửi phản hồi thành công đến " + feedback.getUserEmail(), "UTF-8");
                response.sendRedirect(redirectUrl);
                return;
            } else {
                request.setAttribute("feedback", feedback);
                request.setAttribute("errorMsg", "Có lỗi xảy ra khi gửi email: " + EmailFeedbackUtil.getLastError());
                request.getRequestDispatcher("managerReplyFeedback.jsp").forward(request, response);
            }

        } catch (NumberFormatException | SQLException e) {
            String redirectUrl = "managerFeedbackServlet?page=" + (page != null ? page : "1")
                    + "&pageSize=" + (pageSize != null ? pageSize : "10")
                    + "&keyword=" + java.net.URLEncoder.encode(keyword != null ? keyword : "", "UTF-8")
                    + "&rating=" + (rating != null ? rating : "all")
                    + "&dateFilter=" + (dateFilter != null ? dateFilter : "all")
                    + "&poolId=" + (poolId != null ? poolId : "all")
                    + "&error=" + java.net.URLEncoder.encode("Lỗi: " + e.getMessage(), "UTF-8");
            response.sendRedirect(redirectUrl);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
