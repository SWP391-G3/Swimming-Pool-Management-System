<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    request.setAttribute("activeMenu", "device");
%>
<%
    model.staff.StaffJoinedTable staff = (model.staff.StaffJoinedTable) session.getAttribute("staff");
    model.customer.User user = (model.customer.User) session.getAttribute("currentUser");
%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Danh sách thiết bị hồ bơi</title>
        <!-- Nếu bạn có file CSS riêng, giữ nguyên 2 dòng dưới, nếu không có thì dùng style bên dưới -->

        <link rel="stylesheet" href="./manager-css/manager-device-v2.css">
        <link rel="stylesheet" href="./manager-css/manager-panel.css">
        <link rel="stylesheet" href="./css/staff/styles.css"/>
    </head>
    <body>
        <div class="layout">

            <%@ include file="./staffSidebar.jsp" %>

            <!-- Sidebar -->
            <div class="content-panel">
                <div class="header">
                    <h2>Danh sách thiết bị hồ bơi</h2>
                    <form class="search-form" method="get" action="staffListDeviceServlet"  id="searchForm">
                        <input type="text" name="keyword" placeholder="Tìm theo tên thiết bị..." value="${keyword}">

                        <select name="status" style="margin-right: 12px">
                            <option value="">-- Tất cả trạng thái --</option>
                            <option value="available" ${status == 'available' ? 'selected' : ''}>Tốt</option>
                            <option value="maintenance" ${status == 'maintenance' ? 'selected' : ''}>Bảo trì</option>
                            <option value="broken" ${status == 'broken' ? 'selected' : ''}>Hỏng</option>
                        </select>
                        <select name="pageSize" id="pageSizeSelect" style="margin-left: 12px" onchange="document.getElementById('searchForm').submit();">
                            <option value="5" ${pageSize == 5 ? 'selected' : ''}>5/Trang</option>
                            <option value="10" ${pageSize == 10 ? 'selected' : ''}>10/Trang</option>
                            <option value="15" ${pageSize == 15 ? 'selected' : ''}>15/Trang</option>
                        </select>
                        <input type="hidden" name="page" style="margin-left: 12px" value="${page}">
                        <button type="submit" style="margin-left: 12px">Tìm kiếm</button>
                        <button type="button" onclick="resetSearch()" style="background:#eee;color:#222;border:1px solid #ccc;margin-left:4px;">Reset</button>

                    </form>
                </div>

                <!-- Card Grid Device List -->
                <div class="device-card-grid">
                    <c:choose>
                        <c:when test="${empty devices}">
                            <div class="no-device">
                                Không tìm thấy thiết bị nào phù hợp.
                            </div>
                        </c:when>
                        <c:otherwise>
                            <c:forEach var="device" items="${devices}">
                                <div class="device-card">
                                    <div class="card-thumb">
                                        <img src="${device.deviceImage}" alt="Thiết bị" />
                                    </div>
                                    <div class="card-content">
                                        <div class="card-title">${device.deviceName}</div>
                                        <div class="card-info"><b>Hồ bơi:</b> ${device.poolName}</div>
                                        <div class="card-info"><b>Số lượng:</b> ${device.quantity}</div>
                                        <div class="card-info"><b>Trạng thái:</b>
                                            <span class="status ${device.deviceStatus}">
                                                <c:choose>
                                                    <c:when test="${device.deviceStatus == 'available'}">Tốt</c:when>
                                                    <c:when test="${device.deviceStatus == 'maintenance'}">Bảo trì</c:when>
                                                    <c:when test="${device.deviceStatus == 'broken'}">Hỏng</c:when>
                                                </c:choose>
                                            </span>
                                        </div>
                                        <div class="card-info"><b>Ghi chú:</b> ${device.notes}</div>
                                        <div class="card-action">
                                            <a href="staffDeviceDetailServlet?id=${device.deviceId}" class="btn-detail">Xem chi tiết</a>
                                        </div>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </div>

                <!-- Phân trang -->
                <div class="pagination">
                    <c:if test="${endP > 1}">
                        <c:set var="current" value="${page}" />
                        <c:set var="total" value="${endP}" />
                        <c:set var="maxShow" value="5" />
                        <c:set var="start" value="${current - 2 > 1 ? current - 2 : 1}" />
                        <c:set var="end" value="${start + maxShow - 1 <= total ? start + maxShow - 1 : total}" />
                        <c:if test="${end - start + 1 < maxShow && start > 1}">
                            <c:set var="start" value="${end - maxShow + 1 > 1 ? end - maxShow + 1 : 1}" />
                        </c:if>

                        <!-- Prev -->
                        <c:if test="${current > 1}">
                            <a href="staffListDeviceServlet?page=${current-1}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}">&laquo;</a>
                        </c:if>

                        <!-- First -->
                        <c:if test="${start > 1}">
                            <a href="staffListDeviceServlet?page=1&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}">1</a>
                            <span style="color:#999;">...</span>
                        </c:if>

                        <!-- Main page numbers -->
                        <c:forEach var="i" begin="${start}" end="${end}">
                            <a href="staffListDeviceServlet?page=${i}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}"
                               class="${i == current ? 'active' : ''}">${i}</a>
                        </c:forEach>

                        <!-- Last -->
                        <c:if test="${end < total}">
                            <span style="color:#999;">...</span>
                            <a href="staffListDeviceServlet?page=${total}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}">${total}</a>
                        </c:if>

                        <!-- Next -->
                        <c:if test="${current < total}">
                            <a href="staffListDeviceServlet?page=${current+1}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}">&raquo;</a>
                        </c:if>
                    </c:if>
                </div>

            </div>
        </div>
        <!-- JavaScript tìm kiếm tự động -->
        <script>
            function resetSearch() {
                document.querySelector('input[name="keyword"]').value = "";
                document.querySelector('select[name="poolId"]').value = "";
                document.querySelector('select[name="status"]').value = "";
                document.querySelector('select[name="pageSize"]').value = "5";
                document.querySelector('input[name="page"]').value = 1;
                document.getElementById('searchForm').submit();
            }
            const searchInput = document.querySelector('input[name="keyword"]');
            const searchForm = document.getElementById('searchForm');
            let timeout = null;
            searchInput && searchInput.addEventListener('input', function () {
                clearTimeout(timeout);
                timeout = setTimeout(() => {
                    document.querySelector('input[name="page"]').value = 1; // reset về trang 1
                    searchForm.submit();
                }, 400);
            });
        </script>

    </body>
</html>
