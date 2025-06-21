package controller.Customer;

import dao.customer.DiscountDetailDAO;
import model.customer.DiscountDetail;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;

public class VoucherDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        model.customer.User user = (session != null) ? (model.customer.User) session.getAttribute("currentUser") : null;
        Integer userId = (user != null) ? user.getUser_id(): null;
        String code = request.getParameter("code");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        if (code == null || code.trim().isEmpty()) {
            request.setAttribute("error", "Không tìm thấy mã voucher!");
            request.getRequestDispatcher("VoucherDetail.jsp").forward(request, response);
            return;
        }

        DiscountDetailDAO dao = new DiscountDetailDAO();
        try {
            DiscountDetail voucher = dao.getVoucherDetailByUserIdAndCode(userId, code);
            if (voucher == null) {
                request.setAttribute("error", "Không tìm thấy voucher này!");
            } else {
                request.setAttribute("voucher", voucher);
            }
        } catch (SQLException ex) {
            request.setAttribute("error", "Lỗi truy vấn dữ liệu.");
        }
        request.getRequestDispatcher("VoucherDetail.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
