/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.manager;

import dao.manager.DeviceDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import model.User;
import model.manager.Device;
import model.manager.Pooldevice;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "ListDeviceServlet", urlPatterns = {"/managerListDeviceServlet"})
public class ListDeviceServlet extends HttpServlet {

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

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ListDeviceServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ListDeviceServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        int branchId = 0;
        if (currentUser != null) {
            int currentUser_id = currentUser.getUser_id();
            switch (currentUser_id) {
                case 2:
                    branchId = 1; // hà nội
                    break;
                case 3:
                    branchId = 2; // hồ chí minh
                    break;
                case 4:
                    branchId = 3; // đà nẵng
                    break;
                case 5:
                    branchId = 4; // quy nhơn
                    break;
                case 6:
                    branchId = 5; // cần thơ
                    break;
                default:
                    throw new AssertionError();
            }
        }
        int defaultPageSize = 5;
        int pageSize = defaultPageSize;
        String pageSizeParam = request.getParameter("pageSize");
        if (pageSizeParam != null) {
            try {
                pageSize = Integer.parseInt(pageSizeParam);
                if (pageSize != 5 && pageSize != 10 && pageSize != 15) {
                    pageSize = defaultPageSize;
                }
            } catch (NumberFormatException e) {
                pageSize = defaultPageSize;
            }
        }

        DeviceDao deviceDAO = new DeviceDao();


        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String index = request.getParameter("page");
        String poolIdParam = request.getParameter("poolId");
        if (poolIdParam != null) {
            poolIdParam = poolIdParam.trim();
        }
        int page = 1;
        Integer poolId = null;

        try {
            if (index != null) {
                page = Integer.parseInt(index);
            }
        } catch (NumberFormatException e) {
            page = 1;
        }

        if (poolIdParam != null && !poolIdParam.isEmpty()) {
            try {
                poolId = Integer.parseInt(poolIdParam);
            } catch (NumberFormatException e) {
                poolId = null;
            }
        }

        if (keyword != null) {
            keyword = keyword.trim();
            if (!keyword.isEmpty() && !keyword.matches("[a-zA-Z0-9\\sÀ-ỹ]+")) {
                request.setAttribute("error", "Từ khóa tìm kiếm không hợp lệ (không chứa ký tự đặc biệt)");
                request.setAttribute("pageSize", pageSize); // Truyền lại pageSize khi báo lỗi
                request.getRequestDispatcher("managerDevice.jsp").forward(request, response);
                return;
            }
        }

        int count = deviceDAO.countDevicesWithPool(keyword, status, branchId, poolId);
        int endPage = count / pageSize;
        if (count % pageSize != 0) {
            endPage++;
        }

        List<Device> devices = deviceDAO.getDevicesByPageAndPool(keyword, status, page, pageSize, branchId, poolId);
        List<Pooldevice> poolList = deviceDAO.getPoolsByBranchId(branchId);

        request.setAttribute("devices", devices);
        request.setAttribute("endP", endPage);
        request.setAttribute("page", page);
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        request.setAttribute("poolId", poolIdParam);
        request.setAttribute("poolList", poolList);
        request.setAttribute("pageSize", pageSize); // Bổ sung dòng này để truyền pageSize về JSP
        request.getRequestDispatcher("managerDevice.jsp").forward(request, response);
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
