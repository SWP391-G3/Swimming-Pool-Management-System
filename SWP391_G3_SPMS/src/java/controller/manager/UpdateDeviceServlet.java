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
import model.manager.Device;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "UpdateDeviceServlet", urlPatterns = {"/UpdateDeviceServlet"})
public class UpdateDeviceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // fix lỗi git
        int branchId = 1;
        String idRaw = request.getParameter("id");
        int id = (idRaw != null && !idRaw.trim().isEmpty()) ? Integer.parseInt(idRaw.trim()) : 0;

        DeviceDao dao = new DeviceDao();
        Device d = dao.getDeviceById(id);
        request.setAttribute("device", d);
        request.setAttribute("poolList", dao.getPoolsByBranchId(branchId));

        String poolId = request.getParameter("poolId");
        if (poolId != null) {
            poolId = poolId.trim();
            if (poolId.isEmpty()) poolId = null;
        }
        request.setAttribute("poolId", poolId);

        String keyword = request.getParameter("keyword");
        if (keyword != null) {
            keyword = keyword.trim();
            if (keyword.isEmpty()) keyword = null;
        }
        request.setAttribute("keyword", keyword);

        String status = request.getParameter("status");
        if (status != null) {
            status = status.trim();
            if (status.isEmpty()) status = null;
        }
        request.setAttribute("status", status);

        String page = request.getParameter("page");
        if (page != null) {
            page = page.trim();
            if (page.isEmpty()) page = null;
        }
        request.setAttribute("page", page);

        String pageSize = request.getParameter("pageSize");
        if (pageSize != null) {
            pageSize = pageSize.trim();
            if (pageSize.isEmpty()) pageSize = null;
        }
        request.setAttribute("pageSize", pageSize);

        request.getRequestDispatcher("updateDevice.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int branchId = 1;
        DeviceDao dao = new DeviceDao();

        String returnPoolId = request.getParameter("returnPoolId");
        if (returnPoolId != null) {
            returnPoolId = returnPoolId.trim();
            if (returnPoolId.isEmpty()) returnPoolId = null;
        }

        String returnKeyword = request.getParameter("returnKeyword");
        if (returnKeyword != null) {
            returnKeyword = returnKeyword.trim();
            if (returnKeyword.isEmpty()) returnKeyword = null;
        }

        String returnStatus = request.getParameter("returnStatus");
        if (returnStatus != null) {
            returnStatus = returnStatus.trim();
            if (returnStatus.isEmpty()) returnStatus = null;
        }

        String returnPage = request.getParameter("returnPage");
        if (returnPage != null) {
            returnPage = returnPage.trim();
            if (returnPage.isEmpty()) returnPage = null;
        }

        String pageSizeParam = request.getParameter("pageSize");
        int pageSize = 5;
        if (pageSizeParam != null) {
            try {
                pageSize = Integer.parseInt(pageSizeParam.trim());
                if (pageSize != 5 && pageSize != 10 && pageSize != 20) {
                    pageSize = 5;
                }
            } catch (NumberFormatException e) {
                pageSize = 5;
            }
        }

        try {
            int id = Integer.parseInt(request.getParameter("deviceId"));
            int poolId = Integer.parseInt(request.getParameter("poolId"));
            String name = request.getParameter("deviceName");
            String image = request.getParameter("deviceImage");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String status = request.getParameter("deviceStatus");
            String notes = request.getParameter("notes");

            if (name == null || !name.matches("[a-zA-Z0-9\\sÀ-ỹ]+")) {
                request.setAttribute("error", "Tên thiết bị không hợp lệ.");
                request.setAttribute("device", dao.getDeviceById(id));
                request.setAttribute("poolList", dao.getPoolsByBranchId(branchId));
                request.setAttribute("poolId", returnPoolId);
                request.setAttribute("keyword", returnKeyword);
                request.setAttribute("status", returnStatus);
                request.setAttribute("page", returnPage);
                request.setAttribute("pageSize", pageSize);
                request.getRequestDispatcher("updateDevice.jsp").forward(request, response);
                return;
            }

            Device d = new Device(id, image, name, poolId, null, quantity, status, notes);
            dao.updateDevice(d);

            String redirectUrl = "ListDeviceServlet?page=" + (returnPage != null ? returnPage : "1");

            if (returnPoolId != null) {
                redirectUrl += "&poolId=" + returnPoolId;
            }
            if (returnKeyword != null) {
                redirectUrl += "&keyword=" + java.net.URLEncoder.encode(returnKeyword, "UTF-8");
            }
            if (returnStatus != null) {
                redirectUrl += "&status=" + returnStatus;
            }
            redirectUrl += "&pageSize=" + pageSize;

            response.sendRedirect(redirectUrl);

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Dữ liệu không hợp lệ.");
            request.setAttribute("poolId", returnPoolId);
            request.setAttribute("keyword", returnKeyword);
            request.setAttribute("status", returnStatus);
            request.setAttribute("page", returnPage);
            request.setAttribute("pageSize", pageSize);
            request.getRequestDispatcher("updateDevice.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}