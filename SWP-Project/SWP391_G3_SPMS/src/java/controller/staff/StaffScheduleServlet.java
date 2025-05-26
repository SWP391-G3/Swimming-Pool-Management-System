/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller.staff;

import dao.staff.StaffScheduleDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import model.staff.StaffScheduleRow;

/**
 *
 * @author Tuan Anh
 */
@WebServlet(name = "StaffScheduleServlet", urlPatterns = {"/StaffScheduleServlet"})
public class StaffScheduleServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet StaffScheduleServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet StaffScheduleServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    private LocalDate getStartOfWeek(int year, int week) {
        return LocalDate.ofYearDay(year, 1)
                .with(java.time.temporal.IsoFields.WEEK_OF_WEEK_BASED_YEAR, week)
                .with(java.time.DayOfWeek.MONDAY);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Integer userId = (Integer) request.getSession().getAttribute(user_id);
      Integer userId = 3;
//        if (userId == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }

        LocalDate today = LocalDate.now();
        int week = Optional.ofNullable(request.getParameter("week")).map(Integer::parseInt)
                .orElse(today.get(java.time.temporal.IsoFields.WEEK_OF_WEEK_BASED_YEAR));
        int year = Optional.ofNullable(request.getParameter("year")).map(Integer::parseInt)
                .orElse(today.getYear());

        LocalDate startOfWeek = getStartOfWeek(year, week);
        LocalDate endOfWeek = startOfWeek.plusDays(6);

        List<StaffScheduleRow> scheduleList = new ArrayList<>();
        try {
            StaffScheduleDAO dao = new StaffScheduleDAO();
            scheduleList = dao.getStaffScheduleWithAttendance(userId, startOfWeek, endOfWeek);
        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Lỗi khi tải dữ liệu.");
        }

        request.setAttribute("scheduleList", scheduleList);
        request.setAttribute("startOfWeek", Date.valueOf(startOfWeek)); // chuyển đổi từ LocalDate
        request.setAttribute("week", week);
        request.setAttribute("year", year);
        request.setAttribute("endOfWeek", Date.valueOf(endOfWeek));    
        request.getRequestDispatcher("staff_schedule.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        //Integer userId = (Integer) request.getSession().getAttribute("user_id");
       Integer userId = 3;
//        if (userId == null) {
//            response.sendRedirect("login.jsp");
//            return;
//        }

        String action = request.getParameter("action");
        int poolId = Integer.parseInt(request.getParameter("poolId"));
        String shift = request.getParameter("shift");
        LocalDate date = LocalDate.parse(request.getParameter("date"));

        try {
            StaffScheduleDAO dao = new StaffScheduleDAO();
            Timestamp now = new Timestamp(System.currentTimeMillis());
            if ("checkin".equals(action)) {
                dao.insertCheckIn(userId, poolId, shift, now);
            } else if ("checkout".equals(action)) {
                dao.updateCheckOut(userId, poolId, shift, date, now);
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }

        response.sendRedirect(request.getContextPath() + "/StaffScheduleServlet?week=" + request.getParameter("week") + "&year=" + request.getParameter("year"));

    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
