<%-- 
    Document   : header
    Created on : Jul 3, 2025, 11:17:28 PM
    Author     : LAZYVL
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="model.customer.*, java.util.*" %>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    String userName = (currentUser != null) ? currentUser.getFull_name() : "";
    String avatar = (currentUser != null && currentUser.getImages() != null && !currentUser.getImages().isEmpty())
        ? currentUser.getImages() : "default-avatar.png";
    String userEmail = (currentUser != null) ? currentUser.getEmail() : "";
    String homeUrl = (currentUser != null) ? "customerHome" : "home";
%>
<!-- header -->
<header class="bg-white shadow-md w-full">
    <div class="container mx-auto px-4">
        <div class="flex items-center justify-between py-4">
            <!-- Logo -->
            <div class="flex items-center space-x-3">
                <div class="h-20 w-20">
                    <a href="<%= homeUrl %>">
                        <img src="images/logoPool.png" alt="Logo" class="h-full w-full object-contain" />
                    </a>
                </div>
                <a href="<%= homeUrl %>" class="text-3xl md:text-5xl font-bold text-[#33CCFF]">PoolHub</a>
            </div>

            <!-- Navigation -->
            <nav class="hidden md:flex space-x-6 text-base font-medium items-center">
                <a href="<%= homeUrl %>" class="text-gray-700 hover:text-[#33CCFF] hover:underline underline-offset-4 transition duration-300">Trang Chủ</a>
                <a href="#" class="text-gray-700 hover:text-[#33CCFF] hover:underline underline-offset-4 transition duration-300">Giới Thiệu</a>
                <a href="customerViewPoolList" class="text-gray-700 hover:text-[#33CCFF] hover:underline underline-offset-4 transition duration-300">Bể Bơi</a>
                <a href="#" class="text-gray-700 hover:text-[#33CCFF] hover:underline underline-offset-4 transition duration-300">Đánh Giá</a>
                <a href="contact" class="text-gray-700 hover:text-[#33CCFF] hover:underline underline-offset-4 transition duration-300">Liên Hệ</a>
                <% if (currentUser != null) { %>
                <!-- Nếu đã đăng nhập -->
                <a href="my_account" class="flex items-center space-x-2 text-gray-700 hover:text-[#33CCFF] hover:underline underline-offset-4 transition duration-300">
                    <span>Tài khoản <%= !userName.isEmpty() ? ("| " + userName) : "" %></span>
                    <img src="<%= avatar %>" alt="avatar" class="w-8 h-8 rounded-full object-cover border border-gray-300" />
                </a>
                <% } else { %>
                <!-- Nếu chưa đăng nhập -->
                <a href="login.jsp" class="flex items-center space-x-2 text-gray-700 hover:text-[#33CCFF] hover:underline underline-offset-4 transition duration-300">
                    <span>Đăng nhập</span>
                </a>
                <% } %>
            </nav>
        </div>
    </div>
</header>
<!-- end header -->
