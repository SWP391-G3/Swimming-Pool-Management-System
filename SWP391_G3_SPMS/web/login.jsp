<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Đăng nhập</title>
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
                margin: 0;
            }

            .login-card {
                background: #fff;
                border-radius: 15px;
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
                padding: 40px;
                width: 100%;
                max-width: 420px;
                box-sizing: border-box;
                text-align: center;
            }

            .login-card h2 {
                margin-bottom: 30px;
                font-weight: 700;
                color: #0072ff;
                letter-spacing: 1.5px;
            }

            .back-to-home-link {
                margin-top: 20px;
                text-align: center;
                font-size: 14px;
                color: #555;
            }
            .back-to-home-link a {
                color: #0072ff;
                text-decoration: none;
                font-weight: 600;
            }
            .back-to-home-link a:hover {
                text-decoration: underline;
            }

            label.form-label {
                display: block;
                margin-bottom: 8px;
                font-weight: 600;
                text-align: left;
                color: #333;
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
                margin-top: 10px;
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

            .register-link {
                margin-top: 20px;
                font-size: 14px;
                color: #555;
            }

            .register-link a {
                color: #0072ff;
                text-decoration: none;
                font-weight: 600;
            }

            .register-link a:hover {
                text-decoration: underline;
            }

            /* Google Login button */
            .google-btn {
                display: inline-flex;
                align-items: center;
                background: white;
                color: #757575;
                border: 1px solid #dadce0;
                border-radius: 4px;
                padding: 10px 15px;
                font-family: Roboto, Arial, sans-serif;
                font-weight: 500;
                font-size: 14px;
                cursor: pointer;
                text-decoration: none;
                user-select: none;
                transition: box-shadow 0.2s ease-in-out;
                width: 100%;
                max-width: 320px;
                box-sizing: border-box;
                justify-content: center;
                margin: 20px auto 0 auto;
                box-shadow: 0 1px 1px rgb(0 0 0 / 0.1);
            }

            .google-btn:hover,
            .google-btn:focus {
                box-shadow: 0 2px 4px rgb(0 0 0 / 0.2);
                outline: none;
                color: #202124;
            }

            .google-icon {
                height: 18px;
                width: 18px;
                margin-right: 12px;
            }

            .or-text {
                margin-top: 10px;
                margin-bottom: 10px;
                font-weight: 700;
                color: #555;
                font-size: 18px;
                letter-spacing: 1px;
            }

        </style>
    </head>
    <body>
        <div class="login-card">
            <h2>Đăng nhập</h2>
            <form action="login" method="POST" autocomplete="off">
                <c:if test="${not empty error}">
                    <p class="error-message">${error}</p>
                </c:if>

                <!-- Username Input -->
                <label for="usernameInput" class="form-label">Tên đăng nhập</label>
                <input type="text" id="usernameInput" name="username" class="form-control" placeholder="Nhập tên đăng nhập" required autofocus>

                <!-- Password Input -->
                <label for="passwordInput" class="form-label" style="margin-top:15px;">Mật khẩu</label>
                <input type="password" id="passwordInput" name="password" class="form-control" placeholder="Nhập mật khẩu" required>

                <button type="submit" class="btn btn-primary">Đăng nhập</button>
            </form>

            <div class="register-link">
                Bạn chưa có tài khoản? <a href="register.jsp">Đăng ký ngay</a>
            </div>

            <div class="or-text">Hoặc</div>



            <a href="https://accounts.google.com/o/oauth2/auth?scope=email&redirect_uri=http://localhost:8080/SWP391_G3_SPMS/LoginGoogle&response_type=code&client_id=1011626607904-oroog9kq0dj2t481qcqkp39325sgcjvj.apps.googleusercontent.com&approval_prompt=force"
               class="google-btn" role="button" aria-label="Login with Google">
                <svg class="google-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 533.5 544.3">
                <path fill="#4285F4" d="M533.5 278.4c0-17.7-1.6-34.8-4.6-51.4H272v97.5h146.9c-6.3 34.1-25.3 62.9-54 82.1v68h87.2c51-47 80.4-116.1 80.4-195.6z"/>
                <path fill="#34A853" d="M272 544.3c73.5 0 135.3-24.4 180.4-66.3l-87.2-68c-24 16.1-54.8 25.7-93.2 25.7-71.6 0-132.4-48.3-154.3-113.1H29.5v70.8c45.4 89 138.8 151.9 242.5 151.9z"/>
                <path fill="#FBBC05" d="M117.7 323.6c-10.4-30.6-10.4-63.5 0-94.1V158.7H29.5c-39.3 76.8-39.3 168.7 0 245.5l88.2-80.6z"/>
                <path fill="#EA4335" d="M272 107.7c39.8 0 75.5 13.7 103.7 40.8l77.7-77.7C404.9 24.6 343 0 272 0 168.3 0 74.9 62.9 29.5 152.9l88.2 80.8c22-64.8 82.8-113 154.3-113z"/>
                </svg>
                Đăng nhập với Google
            </a>
            <div class="back-to-home-link">
                <a href="homepage">Quay lại trang chủ</a>
            </div>
        </div>
    </body>
</html>