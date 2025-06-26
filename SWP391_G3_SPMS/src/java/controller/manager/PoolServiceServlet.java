package controller.manager;

import dao.PoolDAO;
import dao.PoolServiceDAO;
import model.Pool;
import model.manager.PoolService;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.User;

@WebServlet("/pool-service")
public class PoolServiceServlet extends HttpServlet {

    private final PoolServiceDAO dao = new PoolServiceDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        User currentUser = (User) session.getAttribute("currentUser");
        String location = "";
        if (currentUser != null) {
            switch (currentUser.getUser_id()) {
                case 2:
                    location = "Hà Nội";
                    break;
                case 3:
                    location = "Hồ Chí Minh";
                    break;
                case 4:
                    location = "Đà Nẵng";
                    break;
                case 5:
                    location = "Cần Thơ";
                    break;
                case 6:
                    location = "Quy Nhơn";
                    break;
            }
        }

        try {
            PoolDAO poolDAO = new PoolDAO();
            List<Pool> poolList = poolDAO.searchPoolByAddress(location);
            List<Integer> poolIds = new ArrayList<>();
            for (Pool pool : poolList) {
                poolIds.add(pool.getPool_id());
            }

            if (poolIds.isEmpty()) {
                request.setAttribute("list", new ArrayList<PoolService>());
                request.setAttribute("total", 0);
                request.setAttribute("page", 1);
                request.setAttribute("endPage", 1);
                request.setAttribute("pageSize", 5);
                request.setAttribute("name", "");
                request.setAttribute("minPrice", "");
                request.setAttribute("maxPrice", "");
                request.setAttribute("poolId", "");
                request.setAttribute("poolList", poolList);
                request.getRequestDispatcher("pool_service_list.jsp").forward(request, response);
                return;
            }

            // 1. Thêm mới (Form trống)
            if ("add".equals(action)) {
                request.setAttribute("poolList", poolList);
                request.getRequestDispatcher("pool_service_form.jsp").forward(request, response);
                return;
            }

            if ("detail".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr == null || idStr.isEmpty()) {
                    response.sendRedirect("pool-service");
                    return;
                }
                int id = Integer.parseInt(idStr);
                PoolService ps = dao.getById(id);
                if (ps == null || !poolIds.contains(ps.getPoolId())) {
                    response.sendRedirect("pool-service");
                    return;
                }
                request.setAttribute("poolList", poolList);
                request.setAttribute("poolService", ps);
                request.getRequestDispatcher("pool_service_detail.jsp").forward(request, response);
                return;
            }

            // 2. Chỉnh sửa
            if ("edit".equals(action)) {
                String idStr = request.getParameter("id");
                if (idStr == null || idStr.isEmpty()) {
                    response.sendRedirect("pool-service");
                    return;
                }
                int id = Integer.parseInt(idStr);
                PoolService ps = dao.getById(id);
                if (ps == null || !poolIds.contains(ps.getPoolId())) {
                    response.sendRedirect("pool-service");
                    return;
                }
                request.setAttribute("poolList", poolList);
                request.setAttribute("poolService", ps);
                request.getRequestDispatcher("pool_service_form.jsp").forward(request, response);
                return;
            }

            // 3. Hiển thị & lọc danh sách dịch vụ
            String name = request.getParameter("name");
            String minPriceStr = request.getParameter("minPrice");
            String maxPriceStr = request.getParameter("maxPrice");
            String pageStr = request.getParameter("page");
            String pageSizeStr = request.getParameter("pageSize");
            String poolIdStr = request.getParameter("poolId");

            Integer poolId = null;
            if (poolIdStr != null && !poolIdStr.isEmpty()) {
                try {
                    int poolIdInput = Integer.parseInt(poolIdStr);
                    if (poolIds.contains(poolIdInput)) {
                        poolId = poolIdInput;
                    }
                } catch (NumberFormatException ignore) {
                }
            }

            int page = 1, pageSize = 5;
            try {
                if (pageStr != null && !pageStr.isEmpty()) {
                    page = Integer.parseInt(pageStr);
                }
                if (pageSizeStr != null && !pageSizeStr.isEmpty()) {
                    pageSize = Integer.parseInt(pageSizeStr);
                }
            } catch (NumberFormatException ex) {
                page = 1;
                pageSize = 5;
            }

            Double minPrice = null, maxPrice = null;
            try {
                if (minPriceStr != null && !minPriceStr.isEmpty()) {
                    minPrice = Double.parseDouble(minPriceStr);
                }
            } catch (NumberFormatException ignore) {
            }
            try {
                if (maxPriceStr != null && !maxPriceStr.isEmpty()) {
                    maxPrice = Double.parseDouble(maxPriceStr);
                }
            } catch (NumberFormatException ignore) {
            }

