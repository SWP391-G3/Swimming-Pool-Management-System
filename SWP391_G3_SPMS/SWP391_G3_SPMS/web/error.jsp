<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lỗi</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f8f9fa;
                text-align: center;
                padding: 50px;
            }
            .error-container {
                background-color: #fff;
                border: 1px solid #dee2e6;
                border-radius: 5px;
                padding: 30px;
                display: inline-block;
                box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            }
            h1 {
                color: #dc3545;
            }
            p {
                font-size: 1.2em;
            }
            strong {
                color: #555;
            }
        </style>
    </head>
    <body>
        <div class="error-container">
            <h1>Đã có lỗi xảy ra</h1>
            <p>Chi tiết lỗi:</p>
                    <p><strong><%= request.getAttribute("errorMessage") != null ? request.getAttribute(
                   "errorMessage") : "Không có thông tin lỗi."%></strong></p>
            <br/>
            <a href="javascript:history.back()">Quay lại trang trước</a>
        </div>
    </body>
s</html>