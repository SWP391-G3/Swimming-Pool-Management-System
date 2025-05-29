<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Home - Pool Management</title>
<style>
    body {
        margin: 0; 
        font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #f5f9ff 0%, #d8e6ff 100%);
        color: #333;
        min-height: 100vh;
        padding: 20px 40px;
        box-sizing: border-box;
    }
    header {
        display: flex;
        justify-content: flex-end;
        padding-bottom: 20px;
    }
    header a {
        color: #1976d2;
        margin-left: 20px;
        font-weight: 600;
        text-decoration: none;
        border: 2px solid transparent;
        padding: 8px 14px;
        border-radius: 8px;
        transition: all 0.3s ease;
    }
    header a:hover {
        background: #1976d2;
        color: #fff;
        border-color: #1976d2;
    }

    /* Title */
    h1 {
        text-align: center;
        margin-bottom: 25px;
        font-weight: 700;
        font-size: 2.4rem;
        color: #0d47a1;
        text-shadow: 1px 1px 4px rgba(0,0,0,0.1);
    }

    /* Filter form */
    form.filter-form {
        display: flex;
        gap: 15px;
        margin-bottom: 30px;
        flex-wrap: nowrap;
        justify-content: center;
        align-items: center;
    }

    form.filter-form input[type="text"],
    form.filter-form select {
        padding: 10px 14px;
        font-size: 16px;
        border-radius: 6px;
        border: 1px solid #aaa;
        width: 220px;
        box-sizing: border-box;
        transition: box-shadow 0.3s ease;
        color: #1976d2;
        font-weight: 600;
        background: #fff;
    }

    form.filter-form input[type="text"]:focus,
    form.filter-form select:focus {
        outline: none;
        box-shadow: 0 0 8px #1565c0;
    }

    form.filter-form button {
        padding: 10px 28px;
        background-color: #1565c0;
        color: white;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        font-weight: 700;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }

    form.filter-form button:hover {
        background-color: #0d47a1;
    }

    /* Table */
    table {
        width: 100%;
        border-collapse: collapse;
        background: #fff;
        color: #0d47a1;
        border-radius: 10px;
        overflow: hidden;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }

    table th, table td {
        padding: 14px 18px;
        text-align: left;
        border-bottom: 1px solid #bbdefb;
        font-weight: 600;
        vertical-align: middle;
    }

    table th {
        background-color: #1565c0;
        color: white;
    }

    table tr:hover {
        background-color: #e3f2fd;
        cursor: default;
    }

    /* Image */
    .pool-img {
        width: 80px;
        height: 50px;
        object-fit: cover;
        border-radius: 6px;
    }

    /* Pagination */
    .pagination {
        display: flex;
        justify-content: center;
        margin-top: 30px;
        gap: 8px;
        flex-wrap: wrap;
    }
    .pagination a {
        padding: 8px 14px;
        border: 1px solid #1976d2;
        color: #1976d2;
        border-radius: 6px;
        font-weight: 600;
        text-decoration: none;
        transition: background-color 0.3s ease, color 0.3s ease;
    }
    .pagination a:hover {
        background-color: #1976d2;
        color: #fff;
    }
    .pagination .active {
        background-color: #1565c0;
        color: #fff;
        border-color: #1565c0;
    }

    /* Responsive */
    @media(max-width: 768px) {
        form.filter-form {
            flex-wrap: wrap;
            justify-content: center;
        }
        form.filter-form input[type="text"],
        form.filter-form select,
        form.filter-form button {
            width: 100%;
        }
    }
</style>
</head>
<body>

<header>
    <a href="login.jsp">Login</a>
    <a href="register.jsp">Register</a>
</header>

<h1>Our Swimming Pools</h1>

<form class="filter-form" method="GET" action="poolsList">
    <input type="text" name="searchName" placeholder="Search by pool name" value="${param.searchName != null ? param.searchName : ''}" />
    <input type="text" name="searchLocation" placeholder="Search by location" value="${param.searchLocation != null ? param.searchLocation : ''}" />
    <select name="sortBy">
        <option value="">Sort by max slots</option>
        <option value="asc" ${param.sortBy == 'asc' ? 'selected' : ''}>Ascending</option>
        <option value="desc" ${param.sortBy == 'desc' ? 'selected' : ''}>Descending</option>
    </select>
    <button type="submit">Filter</button>
</form>

<table>
    <thead>
        <tr>
            <th>Image</th>
            <th>Pool Name</th>
            <th>Road</th>
            <th>Address</th>
            <th>Max Slots</th>
            <th>Open Time</th>
            <th>Close Time</th>
            <th>Status</th>
        </tr>
    </thead>
    <tbody>
        <c:forEach var="pool" items="${pools}">
            <tr>
                <td><img class="pool-img" src="${pool.pool_image}" alt="${pool.pool_name}"/></td>
                <td>${pool.pool_name}</td>
                <td>${pool.pool_road}</td>
                <td>${pool.pool_address}</td>
                <td>${pool.max_slot}</td>
                <td>${pool.open_time}</td>
                <td>${pool.close_time}</td>
                <td>
                    <c:choose>
                        <c:when test="${pool.pool_status}">Open</c:when>
                        <c:otherwise>Closed</c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </tbody>
</table>

<c:if test="${totalPages > 1}">
    <div class="pagination">
        <c:forEach begin="1" end="${totalPages}" var="pageNum">
            <c:choose>
                <c:when test="${pageNum == currentPage}">
                    <a href="?page=${pageNum}&searchName=${param.searchName}&searchLocation=${param.searchLocation}&sortBy=${param.sortBy}" class="active">${pageNum}</a>
                </c:when>
                <c:otherwise>
                    <a href="?page=${pageNum}&searchName=${param.searchName}&searchLocation=${param.searchLocation}&sortBy=${param.sortBy}">${pageNum}</a>
                </c:otherwise>
            </c:choose>
        </c:forEach>
    </div>
</c:if>

</body>
</html>
