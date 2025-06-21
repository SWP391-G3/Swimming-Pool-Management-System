/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dao.manager.TicketTypeDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Optional;
import model.manager.PoolTicket;
import model.User;
import model.manager.TicketType;

/**
 *
 * @author Tuan Anh
 */
public class managerTicketServlet extends HttpServlet {

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
            out.println("<title>Servlet managerTicketServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet managerTicketServlet at " + request.getContextPath() + "</h1>");
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

        // Lấy filter từ request
        String keyword = Optional.ofNullable(request.getParameter("keyword")).orElse("").trim();
        String status = Optional.ofNullable(request.getParameter("status")).orElse("all");
        String poolIdRaw = Optional.ofNullable(request.getParameter("poolId")).orElse("all");
        String pageParam = request.getParameter("page");
        String pageSizeParam = request.getParameter("pageSize");

        String success = request.getParameter("success");
        if ("1".equals(success)) {
            request.setAttribute("success", "Thêm loại vé thành công!");
        }

        // Xử lý phân trang
        int defaultPageSize = 5;
        int pageSize = defaultPageSize;
        if (pageSizeParam != null) {
            try {
                pageSize = Integer.parseInt(pageSizeParam);
                if (pageSize != 5 && pageSize != 10 && pageSize != 15 && pageSize != 25) {
                    pageSize = defaultPageSize;
                }
            } catch (NumberFormatException e) {
                pageSize = defaultPageSize;
            }
        }
        int page = 1;
        try {
            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }
        if (page < 1) {
            page = 1;
        }
        int offset = (page - 1) * pageSize;

        try {
            TicketTypeDAO dao = new TicketTypeDAO();

            // Đếm tổng số vé phù hợp filter để tính tổng số trang
            int total = dao.countTicketsByBranch(branchId, poolIdRaw, status, keyword);
            int endP = total / pageSize;
            if (total % pageSize != 0) {
                endP++;
            }

            // Lấy danh sách vé cho trang hiện tại
            List<TicketType> ticketList = dao.filterTicketsByBranch(branchId, poolIdRaw, status, keyword, offset, pageSize);
            List<PoolTicket> poolList = dao.getPoolsByBranch(branchId);

            // Truyền dữ liệu xuống JSP
            request.setAttribute("ticketList", ticketList);
            request.setAttribute("poolList", poolList);
            request.setAttribute("keyword", keyword);
            request.setAttribute("status", status);
            request.setAttribute("poolId", poolIdRaw);
            request.setAttribute("page", page);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("endP", endP);
            request.setAttribute("total", total);

            request.getRequestDispatcher("managerTicket.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Lỗi truy vấn dữ liệu: " + ex.getMessage());
            request.getRequestDispatcher("managerTicket.jsp").forward(request, response);
        }
    }

    private int parseIntOrDefault(String val, int def) {
        try {
            return Integer.parseInt(val);
        } catch (Exception e) {
            return def;
        }
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
