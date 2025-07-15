package controller.staff;

import dao.manager.DeviceDao;
import dao.staff.StaffDAO;
import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.customer.User;
import model.manager.Device;
import model.manager.Pooldevice;
import model.manager.Staff;

@WebServlet("/staffListDeviceServlet")
public class StaffListDeviceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        int branchId = 0;
        String poolName = null;
        if (currentUser != null) {
            StaffDAO staffDAO = new StaffDAO(); // hoặc inject qua DI
            Staff staff = staffDAO.getStaffById(currentUser.getUser_id());
            if (staff != null) {
                branchId = staff.getBranchId();
                poolName = staff.getPoolName();
            } else {
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
                request.setAttribute("pageSize", pageSize);
                request.getRequestDispatcher("staffDevice.jsp").forward(request, response);
                return;
            }
        }

        int count = deviceDAO.countDevicesWithPoolName(keyword, status, branchId, poolName);
        int endPage = count / pageSize;
        if (count % pageSize != 0) {
            endPage++;
        }

        // Chỉ lấy những thiết bị staff được phép xem (tương tự manager)
        List<Device> devices = deviceDAO.getDevicesByPageAndPoolName(keyword, status, page, pageSize, branchId, poolName);
        List<Pooldevice> poolList = deviceDAO.getPoolsByBranchId(branchId);

        request.setAttribute("devices", devices);
        request.setAttribute("endP", endPage);
        request.setAttribute("page", page);
        request.setAttribute("keyword", keyword);
        request.setAttribute("status", status);
        request.setAttribute("poolId", poolIdParam);
        request.setAttribute("poolList", poolList);
        request.setAttribute("pageSize", pageSize);
        request.getRequestDispatcher("staffDevice.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response); // không dùng post
    }

    @Override
    public String getServletInfo() {
        return "Danh sách thiết bị cho staff (xem-only)";
    }
}
