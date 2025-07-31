<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="model.customer.*, java.util.*" %>
<%
    BookingPageData pageData = (BookingPageData) request.getAttribute("pageData");
    if (pageData == null) {
        out.println("<h2>Lỗi: Không có dữ liệu trang Booking!</h2>");
        return;
    }
    User user = pageData.getUser();
    Pool pool = pageData.getPool();
    List<TicketType> ticketTypes = pageData.getTicketTypes();
    Map<Integer, Integer> ticketTypeSlotMap = (java.util.Map<Integer, Integer>) request.getAttribute("ticketTypeSlotMap");
    List<PoolService> poolServices = pageData.getPoolServices();
    List<Discounts> discounts = pageData.getDiscounts();
%>  
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>Đặt Vé</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap"rel="stylesheet"/>
        <link rel="stylesheet" href="css/styles.css" />
    </head>
    <body class="bg-gray-50 min-h-screen font-['Inter'] antialiased">

        <%@include file="header.jsp" %>

        <div class="container mx-auto px-4 py-8 max-w-5xl">
            <div class="flex items-center mb-6">
                <a href="customerViewPoolList" class="flex items-center text-gray-700 hover:text-blue-600">
                    <svg class="w-6 h-6 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 19l-7-7 7-7"/>
                    </svg>
                    <p class="text-xl md:text-2xl font-bold">Chi tiết bể bơi</p>
                </a>
            </div>

            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null && !error.isEmpty()) {%>
            <div class="mb-4 p-3 bg-red-100 border border-red-400 text-red-700 rounded text-center font-semibold">
                <%= error%>
            </div>
            <% }%>
            <form id="bookingForm" action="booking" method="post">
                <input type="hidden" name="service" value="makeBooking"/>
                <input type="hidden" name="poolId" value="<%= pool.getPool_id()%>"/>
                <input type="hidden" name="bookingDate" id="inputBookingDate"/>
                <input type="hidden" name="startTime" id="inputStartTime"/>
                <input type="hidden" name="endTime" id="inputEndTime"/>
                <input type="hidden" name="slotCount" id="inputSlotCount"/>
                <input type="hidden" name="discountCode" id="inputDiscountCode"/>
                <div
                    class="grid grid-cols-1 md:grid-cols-[340px_1fr] gap-6 balance-grid items-start"
                    >
                    <!-- Cột trái -->
                    <div class="flex flex-col gap-5 h-fit">
                        <!-- Box Thông tin bể bơi: chữ nhỏ lại, layout hợp lý hơn -->
                        <div
                            class="bg-white border border-gray-300 rounded-lg p-5 flex flex-col gap-2"
                            >
                            <div class="font-semibold text-base mb-2">Lựa chọn của bạn</div>
                            <div class="flex flex-row gap-4">
                                <!-- Hình ảnh -->
                                <div
                                    class="w-24 h-24 bg-gray-100 rounded flex items-center justify-center shrink-0"
                                    >
                                    <img
                                        src="<%= pool.getPool_image()%>"
                                        alt="Hồ bơi"
                                        class="w-20 h-20 object-cover rounded"
                                        />
                                </div>
                                <!-- Thông tin tên, địa chỉ (chữ nhỏ lại, căn dòng đẹp) -->
                                <div class="flex flex-col justify-center flex-1">
                                    <span class="font-semibold text-base leading-tight">
                                        <%= pool.getPool_name()%>
                                    </span>
                                    <span class="flex items-center gap-2 mt-1 text-gray-500 text-sm">
                                        Địa chỉ: <%= pool.getPool_road() + ", " + pool.getPool_address()%>
                                    </span>
                                </div>
                            </div>
                            <div class="border-t border-gray-200 my-3"></div>
                            <!-- Slot + ngày giờ -->
                            <div class="flex gap-2">
                                <button
                                    id="slotBtn"
                                    class="flex flex-col items-center justify-center border border-gray-300 rounded-md px-5 py-2 min-w-[55px] focus:outline-none focus:ring-2 focus:ring-blue-400"
                                    type="button"
                                    >
                                    <div class="text-xs text-gray-500">Slot</div>
                                    <div class="text-base font-bold text-blue-700" id="slotNumberText">2</div>
                                </button>
                                <div
                                    class="flex-1 flex flex-col justify-center border border-gray-300 rounded-md px-3 py-2"
                                    >
                                    <div class="flex items-center gap-2 mb-1">
                                        <svg
                                            class="w-4 h-4 text-blue-600"
                                            fill="none"
                                            stroke="currentColor"
                                            viewBox="0 0 24 24"
                                            >
                                        <path
                                            d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"
                                            stroke-width="2"
                                            stroke-linecap="round"
                                            stroke-linejoin="round"
                                            />
                                        </svg>
                                        <span class="font-medium text-sm" id="selectedDateText"
                                              >18/06/2025</span
                                        >
                                    </div>
                                    <div class="flex items-center gap-2 text-gray-500 text-xs">
                                        <svg
                                            class="w-3 h-3 text-gray-400"
                                            fill="none"
                                            stroke="currentColor"
                                            viewBox="0 0 24 24"
                                            >
                                        <circle cx="12" cy="12" r="10" stroke-width="2" />
                                        <path
                                            d="M12 8v4l3 3"
                                            stroke-width="2"
                                            stroke-linecap="round"
                                            stroke-linejoin="round"
                                            />
                                        </svg>
                                        <span id="selectedTimeText">16:00 - 18:00</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Người đặt -->
                        <div class="bg-white border border-gray-200 rounded-lg p-5 flex flex-col gap-2">
                            <div class="font-bold text-lg mb-1">Người đặt</div>
                            <div class="flex justify-between text-gray-700 text-sm">
                                <span>Họ và tên</span>
                                <span class="font-semibold"><%= user.getFull_name()%></span>
                            </div>
                            <div class="flex justify-between text-gray-700 text-sm">
                                <span>Số điện thoại:</span>
                                <span class="font-semibold"><%= user.getPhone() != null ? user.getPhone() : ""%></span>
                            </div>
                        </div>

                        <!-- Ưu đãi -->
                        <div class="bg-white border border-gray-200 rounded-lg p-5 flex flex-col gap-3">
                            <div class="flex items-center justify-between">
                                <span class="font-bold text-base">Ưu đãi</span>
                                <span
                                    id="chooseVoucherSpan"
                                    class="ml-3 px-3 py-2 rounded-md bg-blue-50 hover:bg-blue-100 text-blue-700 font-semibold text-sm border border-blue-200 transition cursor-pointer select-none"
                                    >Chọn ưu đãi</span
                                >
                            </div>
                        </div>
                    </div>

                    <!-- Cột phải (thao tác booking) -->
                    <div class="flex flex-col gap-5 h-full">
                        <!-- Đặt vé -->
                        <div class="bg-white border border-gray-200 rounded-lg p-5 flex flex-col gap-3">
                            <div class="font-bold text-lg mb-1">Đặt vé</div>
                            <!-- Danh sách vé đã chọn -->
                            <div id="selectedTicketsArea"></div>
                            <!-- Nút thêm vé -->
                            <button
                                id="addTicketBtn"
                                class="text-blue-600 hover:underline flex items-center gap-1 text-sm mb-1"
                                type="button"
                                >
                                <span>+ Thêm vé</span>
                            </button>
                            <button id="policyBtn"
                                    class="flex items-center gap-1 text-xs text-gray-400 mt-2 hover:underline focus:outline-none"
                                    type="button">
                                <svg
                                    class="w-3 h-3"
                                    fill="none"
                                    stroke="currentColor"
                                    viewBox="0 0 24 24"
                                    >
                                <circle cx="12" cy="12" r="10" stroke-width="2" />
                                <path d="M8 12h4v4" stroke-width="2" stroke-linecap="round" />
                                </svg>
                                <span>Chính sách</span>
                            </button>
                        </div>
                        <!-- Thuê đồ -->
                        <div
                            class="bg-white border border-gray-200 rounded-lg p-5 flex flex-col gap-3"
                            >
                            <div class="font-bold text-lg mb-1">Thuê đồ</div>
                            <div id="selectedRentsArea"></div>
                            <button
                                id="addRentBtn"
                                class="text-blue-600 hover:underline flex items-center gap-1 text-sm mb-1"
                                type="button"
                                >
                                <span>+ Thêm đồ</span>
                            </button>
                        </div>
                        <!-- Chi tiết thanh toán + nút Thanh toán -->
                        <div class="bg-white border border-gray-200 rounded-lg p-5 flex flex-col h-full">
                            <div class="font-bold text-lg mb-2">Chi tiết thanh toán</div>
                            <div id="paymentDetailArea"></div>
                            <button type="submit"
                                    class="w-full bg-blue-600 text-white text-lg font-semibold rounded-lg py-3 shadow hover:bg-blue-700 transition-colors mt-2 sticky-pay-btn"
                                    >
                                Đến Trang Thanh Toán
                            </button>
                        </div>
                    </div>
                </div>
            </form>

            <!-- Popup chọn ngày và giờ cho Slot -->
            <div
                id="slotModal"
                class="fixed inset-0 bg-black bg-opacity-40 z-50 flex items-center justify-center transition-all hidden"
                >
                <div
                    id="slotModalContent"
                    class="relative bg-white rounded-xl shadow-2xl p-6 md:p-10 w-full max-w-4xl flex flex-col md:flex-row gap-8 animate-fade-in custom-scrollbar"
                    >
                    <!-- Calendar -->
                    <div class="w-full md:w-[480px] flex flex-col">
                        <div class="flex items-center justify-between mb-4">
                            <button id="prevMonthBtn" class="p-2 rounded-full hover:bg-blue-50 transition">
                                <svg class="w-6 h-6 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path
                                    d="M15 19l-7-7 7-7"
                                    stroke-width="2"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    />
                                </svg>
                            </button>
                            <div class="font-semibold text-xl text-gray-700" id="calendarMonthLabel" ></div>
                            <button id="nextMonthBtn"class="p-2 rounded-full hover:bg-blue-50 transition">
                                <svg
                                    class="w-6 h-6 text-gray-600"
                                    fill="none"
                                    stroke="currentColor"
                                    viewBox="0 0 24 24"
                                    >
                                <path
                                    d="M9 5l7 7-7 7"
                                    stroke-width="2"
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    />
                                </svg>
                            </button>
                        </div>
                        <div
                            class="grid grid-cols-7 gap-y-1 text-center text-base font-semibold text-gray-400 mb-2"
                            >
                            <div>T2</div>
                            <div>T3</div>
                            <div>T4</div>
                            <div>T5</div>
                            <div>T6</div>
                            <div>T7</div>
                            <div>CN</div>
                        </div>
                        <div
                            id="calendarGrid"
                            class="grid grid-cols-7 gap-[2px] text-center text-base"
                            ></div>
                    </div>
                    <!-- Slot list -->
                    <div
                        class="w-full md:w-[330px] flex flex-col border-t md:border-t-0 md:border-l border-gray-200 pt-6 md:pt-0 md:pl-8"
                        >
                        <div
                            class="font-semibold text-lg text-blue-700 mb-4"
                            id="slotDayLabel"
                            >
                            Thứ 5, 19/06/2025
                        </div>
                        <div
                            id="slotList"
                            class="flex flex-col gap-3 overflow-y-auto max-h-[460px] pr-1 custom-scrollbar"
                            >
                            <!-- Slot items sẽ render ở đây -->
                        </div>
                    </div>
                    <!-- Close -->
                    <button
                        id="closeSlotModal"
                        class="absolute top-4 right-4 px-4 py-2 rounded-md bg-gray-100 text-gray-700 hover:bg-gray-200 text-base font-medium shadow transition"
                        >
                        Đóng
                    </button>
                </div>
            </div>

            <!-- Popup chọn voucher -->
            <div
                id="voucherModal"
                class="fixed inset-0 bg-black bg-opacity-40 z-50 flex items-center justify-center transition-all hidden"
                >
                <div
                    class="relative bg-white rounded-xl shadow-2xl w-full max-w-[900px] p-6 flex flex-col gap-4 max-h-[95vh] overflow-y-auto"
                    >
                    <div class="font-bold text-xl mb-3">Danh sách voucher</div>
                    <div
                        id="voucherListArea"
                        class="grid grid-cols-1 sm:grid-cols-2 gap-5"
                        ></div>
                    <button
                        id="closeVoucherModal"
                        class="absolute top-3 right-3 px-3 py-1 rounded bg-gray-100 text-gray-700 hover:bg-gray-200 text-sm font-medium shadow transition"
                        >
                        Đóng
                    </button>
                </div>
            </div>

            <!-- Popup chọn vé -->
            <div
                id="ticketModal"
                class="fixed inset-0 bg-black bg-opacity-40 z-50 flex items-center justify-center transition-all hidden"
                >
                <div
                    class="relative bg-white rounded-xl shadow-2xl w-full max-w-md p-6 flex flex-col gap-4 max-h-[90vh] overflow-y-auto"
                    >
                    <div class="font-bold text-lg mb-2">Chọn vé</div>
                    <div id="ticketListArea" class="flex flex-col gap-3"></div>
                    <button
                        id="closeTicketModal"
                        class="absolute top-3 right-3 px-3 py-1 rounded bg-gray-100 text-gray-700 hover:bg-gray-200 text-sm font-medium shadow transition"
                        >
                        Đóng
                    </button>
                </div>
            </div>
            <!-- Popup chính sách hoàn tiền -->
            <div id="policyModal"
                 class="fixed inset-0 bg-black bg-opacity-40 z-50 flex items-center justify-center transition-all hidden">
                <div class="relative bg-white rounded-xl shadow-2xl w-full max-w-md p-6 flex flex-col gap-4">
                    <div class="font-bold text-lg mb-2">Chính sách hoàn tiền</div>
                    <div class="text-gray-700 text-base mb-4">
                        Chính sách hoàn tiền chỉ áp dụng cho các khách hàng có thời gian đặt vé trong vòng 1 tiếng đồng hồ.
                    </div>
                    <button id="closePolicyModal"
                            class="px-3 py-1 rounded bg-gray-100 text-gray-700 hover:bg-gray-200 text-sm font-medium shadow transition self-end">
                        Đóng
                    </button>
                </div>
            </div>
            <!-- Popup chọn đồ thuê -->
            <div
                id="rentModal"
                class="fixed inset-0 bg-black bg-opacity-40 z-50 flex items-center justify-center transition-all hidden"
                >
                <div
                    class="relative bg-white rounded-xl shadow-2xl w-full max-w-md p-6 flex flex-col gap-4 max-h-[90vh] overflow-y-auto"
                    >
                    <div class="font-bold text-lg mb-2">Chọn đồ thuê</div>
                    <div id="rentListArea" class="flex flex-col gap-3"></div>
                    <button
                        id="closeRentModal"
                        class="absolute top-3 right-3 px-3 py-1 rounded bg-gray-100 text-gray-700 hover:bg-gray-200 text-sm font-medium shadow transition"
                        >
                        Đóng
                    </button>
                </div>
            </div>
        </div>
        <%@include file="footer.jsp" %>
        <script>
            document.getElementById('bookingForm').addEventListener('submit', function(e) {
            // Xóa input động cũ (nếu có submit lại)
            Array.from(this.querySelectorAll('.dynamic-input')).forEach(el => el.remove());
            // Thêm input cho các vé đã chọn
            selectedTickets.forEach(t => {
            [
            { name: "ticketTypeName", value: t.name },
            { name: "ticketPrice", value: t.price },
            { name: "ticketQuantity", value: t.quantity },
            { name: "ticketTypeId", value: t.id }
            ].forEach(field => {
            let input = document.createElement("input");
            input.type = "hidden";
            input.name = field.name;
            input.value = field.value;
            input.className = "dynamic-input";
            this.appendChild(input);
            });
            });
            // Thêm input cho các dịch vụ thuê đã chọn
            selectedRents.forEach(r => {
            [
            { name: "rentName", value: r.name },
            { name: "rentPrice", value: r.price },
            { name: "rentQuantity", value: r.quantity },
            { name: "rentId", value: r.id }
            ].forEach(field => {
            let input = document.createElement("input");
            input.type = "hidden";
            input.name = field.name;
            input.value = field.value;
            input.className = "dynamic-input";
            this.appendChild(input);
            });
            });
            // Cập nhật slotCount trước khi submit
            const slotCountInput = document.getElementById('inputSlotCount');
            if (slotCountInput) {
            const totalSlotCount = selectedTickets.reduce((sum, t) => {
            const type = ticketTypes.find(tt => tt.id === t.id);
            const slot = type ? type.slot : 1;
            return sum + t.quantity * slot;
            }, 0);
            slotCountInput.value = totalSlotCount;
            }

            //kiểm tra bắt buộc phải chọn slot
            if (!selectedDate || !selectedSlot) {
            alert("Bạn phải chọn ngày và khung giờ (slot) trước khi thanh toán!");
            e.preventDefault();
            return false;
            }

            // Validate: Số lượng vé tối đa 10
            const totalSlotCount = selectedTickets.reduce((sum, t) => {
            const type = ticketTypes.find(tt => tt.id === t.id);
            const slot = type ? type.slot : 1;
            return sum + t.quantity * slot;
            }, 0);
            if (totalSlotCount > 10) {
            alert("Bạn chỉ được đặt tối đa 10 người!");
            e.preventDefault();
            return false;
            }

            // Nếu muốn kiểm tra bắt buộc phải có ít nhất 1 vé
            if (selectedTickets.length === 0) {
            alert("Bạn phải chọn ít nhất 1 vé!");
            e.preventDefault();
            return false;
            }

            });
        </script>
    </body>
