

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <title>Trang chủ</title>
        <link rel="stylesheet" href="./styleindex/styleindex.css">
    </head>
    <body>

        <header>
            <c:if test="${not empty sessionScope.currentUser}">
                <span>Welcome, ${sessionScope.currentUser.username}</span>
                |
                <a href="LogoutServlet">Logout</a>
            </c:if>

                <c:if test="${empty sessionScope.currentUser}">
                <a href="login.jsp">Đăng nhập</a>
                <a href="register.jsp">Đăng ký</a>
            </c:if>
        </header>



        <h1>Bể bơi của chúng tôi</h1>

        <form class="filter-form" method="GET" action="homepage">
            <input type="text" name="searchName" placeholder="Tìm theo tên" value="${param.searchName != null ? param.searchName : ''}" />
            <input type="text" name="searchLocation" placeholder="Tìm theo vị trí" value="${param.searchLocation != null ? param.searchLocation : ''}" />
            <select name="sortBy">
                <option value="">Sắp xếp theo sức chứa </option>
                <option value="asc" ${param.sortBy == 'asc' ? 'selected' : ''}>Tăng dần</option>
                <option value="desc" ${param.sortBy == 'desc' ? 'selected' : ''}>Giảm dần</option>
            </select>
            <button type="submit">Tìm</button>
        </form>

        <!-- Card Grid -->
        <c:if test="${empty pools}">
            <div class="no-pool-message">
                Không có bể bơi nào phù hợp.
            </div>
        </c:if>
        <div class="pool-card-grid">

            <c:forEach var="pool" items="${pools}">
                <div class="pool-card" onclick="window.location = 'pool-detail?poolId=${pool.pool_id}'">
                    <img class="pool-img" src="${pool.pool_image}" alt="${pool.pool_name}" />
                    <div class="pool-card-content">
                        <h2 class="pool-name">${pool.pool_name}</h2>
                        <div class="pool-info">
                            <p><strong>Đường: </strong> ${pool.pool_road}</p>
                            <p><strong>Địa chỉ: </strong> ${pool.pool_address}</p>
                            <p><strong>Tối đa: </strong> ${pool.max_slot}</p>
                            <p><strong>Mở:</strong> ${pool.open_time} - ${pool.close_time}</p>
                            <p>
                                <strong>Trạng thái:</strong>
                                <span class="${pool.pool_status ? 'status-open' : 'status-closed'}">
                                    <c:choose>
                                        <c:when test="${pool.pool_status}">Đang hoạt động</c:when>
                                        <c:otherwise>Hủy hoạt động</c:otherwise>
                                    </c:choose>
                                </span>
                            </p>
                        </div>
                        <a href="pool-detail?poolId=${pool.pool_id}" class="detail-btn">Chi tiết</a>
                    </div>
                </div>
            </c:forEach>
        </div>



        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <!-- Nút chuyển về trang đầu tiên -->
                <c:if test="${currentPage > 1}">
                    <a href="homepage?page=1&searchName=${param.searchName}&searchLocation=${param.searchLocation}&sortBy=${param.sortBy}">&laquo;</a>
                </c:if>

                <!-- Các nút phân trang -->
                <c:forEach begin="1" end="${totalPages}" var="pageNum">
                    <c:choose>
                        <c:when test="${pageNum == currentPage}">
                            <a href="homepage?page=${pageNum}&searchName=${param.searchName}&searchLocation=${param.searchLocation}&sortBy=${param.sortBy}" class="active">${pageNum}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="homepage?page=${pageNum}&searchName=${param.searchName}&searchLocation=${param.searchLocation}&sortBy=${param.sortBy}">${pageNum}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <!-- Nút chuyển về trang cuối cùng -->
                <c:if test="${currentPage < totalPages}">
                    <a href="?page=${totalPages}&searchName=${param.searchName}&searchLocation=${param.searchLocation}&sortBy=${param.sortBy}">&raquo;</a>
                </c:if>
            </div>
        </c:if>


    </body>
</html>