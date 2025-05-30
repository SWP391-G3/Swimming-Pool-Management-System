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
            /* TODO output your page here. You may use following sample code. */
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
            case "edit":
                int editId = Integer.parseInt(request.getParameter("id"));
                Device device = deviceDAO.getDeviceById(editId);
                List<Pool> pools = deviceDAO.getAllPools();
                request.setAttribute("device", device);
                request.setAttribute("poolList", pools);
                request.getRequestDispatcher("editDevice.jsp").forward(request, response);
                break;
            default:
                String keyword = request.getParameter("keyword");
                String status = request.getParameter("status");
                List<Device> devices = deviceDAO.getAllDevices(keyword, status);
                request.setAttribute("devices", devices);
                request.getRequestDispatcher("managerDevice.jsp").forward(request, response);
        }

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        DeviceDao deviceDAO = new DeviceDao();
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            Device device = new Device();
            device.setPoolId(Integer.parseInt(request.getParameter("poolId")));
            device.setDeviceImage(request.getParameter("deviceImage"));
            device.setDeviceName(request.getParameter("deviceName"));
            device.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            device.setDeviceStatus(request.getParameter("deviceStatus"));
            device.setNotes(request.getParameter("notes"));
            deviceDAO.addDevice(device);
            response.sendRedirect("DeviceServlet");
        } else if ("edit".equals(action)) {
            Device device = new Device();
            device.setDeviceId(Integer.parseInt(request.getParameter("deviceId")));
            device.setPoolId(Integer.parseInt(request.getParameter("poolId")));
            device.setDeviceImage(request.getParameter("deviceImage"));
            device.setDeviceName(request.getParameter("deviceName"));
            device.setQuantity(Integer.parseInt(request.getParameter("quantity")));
            device.setDeviceStatus(request.getParameter("deviceStatus"));
            device.setNotes(request.getParameter("notes"));
            deviceDAO.updateDevice(device);
            response.sendRedirect("DeviceServlet");
        } else if ("delete".equals(action)) {
            int deviceId = Integer.parseInt(request.getParameter("deviceId"));
            deviceDAO.deleteDevice(deviceId);
            response.sendRedirect("DeviceServlet");
        }

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
