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
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Part;

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 1024 * 1024 * 5, // 5MB
        maxRequestSize = 1024 * 1024 * 10 // 10MB
)
/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "AddDeviceServlet", urlPatterns = {"/managerAddDeviceServlet"})
public class AddDeviceServlet extends HttpServlet {

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
        DeviceDao deviceDAO = new DeviceDao();
        List<Pooldevice> poolList = deviceDAO.getPoolsByBranchId(branchId);
        request.setAttribute("poolList", poolList);

        String poolId = request.getParameter("poolId");
        if (poolId != null) {
            poolId = poolId.trim();
            if (poolId.isEmpty()) {
                poolId = null;
            }
        }
        request.setAttribute("poolId", poolId);

        String keyword = request.getParameter("keyword");
        if (keyword != null) {
            keyword = keyword.trim();
            if (keyword.isEmpty()) {
                keyword = null;
            }
        }
        request.setAttribute("keyword", keyword);

        String status = request.getParameter("status");
        if (status != null) {
            status = status.trim();
            if (status.isEmpty()) {
                status = null;
            }
        }
        request.setAttribute("status", status);

        String page = request.getParameter("page");
        if (page != null) {
            page = page.trim();
            if (page.isEmpty()) {
                page = null;
            }
        }
        request.setAttribute("page", page);

        String pageSize = request.getParameter("pageSize");
        if (pageSize != null) {
            pageSize = pageSize.trim();
            if (pageSize.isEmpty()) {
                pageSize = null;
            }
        }
        request.setAttribute("pageSize", pageSize);

        request.getRequestDispatcher("managerAddDevice.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int branchId = 1;
        DeviceDao deviceDAO = new DeviceDao();

        String returnPoolId = request.getParameter("returnPoolId");
        if (returnPoolId != null) {
            returnPoolId = returnPoolId.trim();
            if (returnPoolId.isEmpty()) {
                returnPoolId = null;
            }
        }

        String returnKeyword = request.getParameter("returnKeyword");
        if (returnKeyword != null) {
            returnKeyword = returnKeyword.trim();
            if (returnKeyword.isEmpty()) {
                returnKeyword = null;
            }
        }

        String returnStatus = request.getParameter("returnStatus");
        if (returnStatus != null) {
            returnStatus = returnStatus.trim();
            if (returnStatus.isEmpty()) {
                returnStatus = null;
            }
        }

        String returnPage = request.getParameter("returnPage");
        if (returnPage != null) {
            returnPage = returnPage.trim();
            if (returnPage.isEmpty()) {
                returnPage = null;
            }
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

        Integer filterPoolId = (returnPoolId != null) ? Integer.parseInt(returnPoolId) : null;

        try {
            int poolId = Integer.parseInt(request.getParameter("poolId"));
            String name = request.getParameter("deviceName");
            String image = request.getParameter("deviceImage");
            String status = request.getParameter("deviceStatus");
            String notes = request.getParameter("notes");
            int quantity = Integer.parseInt(request.getParameter("quantity"));

            if (name == null || !name.matches("[a-zA-Z0-9\\sÀ-ỹ]+")) {
                request.setAttribute("error", "Tên thiết bị không được chứa ký tự đặc biệt.");
                request.setAttribute("poolList", deviceDAO.getPoolsByBranchId(branchId));
                request.setAttribute("poolId", returnPoolId);
                request.setAttribute("keyword", returnKeyword);
                request.setAttribute("status", returnStatus);
                request.setAttribute("page", returnPage);
                request.setAttribute("pageSize", pageSize);
                request.getRequestDispatcher("managerAddDevice.jsp").forward(request, response);
                return;
            }

            // Lấy file upload
            Part filePart = request.getPart("deviceImageFile");
            String fileName = null;
            String imagePath = null;
            if (filePart != null && filePart.getSize() > 0) {
                fileName = java.nio.file.Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                // Đường dẫn thư mục lưu file (tùy chỉnh path này cho phù hợp dự án của bạn)
                String uploadDir = getServletContext().getRealPath("/uploads/devices");
                java.io.File dir = new java.io.File(uploadDir);
                if (!dir.exists()) {
                    dir.mkdirs();
                }
                String filePath = uploadDir + java.io.File.separator + fileName;
                filePart.write(filePath);
                imagePath = "uploads/devices/" + fileName; // Đường dẫn lưu vào DB để sử dụng trong src=
            }

            //Device d = new Device(0, image, name, poolId, null, quantity, status, notes);
            Device d = new Device(0, imagePath, name, poolId, null, quantity, status, notes);
            deviceDAO.addDevice(d);

            int count = deviceDAO.countDevicesWithPool(
                    returnKeyword, returnStatus, branchId, filterPoolId);

            int endPage = count / pageSize;
            if (count % pageSize != 0) {
                endPage++;
            }

            String redirectUrl = "managerListDeviceServlet?page=" + endPage;

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
            request.setAttribute("error", "Tên thiết bị không được chứa ký tự đặc biệt.");
            request.setAttribute("poolList", deviceDAO.getPoolsByBranchId(branchId));
            request.setAttribute("poolId", returnPoolId);
            request.setAttribute("keyword", returnKeyword);
            request.setAttribute("status", returnStatus);
            request.setAttribute("page", returnPage);
            request.setAttribute("pageSize", pageSize);
            request.getRequestDispatcher("managerAddDevice.jsp").forward(request, response);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
