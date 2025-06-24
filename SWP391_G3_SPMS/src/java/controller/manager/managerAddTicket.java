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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
import model.manager.PoolTicket;
import model.manager.TicketType;

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

        try {
            TicketTypeDAO dao = new TicketTypeDAO();
            List<PoolTicket> poolList = dao.getPoolsByBranch(branchId);
            List<TicketType> singleTypes = dao.getAllSingleTypes();
            request.setAttribute("poolList", poolList);
            request.setAttribute("singleTypes", singleTypes);
        } catch (SQLException ex) {
            request.setAttribute("error", "Lỗi truy vấn dữ liệu: " + ex.getMessage());
        }
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

        String ticketKind = request.getParameter("ticketKind");
        String[] poolIdsRaw = request.getParameterValues("poolIds");
        if (poolIdsRaw == null || poolIdsRaw.length == 0) {
            setErrorAndForward(request, response, branchId, "Vui lòng chọn ít nhất một hồ bơi!");
            return;
        }
        List<Integer> poolIds = new ArrayList<>();
        for (String pid : poolIdsRaw) {
            poolIds.add(Integer.parseInt(pid));
        }
        String error = null;
        try {
            TicketTypeDAO dao = new TicketTypeDAO();
            if ("single".equals(ticketKind)) {  // Vé đơn
                
                String typeCode = request.getParameter("typeCode");
                String typeName = request.getParameter("typeName");
                String description = request.getParameter("description");
                String basePriceRaw = request.getParameter("basePrice");
                double basePrice = basePriceRaw != null ? Double.parseDouble(basePriceRaw) : 0;
                if (typeCode == null || typeCode.trim().isEmpty()
                        || typeName == null || typeName.trim().isEmpty()) {
                    setErrorAndForward(request, response, branchId, "Vui lòng nhập đủ thông tin vé đơn!");
                    return;
                }
                
                int ticketTypeId = dao.addTicketType(typeCode, typeName, description, basePrice, false);
                dao.addTicketTypeToPools(ticketTypeId, poolIds, "active");
                
            } else if ("combo".equals(ticketKind)) {   // Vé combo
                
                String typeCode = request.getParameter("typeCode");
                String typeName = request.getParameter("typeName");
                String description = request.getParameter("description");
                double discountPercent = Double.parseDouble(Optional.ofNullable(request.getParameter("discountPercent")).orElse("0"));
                double finalComboPrice = Double.parseDouble(Optional.ofNullable(request.getParameter("finalComboPrice")).orElse("0"));
                
                Map<Integer, Integer> comboMap = new HashMap<>();
                List<TicketType> singleTypes = new TicketTypeDAO().getAllSingleTypes();
                
                for (TicketType single : singleTypes) {
                    String qtyStr = request.getParameter("comboQty_" + single.getId());
                    int qty = qtyStr == null ? 0 : Integer.parseInt(qtyStr);
                    if (qty > 0) {
                        comboMap.put(single.getId(), qty);
                    }
                }
                if (typeCode == null || typeCode.trim().isEmpty()
                        || typeName == null || typeName.trim().isEmpty()
                        || comboMap.isEmpty()) {
                    setErrorAndForward(request, response, branchId, "Vui lòng nhập đủ thông tin combo!");
                    return;
                }
                int comboTypeId = dao.addTicketType(typeCode, typeName, description, finalComboPrice, true, discountPercent);
                dao.addTicketTypeToPools(comboTypeId, poolIds, "active");
                // Thêm vào Combo_Detail (combo_type_id, included_type_id, quantity)
                dao.addComboDetail(comboTypeId, comboMap);
                
            } else {
                setErrorAndForward(request, response, branchId, "Loại vé không hợp lệ!");
                return;
            }

            // Lấy lại filter và đưa về trang cuối khi thêm thành công
            String keyword = Optional.ofNullable(request.getParameter("keyword")).orElse("");
            String status = Optional.ofNullable(request.getParameter("status")).orElse("all");
            String poolId = Optional.ofNullable(request.getParameter("poolId")).orElse("all");
            String pageSizeRaw = Optional.ofNullable(request.getParameter("pageSize")).orElse("5");

            int pageSize = 5;
            try {
                pageSize = Integer.parseInt(pageSizeRaw);
            } catch (Exception e) {
                pageSize = 5;
            }

            int total = dao.countTicketsByBranch(branchId, poolId, status, keyword);
            int endPage = total / pageSize;
            if (total % pageSize != 0) {
                endPage++;
            }
            if (endPage < 1) {
                endPage = 1;
            }

            String redirectUrl = String.format(
                    "managerTicketServlet?page=%d&pageSize=%d&keyword=%s&status=%s&poolId=%s&success=1",
                    endPage, pageSize, java.net.URLEncoder.encode(keyword, "UTF-8"), status, poolId
            );
            // Chuyển về danh sách vé với thông báo thành công
            response.sendRedirect(redirectUrl);

        } catch (Exception ex) {

            String msg = ex.getMessage();
            if (msg != null && msg.contains("UNIQUE") && msg.contains("Ticket_Types")) {
                setErrorAndForward(request, response, branchId, "Mã loại vé này đã tồn tại. Vui lòng chọn mã khác!");
                return;
            }
            setErrorAndForward(request, response, branchId, "Lỗi: " + ex.getMessage());
        }
    }

    private int getBranchId(int userId) {
        switch (userId) {
            case 2:
                return 1;
            case 3:
                return 2;
            case 4:
                return 3;
            case 5:
                return 4;
            case 6:
                return 5;
            default:
                return 0;
        }
    }

    private void setErrorAndForward(HttpServletRequest request, HttpServletResponse response, int branchId, String error)
            throws ServletException, IOException {
        try {
            TicketTypeDAO dao = new TicketTypeDAO();
            request.setAttribute("poolList", dao.getPoolsByBranch(branchId));
            request.setAttribute("singleTypes", dao.getAllSingleTypes());
        } catch (SQLException ex) {
        }
        request.setAttribute("error", error);
        request.getRequestDispatcher("managerAddTicket.jsp").forward(request, response);

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
