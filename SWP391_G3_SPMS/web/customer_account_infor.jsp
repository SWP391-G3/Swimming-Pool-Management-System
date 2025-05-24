<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    User user = (User) request.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Account Information</title>
    <link rel="stylesheet" href="https://unpkg.com/bootstrap@5.3.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="customerAccountInfo.css">
</head>
<body>
<div class="container account-container shadow-lg rounded-4 p-4 my-5 bg-white animate-fadeInUp">
    <h2 class="text-primary text-center mb-4 animate-slideDown">Account Information</h2>
    <% if (user == null) { %>
        <div class="alert alert-danger">User not found or not logged in.</div>
    <% } else { %>
    <% if (request.getAttribute("updateSuccess") != null) { %>
        <div class="alert alert-success"><%= request.getAttribute("updateSuccess") %></div>
    <% } %>
    <% if (request.getAttribute("updateError") != null) { %>
        <div class="alert alert-danger"><%= request.getAttribute("updateError") %></div>
    <% } %>
    <form method="post" action="profile">
        <table class="table table-borderless">
            <tr>
                <th scope="row" class="text-primary">Full Name:</th>
                <td><input type="text" class="form-control" name="full_name" value="<%= user.getFull_name() %>"></td>
            </tr>
            <tr>
                <th scope="row" class="text-primary">Email:</th>
                <td><input type="email" class="form-control" name="email" value="<%= user.getEmail() %>"></td>
            </tr>
            <tr>
                <th scope="row" class="text-primary">Phone:</th>
                <td><input type="text" class="form-control" name="phone" value="<%= user.getPhone() %>"></td>
            </tr>
            <tr>
                <th scope="row" class="text-primary">Address:</th>
                <td><input type="text" class="form-control" name="address" value="<%= user.getAddress() %>"></td>
            </tr>
            <tr>
                <th scope="row" class="text-primary">Username:</th>
                <td><input type="text" class="form-control" value="<%= user.getUsername() %>" readonly></td>
            </tr>
            <tr>
                <th scope="row" class="text-primary">Status:</th>
                <td>
                    <span class="badge <%= user.isStatus() ? "bg-success" : "bg-danger" %>">
                        <%= user.isStatus() ? "Active" : "Inactive" %>
                    </span>
                </td>
            </tr>
            <tr>
                <th scope="row" class="text-primary">Created At:</th>
                <td><%= user.getCreate_at() %></td>
            </tr>
            <tr>
                <th scope="row" class="text-primary">Last Updated:</th>
                <td><%= user.getUpdate_at() %></td>
            </tr>
        </table>
        <div class="d-flex justify-content-end">
            <button type="submit" class="btn btn-primary px-4 fw-semibold shadow-sm">Update Profile</button>
        </div>
    </form>
    <% } %>
</div>
<script src="https://unpkg.com/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>