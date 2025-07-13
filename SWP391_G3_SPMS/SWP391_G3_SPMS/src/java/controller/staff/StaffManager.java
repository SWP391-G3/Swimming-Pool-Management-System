package controller.staff;

import dao.staff.StaffDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import model.customer.User;
import model.staff.StaffJoinedTable;

@WebServlet("/staffManager")
public class StaffManager extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("currentUser");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = user.getUser_id();
        StaffDAO staffDAO = new StaffDAO();
        StaffJoinedTable staff = staffDAO.getStaffByUserId(userId);

        if (staff == null) {
            response.sendRedirect("notFound.jsp"); // hoặc trang báo chưa được phân quyền
            return;
        }

        session.setAttribute("staff", staff); // Lưu staff vào session để dùng tiếp ở các servlet khác

        session.setAttribute("staffName", user.getFull_name()); // nếu User có fullName
        session.setAttribute("branchName", staff.getBranchName());
        session.setAttribute("poolName", staff.getPoolName());
        session.setAttribute("staffTypeName", staff.getTypeName());
        
        int staffTypeId = staff.getStaffTypeId();

        // Điều hướng tới servlet nghiệp vụ
        if (staffTypeId == 3) {
            response.sendRedirect("staffListDeviceServlet");
        } else if (staffTypeId == 4) {
            response.sendRedirect("staffPoolService");
        } else {
            response.sendRedirect("notFound.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