</html>
<!-- ================== JS ================== -->
<script>
    // --------- SLOT DATA ---------
    const slotData = {
    slots: [
    {slot: 1, time: "8:00 - 10:00", left: 50},
    {slot: 2, time: "10:00 - 12:00", left: 50},
    {slot: 3, time: "12:00 - 14:00", left: 50},
    {slot: 4, time: "14:00 - 16:00", left: 50},
    {slot: 5, time: "16:00 - 18:00", left: 50},
    {slot: 6, time: "18:00 - 20:00", left: 50},
    ],
    };
// Hiển thị modal
    const slotBtn = document.getElementById("slotBtn");
    const slotModal = document.getElementById("slotModal");
    const slotModalContent = document.getElementById("slotModalContent");
    const closeSlotModal = document.getElementById("closeSlotModal");
// Các phần tử cần cập nhật
    const calendarMonthLabel = document.getElementById("calendarMonthLabel");
    const calendarGrid = document.getElementById("calendarGrid");
    const slotDayLabel = document.getElementById("slotDayLabel");
    const slotList = document.getElementById("slotList");
    const prevMonthBtn = document.getElementById("prevMonthBtn");
    const nextMonthBtn = document.getElementById("nextMonthBtn");
    const selectedDateText = document.getElementById("selectedDateText");
    const selectedTimeText = document.getElementById("selectedTimeText");
    const slotNumberText = document.getElementById("slotNumberText");
    let today = new Date();
    let calendarMonth = today.getMonth();
    let calendarYear = today.getFullYear();
    let selectedDate = null; // Không chọn mặc định
    let selectedSlot = null; // Không chọn mặc định

    function getLocalDateString(date) {
    var year = date.getFullYear();
    var month = (date.getMonth() + 1).toString().padStart(2, "0");
    var day = date.getDate().toString().padStart(2, "0");
    return year + "-" + month + "-" + day;
    }

