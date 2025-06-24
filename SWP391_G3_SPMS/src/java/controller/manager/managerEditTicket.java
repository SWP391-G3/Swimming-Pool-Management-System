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
import java.util.HashMap;
import java.util.Map;
import model.User;
import model.manager.PoolTicket;
import model.manager.TicketType;

@WebServlet(name = "managerEditTicket", urlPatterns = {"/managerEditTicket"})
public class managerEditTicket extends HttpServlet {

    private int getBranchIdByUser(User user) {
        switch (user.getUser_id()) {
            case 2:
                return 1;
            case 3:
                return 2;
            case 4:
                return 3;
            case 5:
                return 4;
            case 6:
                return 5;
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
            if (ticket == null) {
                request.setAttribute("error", "Không tìm thấy loại vé này!");
                request.getRequestDispatcher("managerTicket.jsp").forward(request, response);
                return;
            }
            List<PoolTicket> poolList = dao.getPoolsByBranch(branchId);
            List<TicketType> singleTypes = dao.getAllSingleTypes();
            List<String> selectedPoolIds = dao.getPoolIdsOfTicketType(ticket.getId());  // Danh sách các hồ bơi đang áp dụng vé này
            String poolIdsString = "," + String.join(",", selectedPoolIds) + ",";   // chuỗi để xử lý trong Javascript, JSTL

            // Nếu là combo, lấy thành phần combo
            Map<Integer, Integer> comboDetail = new HashMap<>();
            if (ticket.isIsCombo()) {
                comboDetail = dao.getComboDetail(ticket.getId());
                request.setAttribute("comboDetail", comboDetail);
            }

            

            request.setAttribute("ticket", ticket);
            request.setAttribute("poolList", poolList);
            request.setAttribute("poolIdsString", poolIdsString);
            request.setAttribute("singleTypes", singleTypes);

            // Truyền lại filter 
            request.setAttribute("page", request.getParameter("page"));
            request.setAttribute("pageSize", request.getParameter("pageSize"));
            request.setAttribute("keyword", request.getParameter("keyword"));
            request.setAttribute("status", request.getParameter("status"));
            request.setAttribute("poolId", request.getParameter("poolId"));

            request.getRequestDispatcher("managerEditTicket.jsp").forward(request, response);
            
        } catch (Exception ex) {

            ex.printStackTrace();
            // Ghi thông báo lỗi chi tiết (message hoặc stacktrace) vào biến error
            request.setAttribute("error", "Lỗi: " + ex.getMessage());
            // (Tùy ý) In stacktrace ra chuỗi
            java.io.StringWriter sw = new java.io.StringWriter();
            ex.printStackTrace(new java.io.PrintWriter(sw));
            String stackTrace = sw.toString();
            request.setAttribute("stacktrace", stackTrace);

            // Forward về JSP thay vì redirect (để thấy lỗi)
            request.getRequestDispatcher("managerEditTicket.jsp").forward(request, response);
            return;
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

        String discountPercentRaw = request.getParameter("discountPercent");
        String finalComboPriceRaw = request.getParameter("finalComboPrice");

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
                || (isCombo ? false : (basePriceRaw == null || basePriceRaw.trim().isEmpty()))
                || poolIdsRaw == null || poolIdsRaw.length == 0) {
            error = "Vui lòng nhập đầy đủ thông tin!";
        } else {
            try {
                id = Integer.parseInt(idRaw);
                if (!isCombo) {
                    basePrice = Double.parseDouble(basePriceRaw);
                } else {
                    if (finalComboPriceRaw == null || finalComboPriceRaw.trim().isEmpty()) {
                        error = "Thiếu giá combo!";
                    } else {
                        basePrice = Double.parseDouble(finalComboPriceRaw);
                    }
                }
                for (String pid : poolIdsRaw) {
                    poolIds.add(Integer.parseInt(pid));
                }
            } catch (Exception e) {
                error = "Dữ liệu không hợp lệ!";
            }
        }

        TicketTypeDAO dao = new TicketTypeDAO();

        // Nếu có lỗi -> quay lại trang form
        if (error != null) {
            try {
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
                List<TicketType> singleTypes = dao.getAllSingleTypes();

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

                // Nếu combo, giữ lại detail
                Map<Integer, Integer> comboDetail = new HashMap<>();
                if (isCombo) {
                    List<TicketType> singleTypesList = dao.getAllSingleTypes();
                    for (TicketType single : singleTypesList) {
                        String qtyStr = request.getParameter("comboQty_" + single.getId());
                        int qty = qtyStr == null ? 0 : Integer.parseInt(qtyStr);
                        if (qty > 0) {
                            comboDetail.put(single.getId(), qty);
                        }
                    }
                }

                // Truyền dữ liệu lại JSP
                request.setAttribute("ticket", ticket);
                request.setAttribute("poolList", poolList);
                request.setAttribute("poolIdsString", poolIdsString);
                request.setAttribute("error", error);
                request.setAttribute("singleTypes", dao.getAllSingleTypes());
                if (isCombo) {
                    request.setAttribute("comboDetail", comboDetail);
                }

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
            // 1. Cập nhật Ticket_Types
            if (!isCombo) {
                dao.updateTicketType(id, typeName, description, basePrice, false,0);
            } else {
                double discountPercent = 0;
                try {
                    discountPercent = Double.parseDouble(discountPercentRaw);
                } catch (Exception ignored) {
                }
               
                dao.updateTicketType(id, typeName, description, basePrice, true, discountPercent);
                //  Cập nhật thành phần combo (xóa cũ, thêm mới)
                Map<Integer, Integer> comboMap = new HashMap<>();
                List<TicketType> singleTypesList = dao.getAllSingleTypes();
                
                for (TicketType single : singleTypesList) {
                    String qtyStr = request.getParameter("comboQty_" + single.getId());
                    int qty = qtyStr == null ? 0 : Integer.parseInt(qtyStr);
                    if (qty > 0) {
                        comboMap.put(single.getId(), qty);
                    }
                }
                dao.deleteComboDetail(id);
                dao.addComboDetail(id, comboMap);
            }
            // 3. Cập nhật mapping pool
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
                TicketType ticket = dao.getTicketTypeById(id);
                List<PoolTicket> poolList = dao.getPoolsByBranch(branchId);
                List<String> selectedPoolIds = dao.getPoolIdsOfTicketType(id);
                String poolIdsString = "," + String.join(",", selectedPoolIds) + ",";

                request.setAttribute("ticket", ticket);
                request.setAttribute("poolList", poolList);
                request.setAttribute("poolIdsString", poolIdsString);
                request.setAttribute("singleTypes", dao.getAllSingleTypes());
                if (ticket.isIsCombo()) {
                    request.setAttribute("comboDetail", dao.getComboDetail(id));
                }

                // Giữ lại filter
                request.setAttribute("page", page);
                request.setAttribute("pageSize", pageSize);
                request.setAttribute("keyword", keyword);
                request.setAttribute("status", status);
                request.setAttribute("poolId", poolId);

                request.getRequestDispatcher("managerEditTicket.jsp").forward(request, response);
            } catch (Exception ex) {
                ex.printStackTrace();
                // Ghi thông báo lỗi chi tiết (message hoặc stacktrace) vào biến error
                request.setAttribute("error", "Lỗi: " + ex.getMessage());
                // (Tùy ý) In stacktrace ra chuỗi
                java.io.StringWriter sw = new java.io.StringWriter();
                ex.printStackTrace(new java.io.PrintWriter(sw));
                String stackTrace = sw.toString();
                request.setAttribute("stacktrace", stackTrace);

                // Forward về JSP thay vì redirect (để thấy lỗi)
                request.getRequestDispatcher("managerEditTicket.jsp").forward(request, response);
                return;
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Servlet cập nhật loại vé";
    }
}
