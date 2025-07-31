/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dao.manager.DiscountDAO;
import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import model.customer.User;
import model.manager.Discount;
import okhttp3.Connection;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "ManagerDiscountServlet", urlPatterns = {"/managerDiscountServlet"})
public class ManagerDiscountServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ManagerDiscountServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ManagerDiscountServlet at " + request.getContextPath() + "</h1>");
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

        //  Bỏ xác định branchId, voucher áp dụng toàn hệ thống 
        String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
        String status = request.getParameter("status") != null ? request.getParameter("status") : "all";
        String fromDateStr = request.getParameter("fromDate");
        String toDateStr = request.getParameter("toDate");
        String pageSizeStr = request.getParameter("pageSize");
        String pageStr = request.getParameter("page");

        int pageSize = 5, page = 1;
        try {
            if (pageSizeStr != null) {
                pageSize = Integer.parseInt(pageSizeStr);
            }
        } catch (Exception e) {
        }
        try {
            if (pageStr != null) {
                page = Integer.parseInt(pageStr);
            }
        } catch (Exception e) {
        }

        Date fromDate = null, toDate = null;
        try {
            if (fromDateStr != null && !fromDateStr.isEmpty()) {
                fromDate = new SimpleDateFormat("yyyy-MM-dd").parse(fromDateStr);
            }
        } catch (Exception e) {
        }
        try {
            if (toDateStr != null && !toDateStr.isEmpty()) {
                toDate = new SimpleDateFormat("yyyy-MM-dd").parse(toDateStr);
            }
        } catch (Exception e) {
        }

        try {
            DiscountDAO discountDAO = new DiscountDAO();
            int totalDiscounts = discountDAO.countDiscounts(keyword, status, fromDate, toDate);
            List<Discount> discountList = discountDAO.getDiscountList(keyword, status, fromDate, toDate, page, pageSize);
            int endP = (int) Math.ceil((double) totalDiscounts / pageSize);

            request.setAttribute("discountList", discountList);
            request.setAttribute("keyword", keyword);
            request.setAttribute("status", status);
            request.setAttribute("fromDate", fromDateStr);
            request.setAttribute("toDate", toDateStr);
            request.setAttribute("page", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("endP", endP);

            // Forward đúng đường dẫn JSP
            request.getRequestDispatcher("managerDiscount.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Lỗi khi lấy danh sách voucher");
            // Forward đúng trang error (tạo file này hoặc sửa lại đường dẫn)
            //request.getRequestDispatcher("/error.jsp").forward(request, response);
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
        // </editor-fold>

    }
}
