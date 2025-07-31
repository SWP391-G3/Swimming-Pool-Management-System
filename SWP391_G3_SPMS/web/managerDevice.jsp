<%-- 
    Document   : managerDevice
    Created on : May 28, 2025, 10:10:26 PM
    Author     : Tuan Anh
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%
    request.setAttribute("activeMenu", "device");
%>

<%
  request.setAttribute("activeMenu", "device");

  
  List<String> importErrors = (List<String>) session.getAttribute("importErrors");
  String importSuccess = (String) session.getAttribute("importSuccess");
  if (importErrors != null) {
      request.setAttribute("importErrors", importErrors);
      session.removeAttribute("importErrors");
  }
  if (importSuccess != null) {
      request.setAttribute("importSuccess", importSuccess);
      session.removeAttribute("importSuccess");
  }
%>
<style>
    .alert {
        position: relative;
        padding-right: 35px;
    }
    .closebtn {
        position: absolute;
        right: 10px;
        top: 5px;
        color: #888;
        font-size: 24px;
        font-weight: bold;
        cursor: pointer;
        z-index: 100;
    }
    .closebtn:hover {
        color: #000;
    }
</style>




<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Quản lý thiết bị hồ bơi</title>
        <link rel="stylesheet" href="./manager-css/manager-device-v5.css">
        <link rel="stylesheet" href="./manager-css/manager-panel.css">
    </head>







    <body>


        <div class="layout">
            <!-- Sidebar  --> 
            <%@ include file="../managerSidebar.jsp" %>

            <div class="content-panel">



                <div class="header">
                    <h2>Quản lý thiết bị hồ bơi</h2>

                    <c:if test="${not empty importSuccess}">
                        <div class="alert alert-success" id="successAlert">
                            <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span>
                            ${importSuccess}
                        </div>
                    </c:if>
                    <c:if test="${not empty importErrors}">
                        <div class="alert alert-error" id="errorAlert">
                            <span class="closebtn" onclick="this.parentElement.style.display = 'none';">&times;</span>
                            <ul style="margin: 0; padding-left: 20px;">
                                <c:forEach var="err" items="${importErrors}">
                                    <li>${err}</li>
                                    </c:forEach>
                            </ul>
                        </div>
                    </c:if>


                    <!--                    <script>
                                            window.onload = function () {
                                                var successAlert = document.getElementById('successAlert');
                                                if (successAlert) {
                                                    setTimeout(function () {
                                                        successAlert.style.display = 'none';
                                                    }, 3000);
                                                }
                                                var errorAlert = document.getElementById('errorAlert');
                                                if (errorAlert) {
                                                    setTimeout(function () {
                                                        errorAlert.style.display = 'none';
                                                    }, 3000);
                                                }
                                            };
                                        </script>-->




                    <div class="header-controls">
                        <form class="search-form" method="get" action="managerListDeviceServlet" id="searchForm">
                            <input type="text" name="keyword" placeholder="Tìm theo tên thiết bị..." value="${keyword}">
                            <select name="poolId">
                                <option value="">Tất cả hồ bơi</option>
                                <c:forEach var="pool" items="${poolList}">
                                    <option value="${pool.poolId}" <c:if test="${fn:trim(pool.poolId) == fn:trim(poolId)}">selected</c:if>>${pool.poolName}</option>
                                </c:forEach>
                            </select>
                            <select name="status">
                                <option value="">Tất cả trạng thái</option>
                                <option value="available" ${status == 'available' ? 'selected' : ''}>Tốt</option>
                                <option value="maintenance" ${status == 'maintenance' ? 'selected' : ''}>Bảo trì</option>
                                <option value="broken" ${status == 'broken' ? 'selected' : ''}>Hỏng</option>
                            </select>
                            <select name="pageSize" id="pageSizeSelect" onchange="document.getElementById('searchForm').submit();">
                                <option value="5" ${pageSize == 5 ? 'selected' : ''}>5/Trang</option>
                                <option value="10" ${pageSize == 10 ? 'selected' : ''}>10/Trang</option>
                                <option value="15" ${pageSize == 15 ? 'selected' : ''}>15/Trang</option>
                            </select>
                            <input type="hidden" name="page" value="${page}">
                            <button type="submit">Tìm kiếm</button>
                        </form>

                        <div class="action-buttons">
                            <a href="managerAddDeviceServlet?poolId=${poolId}&keyword=${keyword}&status=${status}&page=${page}&pageSize=${pageSize}" class="btn btn-primary">
                                <i class="fas fa-plus"></i> Thêm thiết bị
                            </a>
                            <a href="managerListDeviceReportServlet" class="btn btn-secondary">
                                <i class="fas fa-file-alt"></i> Xem Báo cáo
                            </a>
                        </div>
                    </div>
                </div>

                <table class="equipment-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Ảnh</th>
                            <th>Tên thiết bị</th>
                            <th>Hồ bơi</th> 
                            <th>Số lượng</th>
                            <th>Trạng thái</th>
                            <th>Ghi chú</th>
                            <th>Thao tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty devices}">
                                <tr>
                                    <td colspan="8" style="text-align: center; color: gray; font-style: italic;">
                                        Không tìm thấy thiết bị nào phù hợp.
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="device" items="${devices}">
                                    <tr>
                                        <td>${device.deviceId}</td>
                                        <td><img src="${device.deviceImage}" alt="Thiết bị" class="thumb"></td>
                                        <td>${device.deviceName}</td>
                                        <td>${device.poolName}</td>
                                        <td>${device.quantity}</td>
                                        <td>
                                            <span class="status ${device.deviceStatus}">
                                                <c:choose>
                                                    <c:when test="${device.deviceStatus == 'available'}">Tốt</c:when>
                                                    <c:when test="${device.deviceStatus == 'maintenance'}">Bảo trì</c:when>
                                                    <c:when test="${device.deviceStatus == 'broken'}">Hỏng</c:when>
                                                </c:choose>
                                            </span>
                                        </td>
                                        <td>${device.notes}</td>
                                        <td>
                                            <a href="managerUpdateDeviceServlet?id=${device.deviceId}
                                               &poolId=${not empty poolId ? fn:trim(poolId) : ''}
                                               &keyword=${not empty keyword ? fn:trim(keyword) : ''}
                                               &status=${not empty status ? fn:trim(status) : ''}
                                               &page=${page}
                                               &pageSize=${pageSize}" class="btn-edit">Cập nhật</a>
                                            <form action="managerDeleteDeviceServlet" method="get" style="display:inline;">
                                                <input type="hidden" name="deviceId" value="${device.deviceId}">
                                                <input type="hidden" name="poolId" value="${poolId}">
                                                <input type="hidden" name="keyword" value="${keyword}">
                                                <input type="hidden" name="status" value="${status}">
                                                <input type="hidden" name="page" value="${page}">
                                                <input type="hidden" name="pageSize" value="${pageSize}">
                                                <button type="submit" class="btn-delete" onclick="return confirm('Bạn chắc chắn muốn xóa thiết bị này?')">Xóa</button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>

                <!-- Phân trang -->
                <div class="pagination">
                    <c:if test="${page > 1}">
                        <a href="managerListDeviceServlet?page=${page-1}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}">&laquo;</a>
                    </c:if>
                    <c:forEach begin="1" end="${endP}" var="i">
                        <a href="managerListDeviceServlet?page=${i}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}"
                           class="${i == page ? 'active' : ''}">${i}</a>
                    </c:forEach>
                    <c:if test="${page < endP}">
                        <a href="managerListDeviceServlet?page=${page+1}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}">&raquo;</a>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- JavaScript tìm kiếm tự động -->
        <script>
            const searchInput = document.querySelector('input[name="keyword"]');
            const searchForm = document.getElementById('searchForm');
            let timeout = null;

            searchInput.addEventListener('input', function () {
                clearTimeout(timeout);
                timeout = setTimeout(() => {
                    document.querySelector('input[name="page"]').value = 1; // reset về trang 1
                    searchForm.submit();
                }, 400);
            });

            searchForm.addEventListener('submit', function (e) {
                const keyword = searchInput.value.trim();
                if (keyword.length > 100) {
                    alert("Từ khóa tìm kiếm không được vượt quá 100 ký tự.");
                    e.preventDefault();
                }
            });
        </script>
    </body>
</html>