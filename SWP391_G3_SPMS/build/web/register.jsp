<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <title>Đăng ký</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous" />
        <style>
            body {
                background: linear-gradient(135deg, #00c6ff 0%, #0072ff 100%);
                min-height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                color: #333;
            }
            .register-card {
                background: #fff;
                border-radius: 15px;
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
                padding: 40px 30px;
                width: 100%;
                max-width: 720px;
            }
            .register-card h2 {
                margin-bottom: 20px;
                font-weight: 700;
                color: #0072ff;
                text-align: center;
                letter-spacing: 1.5px;
            }
            .form-section-title {
                font-weight: 600;
                color: #005bb5;
                font-size: 17px;
                margin-bottom: 15px;
                margin-top: 10px;
            }
            .form-control:focus {
                border-color: #0072ff;
                box-shadow: 0 0 8px rgba(0, 114, 255, 0.5);
            }
            .btn-primary {
                background-color: #0072ff;
                border: none;
                padding: 12px;
                font-weight: 600;
                transition: background-color 0.3s ease;
                width: 100%;
            }
            .btn-primary:hover {
                background-color: #005bb5;
            }
            .error-message {
                margin-bottom: 15px;
                padding: 12px;
                background-color: #f8d7da;
                color: #842029;
                border-radius: 8px;
                font-weight: 600;
                text-align: center;
            }
            .login-link {
                margin-top: 20px;
                text-align: center;
                font-size: 14px;
                color: #555;
            }
            .login-link a {
                color: #0072ff;
                text-decoration: none;
                font-weight: 600;
            }
            .login-link a:hover {
                text-decoration: underline;
            }
            .google-signin {
                margin-top: 25px;
                display: flex;
                justify-content: center;
            }
            .g_id_signin {
                width: 100% !important;
                max-width: 320px;
                margin: 0 auto;
                display: block;
            }
            @media (max-width: 991.98px) {
                .register-card {
                    max-width: 95vw;
                    padding: 28px 10px;
                }
            }
            @media (max-width: 767.98px) {
                .register-card {
                    max-width: 99vw;
                    padding: 10px 2vw;
                }
            }
            .sucees_message{
                margin-bottom: 15px;
                padding: 12px;
                background-color: greenyellow;

                border-radius: 8px;
                font-weight: 600;
                text-align: center;
            }
        </style>
    </head>
    <body>

        <div class="register-card">
            <h2>Đăng ký</h2>

            <c:if test="${not empty error}">
                <p class="error-message">${error}</p>
            </c:if>
            <c:if test="${not empty mess}">
                <p class="sucees_message">${mess}</p>
            </c:if>


            <form action="register" method="POST" autocomplete="off">
    <div class="row">
        <div class="col-md-12">
            <!-- Full Name -->
            <div class="mb-3">
                <label for="full_name" class="form-label">Họ và tên</label>
                <input type="text" id="full_name" name="full_name" class="form-control" placeholder="Nhập họ và tên"
                       value="${param.full_name != null ? param.full_name : ''}" />
            </div>

            <!-- Email -->
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="text" id="email" name="email" class="form-control" placeholder="email@gmail.com"
                       value="${param.email != null ? param.email : ''}" />
            </div>

            <!-- Phone -->
            <div class="mb-3">
                <label for="phone" class="form-label">Số điện thoại</label>
                <input type="tel" id="phone" name="phone" class="form-control" placeholder="Nhập số điện thoại"
                       value="${param.phone != null ? param.phone : ''}" />
            </div>

            <!-- Username -->
            <div class="mb-3">
                <label for="username" class="form-label">Tên đăng nhập</label>
                <input type="text" id="username" name="username" class="form-control" placeholder="Tên đăng nhập"
                       value="${param.username != null ? param.username : ''}" />
            </div>

            <!-- Password -->
             <div class="mb-3">
                <label for="password" class="form-label">Nhập mật khẩu</label>
                <input type="password" id="password" name="password" class="form-control" placeholder="Nhập mật khẩu" />
            </div>
            <!-- Confirm Password -->
            <div class="mb-3">
                <label for="confirm_password" class="form-label">Nhập lại mật khẩu</label>
                <input type="password" id="confirm_password" name="confirm_password" class="form-control" placeholder="Nhập lại mật khẩu" />
            </div>

            <!-- Submit Button (aligned bottom) -->
            <div class="mb-3 mt-4 pt-2">
                <button type="submit" class="btn btn-primary w-100">Đăng ký</button>
            </div>
        </div>
    </div>
</form>


            <div class="login-link">
                <a href="landingpage.jsp">Quay lại trang chủ</a>
            </div>
            <div class="login-link">
                Đã có tài khoản? <a href="login.jsp">Đăng nhập</a>
            </div>


        </div>
        <script src="https://accounts.google.com/gsi/client" async defer></script>
    </body>
</html>