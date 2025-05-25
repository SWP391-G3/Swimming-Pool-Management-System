<%@ page contentType="text/html;charset=UTF-8" language="java" %>


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
            .success-message {
                margin-bottom: 15px;
                padding: 12px;
                background-color: #d4edda;
                color: #155724;
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
        </style>
    </head>
    <body>

        <div class="register-card">
            <h2>Register Account</h2>

            <%
           String error = (String) request.getAttribute("error");
           if (error != null) {
            %>
            <p style="color:red;"><%= error %></p>
            <%
                }
            %>


            <form action="register" method="POST" autocomplete="off">
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" id="username" name="username" class="form-control" placeholder="Enter username" required
                           value="<%= request.getParameter("username") != null ? request.getParameter("username") : "" %>" />
                </div>

                <div class="mb-3">
                    <label for="full_name" class="form-label">Full Name</label>
                    <input type="text" id="full_name" name="full_name" class="form-control" placeholder="Enter full name" required
                           value="<%= request.getParameter("full_name") != null ? request.getParameter("full_name") : "" %>" />
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" id="email" name="email" class="form-control" placeholder="Enter email (@gmail.com)" required
                           value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" />
                </div>

                <div class="mb-3">
                    <label for="phone" class="form-label">Phone</label>
                    <input type="tel" id="phone" name="phone" class="form-control" pattern="[0-9]{9,12}" placeholder="Enter phone number" required
                           value="<%= request.getParameter("phone") != null ? request.getParameter("phone") : "" %>" />
                </div>

                <div class="mb-3">
                    <label for="address" class="form-label">Address</label>
                    <input type="text" id="address" name="address" class="form-control" placeholder="Enter address" required
                           value="<%= request.getParameter("address") != null ? request.getParameter("address") : "" %>" />
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" id="password" name="password" class="form-control" placeholder="Enter password" required />
                    <!--value="<%= request.getParameter("password") != null ? request.getParameter("password") : "" %>" />-->
                </div>

                <button type="submit" class="btn btn-primary w-100">Register</button>
            </form>

            <div class="login-link">
                Already have an account? <a href="login.jsp">Login here</a>
            </div>
        </div>

    </body>
</html>
