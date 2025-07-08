<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="java.util.List,model.customer.Pool,model.customer.FeedbackHomepage,model.customer.User" %>
<!DOCTYPE html>
<html>
    <head>
        <!-- basic -->
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <!-- mobile metas -->
        <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
        <!-- site metas -->
        <title>PoolHub</title>
        <meta name="keywords" content="bể bơi, PoolHub, đặt phòng">
        <meta name="description" content="Hệ thống bể bơi PoolHub - Nơi trải nghiệm tuyệt vời">
        <meta name="author" content="PoolHub Team">
        <!-- bootstrap css -->
        <link rel="stylesheet" href="css/bootstrap.min.css">
        <!-- style css -->
        <link rel="stylesheet" href="css/style.css">
        <!-- Responsive-->
        <link rel="stylesheet" href="css/responsive.css">
        <!-- fevicon -->
        <link rel="icon" href="images/fevicon.png" type="image/gif" />
        <!-- Scrollbar Custom CSS -->
        <link rel="stylesheet" href="css/jquery.mCustomScrollbar.min.css">
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- Tweaks for older IEs-->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.0.3/css/font-awesome.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/fancybox/2.1.5/jquery.fancybox.min.css"
              media="screen">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

        <!--[if lt IE 9]>
           <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
           <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script><![endif]-->
    </head>

    <body class="main-layout">



        <c:if test="${not empty sessionScope.message}">
            <div id="loginSuccessToast"
                 style="position:fixed;top:1.5rem;left:50%;transform:translateX(-50%);
                 background:#38a169;color:#fff;padding:0.75rem 1.25rem;
                 border-radius:0.5rem;box-shadow:0 4px 12px rgba(0,0,0,0.15);
                 z-index:9999;font-weight:600;display:flex;align-items:center;gap:.5rem;">
                ✅ ${sessionScope.message}
                <button onclick="this.parentElement.style.display = 'none'"
                        style="margin-left:0.75rem;font-weight:bold;">×</button>
            </div>

            <c:remove var="message" scope="session" />
            <script>
                setTimeout(() => {
                    const toast = document.getElementById('loginSuccessToast');
                    if (toast)
                        toast.style.display = 'none';
                }, 4000);
            </script>
        </c:if>

        <%@include file="header.jsp" %>

        <!-- banner -->
        <section class="relative w-full overflow-hidden">
            <!-- Carousel Wrapper -->
            <div class="relative h-[500px] w-full">
                <div class="absolute inset-0 animate-fade-in-out z-10">
                    <img src="images/banner2.jpg" alt="Trải nghiệm tuyệt vời" class="w-full h-full object-cover" />
                </div>
                <div class="absolute inset-0 animate-fade-in-out delay-5000 z-0">
                    <img src="images/banner3.jpg" alt="Thư giãn bên bể bơi" class="w-full h-full object-cover" />
                </div>
            </div>

            <!-- Nút điều hướng nếu muốn thêm -->
            <!--
            <div class="absolute inset-0 flex items-center justify-between px-4 z-20">
                <button class="bg-white/50 hover:bg-white/80 rounded-full p-2">
                    <svg class="w-6 h-6 text-gray-800" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M12.707 14.707a1 1 0 01-1.414 0L7.586 11l3.707-3.707a1 1 0 011.414 1.414L10.414 11l2.293 2.293a1 1 0 010 1.414z" clip-rule="evenodd" /></svg>
                </button>
                <button class="bg-white/50 hover:bg-white/80 rounded-full p-2">
                    <svg class="w-6 h-6 text-gray-800" fill="currentColor" viewBox="0 0 20 20"><path fill-rule="evenodd" d="M7.293 14.707a1 1 0 001.414 0L12.414 11 8.707 7.293a1 1 0 10-1.414 1.414L9.586 11l-2.293 2.293a1 1 0 000 1.414z" clip-rule="evenodd" /></svg>
                </button>
            </div>
            -->
        </section>
        <style>
            @keyframes fade-in-out {
                0%, 100% {
                    opacity: 1;
                }
                50% {
                    opacity: 0;
                }
            }
            .animate-fade-in-out {
                animation: fade-in-out 10s infinite;
            }
            .delay-5000 {
                animation-delay: 5s;
            }
        </style>

        <!-- end banner -->

        <!-- about -->
        <section class="py-16 bg-white">
            <div class="container mx-auto px-4 flex flex-col lg:flex-row items-center gap-12">
                <!-- Nội dung -->
                <div class="lg:w-5/12 text-center lg:text-left">
                    <h2 class="text-3xl md:text-4xl font-bold text-[#33CCFF] mb-4">Về Chúng Tôi</h2>
                    <p class="text-gray-700 mb-6">
                        PoolHub là hệ thống bể bơi hàng đầu, nơi bạn có thể tận hưởng những giây phút thư giãn tuyệt vời.
                        Chúng tôi cam kết mang đến cho bạn trải nghiệm tốt nhất với dịch vụ chuyên nghiệp và cơ sở vật chất hiện đại.
                    </p>
                    <a href="#" class="inline-block bg-[#33CCFF] text-white px-6 py-2 rounded-full hover:bg-[#1BAFDA] transition">
                        Đọc Thêm
                    </a>
                </div>

                <!-- Hình ảnh với overlay -->
                <div class="lg:w-7/12 relative group cursor-pointer">
                    <img src="images/about.png" alt="Về chúng tôi"
                         class="rounded-2xl shadow-lg w-full max-h-[500px] object-cover group-hover:brightness-75 transition duration-300" />
                    <div
                        class="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition duration-300">
                        <button onclick="openPopup()"
                                class="bg-black bg-opacity-60 text-white px-6 py-2 rounded-full hover:bg-opacity-80 transition">
                            Xem Thêm
                        </button>
                    </div>
                </div>
            </div>

            <!-- Popup -->
            <div id="popupImage"
                 class="fixed inset-0 bg-black bg-opacity-70 flex items-center justify-center z-50 hidden">
                <div class="relative">
                    <img src="images/about.png" class="max-w-full max-h-screen rounded-xl shadow-lg" />
                    <button onclick="closePopup()"
                            class="absolute top-2 right-2 text-white text-2xl bg-black bg-opacity-50 rounded-full px-3 hover:bg-opacity-70 transition">
                        &times;
                    </button>
                </div>
            </div>
        </section>

        <!-- Script -->
        <script>
            function openPopup() {
                document.getElementById("popupImage").classList.remove("hidden");
            }
            function closePopup() {
                document.getElementById("popupImage").classList.add("hidden");
            }
        </script>


        <!-- end about -->

        <!-- our_room -->
        <div class="py-16 bg-gradient-to-b from-white to-blue-50">
            <div class="container mx-auto px-4">
                <!-- Tiêu đề -->
                <div class="text-center mb-12">
                    <h2 class="text-4xl font-extrabold text-[#33CCFF]">Bể Bơi Của Chúng Tôi</h2>
                    <p class="text-gray-600 mt-2 text-lg">Khám phá các bể bơi tuyệt đẹp của chúng tôi.</p>
                </div>

                <!-- Danh sách bể bơi -->
                <div class="grid gap-8 sm:grid-cols-2 lg:grid-cols-3">
                    <%
                        List<Pool> listPool = (List<Pool>) request.getAttribute("listPool");
                        int count = 0;
                        if (listPool != null) {
                            for (Pool p : listPool) {
                    %>
                    <div class="bg-white rounded-2xl shadow-md hover:shadow-xl transition-all duration-300 overflow-hidden group border border-gray-200">
                        <div class="overflow-hidden">
                            <img src="<%= p.getPool_image()%>" alt="Pool <%= count + 1%>" 
                                 class="w-full h-60 object-cover transform group-hover:scale-105 group-hover:brightness-110 transition duration-500" />
                        </div>
                        <div class="p-5">
                            <h3 class="text-xl font-bold text-[#33CCFF] mb-2">Bể Bơi <%= ++count%></h3>
                            <p class="text-gray-700 text-sm leading-relaxed"><%= p.getPool_description()%></p>
                        </div>
                    </div>
                    <% }
                        } %>
                </div>
            </div>
        </div>


        <!-- end our_room -->

        <!-- gallery -->
        <div class="py-16 bg-gradient-to-b from-white to-blue-50">
            <div class="container mx-auto px-4">
                <!-- Tiêu đề -->
                <div class="text-center mb-12">
                    <h2 class="text-4xl font-extrabold text-[#33CCFF]">Thư Viện Hình Ảnh</h2>
                </div>

                <!-- Lưới hình ảnh -->
                <div class="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
                    <%
                        List<Pool> listPool2 = (List<Pool>) request.getAttribute("listPool2");
                        if (listPool2 != null) {
                            for (Pool p : listPool2) {
                    %>
                    <div class="relative group rounded-2xl overflow-hidden shadow-md hover:shadow-xl transition duration-300" data-index="<%= listPool2.indexOf(p)%>">
                        <img src="<%= p.getPool_image()%>" 
                             alt="Ảnh bể bơi" 
                             class="w-full h-52 object-cover transform group-hover:scale-110 group-hover:brightness-75 transition duration-500" />
                        <!-- Overlay -->
                        <div class="absolute inset-0 flex items-center justify-center opacity-0 group-hover:opacity-100 transition duration-300">
                            <span class="view-image-btn text-white font-semibold text-lg bg-black bg-opacity-50 px-4 py-2 rounded cursor-pointer" data-index="<%= listPool2.indexOf(p)%>">Xem ảnh</span>
                        </div>
                    </div>
                    <!-- Lightbox popup -->
                    <div id="lightboxModal" class="fixed inset-0 bg-black bg-opacity-80 z-50 hidden flex items-center justify-center">
                        <button id="lightboxClose" class="absolute top-5 right-5 text-white text-3xl font-bold">&times;</button>
                        <button id="prevBtn" class="absolute left-4 text-white text-4xl font-bold">&lsaquo;</button>
                        <img id="lightboxImage" src="" alt="Ảnh lớn" class="max-h-[80vh] max-w-[90vw] rounded shadow-lg" />
                        <button id="nextBtn" class="absolute right-4 text-white text-4xl font-bold">&rsaquo;</button>
                    </div>

                    <% }
                        } %>
                </div>
                <script>
                    const images = [...document.querySelectorAll('.view-image-btn')].map(btn =>
                        btn.closest('.group').querySelector('img').src
                    );

                    const lightbox = document.getElementById('lightboxModal');
                    const lightboxImg = document.getElementById('lightboxImage');
                    const closeBtn = document.getElementById('lightboxClose');
                    const prevBtn = document.getElementById('prevBtn');
                    const nextBtn = document.getElementById('nextBtn');

                    let currentIndex = 0;

                    document.querySelectorAll('.view-image-btn').forEach(btn => {
                        btn.addEventListener('click', (e) => {
                            currentIndex = parseInt(btn.dataset.index);
                            lightboxImg.src = images[currentIndex];
                            lightbox.classList.remove('hidden');
                        });
                    });

                    closeBtn.addEventListener('click', () => {
                        lightbox.classList.add('hidden');
                    });

                    nextBtn.addEventListener('click', () => {
                        currentIndex = (currentIndex + 1) % images.length;
                        lightboxImg.src = images[currentIndex];
                    });

                    prevBtn.addEventListener('click', () => {
                        currentIndex = (currentIndex - 1 + images.length) % images.length;
                        lightboxImg.src = images[currentIndex];
                    });

                    // Đóng popup khi bấm ngoài ảnh
                    lightbox.addEventListener('click', (e) => {
                        if (e.target === lightbox) {
                            lightbox.classList.add('hidden');
                        }
                    });
                </script>

            </div>
        </div>



        <!-- end gallery -->

        <!-- blog -->
        <div class="py-16 bg-gray-50">
            <div class="container mx-auto px-4">
                <!-- Tiêu đề -->
                <div class="text-center mb-12">
                    <h2 class="text-4xl font-bold text-[#33CCFF]">Đánh Giá</h2>
                    <p class="text-gray-600 mt-3 text-base max-w-xl mx-auto">
                        Dưới đây là những đánh giá và trải nghiệm chân thực từ khách hàng đã sử dụng dịch vụ tại PoolHub.
                    </p>
                </div>

                <!-- Danh sách đánh giá -->
                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-8">
                    <%
                        List<FeedbackHomepage> listPool3 = (List<FeedbackHomepage>) request.getAttribute("listPool3");
                        if (listPool3 != null) {
                            for (FeedbackHomepage f : listPool3) {
                                int rating = f.getRating();
                    %>
                    <div class="bg-white rounded-2xl shadow-md hover:shadow-xl transition duration-300 flex flex-col overflow-hidden">
                        <img src="<%= f.getPool_image()%>" alt="Hình ảnh bể bơi" class="w-full h-48 object-cover rounded-t-2xl" />
                        <div class="p-5 flex flex-col flex-grow">
                            <h3 class="text-lg font-semibold text-[#33CCFF] mb-2"><%= f.getPool_name()%></h3>
                            <!-- Rating -->
                            <div class="flex items-center mb-3">
                                <% for (int i = 1; i <= 5; i++) {%>
                                <svg xmlns="http://www.w3.org/2000/svg" 
                                     class="h-5 w-5 <%= i <= rating ? "text-yellow-400" : "text-gray-300"%>" 
                                     viewBox="0 0 20 20" fill="currentColor">
                                <path d="M9.049 2.927c.3-.921 1.603-.921 1.902 0l1.286 3.956a1 1 0 00.95.69h4.162c.969 0 
                                      1.371 1.24.588 1.81l-3.37 2.45a1 1 0 00-.364 1.118l1.286 3.957c.3.921-.755 
                                      1.688-1.54 1.118l-3.371-2.45a1 1 0 00-1.175 0l-3.371 2.45c-.784.57-1.838-.197-1.539-1.118l1.285-3.957a1 
                                      1 0 00-.364-1.118l-3.37-2.45c-.784-.57-.38-1.81.588-1.81h4.162a1 1 
                                      0 00.951-.69l1.285-3.956z" />
                                </svg>
                                <% }%>
                            </div>
                            <!-- Comment -->
                            <p class="text-gray-600 text-sm flex-grow"><%= f.getComment()%></p>
                        </div>
                    </div>
                    <% }
                        }%>
                </div>
            </div>
        </div>


        <%@include file="footer.jsp" %>

        <!-- Javascript files-->
        <script src="js/jquery.min.js"></script>
        <script src="js/bootstrap.bundle.min.js"></script>
        <script src="js/jquery-3.0.0.min.js"></script>
        <!-- sidebar -->
        <script src="js/jquery.mCustomScrollbar.concat.min.js"></script>
        <script src="js/custom.js"></script>
    </body>
</html>