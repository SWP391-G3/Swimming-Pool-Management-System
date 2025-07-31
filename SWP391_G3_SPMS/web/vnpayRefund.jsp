<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="utf-8">
        <title>Hoàn tiền VNPay</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet" />
        <link rel="stylesheet" href="css/styles.css" />
        <meta name="viewport" content="width=device-width, initial-scale=1">
    </head>
    <body class="bg-gray-50 min-h-screen font-['Inter'] antialiased">
        <div class="w-full flex flex-col items-center py-8">
            <div class="w-full max-w-4xl mx-auto px-2 sm:px-6">
                <div class="w-full rounded-lg overflow-hidden shadow mb-10">
                    <div class="relative w-full h-40 md:h-56 bg-blue-100 flex items-center justify-center">
                        <img src="https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=compress&fit=crop&w=1200&q=80"
                             alt="VNPay Banner" class="w-full h-full object-cover"/>
                        <div class="absolute inset-0 bg-gradient-to-b from-black/20 to-black/5"></div>
                        <h1 class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 text-2xl md:text-3xl font-bold text-white text-center drop-shadow-lg px-4">
                            HOÀN TIỀN VNPay
                        </h1>
                    </div>
                </div>
                <section class="w-full bg-white border border-gray-200 rounded-xl shadow-lg p-10 flex flex-col gap-8">
                    <!-- Hiển thị thông báo thành công/thất bại nếu có -->
                    <c:if test="${not empty successMsg}">
                        <div class="mb-6 px-4 py-3 bg-green-100 text-green-800 rounded text-center font-semibold">
                            ${successMsg}
                        </div>
                    </c:if>
                    <c:if test="${not empty errorMsg}">
                        <div class="mb-6 px-4 py-3 bg-red-100 text-red-800 rounded text-center font-semibold">
                            ${errorMsg}
                        </div>
                    </c:if>
                    <form action="vnpayrefund" id="frmrefund" method="POST" class="flex flex-col gap-8">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                            <div>
                                <label class="block mb-1 font-medium text-gray-700">Mã giao dịch cần hoàn</label>
                                <div class="w-full border border-gray-300 rounded-lg px-4 py-2 bg-gray-100 text-gray-800">
                                    ${order_id}
                                </div>
                                <input type="hidden" name="order_id" value="${order_id}" />
                            </div>
                            <div>
                                <label class="block mb-1 font-medium text-gray-700">Số tiền hoàn</label>
                                <div class="w-full border border-gray-300 rounded-lg px-4 py-2 bg-gray-100 text-gray-800">
                                    ${amount}
                                </div>
                                <input type="hidden" name="amount" value="${amount}" />
                            </div>
                            <div>
                                <label class="block mb-1 font-medium text-gray-700">Kiểu hoàn tiền</label>
                                <div class="w-full border border-gray-300 rounded-lg px-4 py-2 bg-gray-100 text-gray-800">
                                    Chuyển khoản - VNPay
                                </div>
                                <input type="hidden" name="trantype" value="02" />
                            </div>
                            <div>
                                <label class="block mb-1 font-medium text-gray-700">Thời gian khởi tạo giao dịch</label>
                                <div class="w-full border border-gray-300 rounded-lg px-4 py-2 bg-gray-100 text-gray-800">
                                    ${trans_date}
                                </div>
                                <input type="hidden" name="trans_date" value="${trans_date}" />
                            </div>
                        </div>
                        <div>
                            <label class="block mb-1 font-medium text-gray-700">Người yêu cầu hoàn tiền</label>
                            <div class="w-full border border-gray-300 rounded-lg px-4 py-2 bg-gray-100 text-gray-800">
                                ${user}
                            </div>
                            <input type="hidden" name="user" value="${user}" />
                        </div>
                        <div class="flex justify-end">
                            <button type="submit"
                                    class="inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white font-semibold px-8 py-2 rounded-lg shadow transition text-lg active:scale-95">
                                <svg class="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"/>
                                </svg>
                                Refund
                            </button>
                        </div>
                    </form>
                </section>
            </div>
        </div>
    </body>
</html>