/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dao.manager.TicketTypeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
import model.manager.PoolTicket;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "managerAddTicket", urlPatterns = {"/managerAddTicket"})
public class managerAddTicket extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet managerAddTicket</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet managerAddTicket at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

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

        List<PoolTicket> poolList = new ArrayList<>();
        try {
            TicketTypeDAO dao = new TicketTypeDAO();
            poolList = dao.getPoolsByBranch(branchId);
        } catch (SQLException ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Lỗi truy vấn hồ bơi: " + ex.getMessage());
        }

        request.setAttribute("poolList", poolList);
        request.getRequestDispatcher("managerAddTicket.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

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

        // Lấy dữ liệu từ form
        String typeCode = request.getParameter("typeCode");
        String typeName = request.getParameter("typeName");
        String description = request.getParameter("description");
        String basePriceRaw = request.getParameter("basePrice");
        String isComboRaw = request.getParameter("isCombo");
        String[] poolIdsRaw = request.getParameterValues("poolIds");
        String status = "active"; // mặc định

        // Validate dữ liệu
        String error = null;
        double basePrice = 0;
        boolean isCombo = "1".equals(isComboRaw);
        List<Integer> poolIds = new ArrayList<>();
        if (typeCode == null || typeCode.trim().isEmpty()
                || typeName == null || typeName.trim().isEmpty()
                || basePriceRaw == null || basePriceRaw.trim().isEmpty()
                || poolIdsRaw == null || poolIdsRaw.length == 0) {
            error = "Vui lòng nhập đầy đủ các trường bắt buộc!";
        } else {
            try {
                basePrice = Double.parseDouble(basePriceRaw);
                if (basePrice < 0) {
                    error = "Giá vé không được âm!";
                }
                for (String pid : poolIdsRaw) {
                    poolIds.add(Integer.parseInt(pid));
                }
            } catch (Exception e) {
                error = "Dữ liệu không hợp lệ!";
            }
        }

        if (error != null) {
            List<PoolTicket> poolList = new ArrayList<>();
            try {
                poolList = new TicketTypeDAO().getPoolsByBranch(branchId);
            } catch (SQLException ex) {
                ex.printStackTrace();
                request.setAttribute("error", "Lỗi truy vấn hồ bơi: " + ex.getMessage());
            }
            request.setAttribute("poolList", poolList);
            request.setAttribute("error", error);
            request.getRequestDispatcher("managerAddTicket.jsp").forward(request, response);
            return;
        }

        try {
            TicketTypeDAO dao = new TicketTypeDAO();
            int ticketTypeId = dao.addTicketType(typeCode, typeName, description, basePrice, isCombo);
            dao.addTicketTypeToPools(ticketTypeId, poolIds, status);

            // Lấy lại filter từ form
            String poolId = request.getParameter("poolId") != null ? request.getParameter("poolId") : "all";
            String statusF = request.getParameter("status") != null ? request.getParameter("status") : "all";
            String keyword = request.getParameter("keyword") != null ? request.getParameter("keyword") : "";
            String pageSizeRaw = request.getParameter("pageSize");
            int pageSize = 5;
            try {
                pageSize = Integer.parseInt(pageSizeRaw);
            } catch (Exception e) {
                pageSize = 5;
            }

            int total = dao.countTicketsByBranch(branchId, poolId, statusF, keyword);

            int endP = total / pageSize;
            if (total % pageSize != 0) {
                endP++;
            }
            if (endP < 1) {
                endP = 1;
            }

            String redirectUrl = String.format(
                    "managerTicketServlet?page=%d&pageSize=%d&keyword=%s&status=%s&poolId=%s&success=1",
                    endP, pageSize, java.net.URLEncoder.encode(keyword, "UTF-8"), statusF, poolId
            );
            response.sendRedirect(redirectUrl);

        } catch (Exception e) {
            e.printStackTrace();
            List<PoolTicket> poolList = new ArrayList<>();
            try {
                poolList = new TicketTypeDAO().getPoolsByBranch(branchId);
            } catch (SQLException ex) {
                ex.printStackTrace();
                request.setAttribute("error", "Lỗi truy vấn hồ bơi: " + ex.getMessage());
            }
            request.setAttribute("poolList", poolList);
            request.setAttribute("error", "Lỗi khi thêm loại vé: " + e.getMessage());
            request.getRequestDispatcher("managerAddTicket.jsp").forward(request, response);
        }

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
