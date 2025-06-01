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
@WebServlet(name = "DeviceServlet", urlPatterns = {"/DeviceServlet"})
public class DeviceServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DeviceServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeviceServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        DeviceDao deviceDAO = new DeviceDao();

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                List<Pool> poolList = deviceDAO.getAllPools();
                request.setAttribute("poolList", poolList);
                request.getRequestDispatcher("addDevice.jsp").forward(request, response);
                break;

            case "update":
                String id = request.getParameter("id");
                int updateId = Integer.parseInt(id);
                Device device = deviceDAO.getDeviceById(updateId);
                List<Pool> poolList2 = deviceDAO.getAllPools();
                request.setAttribute("device", device);
                request.setAttribute("poolList", poolList2);
                request.getRequestDispatcher("updateDevice.jsp").forward(request, response);
                break;

            default: {
                String keyword = request.getParameter("keyword");
                String status = request.getParameter("status");
                String index = request.getParameter("page");
                int page = 1;
                try {
                    if (index != null) {
                        page = Integer.parseInt(index);
                    }
                } catch (NumberFormatException e) {
                    page = 1;
                }

                int count = deviceDAO.countDevices(keyword, status);
                int endPage = count / 6;           // Tính số lượng trang
                if (count % 6 != 0) {
                    endPage++;
                }

                List<Device> devices = deviceDAO.getDevicesByPage(keyword, status, page);
                request.setAttribute("devices", devices);
                request.setAttribute("endP", endPage);
                request.setAttribute("page", page);
                request.setAttribute("keyword", keyword);
                request.setAttribute("status", status);
                request.getRequestDispatcher("managerDevice.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DeviceDao deviceDAO = new DeviceDao();
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            try {
                int poolId = Integer.parseInt(request.getParameter("poolId"));
                String deviceImage = request.getParameter("deviceImage");
                String deviceName = request.getParameter("deviceName");
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                String deviceStatus = request.getParameter("deviceStatus");
                String notes = request.getParameter("notes");

                Device device = new Device();

                device.setPoolId(poolId);
                device.setDeviceImage(deviceImage);
                device.setDeviceName(deviceName);
                device.setQuantity(quantity);
                device.setDeviceStatus(deviceStatus);
                device.setNotes(notes);

                deviceDAO.addDevice(device);
                response.sendRedirect("DeviceServlet");

            } catch (NumberFormatException e) {
                request.setAttribute("error", "Số lượng hoặc Pool ID không hợp lệ");
                request.getRequestDispatcher("addDevice.jsp").forward(request, response);
            }

        } else if ("update".equals(action)) {
            try {
                int deviceId = Integer.parseInt(request.getParameter("deviceId"));
                int poolId = Integer.parseInt(request.getParameter("poolId"));
                String deviceImage = request.getParameter("deviceImage");
                String deviceName = request.getParameter("deviceName");
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                String deviceStatus = request.getParameter("deviceStatus");
                String notes = request.getParameter("notes");

                Device device = new Device();
                device.setDeviceId(deviceId);
                device.setPoolId(poolId);
                device.setDeviceImage(deviceImage);
                device.setDeviceName(deviceName);
                device.setQuantity(quantity);
                device.setDeviceStatus(deviceStatus);
                device.setNotes(notes);

                deviceDAO.updateDevice(device);
                response.sendRedirect("DeviceServlet");

            } catch (NumberFormatException e) {
                request.setAttribute("error", "Thiết bị hoặc dữ liệu số không hợp lệ");
                request.getRequestDispatcher("updateDevice.jsp").forward(request, response);
            }

        } else if ("delete".equals(action)) {
            try {
                int deviceId = Integer.parseInt(request.getParameter("deviceId"));
                deviceDAO.deleteDevice(deviceId);
                response.sendRedirect("DeviceServlet");

            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID thiết bị không hợp lệ");
                request.getRequestDispatcher("DeviceServlet").forward(request, response);
            }
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
