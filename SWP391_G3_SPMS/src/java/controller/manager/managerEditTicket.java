package controller.manager;

import dao.manager.TicketTypeDAO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import model.manager.PoolTicket;
import model.manager.TicketType;

@WebServlet(name = "managerEditTicket", urlPatterns = {"/managerEditTicket"})
public class managerEditTicket extends HttpServlet {

    // Lấy branchId theo user_id (Tối ưu hóa đoạn này)
    private int getBranchIdByUser(User user) {
        switch (user.getUser_id()) {
            case 2:
                return 1; // Hà Nội
            case 3:
                return 2; // Hồ Chí Minh
            case 4:
                return 3; // Đà Nẵng
            case 5:
                return 4; // Quy Nhơn
            case 6:
                return 5; // Cần Thơ
            default:
                return -1;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int branchId = getBranchIdByUser(currentUser);
        if (branchId == -1) {
            response.sendRedirect("login.jsp");
            return;
        }

        String idRaw = request.getParameter("id");
        if (idRaw == null) {
            response.sendRedirect("managerTicketServlet");
            return;
        }

        try {
            int id = Integer.parseInt(idRaw);
            TicketTypeDAO dao = new TicketTypeDAO();
            TicketType ticket = dao.getTicketTypeById(id);
            List<PoolTicket> poolList = dao.getPoolsByBranch(branchId);

            // Lấy danh sách pool_id dạng chuỗi để giữ chọn trong JSP
            List<String> selectedPoolIds = dao.getPoolIdsOfTicketType(ticket.getId());
            String poolIdsString = "," + String.join(",", selectedPoolIds) + ",";

            request.setAttribute("ticket", ticket);
            request.setAttribute("poolList", poolList);
            request.setAttribute("poolIdsString", poolIdsString);

            // Truyền lại filter nếu có
            request.setAttribute("page", request.getParameter("page"));
            request.setAttribute("pageSize", request.getParameter("pageSize"));
            request.setAttribute("keyword", request.getParameter("keyword"));
            request.setAttribute("status", request.getParameter("status"));
            request.setAttribute("poolId", request.getParameter("poolId"));

            request.getRequestDispatcher("managerEditTicket.jsp").forward(request, response);
        } catch (Exception ex) {
            ex.printStackTrace();
            response.sendRedirect("managerTicketServlet");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        int branchId = getBranchIdByUser(currentUser);
        if (branchId == -1) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy dữ liệu form
        String idRaw = request.getParameter("id");
        String typeName = request.getParameter("typeName");
        String description = request.getParameter("description");
        String basePriceRaw = request.getParameter("basePrice");
        String isComboRaw = request.getParameter("isCombo");
        String[] poolIdsRaw = request.getParameterValues("poolIds");
        String statusF = request.getParameter("statusF");

        // Lấy lại filter
        String page = request.getParameter("page");
        String pageSize = request.getParameter("pageSize");
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String poolId = request.getParameter("poolId");

        String error = null;
        int id = 0;
        double basePrice = 0;
        boolean isCombo = "1".equals(isComboRaw);
        List<Integer> poolIds = new ArrayList<>();

        // Validate
        if (idRaw == null || typeName == null || typeName.trim().isEmpty()
                || basePriceRaw == null || basePriceRaw.trim().isEmpty()
                || poolIdsRaw == null || poolIdsRaw.length == 0) {
            error = "Vui lòng nhập đầy đủ thông tin!";
        } else {
            try {
                id = Integer.parseInt(idRaw);
                basePrice = Double.parseDouble(basePriceRaw);
                for (String pid : poolIdsRaw) {
                    poolIds.add(Integer.parseInt(pid));
                }
            } catch (Exception e) {
                error = "Dữ liệu không hợp lệ!";
            }
        }

        // Nếu có lỗi -> quay lại trang form
        if (error != null) {
            try {
                TicketTypeDAO dao = new TicketTypeDAO();
                TicketType ticket = dao.getTicketTypeById(id);
                if (ticket == null) {
                    ticket = new TicketType();
                    ticket.setId(id);
                }

                // Giữ lại dữ liệu user đã nhập
                ticket.setName(typeName);
                ticket.setDescription(description);
                ticket.setBasePrice(basePrice);
                ticket.setIsCombo(isCombo);

                // Lấy danh sách hồ bơi chi nhánh
                List<PoolTicket> poolList = dao.getPoolsByBranch(branchId);

                // Tạo danh sách tên hồ bơi và poolIdsString để giữ lại lựa chọn
                List<String> poolNames = new ArrayList<>();
                List<String> poolIdsStringList = new ArrayList<>();
                for (String pid : poolIdsRaw) {
                    poolIdsStringList.add(pid);
                    for (PoolTicket pool : poolList) {
                        if (String.valueOf(pool.getId()).equals(pid)) {
                            poolNames.add(pool.getName());
                        }
                    }
                }
                String poolIdsString = "," + String.join(",", poolIdsStringList) + ",";
                ticket.setPools(poolNames);

                // Truyền dữ liệu lại JSP
                request.setAttribute("ticket", ticket);
                request.setAttribute("poolList", poolList);
                request.setAttribute("poolIdsString", poolIdsString);
                request.setAttribute("error", error);

                // Giữ lại filter
                request.setAttribute("page", page);
                request.setAttribute("pageSize", pageSize);
                request.setAttribute("keyword", keyword);
                request.setAttribute("status", status);
                request.setAttribute("poolId", poolId);

                request.getRequestDispatcher("managerEditTicket.jsp").forward(request, response);
                return;
            } catch (Exception ex) {
                ex.printStackTrace();
                response.sendRedirect("managerTicketServlet");
                return;
            }
        }

        // Nếu hợp lệ -> xử lý cập nhật
        try {
            TicketTypeDAO dao = new TicketTypeDAO();
            dao.updateTicketType(id, typeName, description, basePrice, isCombo);
            dao.updateTicketTypePools(id, poolIds, statusF);

            // Redirect về lại danh sách (có encode keyword)
            response.sendRedirect("managerTicketServlet?page=" + page
                    + "&pageSize=" + pageSize
                    + "&keyword=" + (keyword == null ? "" : java.net.URLEncoder.encode(keyword, "UTF-8"))
                    + "&status=" + (status == null ? "" : status)
                    + "&poolId=" + (poolId == null ? "" : poolId)
                    + "&success=2");
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Có lỗi khi cập nhật loại vé.");
            try {
                TicketTypeDAO dao = new TicketTypeDAO();
                TicketType ticket = dao.getTicketTypeById(id);
                List<PoolTicket> poolList = dao.getPoolsByBranch(branchId);

                // Lấy lại poolIdsString từ DB
                List<String> selectedPoolIds = dao.getPoolIdsOfTicketType(id);
                String poolIdsString = "," + String.join(",", selectedPoolIds) + ",";

                request.setAttribute("ticket", ticket);
                request.setAttribute("poolList", poolList);
                request.setAttribute("poolIdsString", poolIdsString);

                // Giữ lại filter
                request.setAttribute("page", page);
                request.setAttribute("pageSize", pageSize);
                request.setAttribute("keyword", keyword);
                request.setAttribute("status", status);
                request.setAttribute("poolId", poolId);

                request.getRequestDispatcher("managerEditTicket.jsp").forward(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
                response.sendRedirect("managerTicketServlet");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet cập nhật loại vé";
    }
}
