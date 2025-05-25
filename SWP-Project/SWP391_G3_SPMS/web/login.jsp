<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <title>Login - Swimming Pool Management</title>
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
            .login-card {
                background: #fff;
                border-radius: 15px;
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
                padding: 40px 30px;
                width: 100%;
                max-width: 420px;
            }
            .login-card h2 {
                margin-bottom: 30px;
                font-weight: 700;
                color: #0072ff;
                text-align: center;
                letter-spacing: 1.5px;
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
                text-align: center;
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
        </style>
    </head>
    <body>
        <div class="login-card">
            <h2>Pool Management Login</h2>
            <form action="login" method="POST" autocomplete="off">
                <c:if test="${not empty error}">
                    <p style="color:red;">${error}</p>
                </c:if>

                <div class="mb-3">
                    <label for="usernameInput" class="form-label">Username</label>
                    <input type="text" id="usernameInput" name="username" class="form-control" placeholder="Enter your username" required autofocus>
                </div>

                <div class="mb-3">
                    <label for="passwordInput" class="form-label">Password</label>
                    <input type="password" id="passwordInput" name="password" class="form-control" placeholder="Enter your password" required>
                </div>

<!--                <div class="d-flex justify-content-between align-items-center mb-3">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="rememberCheck" />
                        <label class="form-check-label" for="rememberCheck">Remember me</label>
                    </div>
                </div>-->

                <button type="submit" class="btn btn-primary w-100">Login</button>

                <div class="register-link">
                    Don't have an account? <a href="register.jsp">Register now</a>
                </div>
            </form>
        </div>
    </body>
</html>