            int offset = (page - 1) * pageSize;

            List<PoolService> list = dao.filterServicesWithPoolIds(name, minPrice, maxPrice, poolId, offset, pageSize, poolIds);
            int totalRecords = dao.countFilteredWithPoolIds(name, minPrice, maxPrice, poolId, poolIds);
            int endPage = (int) Math.ceil((double) totalRecords / pageSize);

            request.setAttribute("list", list);
            request.setAttribute("total", totalRecords);
            request.setAttribute("page", page);
            request.setAttribute("endPage", endPage);
            request.setAttribute("pageSize", pageSize);
            request.setAttribute("name", name);
            request.setAttribute("minPrice", minPriceStr);
            request.setAttribute("maxPrice", maxPriceStr);
            request.setAttribute("poolId", poolIdStr);
            request.setAttribute("poolList", poolList);

            request.getRequestDispatcher("pool_service_list.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         String action = request.getParameter("action");
    HttpSession session = request.getSession();
    User currentUser = (User) session.getAttribute("currentUser");
    String location = "";
    if (currentUser != null) {
        switch (currentUser.getUser_id()) {
            case 2:
                location = "Hà Nội";
                break;
            case 3:
                location = "Hồ Chí Minh";
                break;
            case 4:
                location = "Đà Nẵng";
                break;  
            case 5:
                location = "Cần Thơ";
                break;
            case 6:
                location = "Quy Nhơn";
                break;
        }
    }

    try {
        PoolDAO poolDAO = new PoolDAO();
        List<Pool> poolList = poolDAO.searchPoolByAddress(location);
        List<Integer> poolIds = new ArrayList<>();
        for (Pool pool : poolList) {
            poolIds.add(pool.getPool_id());
        }

        if ("add".equals(action)) {
            String[] poolIdsParam = request.getParameterValues("pool_ids");
            if (poolIdsParam == null || poolIdsParam.length == 0) {
                session.setAttribute("errorMessage", "Vui lòng chọn ít nhất một hồ bơi.");
                response.sendRedirect("pool-service");
                return;
            }

            String serviceName = request.getParameter("service_name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String serviceImage = request.getParameter("service_image");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String serviceStatus = request.getParameter("service_status");

            for (String poolIdStr : poolIdsParam) {
                int poolId = Integer.parseInt(poolIdStr.trim());
                if (!poolIds.contains(poolId)) continue;

                PoolService ps = new PoolService();
                ps.setPoolId(poolId);
                ps.setServiceName(serviceName);
                ps.setDescription(description);
                ps.setPrice(price);
                ps.setServiceImage(serviceImage);
                ps.setQuantity(quantity);
                ps.setServiceStatus(serviceStatus);

                dao.add(ps);
            }

            response.sendRedirect("pool-service");
            return;

        } else if ("update".equals(action)) {
            int poolId = Integer.parseInt(request.getParameter("pool_id"));
            if (!poolIds.contains(poolId)) {
                response.sendRedirect("pool-service");
                return;
            }

            String serviceName = request.getParameter("service_name");
            String description = request.getParameter("description");
            double price = Double.parseDouble(request.getParameter("price"));
            String serviceImage = request.getParameter("service_image");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String serviceStatus = request.getParameter("service_status");

            PoolService ps = new PoolService();
            ps.setPoolId(poolId);
            ps.setServiceName(serviceName);
            ps.setDescription(description);
            ps.setPrice(price);
            ps.setServiceImage(serviceImage);
            ps.setQuantity(quantity);
            ps.setServiceStatus(serviceStatus);
            ps.setPoolServiceId(Integer.parseInt(request.getParameter("pool_service_id")));

            dao.update(ps);
            response.sendRedirect("pool-service");
            return;

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            PoolService ps = dao.getById(id);

            if (ps != null && poolIds.contains(ps.getPoolId())) {
                if ("unavailable".equalsIgnoreCase(ps.getServiceStatus())) {
                    dao.delete(id);
                } else {
                    session.setAttribute("errorMessage", "Không thể xóa dịch vụ đang hoạt động. Vui lòng ngưng trước khi xóa.");
                }
            } else {
                session.setAttribute("errorMessage", "Dịch vụ không hợp lệ hoặc bạn không có quyền xóa.");
            }

            response.sendRedirect("pool-service");
        }

    } catch (SQLException | NumberFormatException e) {
        e.printStackTrace();
        response.sendRedirect("error.jsp");
    }
    }
}
