package controller.manager;

import dao.manager.DiscountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.customer.User;

@WebServlet(name = "ManagerDeleteDiscountServlet", urlPatterns = {"/managerDeleteDiscountServlet"})
public class ManagerDeleteDiscountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Lấy user hiện tại
        User currentUser = (User) session.getAttribute("managerAccount");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int managerId = currentUser.getUser_id(); // hoặc getId() tùy model

        String idRaw = request.getParameter("id");
        String page = request.getParameter("page");
        String pageSize = request.getParameter("pageSize");
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");

        try {
            int id = Integer.parseInt(idRaw);
            DiscountDAO dao = new DiscountDAO();
            // Kiểm tra quyền trước khi xóa
            boolean canEdit = dao.canManagerEditDiscount(id, managerId);
            if (!canEdit) {
                session.setAttribute("error", "Bạn không phải người tạo mã giảm giá này, không có quyền xóa!");
            } else {
                boolean success = dao.deleteDiscount(id, managerId);
                if (success) {
                    session.setAttribute("success", "Xóa mã giảm giá thành công!");
                } else {
                    session.setAttribute("error", "Không thể xóa mã giảm giá (có thể đã bị xóa hoặc lỗi hệ thống)!");
                }
            }
        } catch (Exception e) {
            session.setAttribute("error", "ID không hợp lệ hoặc lỗi hệ thống!");
        }

        String redirectUrl = "managerDiscountServlet?page=" + (page != null ? page : "1")
                + "&pageSize=" + (pageSize != null ? pageSize : "10")
                + "&keyword=" + (keyword != null ? keyword : "")
                + "&status=" + (status != null ? status : "all");

        response.sendRedirect(redirectUrl);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // Xử lý giống GET
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}