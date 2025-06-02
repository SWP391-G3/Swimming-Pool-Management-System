package controller.poolist;

import dao.PoolsDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import model.Pools;

@WebServlet("/homepage")
public class PoolListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchName = request.getParameter("searchName");
        String searchLocation = request.getParameter("searchLocation");
        String sortBy = request.getParameter("sortBy");
        String pageParam = request.getParameter("page");
        int currentPage = 1;

        int pageSize = 6;
        PoolsDAO dao = new PoolsDAO();
        int totalPools = dao.countFilteredPools(searchName,searchLocation);
        int totalPages = (int) Math.ceil((double) totalPools / pageSize);
        if (pageParam != null && !pageParam.isEmpty()) {
            try {
                currentPage = Integer.parseInt(pageParam);
            } catch (NumberFormatException e) {
                currentPage = 1;
            }
            if (currentPage > totalPages) {
                currentPage = totalPages; // 👉 chính dòng này đã đưa bạn về TRANG CUỐI
            }
        }

        List<Pools> pools = dao.getPools(searchName, searchLocation, sortBy, currentPage, pageSize);

        request.setAttribute("pools", pools);

        request.setAttribute("currentPage", currentPage);
        request.setAttribute("totalPages", totalPages);

        request.getRequestDispatcher("homepage.jsp").forward(request, response);
    }

}
