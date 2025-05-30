/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller.manager;

import dao.manager.DeviceDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.manager.Device;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name="ListPageDevice", urlPatterns={"/ListPageDevice"})
public class ListPageDevice extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
       
        String keyword = request.getParameter("keyword");
        String status = request.getParameter("status");
        String index = request.getParameter("page");
        int page = Integer.parseInt(index);
        
        
        
        // Lấy tổng số lượng thiết bị
        DeviceDao dao = new DeviceDao();
        int count = dao.getTotalDevice();
        int endPage = count/7 ;    // muốn mỗi trang 7 bài
        if(count % 7 != 0){  // nếu mà chia có dư thì tăng
            endPage ++;
        }
        
        List<Device> device = dao.getDevicesByPage(keyword,status, page);
        
        request.setAttribute("device", device);
        request.setAttribute("endP", endPage);
        request.getRequestDispatcher("managerDevice.jsp").forward(request, response);
    } 

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
