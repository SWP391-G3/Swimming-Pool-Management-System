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
import java.util.List;
import model.manager.Device;
import model.manager.Pool;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "ListDeviceServlet", urlPatterns = {"/ListDeviceServlet"})
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

    private static final int PAGE_SIZE = 5;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DeviceDao deviceDAO = new DeviceDao();
        int branchId = 1;

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
                request.getRequestDispatcher("managerDevice.jsp").forward(request, response);
                return;
            }
        }

        int count = deviceDAO.countDevicesWithPool(keyword, status, branchId, poolId);
        int endPage = count / PAGE_SIZE;
        if (count % PAGE_SIZE != 0) {
            endPage++;
        }

        List<Device> devices = deviceDAO.getDevicesByPageAndPool(keyword, status, page, PAGE_SIZE, branchId, poolId);
        List<Pool> poolList = deviceDAO.getPoolsByBranchId(branchId);

        request.setAttribute("devices", devices);
        request.setAttribute("endP", endPage);
        request.setAttribute("page", page);
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        request.setAttribute("poolId", poolIdParam);
        request.setAttribute("poolList", poolList);
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
