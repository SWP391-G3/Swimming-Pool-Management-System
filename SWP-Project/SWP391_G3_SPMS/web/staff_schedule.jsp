<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Lịch làm việc & Điểm danh</title>
        <link rel="stylesheet" href="./staff-css/staff-schedule.css">
    </head>
    <body>
        <div class="layout">
            <div class="content-panel">
                <div class="content-header">
                    <h2>Lịch làm việc & Điểm danh</h2>
                    <p class="desc">Chào, <c:out value="${sessionScope.full_name}" default="Nhân viên"/>! Dưới đây là lịch và trạng thái điểm danh tuần này.</p>
                    <div class="week-nav">
                        <form method="get" style="display:inline">
                            <input type="hidden" name="week" value="${week - 1}"/>
                            <input type="hidden" name="year" value="${year}"/>
                            <button type="submit" class="btn-nav">&lt; Tuần trước</button>
                        </form>
                        <span class="week-range">
                            Tuần ${week} (<fmt:formatDate value="${startOfWeek}" pattern="EEEE, dd/MM"/> - <fmt:formatDate value="${endOfWeek}" pattern="EEEE, dd/MM"/>)
                        </span>
                        <form method="get" style="display:inline">
                            <input type="hidden" name="week" value="${week + 1}"/>
                            <input type="hidden" name="year" value="${year}"/>
                            <button type="submit" class="btn-nav">Tuần sau &gt;</button>
                        </form>
                    </div>
                </div>
                <div class="schedule-wrapper">
                    <table class="schedule-table">
                        <thead>
                            <tr>
                                <th>Ngày</th>
                                <th>Hồ bơi</th>
                                <th>Ca làm</th>
                                <th>Check-in</th>
                                <th>Check-out</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${not empty scheduleList}">
                                    <c:forEach var="row" items="${scheduleList}">
                                        <tr>
                                            <td><fmt:formatDate value="${row.utilDate}" pattern="EEEE, dd/MM"/></td>
                                            <td>${row.pool}</td>
                                            <td>${row.shift}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${row.checkIn != null}">
                                                        <fmt:formatDate value="${row.checkIn}" pattern="HH:mm dd/MM"/>
                                                    </c:when>
                                                    <c:otherwise>-</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${row.checkOut != null}">
                                                        <fmt:formatDate value="${row.checkOut}" pattern="HH:mm dd/MM"/>
                                                    </c:when>
                                                    <c:otherwise>-</c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${row.checkIn == null}">
                                                        <form method="post" style="display:inline;">
                                                            <input type="hidden" name="action" value="checkin"/>
                                                            <input type="hidden" name="date" value="${row.date}"/>
                                                            <input type="hidden" name="shift" value="${row.shift}"/>
                                                            <input type="hidden" name="poolId" value="${row.poolId}"/>
                                                            <input type="hidden" name="week" value="${week}"/>
                                                            <input type="hidden" name="year" value="${year}"/>
                                                            <button class="btn-check btn-checkin" type="submit">Check-in</button>
                                                        </form>
                                                    </c:when>
                                                    <c:when test="${row.checkIn != null && row.checkOut == null}">
                                                        <form method="post" style="display:inline;">
                                                            <input type="hidden" name="action" value="checkout"/>
                                                            <input type="hidden" name="date" value="${row.date}"/>
                                                            <input type="hidden" name="shift" value="${row.shift}"/>
                                                            <input type="hidden" name="poolId" value="${row.poolId}"/>
                                                            <input type="hidden" name="week" value="${week}"/>
                                                            <input type="hidden" name="year" value="${year}"/>
                                                            <button class="btn-check btn-checkout" type="submit">Check-out</button>
                                                        </form>
                                                    </c:when>
                                                    <c:when test="${row.checkIn != null && row.checkOut != null}">
                                                        <span class="btn-check btn-checked">Hoàn thành</span>
                                                    </c:when>
                                                </c:choose>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr><td colspan="6">Không có ca làm nào tuần này.</td></tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
                <div class="back-btn-wrapper">
                    <a href="staff_dashboard.jsp" class="btn-back">
                        <span class="back-icon">&#8592;</span> 
                        Quay về trang chính
                    </a>
                </div>
            </div>
        </div>
    </body>
</html>