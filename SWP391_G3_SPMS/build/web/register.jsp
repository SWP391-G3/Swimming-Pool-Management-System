<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <title>Register - Swimming Pool Management</title>
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
                max-width: 480px;
            }

            .register-card h2 {
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

            /* Google Sign-In button style */
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
        </style>
    </head>
    <body>

        <div class="register-card">
            <h2>Register Account</h2>

            <c:if test="${not empty error}">
                <p class="error-message">${error}</p>
            </c:if>

            <form action="register" method="POST" autocomplete="off">
                <!-- Username Input -->
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" id="username" name="username" class="form-control" placeholder="Enter username" required
                           value="${enteredUsername != null ? enteredUsername : ''}" />
                </div>

                <!-- Full Name Input -->
                <div class="mb-3">
                    <label for="full_name" class="form-label">Full Name</label>
                    <input type="text" id="full_name" name="full_name" class="form-control" placeholder="Enter full name" required
                           value="${enteredFullName != null ? enteredFullName : ''}" />
                </div>

                <!-- Email Input -->
                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" id="email" name="email" class="form-control" placeholder="Enter email (@gmail.com)" required
                           value="${enteredEmail != null ? enteredEmail : ''}" />
                </div>

                <!-- Phone Input -->
                <div class="mb-3">
                    <label for="phone" class="form-label">Phone</label>
                    <input type="text" id="phone" name="phone" class="form-control" placeholder="Enter phone number" required
                           value="${enteredPhone != null ? enteredPhone : ''}" />
                </div>

                <!-- Address Input -->
                <div class="mb-3">
                    <label for="address" class="form-label">Address</label>
                    <input type="text" id="address" name="address" class="form-control" placeholder="Enter address" required
                           value="${enteredAddress != null ? enteredAddress : ''}" />
                </div>

                <!-- Password Input -->
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Enter password" required />
                </div>

                <button type="submit" class="btn btn-primary w-100">Register</button>
            </form>

            <div class="login-link">
                Already have an account? <a href="login.jsp">Login here</a>
            </div>

            <!-- Google Sign-In Button -->
            <div class="google-signin">
                <div id="g_id_onload"
                     data-client_id="YOUR_CLIENT_ID"
                     data-login_uri="http://localhost:8080/yourapp/oauth2callback"
                     data-auto_prompt="false">
                </div>

<!--                <div class="g_id_signin"
                     data-type="standard"
                     data-size="large"
                     data-theme="outline"
                     data-text="Sign in with Google"
                     data-shape="rectangular"
                     data-logo_alignment="left">
                </div>-->


            </div>

        </div>

        <script src="https://accounts.google.com/gsi/client" async defer></script>

    </body>
</html>
