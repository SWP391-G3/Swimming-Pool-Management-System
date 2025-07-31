<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>404 - Không tìm thấy trang</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                background: #f8fafc;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                margin: 0;
                padding: 0;
                color: #333;
            }
            .container {
                min-height: 100vh;
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
                text-align: center;
            }
            .error-code {
                font-size: 8rem;
                font-weight: bold;
                color: #3b82f6;
                margin-bottom: 0.5em;
            }
            .message {
                font-size: 2rem;
                margin-bottom: 1em;
            }
            .desc {
                color: #555;
                margin-bottom: 2em;
            }
            a.home-btn {
                display: inline-block;
                padding: 12px 32px;
                background: #3b82f6;
                color: #fff;
                border-radius: 8px;
                text-decoration: none;
                font-size: 1.1rem;
                transition: background 0.2s;
            }
            a.home-btn:hover {
                background: #2563eb;
            }
            .illustration {
                margin-bottom: 2em;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="illustration">
                <!-- Optional: SVG illustration or icon -->
                <svg width="120" height="120" fill="none" viewBox="0 0 24 24">
                <circle cx="12" cy="12" r="10" fill="#3b82f6" opacity="0.15"/>
                <path d="M8.5 10.5h.01M15.5 10.5h.01M9 16c1.5-1 4.5-1 6 0" stroke="#3b82f6" stroke-width="1.5" stroke-linecap="round"/>
                <circle cx="12" cy="12" r="9" stroke="#3b82f6" stroke-width="1.5"/>
                </svg>
            </div>
            <div class="error-code">404</div>
            <div class="message">Không tìm thấy trang</div>
            <div class="desc">
                Xin lỗi, trang bạn tìm kiếm không tồn tại hoặc đã bị xóa.<br/>
                Vui lòng kiểm tra lại địa chỉ URL hoặc quay về trang chủ.
            </div>
            <a class="home-btn" href="<%= request.getContextPath() %>/">Quay về trang chủ</a>
        </div>
    </body>
</html>