// Hàm khởi tạo hiển thị mặc định cho box slot
    function initSlotBoxDisplay() {
    slotNumberText.textContent = "Chọn Slot";
    selectedDateText.textContent = "--/--/----";
    selectedTimeText.textContent = "--:-- - --:--";
    }
// Gọi hàm này khi load trang
    initSlotBoxDisplay();
    function renderCalendar(y, m) {
    const monthNames = [
            "January", "February", "March", "April", "May", "June",
            "July", "August", "September", "October", "November", "December"
    ];
    calendarMonthLabel.textContent = monthNames[m].toUpperCase() + " " + y;
    const firstDay = new Date(y, m, 1);
    const startDay = firstDay.getDay();
    const daysInMonth = new Date(y, m + 1, 0).getDate();
    calendarGrid.innerHTML = "";
    let grid = [];
    let blanks = startDay === 0 ? 6 : startDay - 1;
    for (let i = 0; i < blanks; i++) grid.push("");
    for (let d = 1; d <= daysInMonth; d++) grid.push(d);
    while (grid.length % 7 !== 0) grid.push("");
    for (let i = 0; i < grid.length; i++) {
    let d = grid[i];
    let cell = document.createElement("div");
    cell.className = "calendar-day text-gray-700 text-base py-2 cursor-pointer transition";
    if (d === "") {
    cell.className += " disabled";
    cell.innerHTML = "&nbsp;";
    } else {
    let thisDate = new Date(y, m, d);
    // Kiểm tra nếu là ngày trước hôm nay thì disable
    let thisDateNoTime = new Date(thisDate.getFullYear(), thisDate.getMonth(), thisDate.getDate());
    let todayNoTime = new Date(today.getFullYear(), today.getMonth(), today.getDate());
    if (thisDateNoTime < todayNoTime) {
    cell.className += " disabled text-gray-300 cursor-not-allowed";
    cell.innerHTML = d;
    } else {
    cell.textContent = d;
    if (
            thisDate.getFullYear() === today.getFullYear() &&
            thisDate.getMonth() === today.getMonth() &&
            thisDate.getDate() === today.getDate()
            )
            cell.className += " today";
    if (
            selectedDate &&
            thisDate.getFullYear() === selectedDate.getFullYear() &&
            thisDate.getMonth() === selectedDate.getMonth() &&
            thisDate.getDate() === selectedDate.getDate()
            )
            cell.className += " selected";
    cell.onclick = function () {
    selectedDate = new Date(y, m, d);
    renderCalendar(y, m);
    renderSlots();
    };
    }
    }
    calendarGrid.appendChild(cell);
    }
    }

    function renderSlots() {
    // Nếu chưa chọn ngày thì không render slot và label
    if (!selectedDate) {
    slotDayLabel.textContent = "";
    slotList.innerHTML = '<div class="text-gray-400 text-center py-8">Vui lòng chọn ngày trước</div>';
    return;
    }
    const weekday = [
            "Chủ nhật", "Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5", "Thứ 6", "Thứ 7"
    ];
    var dayStr = selectedDate.getDate().toString().padStart(2, "0");
    var monthStr = (selectedDate.getMonth() + 1).toString().padStart(2, "0");
    var label =
            weekday[selectedDate.getDay()] +
            ", " +
            dayStr +
            "/" +
            monthStr +
            "/" +
            selectedDate.getFullYear();
    slotDayLabel.textContent = label;
    slotList.innerHTML = "";
    let isToday = selectedDate.toDateString() === today.toDateString();
    let now = new Date();
    slotData.slots.forEach(function (slot) {
    var slotDiv = document.createElement("button");
    slotDiv.type = "button";
    slotDiv.className =
            "slot-item w-full border border-gray-300 rounded-lg px-5 py-3 flex flex-col text-left transition text-base bg-white hover:border-blue-400 hover:bg-blue-50 focus:outline-none";
    // Lấy giờ bắt đầu slot
    let startTime = slot.time.split(" - ")[0]; // "8:00"
    let [h, m] = startTime.split(":");
    let slotStart = new Date(selectedDate.getFullYear(), selectedDate.getMonth(), selectedDate.getDate(), Number(h), Number(m), 0, 0);
    // Nếu là hôm nay và slotStart <= giờ hiện tại thì disable
    let disabled = false;
    if (isToday && slotStart <= now) {
    disabled = true;
    slotDiv.className += " disabled text-gray-300 cursor-not-allowed";
    }

    if (selectedSlot && selectedSlot.slot === slot.slot)
            slotDiv.className += " selected border-blue-600 bg-blue-50";
    slotDiv.innerHTML =
            '<div class="flex justify-between items-center mb-1">' +
            '<span class="font-semibold text-base text-blue-700">Slot ' +
            slot.slot +
            "</span>" +
            '<span class="text-gray-600 text-sm">' +
            slot.time +
            "</span>" +
            "</div>" +
            '<div class="text-xs text-gray-400 ml-1">Đang còn: ' +
            slot.left +
            "</div>";
    if (!disabled) {
    slotDiv.onclick = function () {
    selectedSlot = slot;
    renderSlots();
    // Cập nhật UI box trái
    if (selectedSlot && selectedDate) {
    selectedDateText.textContent = selectedDate.toLocaleDateString("vi-VN");
    selectedTimeText.textContent = selectedSlot.time;
    slotNumberText.textContent = selectedSlot.slot;
    document.getElementById('inputBookingDate').value = getLocalDateString(selectedDate); // yyyy-mm-dd
    var timeParts = selectedSlot.time.split(" - ");
    document.getElementById('inputStartTime').value = timeParts[0];
    document.getElementById('inputEndTime').value = timeParts[1];
    } else {
    initSlotBoxDisplay();
    }
    slotModal.classList.add("hidden");
    };
    }
    slotList.appendChild(slotDiv);
    });
    }

    if (slotBtn && slotModal && closeSlotModal) {
    slotBtn.onclick = function () {
    slotModal.classList.remove("hidden");
    renderCalendar(calendarYear, calendarMonth);
    renderSlots();
    };
    closeSlotModal.onclick = function () {
    slotModal.classList.add("hidden");
    // Khi đóng modal mà chưa chọn slot, giữ nguyên hiển thị placeholder
    if (!(selectedDate && selectedSlot)) {
    initSlotBoxDisplay();
    }
    };
    slotModal.onclick = function (e) {
    if (e.target === slotModal) {
    slotModal.classList.add("hidden");
    if (!(selectedDate && selectedSlot)) {
    initSlotBoxDisplay();
    }
    }
    };
    }
    if (prevMonthBtn && nextMonthBtn) {
    prevMonthBtn.onclick = function () {
    calendarMonth--;
    if (calendarMonth < 0) {
    calendarMonth = 11;
    calendarYear--;
    }
    renderCalendar(calendarYear, calendarMonth);
    };
    nextMonthBtn.onclick = function () {
    calendarMonth++;
    if (calendarMonth > 11) {
    calendarMonth = 0;
    calendarYear++;
    }
    renderCalendar(calendarYear, calendarMonth);
    };
    }

    // --------- Vé ---------
    const ticketTypes = [
    <%
        for (int i = 0; i < ticketTypes.size(); i++) {
            TicketType t = ticketTypes.get(i);
            int slot = ticketTypeSlotMap.getOrDefault(t.getTicketTypeId(), 1);
    %>
    {
    id: <%= t.getTicketTypeId()%>,
            name: "<%= t.getTypeName()%>",
            price: <%= t.getBasePrice() != null ? t.getBasePrice().intValue() : 0%>,
            description: "<%= t.getDescription() != null ? t.getDescription().replace("\"", "\\\"") : ""%>",
            slot: <%= slot%>
    }<%= (i < ticketTypes.size() - 1) ? "," : ""%>
    <% } %>
    ];
    let selectedTickets = [];
    const addTicketBtn = document.getElementById("addTicketBtn");
    const ticketModal = document.getElementById("ticketModal");
    const closeTicketModal = document.getElementById("closeTicketModal");
    const ticketListArea = document.getElementById("ticketListArea");
    const selectedTicketsArea = document.getElementById("selectedTicketsArea");
    function renderSelectedTickets() {
    selectedTicketsArea.innerHTML = "";
    selectedTickets.forEach(function (ticket, idx) {
    const otherSelectedNames = selectedTickets
            .filter(function (t, i) { return i !== idx; })
            .map(function (t) { return t.name; });
    const selectWrap = document.createElement("div");
    selectWrap.className = "relative flex-1";
    const select = document.createElement("select");
    select.className = "border rounded-md p-2 w-full min-w-[140px]";
    ticketTypes.forEach(function (type) {
    const option = document.createElement("option");
    option.value = type.name;
    option.textContent = type.name;
    option.disabled = otherSelectedNames.indexOf(type.name) !== - 1;
    if (type.name === ticket.name)
            option.selected = true;
    select.appendChild(option);
    });
    select.title = (ticketTypes.find(function (t) {
    return t.name === ticket.name;
    }) || {}).description || "";
    select.onchange = function () {
    var t = ticketTypes.find(function (t) {
    return t.name === select.value;
    });
    ticket.name = t.name;
    ticket.price = t.price;
    renderSelectedTickets();
    updatePaymentDetail();
    };
    selectWrap.appendChild(select);
    const minusBtn = document.createElement("button");
    minusBtn.type = "button";
    minusBtn.textContent = "-";
    minusBtn.className =
            "w-9 h-9 text-lg font-bold text-gray-700 hover:bg-gray-100 rounded-l transition";
    minusBtn.onclick = function () {
    if (ticket.quantity > 1) {
    ticket.quantity--;
    renderSelectedTickets();
    updatePaymentDetail();
    }
    };
    const plusBtn = document.createElement("button");
    plusBtn.type = "button";
    plusBtn.textContent = "+";
    plusBtn.className =
            "w-9 h-9 text-lg font-bold text-gray-700 hover:bg-gray-100 rounded-r transition";
    plusBtn.onclick = function () {
    ticket.quantity++;
    renderSelectedTickets();
    updatePaymentDetail();
    };
    const qtySpan = document.createElement("span");
    qtySpan.className = "px-3 font-semibold";
    qtySpan.textContent = ticket.quantity;
    const qtyBox = document.createElement("div");
    qtyBox.className =
            "flex items-center gap-0 border border-gray-300 rounded-md ml-3";
    qtyBox.appendChild(minusBtn);
    qtyBox.appendChild(qtySpan);
    qtyBox.appendChild(plusBtn);
    const removeBtn = document.createElement("button");
    removeBtn.type = "button";
    removeBtn.className =
            "ml-2 text-gray-400 hover:text-red-500 text-lg font-bold px-2";
    removeBtn.title = "Xoá vé này";
    removeBtn.innerHTML = "&times;";
    removeBtn.onclick = function () {
    selectedTickets.splice(idx, 1);
    renderSelectedTickets();
    updatePaymentDetail();
    };
    const row = document.createElement("div");
    row.className = "flex items-center gap-2 mb-2";
    row.appendChild(selectWrap);
    row.appendChild(qtyBox);
    row.appendChild(removeBtn);
    selectedTicketsArea.appendChild(row);
    });
    updatePaymentDetail();
    }

    addTicketBtn.onclick = function () {
    ticketModal.classList.remove("hidden");
    renderTicketList();
    };
    closeTicketModal.onclick = function () {
    ticketModal.classList.add("hidden");
    };
    ticketModal.onclick = function (e) {
    if (e.target === ticketModal)
            ticketModal.classList.add("hidden");
    };
    function renderTicketList() {
    ticketListArea.innerHTML = "";
    ticketTypes.forEach(function (ticket, idx) {
    const isSelected = selectedTickets.some(function (t) {
    return t.name === ticket.name;
    });
    const box = document.createElement("div");
    box.className = "border border-gray-400 rounded-md bg-white";
    box.style.opacity = isSelected ? "0.5" : "1";
    box.style.pointerEvents = isSelected ? "none" : "auto";
    const header = document.createElement("div");
    header.className =
            "flex items-center justify-between px-3 pt-3 pb-1 cursor-pointer";
    header.innerHTML =
            '<span class="font-medium">' + ticket.name + '</span>' +
            '<span class="font-semibold">' + ticket.price.toLocaleString("vi-VN") + 'đ</span>';
    const arrowWrap = document.createElement("div");
    arrowWrap.className =
            "w-full border-t border-gray-300 flex justify-center items-center cursor-pointer hover:bg-gray-50 transition";
    arrowWrap.innerHTML =
            '<svg class="w-6 h-6 text-gray-500 transition-transform duration-200" style="transform: rotate(0deg);" fill="none" stroke="currentColor" viewBox="0 0 24 24">' +
            '<path d="M19 9l-7 7-7-7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>' +
            '</svg>';
    const dropdown = document.createElement("div");
    dropdown.className = "px-3 pb-3 pt-2 text-gray-600 text-sm hidden";
    dropdown.textContent = ticket.description;
    arrowWrap.onclick = function (e) {
    e.stopPropagation();
    const isOpen = !dropdown.classList.contains("hidden");
    Array.prototype.forEach.call(ticketListArea.children, function (child) {
    if (child !== box) {
    var d = child.querySelector(".ticket-dropdown");
    if (d)
            d.classList.add("hidden");
    var svg = child.querySelector("svg");
    if (svg)
            svg.style.setProperty("transform", "rotate(0deg)");
    }
    });
    if (isOpen) {
    dropdown.classList.add("hidden");
    arrowWrap.querySelector("svg").style.transform = "rotate(0deg)";
    } else {
    dropdown.classList.remove("hidden");
    arrowWrap.querySelector("svg").style.transform = "rotate(180deg)";
    }
    };
    dropdown.classList.add("ticket-dropdown");
    header.onclick = function () {
    if (!isSelected) {
    selectedTickets.push({
    id: ticket.id,
            name: ticket.name,
            price: ticket.price,
            quantity: 1
    });
    renderSelectedTickets();
    ticketModal.classList.add("hidden");
    }
    };
    box.appendChild(header);
    box.appendChild(arrowWrap);
    box.appendChild(dropdown);
    ticketListArea.appendChild(box);
    });
    }

    // --------- Hoàn tiền ---------
    const policyBtn = document.getElementById("policyBtn");
    const policyModal = document.getElementById("policyModal");
    const closePolicyModal = document.getElementById("closePolicyModal");
    if (policyBtn && policyModal && closePolicyModal) {
    policyBtn.onclick = function () {
    policyModal.classList.remove("hidden");
    };
    closePolicyModal.onclick = function () {
    policyModal.classList.add("hidden");
    };
    policyModal.onclick = function (e) {
    if (e.target === policyModal) {
    policyModal.classList.add("hidden");
    }
    };
    }

    // --------- Đồ thuê ---------
    const rentTypes = [
    <% for (PoolService s : poolServices) {%>
    {
    id: <%= s.getPoolServiceId()%>,
            name: "<%= s.getServiceName()%>",
            price: <%= s.getPrice().intValue()%>,
            description: "<%= s.getDescription() != null ? s.getDescription().replace("\"", "\\\"") : ""%>"
    },
    <% } %>
    ];
    let selectedRents = [];
    const addRentBtn = document.getElementById("addRentBtn");
    const rentModal = document.getElementById("rentModal");
    const closeRentModal = document.getElementById("closeRentModal");
    const rentListArea = document.getElementById("rentListArea");
    const selectedRentsArea = document.getElementById("selectedRentsArea");
    function renderSelectedRents() {
    selectedRentsArea.innerHTML = "";
    selectedRents.forEach(function (rent, idx) {
    const otherSelectedNames = selectedRents
            .filter(function (t, i) { return i !== idx; })
            .map(function (t) { return t.name; });
    const selectWrap = document.createElement("div");
    selectWrap.className = "relative flex-1";
    const select = document.createElement("select");
    select.className = "border rounded-md p-2 w-full min-w-[140px]";
    rentTypes.forEach(function (type) {
    const option = document.createElement("option");
    option.value = type.name;
    option.textContent = type.name;
    option.disabled = otherSelectedNames.indexOf(type.name) !== - 1;
    if (type.name === rent.name)
            option.selected = true;
    select.appendChild(option);
    });
    select.title = (rentTypes.find(function (t) {
    return t.name === rent.name;
    }) || {}).description || "";
    select.onchange = function () {
    var t = rentTypes.find(function (t) {
    return t.name === select.value;
    });
    rent.name = t.name;
    rent.price = t.price;
    renderSelectedRents();
    updatePaymentDetail();
    };
    selectWrap.appendChild(select);
    const minusBtn = document.createElement("button");
    minusBtn.type = "button";
    minusBtn.textContent = "-";
    minusBtn.className =
            "w-9 h-9 text-lg font-bold text-gray-700 hover:bg-gray-100 rounded-l transition";
    minusBtn.onclick = function () {
    if (rent.quantity > 1) {
    rent.quantity--;
    renderSelectedRents();
    updatePaymentDetail();
    }
    };
    const plusBtn = document.createElement("button");
    plusBtn.type = "button";
    plusBtn.textContent = "+";
    plusBtn.className =
            "w-9 h-9 text-lg font-bold text-gray-700 hover:bg-gray-100 rounded-r transition";
    plusBtn.onclick = function () {
    // Tính tổng số người (slot) đã đặt
    const slotCount = selectedTickets.reduce((sum, t) => {
    const type = ticketTypes.find(tt => tt.id === t.id);
    const slot = type ? type.slot : 1;
    return sum + t.quantity * slot;
    }, 0);
    if (rent.quantity < slotCount) {
    rent.quantity++;
    renderSelectedRents();
    updatePaymentDetail();
    } else {
    alert("Bạn chỉ được thuê tối đa " + slotCount + " " + rent.name + " (tương ứng tổng số người/vé đã đặt)!");
    }
    };
    const qtySpan = document.createElement("span");
    qtySpan.className = "px-3 font-semibold";
    qtySpan.textContent = rent.quantity;
    const qtyBox = document.createElement("div");
    qtyBox.className =
            "flex items-center gap-0 border border-gray-300 rounded-md ml-3";
    qtyBox.appendChild(minusBtn);
    qtyBox.appendChild(qtySpan);
    qtyBox.appendChild(plusBtn);
    const removeBtn = document.createElement("button");
    removeBtn.type = "button";
    removeBtn.className =
            "ml-2 text-gray-400 hover:text-red-500 text-lg font-bold px-2";
    removeBtn.title = "Xoá đồ này";
    removeBtn.innerHTML = "&times;";
    removeBtn.onclick = function () {
    selectedRents.splice(idx, 1);
    renderSelectedRents();
    updatePaymentDetail();
    };
    const row = document.createElement("div");
    row.className = "flex items-center gap-2 mb-2";
    row.appendChild(selectWrap);
    row.appendChild(qtyBox);
    row.appendChild(removeBtn);
    selectedRentsArea.appendChild(row);
    });
    updatePaymentDetail();
    }

    addRentBtn.onclick = function () {
    rentModal.classList.remove("hidden");
    renderRentList();
    };
    closeRentModal.onclick = function () {
    rentModal.classList.add("hidden");
    };
    rentModal.onclick = function (e) {
    if (e.target === rentModal)
            rentModal.classList.add("hidden");
    };
    function renderRentList() {
    rentListArea.innerHTML = "";
    rentTypes.forEach(function (rent, idx) {
    const isSelected = selectedRents.some(function (t) {
    return t.name === rent.name;
    });
    const box = document.createElement("div");
    box.className = "border border-gray-400 rounded-md bg-white";
    box.style.opacity = isSelected ? "0.5" : "1";
    box.style.pointerEvents = isSelected ? "none" : "auto";
    const header = document.createElement("div");
    header.className =
            "flex items-center justify-between px-3 pt-3 pb-1 cursor-pointer";
    header.innerHTML =
            '<span class="font-medium">' + rent.name + '</span>' +
            '<span class="font-semibold">' + rent.price.toLocaleString("vi-VN") + 'đ</span>';
    const arrowWrap = document.createElement("div");
    arrowWrap.className =
            "w-full border-t border-gray-300 flex justify-center items-center cursor-pointer hover:bg-gray-50 transition";
    arrowWrap.innerHTML =
            '<svg class="w-6 h-6 text-gray-500 transition-transform duration-200" style="transform: rotate(0deg);" fill="none" stroke="currentColor" viewBox="0 0 24 24">' +
            '<path d="M19 9l-7 7-7-7" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>' +
            '</svg>';
    const dropdown = document.createElement("div");
    dropdown.className = "px-3 pb-3 pt-2 text-gray-600 text-sm hidden";
    dropdown.textContent = rent.description;
    arrowWrap.onclick = function (e) {
    e.stopPropagation();
    var isOpen = !dropdown.classList.contains("hidden");
    Array.prototype.forEach.call(rentListArea.children, function (child) {
    if (child !== box) {
    var d = child.querySelector(".ticket-dropdown");
    if (d)
            d.classList.add("hidden");
    var svg = child.querySelector("svg");
    if (svg)
            svg.style.setProperty("transform", "rotate(0deg)");
    }
    });
    if (isOpen) {
    dropdown.classList.add("hidden");
    arrowWrap.querySelector("svg").style.transform = "rotate(0deg)";
    } else {
    dropdown.classList.remove("hidden");
    arrowWrap.querySelector("svg").style.transform = "rotate(180deg)";
    }
    };
    dropdown.classList.add("ticket-dropdown");
    header.onclick = function () {
    if (!isSelected) {
    selectedRents.push({
    id: rent.id,
            name: rent.name,
            price: rent.price,
            quantity: 1
    });
    renderSelectedRents();
    rentModal.classList.add("hidden");
    }
    };
    box.appendChild(header);
    box.appendChild(arrowWrap);
    box.appendChild(dropdown);
    rentListArea.appendChild(box);
    });
    }

    // --------- Voucher ---------
    const voucherTypes = [
    <% for (Discounts d : discounts) {%>
    {
    code: "<%= d.getDiscountCode()%>",
            info: "<%= d.getDescription() != null ? d.getDescription().replace("\"", "\\\"") : ""%>",
            expire: "<%= d.getValidTo() != null ? d.getValidTo().toString().substring(0, 10) : ""%>",
            used: "",
            detail: "<%= d.getDescription() != null ? d.getDescription().replace("\"", "\\\"") : ""%>"
    },
    <% }%>
    ];
    let selectedVoucher = null;
    const chooseVoucherSpan = document.getElementById("chooseVoucherSpan");
    const voucherModal = document.getElementById("voucherModal");
    const closeVoucherModal = document.getElementById("closeVoucherModal");
    const voucherListArea = document.getElementById("voucherListArea");
    chooseVoucherSpan.onclick = function () {
    voucherModal.classList.remove("hidden");
    renderVoucherList();
    };
    closeVoucherModal.onclick = function () {
    voucherModal.classList.add("hidden");
    };
    voucherModal.onclick = function (e) {
    if (e.target === voucherModal)
            voucherModal.classList.add("hidden");
    };
    function renderVoucherList() {
    voucherListArea.innerHTML = "";
    voucherTypes.forEach(function (voucher) {
    var box = document.createElement("div");
    box.className =
            "border border-gray-400 rounded-lg bg-white flex flex-row min-h-[84px] hover:border-blue-500 hover:shadow-md group transition relative cursor-pointer";
    box.onclick = function () {
    selectedVoucher = voucher;
    chooseVoucherSpan.textContent = voucher.code;
    chooseVoucherSpan.classList.add(
            "bg-green-50",
            "text-green-700",
            "border-green-200"
            );
    chooseVoucherSpan.classList.remove(
            "bg-blue-50",
            "text-blue-700",
            "border-blue-200"
            );
    document.getElementById('inputDiscountCode').value = voucher.code; // <-- cập nhật code
    voucherModal.classList.add("hidden");
    updatePaymentDetail();
    };
    chooseVoucherSpan.oncontextmenu = function (e) {
    e.preventDefault();
    if (selectedVoucher !== null) {
    selectedVoucher = null;
    chooseVoucherSpan.textContent = "Chọn ưu đãi";
    chooseVoucherSpan.classList.remove(
            "bg-green-50",
            "text-green-700",
            "border-green-200"
            );
    chooseVoucherSpan.classList.add(
            "bg-blue-50",
            "text-blue-700",
            "border-blue-200"
            );
    document.getElementById('inputDiscountCode').value = "";
    updatePaymentDetail();
    }
    };
    box.innerHTML =
            '<div class="flex flex-col justify-between w-3/7 px-4 py-3">' +
            '<div class="font-semibold text-base text-gray-700 break-words">' + voucher.code + '</div>' +
            '</div>' +
            '<div class="flex-1 flex flex-col justify-between px-2 py-2">' +
            '<div class="font-semibold text-gray-800 mb-1">' + voucher.info + '</div>' +
            '<div class="text-xs text-gray-500">Hết hạn: ' + voucher.expire + '</div>' +
            '<div class="text-xs text-gray-500">Đã dùng: ' + voucher.used + '</div>' +
            '</div>';
    voucherListArea.appendChild(box);
    });
    }

    chooseVoucherSpan.oncontextmenu = function (e) {
    e.preventDefault();
    if (selectedVoucher !== null) {
    selectedVoucher = null;
    chooseVoucherSpan.textContent = "Chọn ưu đãi";
    chooseVoucherSpan.classList.remove(
            "bg-green-50",
            "text-green-700",
            "border-green-200"
            );
    chooseVoucherSpan.classList.add(
            "bg-blue-50",
            "text-blue-700",
            "border-blue-200"
            );
    updatePaymentDetail();
    }
    };
    // --------- Update Payment Detail ---------
    function calcVoucherDiscount(total) {
    if (!selectedVoucher || !selectedVoucher.code) return 0;
    let percentMatch = selectedVoucher.code.match(/\d+/);
    if (percentMatch) {
    let percent = parseInt(percentMatch[0]);
    return Math.round(total * percent / 100);
    }
    return 0;
    }

    function updatePaymentDetail() {
    const paymentDetailArea = document.getElementById("paymentDetailArea");
    if (!paymentDetailArea) return;
    var html = "";
    var total = 0;
    // Danh sách vé
    selectedTickets.forEach(function (ticket) {
    if (ticket.quantity && ticket.quantity > 0) {
    html +=
            '<div class="flex justify-between text-gray-700 text-sm mb-1">' +
            '<span>' + ticket.name + ' <span class="text-gray-400">x' + ticket.quantity + '</span></span>' +
            '<span>' + ticket.price.toLocaleString("vi-VN") + ' đ</span>' +
            '</div>';
    total += ticket.price * ticket.quantity;
    }
    });
    // Danh sách dịch vụ thuê
    selectedRents.forEach(function (rent) {
    if (rent.quantity && rent.quantity > 0) {
    html +=
            '<div class="flex justify-between text-gray-700 text-sm mb-1">' +
            '<span>' + rent.name + ' <span class="text-gray-400">x' + rent.quantity + '</span></span>' +
            '<span>' + rent.price.toLocaleString("vi-VN") + ' đ</span>' +
            '</div>';
    total += rent.price * rent.quantity;
    }
    });
    var discount = calcVoucherDiscount(total);
    //Dòng voucher: luôn hiện nếu có selectedVoucher
    if (selectedVoucher && selectedVoucher.code) {
    if (discount > 0) {
    html +=
            '<div class="flex justify-between text-green-600 text-sm mb-1 font-semibold">' +
            '<span>Ưu đãi (' + selectedVoucher.code + ')</span>' +
            '<span>- ' + discount.toLocaleString("vi-VN") + ' đ</span>' +
            '</div>';
    } else {
    html +=
            '<div class="flex justify-between text-green-600 text-sm mb-1 font-semibold">' +
            '<span>Ưu đãi (' + selectedVoucher.code + ')</span>' +
            '<span></span>' +
            '</div>';
    }
    }

    var totalFinal = total - discount;
    html += '<div class="border-b my-2"></div>' +
            '<div class="flex justify-between items-center font-bold text-lg mb-3">' +
            '<span>Tổng</span>' +
            '<span class="text-blue-700 text-2xl">' + totalFinal.toLocaleString("vi-VN") + ' đ</span>' +
            '</div>';
    paymentDetailArea.innerHTML = html;
    }

    // Cập nhật giá trị input hidden slotCount
    const slotCountInput = document.getElementById('inputSlotCount');
    if (slotCountInput) {
    const totalSlotCount = selectedTickets.reduce((sum, t) => {
    const type = ticketTypes.find(tt => tt.id === t.id);
    const slot = type ? type.slot : 1;
    return sum + t.quantity * slot;
    }, 0);
    slotCountInput.value = totalSlotCount;
    }
</script>
