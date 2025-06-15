package controller.poolist;

import dao.PoolsCustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.PoolsCustomer;

@WebServlet("/homepage")
public class PoolListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchName = request.getParameter("searchName");
        String searchLocation = request.getParameter("searchLocation");
        String capacity = request.getParameter("capacity");
        String openTime = request.getParameter("openTime");
        String closeTime = request.getParameter("closeTime");
        String pageParam = request.getParameter("page");
        int currentPage = 1;
        int pageSize = 6;

        // Nếu searchLocation là "All", không lọc theo vị trí
        if ("All".equals(searchLocation)) {
            searchLocation = null; // Đặt searchLocation thành null để không lọc theo vị trí
        }

        PoolsCustomerDAO dao = new PoolsCustomerDAO();
        
        // Tính toán tổng số hồ bơi sau khi lọc
        int totalPools = dao.countFilteredPools(searchName, searchLocation, capacity, openTime, closeTime);
        int totalPages = (int) Math.ceil((double) totalPools / pageSize);   //25/6   4,5

        if (pageParam != null && !pageParam.isEmpty()) {
            try { 
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
            if (currentPage > totalPages && totalPages > 0) {
                currentPage = totalPages;
            }
            if (currentPage < 1) {
                currentPage = 1;
            }
        }

        // Lấy danh sách hồ bơi dựa trên các tham số đã lọc
        List<PoolsCustomer> pools = dao.getPools(searchName, searchLocation, capacity, openTime, closeTime, currentPage, pageSize);

        // Gửi dữ liệu vào request để hiển thị
        request.setAttribute("pools", pools);
        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);
        
      

        request.getRequestDispatcher("viewpoolList.jsp").forward(request, response);
    }

}
