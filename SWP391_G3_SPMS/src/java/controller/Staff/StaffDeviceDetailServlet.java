/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.Staff;

import dao.manager.DeviceDao;
import dao.staff.StaffDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.customer.User;
import model.manager.Device;
import model.manager.Staff;

@WebServlet(name="StaffDeviceDetailServlet", urlPatterns={"/staffDeviceDetailServlet"})
public class StaffDeviceDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        int id = Integer.parseInt(idStr);

        DeviceDao dao = new DeviceDao();
        Device device = dao.getDeviceById(id);
        request.setAttribute("device", device);

        request.getRequestDispatcher("staffDeviceDetail.jsp").forward(request, response);
    }
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy thông tin gửi từ form
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        int deviceId = Integer.parseInt(request.getParameter("deviceId"));
        String deviceName = request.getParameter("deviceName");
        int poolId = Integer.parseInt(request.getParameter("poolId"));
           int branchId = 0;
        String poolName = null;
         StaffDAO staffDAO = new StaffDAO(); // hoặc inject qua DI
            Staff staff = staffDAO.getStaffById(currentUser.getUser_id());
        if (currentUser != null) {
           
            if (staff != null) {
                branchId = staff.getBranchId();
                poolName = staff.getPoolName();
                // Hoặc lấy luôn branchName nếu cần
            } else {
                // Xử lý trường hợp không tìm thấy staff
            }
        }
        String reportReason = request.getParameter("reportReason");
        String suggestion = request.getParameter("suggestion");

        // Lấy user hiện tại từ session
        
        int staffId = currentUser.getUser_id();

        // Lưu báo cáo
        StaffDAO staffDao = new StaffDAO();
        boolean success = staffDao.addDeviceReport(
                staffId, poolId, branchId, deviceId, deviceName, reportReason, suggestion
        );

        // Load lại thông tin thiết bị để hiển thị
        DeviceDao deviceDao = new DeviceDao();
        Device device = deviceDao.getDeviceById(deviceId);
        request.setAttribute("device", device);

        // Gửi thông báo trạng thái gửi báo cáo
        String message = success ? "Gửi báo cáo thành công!" : "Đã xảy ra lỗi, vui lòng thử lại.";
        request.setAttribute("reportMessage", message);

        // Forward lại trang detail
        request.getRequestDispatcher("staffDeviceDetail.jsp").forward(request, response);
    }
}
