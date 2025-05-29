<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Admin Dashboard</title>
<style>
    body {
        margin: 0; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
        color: #fff;
        min-height: 100vh;
    }
    header {
        display: flex;
        justify-content: flex-end;
        align-items: center;
        padding: 20px 40px;
        background: rgba(0,0,0,0.3);
        gap: 20px;
        font-weight: 600;
    }
    header a {
        color: #fff;
        text-decoration: none;
        border: 2px solid transparent;
        padding: 8px 14px;
        border-radius: 8px;
        transition: all 0.3s ease;
    }
    header a:hover {
        background: #fff;
        color: #764ba2;
        border-color: #764ba2;
    }
    main {
        padding: 40px;
        font-size: 1.8rem;
        text-align: center;
    }
</style>
</head>
<body>
<header>
    <span>Welcome, <c:out value="${sessionScope.currentUser.username}" /></span>
    <a href="LogoutServlet">Logout</a>
</header>
<main>
    <h1>Admin Dashboard</h1>
    <p>Đây là trang dành cho admin sau khi đăng nhập.</p>
</main>
</body>
</html>