<%-- 
    Document   : managerError.jsp
    Created on : Jul 19, 2025, 10:15:19 PM
    Author     : Tuan Anh
--%>

<%@page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Lỗi hệ thống - Manager Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <div class="alert alert-danger">
            <h4 class="alert-heading"><i class="fas fa-exclamation-triangle"></i> Đã xảy ra lỗi!</h4>
            <hr>
            <p><strong>Lý do:</strong> <span style="color:darkred">${error}</span></p>
        </div>
        <div>
            <a href="javascript:history.back()" class="btn btn-primary">Quay lại</a>
            <a href="managerDashBoardServlet" class="btn btn-secondary">Về Dashboard</a>
        </div>
    </div>
</body>
</html>
