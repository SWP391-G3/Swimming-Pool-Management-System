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
                    <form action="vnpayrefund" id="frmrefund" method="POST" class="flex flex-col gap-8">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
                            <div>
                                <label for="order_id" class="block mb-1 font-medium text-gray-700">Mã giao dịch cần hoàn</label>
                                <input class="w-full border border-gray-300 rounded-lg px-4 py-2 bg-gray-100" id="order_id" name="order_id" type="text" value="${param.order_id}" readonly/>
                            </div>
                            <div>
                                <label for="amount" class="block mb-1 font-medium text-gray-700">Số tiền hoàn</label>
                                <input class="w-full border border-gray-300 rounded-lg px-4 py-2 bg-gray-100" id="amount" name="amount" type="number" min="1" max="100000000" value="${param.amount}" readonly/>
                            </div>
                            <div>
                                <label for="trantype" class="block mb-1 font-medium text-gray-700">Kiểu hoàn tiền</label>
                                <input class="w-full border border-gray-300 rounded-lg px-4 py-2 bg-gray-100" id="trantype" name="trantype" type="text" value="02" readonly/>
                            </div>
                            <div>
                                <label for="trans_date" class="block mb-1 font-medium text-gray-700">Thời gian khởi tạo giao dịch</label>
                                <input class="w-full border border-gray-300 rounded-lg px-4 py-2 bg-gray-100" id="trans_date" name="trans_date" type="text" value="${param.trans_date}" readonly/>
                            </div>
                        </div>
                        <div>
                            <label for="user" class="block mb-1 font-medium text-gray-700">User khởi tạo hoàn</label>
                            <input class="w-full border border-gray-300 rounded-lg px-4 py-2 bg-gray-100" id="user" name="user" type="text" value="${param.user}" readonly/>
                        </div>
                        <div class="flex justify-end">
                            <button type="submit" class="inline-flex items-center gap-2 bg-blue-600 hover:bg-blue-700 text-white font-semibold px-8 py-2 rounded-lg shadow transition text-lg active:scale-95">
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