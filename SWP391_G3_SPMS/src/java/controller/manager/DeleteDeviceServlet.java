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

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "DeleteDeviceServlet", urlPatterns = {"/managerDeleteDeviceServlet"})
public class DeleteDeviceServlet extends HttpServlet {

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

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet DeleteDeviceServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet DeleteDeviceServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            int id = Integer.parseInt(request.getParameter("deviceId"));
            DeviceDao dao = new DeviceDao();
            dao.deleteDevice(id);
        } catch (NumberFormatException ignored) {
        }

        String poolId = request.getParameter("poolId");
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String page = request.getParameter("page");

        String redirectUrl = "managerListDeviceServlet";
        boolean first = true;
        if (page != null && !page.isEmpty()) {
            redirectUrl += (first ? "?" : "&") + "page=" + page;
            first = false;
        }
        if (poolId != null && !poolId.isEmpty()) {
            redirectUrl += (first ? "?" : "&") + "poolId=" + poolId;
            first = false;
        }
        if (keyword != null && !keyword.isEmpty()) {
            redirectUrl += (first ? "?" : "&") + "keyword=" + java.net.URLEncoder.encode(keyword, "UTF-8");
            first = false;
        }
        if (status != null && !status.isEmpty()) {
            redirectUrl += (first ? "?" : "&") + "status=" + status;
            first = false;
        }
        response.sendRedirect(redirectUrl);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
