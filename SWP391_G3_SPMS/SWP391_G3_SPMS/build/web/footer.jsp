<%-- 
    Document   : footer
    Created on : Jul 3, 2025, 11:18:20 PM
    Author     : LAZYVL
--%>

<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!-- footer -->
<footer class="bg-gray-900 text-white pt-12">
    <div class="container mx-auto px-4 grid grid-cols-1 md:grid-cols-3 gap-10 pb-10">
        <!-- Liên Hệ -->
        <div>
            <h3 class="text-xl font-semibold mb-4 text-[#33CCFF]">Liên Hệ Chúng Tôi</h3>
            <ul class="space-y-3 text-gray-300">
                <li class="flex items-center gap-2">
                    <i class="fa fa-map-marker text-[#33CCFF]"></i> Địa chỉ
                </li>
                <li class="flex items-center gap-2">
                    <i class="fa fa-mobile text-[#33CCFF]"></i> +01 1234569540
                </li>
                <li class="flex items-center gap-2">
                    <i class="fa fa-envelope text-[#33CCFF]"></i>
                    <a href="mailto:poolhub@gmail.com" class="hover:underline">poolhub@gmail.com</a>
                </li>
            </ul>
        </div>

        <!-- Liên Kết Menu -->
        <div>
            <h3 class="text-xl font-semibold mb-4 text-[#33CCFF]">Liên Kết Menu</h3>
            <ul class="space-y-2 text-gray-300">
                <li><a href="#" class="hover:text-[#33CCFF] transition">Trang Chủ</a></li>
                <li><a href="#" class="hover:text-[#33CCFF] transition">Về Chúng Tôi</a></li>
                <li><a href="#" class="hover:text-[#33CCFF] transition">Bể Bơi</a></li>
                <li><a href="#" class="hover:text-[#33CCFF] transition">Thư Viện Hình Ảnh</a></li>
                <li><a href="#" class="hover:text-[#33CCFF] transition">Đánh Giá</a></li>
                <li><a href="#" class="hover:text-[#33CCFF] transition">Liên Hệ</a></li>
            </ul>
        </div>

        <!-- Đăng ký bản tin -->
        <div>
            <h3 class="text-xl font-semibold mb-4 text-[#33CCFF]">Bản Tin</h3>
            <form class="flex flex-col gap-3 mb-4">
                <input type="email" placeholder="Nhập email của bạn" 
                       class="w-full px-4 py-2 rounded-lg text-black focus:outline-none focus:ring-2 focus:ring-[#33CCFF]" />
                <button type="submit" class="bg-[#33CCFF] text-white px-4 py-2 rounded-lg hover:bg-[#1BAFDA] transition">Đăng Ký</button>
            </form>

            <div class="flex space-x-4">
                <a href="#"><i class="fa fa-facebook text-2xl hover:text-[#33CCFF] transition"></i></a>
                <a href="#"><i class="fa fa-twitter text-2xl hover:text-[#33CCFF] transition"></i></a>
                <a href="#"><i class="fa fa-linkedin text-2xl hover:text-[#33CCFF] transition"></i></a>
                <a href="#"><i class="fa fa-youtube-play text-2xl hover:text-[#33CCFF] transition"></i></a>
            </div>
        </div>
    </div>

    <!-- Copyright -->
    <div class="border-t border-gray-700 py-4 text-center text-gray-400 text-sm">
        © 2025 Tất cả quyền được bảo lưu. Thiết kế và phân phối bởi <span class="text-[#33CCFF] font-semibold">PoolHub</span>.
    </div>
</footer>
<!-- end footer -->
