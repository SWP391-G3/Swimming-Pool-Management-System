<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8"/>
        <title>Kết quả thanh toán VNPay</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet" />
        <link rel="stylesheet" href="css/styles.css" />
    </head>
    <body class="bg-gray-50 min-h-screen font-['Inter'] antialiased">
        <div class="w-full flex flex-col items-center py-8">
            <div class="w-full max-w-4xl mx-auto px-2 sm:px-6">
                <!-- Banner mở rộng -->
                <div class="w-full rounded-lg overflow-hidden shadow mb-10">
                    <div class="relative w-full h-40 md:h-56 flex items-center justify-center bg-blue-100">
                        <img
                            src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=compress&fit=crop&w=1200&q=80"
                            alt="VNPay Banner"
                            class="w-full h-full object-cover"
                            />
                        <div class="absolute inset-0 bg-gradient-to-b from-black/20 to-black/5"></div>
                        <h1 class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-2xl md:text-3xl font-bold text-white text-center drop-shadow-lg px-4">
                            KẾT QUẢ THANH TOÁN
                        </h1>
                    </div>
                </div>

                <!-- Box kết quả -->
                <div class="w-full bg-white border border-gray-200 rounded-xl shadow-lg p-10 flex flex-col gap-8">
                    <!-- Trạng thái thanh toán -->
                    <c:choose>
                        <c:when test="${paymentSuccess}">
                            <div class="flex flex-col items-center mb-2">
                                <div class="flex items-center gap-2">
                                    <svg class="w-9 h-9 text-green-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                    <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="2" fill="#d1fae5"/>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 12l2.5 2.5L16 9" stroke="#10b981"/>
                                    </svg>
                                    <span class="text-green-700 text-2xl font-bold">Thanh toán thành công!</span>
                                </div>
                                <span class="bg-green-100 text-green-700 px-5 py-1 rounded-full text-base font-semibold mt-2">Cảm ơn bạn đã sử dụng dịch vụ</span>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="flex flex-col items-center mb-2">
                                <div class="flex items-center gap-2">
                                    <svg class="w-9 h-9 text-red-500" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                                    <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="2" fill="#fee2e2"/>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 9l-6 6m0-6l6 6" stroke="#ef4444"/>
                                    </svg>
                                    <span class="text-red-700 text-2xl font-bold">Thanh toán thất bại!</span>
                                </div>
                                <span class="bg-red-100 text-red-700 px-5 py-1 rounded-full text-base font-semibold mt-2">${errorMessage}</span>
                            </div>
                        </c:otherwise>
                    </c:choose>

                    <!-- Thông tin giao dịch -->
                    <div class="overflow-x-auto flex justify-center">
                        <table class="w-full max-w-2xl text-base">
                            <tr>
                                <td class="py-2 font-medium text-gray-600 w-1/2">Mã giao dịch (TxnRef):</td>
                                <td class="py-2 text-gray-900">${vnp_TxnRef}</td>
                            </tr>
                            <tr>
                                <td class="py-2 font-medium text-gray-600">Mã booking:</td>
                                <td class="py-2 text-gray-900">${bookingId}</td>
                            </tr>
                            <tr>
                                <td class="py-2 font-medium text-gray-600">Phương thức thanh toán:</td>
                                <td class="py-2 text-gray-900">Thanh toán trực tuyến - VNPay</td>
                            </tr>
                            <tr>
                                <td class="py-2 font-medium text-gray-600">Ngày đặt vé:</td>
                                <td class="py-2 text-gray-900">${bookingDate}</td>
                            </tr>
                            <tr>
                                <td class="py-2 font-medium text-gray-600">Số tiền thanh toán:</td>
                                <td class="py-2 font-bold text-blue-700 text-lg">${amount}</td>
                            </tr>
                            <tr>
                                <td class="py-2 font-medium text-gray-600">Mã ngân hàng:</td>
                                <td class="py-2 text-gray-900">${vnp_BankCode}</td>
                            </tr>
                            <tr>
                                <td class="py-2 font-medium text-gray-600">Mã giao dịch ngân hàng:</td>
                                <td class="py-2 text-gray-900">${vnp_TransactionNo}</td>
                            </tr>
                            <tr>
                                <td class="py-2 font-medium text-gray-600">Thời gian thanh toán:</td>
                                <td class="py-2 text-gray-900">${vnp_PayDate}</td>
                            </tr>
                        </table>
                    </div>
                    <div class="mt-8 text-center">
                        <a href="customerHome" class="inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white font-semibold px-9 py-3 rounded-lg shadow transition text-lg active:scale-95">
                            <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 10h2l.4 2m.6-2h13.4a1 1 0 0 1 1 1v7a1 1 0 0 1-1 1H6a1 1 0 0 1-1-1v-7a1 1 0 0 1 1-1zm2 0V5a2 2 0 0 1 2-2h2a2 2 0 0 1 2 2v5"/>
                            </svg>
                            Quay về
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>