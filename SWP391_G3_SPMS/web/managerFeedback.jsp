<%-- 
    Document   : managerFeedback
    Created on : Jul 5, 2025, 2:40:00 PM
    Author     : Tuan Anh
--%>

<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    request.setAttribute("activeMenu", "feedback");
%>

<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Quản lý Phản hồi</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
        <link rel="stylesheet" href="./manager-css/manager-panel.css">
        <link rel="stylesheet" href="./manager-css/managerFeedback-v3.css">
    </head>

    <body>

        <div id="toast" class="toast"></div>


        <div class="layout">
            <div class="sidebar">
                <%@ include file="../managerSidebar.jsp" %>
            </div>
            <div class="content-panel">
                <div class="header">
                    <div class="header-title-row">
                        <h2>Quản lý phản hồi</h2>

                    </div>

                    <div class="filter-row">
                        <form class="search-form" method="get" action="managerFeedbackServlet" id="searchForm">
                            <input type="text" name="keyword" placeholder="Tìm theo tên hoặc nội dung..." 
                                   value="${fn:escapeXml(keyword)}" maxlength="100">

                            <select name="poolId">
                                <option value="all" <c:if test="${poolId == 'all' || empty poolId}">selected</c:if>>-- Tất cả hồ bơi --</option>
                                <c:forEach var="pool" items="${poolList}">
                                    <option value="${pool.id}" <c:if test="${pool.id.toString() == poolId}">selected</c:if>>
                                        ${pool.name}
                                    </option>
                                </c:forEach>
                            </select>

                            <select name="rating">
                                <option value="all" <c:if test="${rating == 'all' || empty rating}">selected</c:if>>Tất cả đánh giá</option>
                                <option value="1" <c:if test="${rating == '1'}">selected</c:if>>1 sao</option>
                                <option value="2" <c:if test="${rating == '2'}">selected</c:if>>2 sao</option>
                                <option value="3" <c:if test="${rating == '3'}">selected</c:if>>3 sao</option>
                                <option value="4" <c:if test="${rating == '4'}">selected</c:if>>4 sao</option>
                                <option value="5" <c:if test="${rating == '5'}">selected</c:if>>5 sao</option>
                                </select>

                                <select name="dateFilter">
                                    <option value="all" <c:if test="${dateFilter == 'all' || empty dateFilter}">selected</c:if>>Tất cả thời gian</option>
                                <option value="today" <c:if test="${dateFilter == 'today'}">selected</c:if>>Hôm nay</option>
                                <option value="week" <c:if test="${dateFilter == 'week'}">selected</c:if>>Tuần này</option>
                                <option value="month" <c:if test="${dateFilter == 'month'}">selected</c:if>>Tháng này</option>
                                </select>

                                <select name="pageSize" id="pageSizeSelect">
                                    <option value="5" <c:if test="${pageSize == 5}">selected</c:if>>5/Trang</option>
                                <option value="10" <c:if test="${pageSize == 10}">selected</c:if>>10/Trang</option>
                                <option value="15" <c:if test="${pageSize == 15}">selected</c:if>>15/Trang</option>
                                <option value="25" <c:if test="${pageSize == 25}">selected</c:if>>25/Trang</option>
                                </select>

                                <input type="hidden" name="page" value="1">
                                <button type="submit"><i class="fas fa-search"></i></button>
                            </form>

                            <div class="action-buttons">
                                <a href="managerFeedbackServlet" class="btn-copy">
                                    <i class="fa-solid fa-arrows-rotate"></i> Làm mới
                                </a>
                            </div>

                        </div>
                    </div>
                    <div class="feedback-list">
                        <table class="feedback-table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Khách hàng</th>
                                    <th>Email</th>
                                    <th>Hồ bơi</th>
                                    <th>Đánh giá</th>
                                    <th>Nội dung</th>
                                    <th>Ngày tạo</th>
                                    <th>Thao tác</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:choose>
                                <c:when test="${empty feedbackList}">
                                    <tr>
                                        <td colspan="7" style="text-align: center; color: gray; font-style: italic;">
                                            Không tìm thấy phản hồi nào phù hợp.
                                        </td>
                                    </tr>
                                </c:when>
                                <c:otherwise>
                                    <c:forEach var="feedback" items="${feedbackList}" varStatus="i">
                                        <tr>
                                            <td>${feedback.feedbackId}</td>
                                            <td>
                                                <div class="user-info">
                                                    <c:if test="${not empty feedback.userImage}">
                                                        <img src="${feedback.userImage}" alt="User Avatar" class="user-avatar">
                                                    </c:if>
                                                    <span>${feedback.userName}</span>
                                                </div>
                                            </td>
                                            <td>${feedback.userEmail}</td>
                                            <td>${feedback.poolName}</td>
                                            <td>
                                                <div class="star-rating">
                                                    <c:forEach begin="1" end="5" var="star">
                                                        <i class="fas fa-star ${star <= feedback.rating ? 'active' : ''}"></i>
                                                    </c:forEach>
                                                </div>
                                            </td>
                                            <td class="comment-cell">
                                                <div class="comment-content">
                                                    ${feedback.comment}
                                                </div>
                                                <c:if test="${fn:length(feedback.comment) > 100}">
                                                    <button class="btn-view-more" onclick="toggleComment(this)">Xem thêm</button>
                                                </c:if>
                                            </td>
                                            <td>
                                                <fmt:formatDate value="${feedback.createdAt}" pattern="dd/MM/yyyy HH:mm"/>
                                            </td>
                                            <td>

                                                <a href="managerReplyFeedbackServlet?id=${feedback.feedbackId}&page=${page}&pageSize=${pageSize}&keyword=${fn:escapeXml(keyword)}&rating=${fn:escapeXml(rating)}&dateFilter=${fn:escapeXml(dateFilter)}&poolId=${fn:escapeXml(poolId)}"
                                                   class="action-btn btn-reply"
                                                   title="Phản hồi">
                                                    <i class="fas fa-reply"></i>
                                                </a>
                                                <a href="managerDeleteFeedbackServlet?id=${feedback.feedbackId}&page=${page}&pageSize=${pageSize}&keyword=${fn:escapeXml(keyword)}&rating=${fn:escapeXml(rating)}&dateFilter=${fn:escapeXml(dateFilter)}&poolId=${fn:escapeXml(poolId)}"
                                                   class="action-btn btn-disable"
                                                   title="Xóa"
                                                   onclick="return confirm('Bạn có chắc chắn muốn xóa phản hồi này?');">
                                                    <i class="fas fa-trash"></i>
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
                                <a href="managerFeedbackServlet?page=${page-1}&keyword=${fn:escapeXml(keyword)}&rating=${fn:escapeXml(rating)}&dateFilter=${fn:escapeXml(dateFilter)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}">«</a>
                            </c:if>
                            <c:forEach begin="1" end="${endP}" var="i">
                                <a href="managerFeedbackServlet?page=${i}&keyword=${fn:escapeXml(keyword)}&rating=${fn:escapeXml(rating)}&dateFilter=${fn:escapeXml(dateFilter)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}" class="${i == page ? 'active' : ''}">${i}</a>
                            </c:forEach>
                            <c:if test="${page < endP}">
                                <a href="managerFeedbackServlet?page=${page+1}&keyword=${fn:escapeXml(keyword)}&rating=${fn:escapeXml(rating)}&dateFilter=${fn:escapeXml(dateFilter)}&poolId=${fn:escapeXml(poolId)}&pageSize=${pageSize}">»</a>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>



        <script>
            function toggleComment(button) {
                const cell = button.closest('.comment-cell');
                const content = cell.querySelector('.comment-content');
                content.classList.toggle('expanded');

                if (content.classList.contains('expanded')) {
                    button.textContent = 'Thu gọn';
                } else {
                    button.textContent = 'Xem thêm';
                }
            }





            // Tự động submit form khi thay đổi filter
            document.addEventListener('DOMContentLoaded', function () {
                const searchForm = document.getElementById('searchForm');
                const inputs = searchForm.querySelectorAll('select[name], input[name]');

                inputs.forEach(input => {
                    if (input.id !== 'pageSizeSelect') {
                        input.addEventListener('change', function () {
                            document.querySelector('input[name="page"]').value = 1; // reset về trang 1
                            searchForm.submit();
                        });
                    }
                });

                // Validate keyword
                searchForm.addEventListener('submit', function (e) {
                    const keywordInput = document.querySelector('input[name="keyword"]');
                    const keyword = keywordInput.value.trim();

                    if (keyword.length > 100) {
                        alert("Từ khóa tìm kiếm không được vượt quá 100 ký tự.");
                        e.preventDefault();
                        return;
                    }

                    const invalidPattern = /[<>']/;
                    if (invalidPattern.test(keyword)) {
                        alert("Từ khóa không được chứa ký tự < > hoặc dấu nháy.");
                        e.preventDefault();
                        return;
                    }
                });
            });
        </script>



        <script>
            function showToast(message, type = 'success') {
                const toast = document.getElementById('toast');
                toast.className = 'toast show ' + type;
                toast.innerHTML = message;
                setTimeout(function () {
                    toast.className = 'toast ' + type;
                }, 3500);
            }
        </script>
        <c:if test="${not empty success}">
            <script>
                showToast("<i class='fas fa-check-circle'></i> ${success}", "success");
            </script>
        </c:if>
        <c:if test="${not empty error}">
            <script>
                showToast("<i class='fas fa-exclamation-circle'></i> ${error}", "error");
            </script>
        </c:if>
    </body>
</html>
