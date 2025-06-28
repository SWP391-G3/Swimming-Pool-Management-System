<%-- 
    Document   : managerDiscount
    Created on : Jun 23, 2025, 1:24:34 PM
    Author     : Tuan Anh
--%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    request.setAttribute("activeMenu", "voucher");
%>


<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Mã giảm giá</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <link rel="stylesheet" href="./manager-css/manager-panel.css">
        <link rel="stylesheet" href="./manager-css/managerDiscount-v4.css">



    </head>
    <body>

        <c:if test="${not empty sessionScope.success}">
            <div class="success-message" id="successMsg">${sessionScope.success}</div>
            <%
                session.removeAttribute("success");
            %>
            <script>
                setTimeout(function () {
                    var msg = document.getElementById('successMsg');
                    if (msg)
                        msg.style.display = 'none';
                }, 3000);
            </script>
        </c:if>


        <div class="layout">
            <div class="sidebar">
                <!-- Sidebar content -->
                <%@ include file="../managerSidebar.jsp" %>

            </div>

            <div class="content-panel">
                <div class="header">
                    <h2>Quản lý Mã giảm giá</h2>
                    <form class="search-form" method="get" action="managerDiscountServlet" id="searchForm">

                        <div class="search-input-group">
                            <input type="text" name="keyword" placeholder="Tìm kiếm mã giảm giá..." value="${fn:escapeXml(keyword)}">
                            <select name="status">
                                <option value="all" ${status == 'all' ? 'selected' : ''}>Tất cả trạng thái</option>
                                <option value="active" ${status == 'active' ? 'selected' : ''}>Đang hoạt động</option>
                                <option value="inactive" ${status == 'inactive' ? 'selected' : ''}>Ngừng hoạt động</option>
                                <option value="expired" ${status == 'expired' ? 'selected' : ''}>Đã hết hạn</option>
                                <option value="upcoming" ${status == 'upcoming' ? 'selected' : ''}>Sắp diễn ra</option>
                            </select>
                            <!-- Thêm bộ lọc ngày -->
                            <input type="date" name="fromDate" value="${fromDate}">

                            <input type="date" name="toDate" value="${toDate}">
                            <input type="hidden" name="page" value="${page}">
                            <select name="pageSize" id="pageSizeSelect">
                                <option value="5" ${pageSize == 5 ? 'selected' : ''}>5/Trang</option>
                                <option value="10" ${pageSize == 10 ? 'selected' : ''}>10/Trang</option>
                                <option value="15" ${pageSize == 15 ? 'selected' : ''}>15/Trang</option>
                                <option value="25" ${pageSize == 25 ? 'selected' : ''}>25/Trang</option>
                            </select>
                            <button type="submit" class="search-button">
                                <i class="fas fa-search"></i>
                                <span class="search-text">Tìm kiếm</span>
                            </button>
                        </div>
                    </form>
                    <div class="action-buttons">
                        <a href="ManagerAddDiscountServlet?page=${page}&pageSize=${pageSize}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}" class="btn-add">
                            <i class="fas fa-plus"></i> Thêm mã giảm giá
                        </a>
                    </div>
                </div>


                <div class="discount-list">
                    <table class="discount-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Mã giảm giá</th>

                                <th>Giảm giá</th>
                                <th>Số lượng</th>
                                <th>Ngày bắt đầu</th>
                                <th>Ngày kết thúc</th>
                                <th>Trạng thái</th>
                                <th>Ngày tạo</th>
                                <th>Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:choose>
                                <c:when test="${empty discountList}">
                                    <tr>
                                        <td colspan="10" style="text-align: center; color: gray; font-style: italic;">
                                            Không tìm thấy mã giảm giá nào phù hợp.
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="discount" items="${discountList}" varStatus="i">
                                        <tr>
                                            <td>${discount.id}</td>
                                            <td>${discount.code}</td>
                                            <!-- <td>{discount.description}</td> -->   
                                            <td><fmt:formatNumber value="${discount.percent}" maxFractionDigits="0" />%</td>
                                            <td>${discount.quantity}</td>
                                            <td>
                                                <fmt:formatDate value="${discount.validFrom}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${discount.validTo}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <c:set var="now" value="<%= new java.util.Date() %>"/>

                                            <td>
                                                <c:choose>
                                                    <c:when test="${!discount.status}">
                                                        <span class="status inactive">Ngừng hoạt động</span>
                                                    </c:when>
                                                    <c:when test="${discount.status and discount.validFrom gt now}">
                                                        <span class="status upcoming">Sắp diễn ra</span>
                                                    </c:when>
                                                    <c:when test="${discount.status and discount.validTo lt now}">
                                                        <span class="status expired">Đã hết hạn</span>
                                                    </c:when>
                                                    <c:when test="${discount.status and discount.validFrom le now and discount.validTo ge now}">
                                                        <span class="status active">Đang hoạt động</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="status inactive">Không xác định</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${discount.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td>
                                                <a href="javascript:void(0);" class="btn-edit btn-view" title="Xem chi tiết"
                                                   onclick="showDiscountDetail(${discount.id})">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <a href="managerEditDiscountServlet?id=${discount.id}&page=${page}&pageSize=${pageSize}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}" 
                                                   class="btn-edit" 
                                                   title="Cập nhật">
                                                    Cập nhật
                                                </a>
                                                <a href="managerDeleteDiscountServlet?id=${discount.id}&page=${page}&pageSize=${pageSize}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}"
                                                   class="btn-disable"
                                                   title="Xóa"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa mã giảm giá này?');">
                                                    Xóa
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:otherwise>
                            </c:choose>
                        </tbody>

                    </table>

                    <!-- PHÂN TRANG -->
                    <c:if test="${endP > 1}">
                        <div class="pagination">
                            <c:if test="${page > 1}">
                                <a href="managerDiscountServlet?page=${page-1}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&pageSize=${pageSize}">«</a>
                            </c:if>
                            <c:forEach begin="1" end="${endP}" var="i">
                                <a href="managerDiscountServlet?page=${i}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&pageSize=${pageSize}" class="${i == page ? 'active' : ''}">${i}</a>
                            </c:forEach>
                            <c:if test="${page < endP}">
                                <a href="managerDiscountServlet?page=${page+1}&keyword=${fn:escapeXml(keyword)}&status=${fn:escapeXml(status)}&pageSize=${pageSize}">»</a>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- Modal xem chi tiết -->
        <div id="discountDetailModal" class="modal" style="display:none;">
            <div class="modal-content">
                <span class="close" onclick="closeDiscountModal()">&times;</span>
                <div id="discountDetailBody">
                    <!-- Nội dung sẽ được load ở đây -->
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
                }, 400);
            });

            function showDiscountDetail(discountId) {
                var modal = document.getElementById('discountDetailModal');
                var body = document.getElementById('discountDetailBody');
                body.innerHTML = `
                    <div class="loading-spinner">
                        <div class="spinner"></div>
                        <p>Loading discount details...</p>
                    </div>
                `;
                modal.style.display = 'flex';
                setTimeout(() => modal.classList.add('show'), 10);

                var params = new URLSearchParams({id: discountId});
                fetch("managerDetailDiscountAjax", {
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
                                    <p>Failed to load discount details. Please try again.</p>
                                </div>
                            `;
                        });
            }

            function closeDiscountModal() {
                var modal = document.getElementById('discountDetailModal');
                modal.classList.remove('show');
                setTimeout(() => {
                    modal.style.display = 'none';
                    document.getElementById('discountDetailBody').innerHTML = '';
                }, 300);
            }
        </script>

    </body>
</html>