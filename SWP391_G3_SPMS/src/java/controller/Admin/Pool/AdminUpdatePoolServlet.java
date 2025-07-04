/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.Admin.Pool;

import dao.customer.PoolDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.UUID;
import model.customer.Pool;

/**
 *
 * @author Lenovo
 */
@WebServlet(name = "AdminUpdatePoolServlet", urlPatterns = {"/adminUpdatePool"})

@MultipartConfig(
        fileSizeThreshold = 1024 * 1024, // 1MB
        maxFileSize = 5 * 1024 * 1024, // 5MB
        maxRequestSize = 10 * 1024 * 1024 // 10MB
)
public class AdminUpdatePoolServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AdminUpdatePoolServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AdminUpdatePoolServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String id = request.getParameter("id");
        String page = request.getParameter("page");
        PoolDAO dao = new PoolDAO();
        int pool_id;
        try {
            pool_id = Integer.parseInt(id);
            Pool pool = dao.getPoolByID(pool_id);
            if (pool != null) {
                request.setAttribute("Pool", pool);
                request.setAttribute("page", page);
                request.getRequestDispatcher("AdminUpdatePool.jsp").forward(request, response);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        PoolDAO dao = new PoolDAO();
        Pool pool;
        String id = request.getParameter("pool_id");
        String pool_name = request.getParameter("pool_name");
        String pool_desctiprion = request.getParameter("pool_description");
        String pool_image = request.getParameter("pool_image");
        String pool_road = request.getParameter("pool_road");
        String pool_address = request.getParameter("pool_address");
        String slot = request.getParameter("max_slot");
        String open = request.getParameter("open_time");
        String close = request.getParameter("close_time");
        String status = request.getParameter("pool_status");
        String branch_idRaw = request.getParameter("branch_id");
        String pageRaw = request.getParameter("page");
        LocalDate updateDate = LocalDate.now();
        LocalTime open_time, close_time;
        int max_slot, pool_id, branch_id,currentPage;
        boolean pool_status;
        try {
            pool_id = Integer.parseInt(id);
            pool_status = Boolean.parseBoolean(status);
            max_slot = Integer.parseInt(slot);
            branch_id = Integer.parseInt(branch_idRaw);
            open_time = LocalTime.parse(open);
            close_time = LocalTime.parse(close);
            currentPage = Integer.parseInt(pageRaw);

            // Lấy ảnh hiện tại từ DB
            Pool existingPool = dao.getPoolByID(pool_id);
            String currentImage = existingPool.getPool_image();

            // Lấy file ảnh mới nếu có
            Part filePart = request.getPart("pool_image");
            String fileName = filePart.getSubmittedFileName();

            pool_image = currentImage; // Mặc định giữ ảnh cũ

            if (fileName != null && !fileName.isEmpty()) {
                // Kiểm tra định dạng
                if (!fileName.matches(".*\\.(jpg|jpeg|png|webp)$")) {
                    request.setAttribute("error", "Ảnh phải là JPG, PNG hoặc WEBP.");
                    request.setAttribute("Pool", existingPool);
                    request.getRequestDispatcher("AdminUpdatePool.jsp").forward(request, response);
                    return;
                }

                // Tạo tên file duy nhất và lưu ảnh
                String uniqueFileName = UUID.randomUUID().toString() + "_" + fileName;
                String appPath = getServletContext().getRealPath("/");
                String uploadPath = appPath + "images" + File.separator + "pool";
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                String filePath = uploadPath + File.separator + uniqueFileName;
                filePart.write(filePath);

                // Gán đường dẫn ảnh mới
                pool_image = "images/pool/" + uniqueFileName;
            }

            // Tạo đối tượng và update
            pool = new Pool(pool_id, pool_name, pool_road, pool_address, max_slot,
                    open_time, close_time, pool_status, pool_image,
                    null, updateDate, pool_desctiprion, branch_id);

            dao.updatePool(pool);
            response.sendRedirect("adminPoolManagement?page=" + currentPage);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Có lỗi xảy ra");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
