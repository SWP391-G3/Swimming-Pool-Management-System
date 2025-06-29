<%-- 
    Document   : managerTicket
    Created on : Jun 21, 2025, 9:58:07 PM
    Author     : Tuan Anh
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    request.setAttribute("activeMenu", "ticket");
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Loại vé</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <link rel="stylesheet" href="./manager-css/manager-panel.css">
        <link rel="stylesheet" href="./manager-css/managerTicket-v3.css">
    </head>

    <body>

        <c:if test="${not empty error}">
            <div class="error-message" style="color:red; background:#fff0f0; padding:10px;">
                ${error}
            </div>
        </c:if>


        <c:if test="${not empty success}">
            <div class="success-message" id="successMsg">${success}</div>
            <script>
                setTimeout(function () {
                    var msg = document.getElementById('successMsg');
                    if (msg)
                        msg.style.display = 'none';
                }, 3000); // 3000 ms = 3 giây
            </script>
        </c:if>

        <div class="layout">
            <div class="sidebar">
                <%@ include file="../managerSidebar.jsp" %>
            </div>
            <div class="content-panel">
                <div class="header">
                    <h2>Quản lý Loại vé</h2>
                    <form class="search-form" method="get" action="managerTicketServlet" id="searchForm">
                        <input type="text" name="keyword" placeholder="Nhập mã hoặc tên vé (tối đa 50 ký tự)..." value="${fn:escapeXml(keyword)}">
                        <select name="poolId">
                            <option value="all" <c:if test="${poolId == 'all'}">selected</c:if>>-- Tất cả hồ bơi --</option>
                            <c:forEach var="pool" items="${poolList}">
                                <option value="${pool.id}" <c:if test="${pool.id.toString() == poolId}">selected</c:if>>${pool.name}</option>
                            </c:forEach>
                        </select>
                        <select name="status">
                            <option value="all" <c:if test="${status == 'all'}">selected</c:if>>Tất cả</option>
                            <option value="active" <c:if test="${status == 'active'}">selected</c:if>>Đang bán</option>
                            <option value="inactive" <c:if test="${status == 'inactive'}">selected</c:if>>Ngừng bán</option>
                            </select>
                            <select name="pageSize" id="pageSizeSelect" onchange="document.getElementById('searchForm').submit();">
                                <option value="5" <c:if test="${pageSize == 5}">selected</c:if>>5/Trang</option>
                            <option value="10" <c:if test="${pageSize == 10}">selected</c:if>>10/Trang</option>
                            <option value="15" <c:if test="${pageSize == 15}">selected</c:if>>15/Trang</option>
                            <option value="25" <c:if test="${pageSize == 25}">selected</c:if>>25/Trang</option>
                            </select>
                            <input type="hidden" name="page" value="${page}">
                        <button type="submit"><i class="fas fa-search"></i></button>
                    </form>
                    <div class="action-buttons">
                        <a href="managerAddTicket?page=${page}&pageSize=${pageSize}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}" class="btn-add"><i class="fa-solid fa-plus"></i> Thêm loại vé</a>
                        <!-- comment   <a href="copyTicket.jsp?page=${page}&pageSize=${pageSize}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}" class="btn-copy"><i class="fas fa-copy"></i> Copy loại vé</a> -->
                        <a href="managerTicketServlet" class="btn-copy"><i class="fa-solid fa-face-smile"></i>Làm mới</a> 
                    </div>
                </div>
                <div class="ticket-list">
                    <table class="equipment-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Mã loại</th>
                                <th>Tên loại vé</th>
                                <th>Giá vé</th>
                                <th>Áp dụng tại</th>
                                <th>Ngày tạo</th>
                                <th>Trạng thái</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty ticketList}">
                                    <tr>
                                        <td colspan="7" style="text-align: center; color: gray; font-style: italic;">
                                            Không tìm thấy loại vé nào phù hợp.
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="ticket" items="${ticketList}" varStatus="i">
                                        <tr>
                                            <td>${ticket.id}</td>
                                            <td>${ticket.code}</td>
                                            <td>${ticket.name}</td>
                                            <td><fmt:formatNumber value="${ticket.basePrice}" type="currency" currencySymbol="₫"/></td>
                                            <td>
                                                <div class="pool-tags">
                                                    <c:forEach var="pool" items="${ticket.pools}">
                                                        <span class="pool-tag">${pool}</span>
                                                    </c:forEach>
                                                </div>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${ticket.createdAt}" pattern="dd/MM/yyyy HH:mm:ss"/>
                                            </td>
                                            <td>
                                                <span class="status ${ticket.active ? 'available' : 'broken'}">
                                                    ${ticket.active ? 'Đang bán' : 'Ngừng bán'}
                                                </span>
                                            </td>
                                            <td>
                                                <a href="javascript:void(0);" class="btn-edit btn-view" title="Xem chi tiết"
                                                   onclick="showTicketDetail(${ticket.id})">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <a href="managerEditTicket?id=${ticket.id}&page=${page}&pageSize=${pageSize}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}" 
                                                   class="btn-edit" 
                                                   title="Cập nhật">
                                                    Cập nhật
                                                </a>
                                                <a href="managerDeleteTicket?id=${ticket.id}&page=${page}&pageSize=${pageSize}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}"
                                                   class="btn-disable"
                                                   title="Xóa"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa loại vé này?');">
                                                    Xóa
                                                </a>
                                                </div>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>


                    <!-- PHÂN TRANG CHUẨN -->
                    <c:if test="${endP > 1}">
                        <div class="pagination">
                            <c:if test="${page > 1}">
                                <a href="managerTicketServlet?page=${page-1}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}">«</a>
                            </c:if>
                            <c:forEach begin="1" end="${endP}" var="i">
                                <a href="managerTicketServlet?page=${i}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}" class="${i == page ? 'active' : ''}">${i}</a>
                            </c:forEach>
                            <c:if test="${page < endP}">
                                <a href="managerTicketServlet?page=${page+1}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}">»</a>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>


        <script>
            const searchInput = document.querySelector('input[name="keyword"]');
            const searchForm = document.getElementById('searchForm');
            let timeout = null;

            searchInput.addEventListener('input', function () {
                clearTimeout(timeout);
                timeout = setTimeout(() => {
                    document.querySelector('input[name="page"]').value = 1; // reset về trang 1
                    searchForm.submit();
                }, 500);
            });
        </script>


        <!-- Validate keyword truyền vào  -->
        <script>
            document.getElementById('searchForm').addEventListener('submit', function (e) {
                const keywordInput = document.querySelector('input[name="keyword"]');
                const keyword = keywordInput.value.trim();

                // Kiểm tra rỗng toàn dấu cách
                if (keyword.length > 0) {
                    // Giới hạn độ dài
                    if (keyword.length > 50) {
                        alert("Từ khóa tìm kiếm không được vượt quá 50 ký tự.");
                        e.preventDefault();
                        return;
                    }

                    // Kiểm tra ký tự đặc biệt nguy hiểm
                    const invalidPattern = /[<>']/;
                    if (invalidPattern.test(keyword)) {
                        alert("Từ khóa không được chứa ký tự < > hoặc dấu nháy.");
                        e.preventDefault();
                        return;
                    }
                }


            });
        </script>




    </body>
</html>



<link rel="stylesheet" href="./manager-css/managerPopupTicket.css">
<div id="ticketDetailModal" class="modal" style="display:none;">
    <div class="modal-content">
        <span class="close" onclick="closeTicketModal()">&times;</span>
        <div id="ticketDetailBody">
            <!-- Nội dung sẽ được load ở đây -->
        </div>
    </div>
</div>
<script>
    function showTicketDetail(ticketId) {
        var modal = document.getElementById('ticketDetailModal');
        var body = document.getElementById('ticketDetailBody');
        body.innerHTML = `
        <div class="loading-spinner">
            <div class="spinner"></div>
            <p>Loading ticket details...</p>
        </div>
    `;
        modal.style.display = 'flex';
        setTimeout(() => modal.classList.add('show'), 10);

        var params = new URLSearchParams({id: ticketId});
        fetch("managerDetailTicketAjax", {
            method: "POST",
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            body: params
        })
                .then(res => res.text())
                .then(html => {
                    body.innerHTML = html;
                })
                .catch(error => {
                    body.innerHTML = `
            <div class="error-message">
                <h3>Error</h3>
                <p>Failed to load ticket details. Please try again.</p>
            </div>
        `;
                });
    }

    function closeTicketModal() {
        var modal = document.getElementById('ticketDetailModal');
        modal.classList.remove('show');
        setTimeout(() => {
            modal.style.display = 'none';
            document.getElementById('ticketDetailBody').innerHTML = '';
        }, 300);
    }
</script>



