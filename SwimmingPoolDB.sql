-- Cơ sở dữ liệu mới 
--create database SwimmingPoolDB;
-- Bảng vai trò người dùng
CREATE TABLE Roles (
    role_id INT IDENTITY(1,1) PRIMARY KEY,
    role_name NVARCHAR(50) NOT NULL UNIQUE
);

-- Bảng người dùng
CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    full_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    phone NVARCHAR(15),
    address NVARCHAR(255),
    role_id INT NOT NULL,
    status BIT NOT NULL DEFAULT 1,
    dob DATE,
    gender NVARCHAR(10),
    images NVARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME,
    CONSTRAINT FK_Users_Roles FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

-- Bảng hồ bơi
CREATE TABLE Pools (
    pool_id INT IDENTITY(1,1) PRIMARY KEY,
    pool_name NVARCHAR(100) NOT NULL,
    pool_road NVARCHAR(255) NOT NULL,
    pool_address NVARCHAR(100) NOT NULL,
    max_slot INT NOT NULL CHECK (max_slot > 0),
    open_time TIME NOT NULL,
    close_time TIME NOT NULL,
    pool_status BIT NOT NULL DEFAULT 1,
    pool_image NVARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME,
    CONSTRAINT CK_Pools_OpenBeforeClose CHECK (close_time > open_time)
);

-- Bảng loại vé
CREATE TABLE Ticket_Types (
    ticket_type_id INT IDENTITY(1,1) PRIMARY KEY,
    type_name NVARCHAR(50) NOT NULL UNIQUE,  -- Ví dụ: Vé trẻ em, người lớn
    description NVARCHAR(255),
    base_price DECIMAL(10,2) NOT NULL
);

-- Bảng đặt lịch
CREATE TABLE Booking (
    booking_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    pool_id INT NOT NULL,
    booking_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    slot_count INT NOT NULL CHECK (slot_count > 0),
    booking_status NVARCHAR(20) NOT NULL DEFAULT 'pending', -- pending, confirmed, cancelled
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME,
    CONSTRAINT FK_Booking_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT FK_Booking_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id),
    CONSTRAINT CK_Booking_Time CHECK (end_time > start_time)
);

-- Bảng vé
CREATE TABLE Ticket (
    ticket_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT NOT NULL UNIQUE,
    ticket_type_id INT NOT NULL,
    ticket_price DECIMAL(10,2) NOT NULL,
    payment_status NVARCHAR(20) NOT NULL DEFAULT 'unpaid', -- unpaid, paid, refunded
    payment_time DATETIME,
    ticket_code NVARCHAR(50) UNIQUE,
    issued_by INT,
    issued_at DATETIME,
    CONSTRAINT FK_Ticket_Booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    CONSTRAINT FK_Ticket_IssuedBy FOREIGN KEY (issued_by) REFERENCES Users(user_id),
    CONSTRAINT FK_Ticket_TicketType FOREIGN KEY (ticket_type_id) REFERENCES Ticket_Types(ticket_type_id)
);

-- Bảng phản hồi
CREATE TABLE Feedbacks (
    feedback_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    pool_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment NVARCHAR(1000),
    Fstatus NVARCHAR(20) NOT NULL DEFAULT 'pending',
    response NVARCHAR(1000),
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME,
    CONSTRAINT FK_Feedback_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT FK_Feedback_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id)
);

-- alter table Pool_Equipment
-- add device_image NVARCHAR(255)

-- Bảng thiết bị
CREATE TABLE Pool_Equipment (
    equipment_id INT IDENTITY(1,1) PRIMARY KEY,
    pool_id INT NOT NULL,
	device_image NVARCHAR(255),
    equipment_name NVARCHAR(100) NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    status NVARCHAR(20) NOT NULL DEFAULT 'available', -- available, broken, maintenance
    purchase_date DATE,
    last_maintenance_date DATE,
    notes NVARCHAR(255),
    CONSTRAINT FK_PoolEquipment_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id)
);

-- Phân công nhân viên
CREATE TABLE Staff_Assignment (
    assignment_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    pool_id INT NOT NULL,
    role NVARCHAR(50) NOT NULL,
    shift_name NVARCHAR(50) NOT NULL,
    assigned_date DATE NOT NULL,
    CONSTRAINT FK_StaffAssign_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT FK_StaffAssign_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id)
);

-- Bảng dịch vụ bổ sung
CREATE TABLE Services (
    service_id INT IDENTITY(1,1) PRIMARY KEY,
    service_name NVARCHAR(100) NOT NULL UNIQUE,
    description NVARCHAR(255),
    price DECIMAL(10,2) NOT NULL,
    status BIT NOT NULL DEFAULT 1
);

-- Thanh toán tổng
CREATE TABLE Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method NVARCHAR(50) NOT NULL,
    payment_status NVARCHAR(20) NOT NULL DEFAULT 'pending',
    payment_date DATETIME NOT NULL DEFAULT GETDATE(),
    transaction_reference NVARCHAR(100),
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME,
    CONSTRAINT FK_Payments_Booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- Chi tiết thanh toán
CREATE TABLE Payment_Details (
    payment_detail_id INT IDENTITY(1,1) PRIMARY KEY,
    payment_id INT NOT NULL,
    ticket_id INT,
    service_id INT,
    amount DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    CONSTRAINT FK_PaymentDetails_Payment FOREIGN KEY (payment_id) REFERENCES Payments(payment_id),
    CONSTRAINT FK_PaymentDetails_Ticket FOREIGN KEY (ticket_id) REFERENCES Ticket(ticket_id),
    CONSTRAINT FK_PaymentDetails_Service FOREIGN KEY (service_id) REFERENCES Services(service_id)
);

-- Thông báo
CREATE TABLE Notifications (
    notification_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    title NVARCHAR(150) NOT NULL,
    message NVARCHAR(MAX) NOT NULL,
    is_read BIT NOT NULL DEFAULT 0,
    sent_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Notifications_User FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Giảm giá
CREATE TABLE Discounts (
    discount_id INT IDENTITY(1,1) PRIMARY KEY,
    discount_code NVARCHAR(50) UNIQUE NOT NULL,
    description NVARCHAR(255),
    discount_percent DECIMAL(5,2) NOT NULL,
    valid_from DATETIME NOT NULL,
    valid_to DATETIME NOT NULL,
    status BIT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME
);

-- Áp dụng giảm giá vào booking
CREATE TABLE Booking_Discounts (
    booking_discount_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT NOT NULL,
    discount_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    CONSTRAINT FK_BookingDiscounts_Booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    CONSTRAINT FK_BookingDiscounts_Discount FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id)
);

-- Doanh thu theo ngày
CREATE TABLE Revenue (
    revenue_id INT IDENTITY(1,1) PRIMARY KEY,
    pool_id INT NOT NULL,
    revenue_date DATE NOT NULL,
    total_amount DECIMAL(15,2) NOT NULL,
    total_bookings INT NOT NULL,
    total_tickets_sold INT NOT NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Revenue_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id)
);

CREATE TABLE Attendance (
    attendance_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    pool_id INT NOT NULL,
    check_in DATETIME NOT NULL,
    check_out DATETIME,
    shift_name NVARCHAR(50), -- Ví dụ: sáng, chiều, tối
    note NVARCHAR(255),
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Attendance_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT FK_Attendance_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id)
);

CREATE TABLE Branches (
    branch_id INT IDENTITY(1,1) PRIMARY KEY,
    branch_name NVARCHAR(100) NOT NULL,
    branch_address NVARCHAR(255) NOT NULL,
    status BIT NOT NULL DEFAULT 1
);


CREATE TABLE Device_Report (
    report_id INT IDENTITY(1,1) PRIMARY KEY,
    equipment_id INT NOT NULL,
    reported_by INT NOT NULL, -- user_id của staff
    report_time DATETIME NOT NULL DEFAULT GETDATE(),
    description NVARCHAR(1000) NOT NULL, -- mô tả sự cố
    status NVARCHAR(20) NOT NULL DEFAULT 'Chưa xử lý', -- Chưa xử lý | Đang xử lý | Đã xử lý
    response_note NVARCHAR(1000),
    response_by INT, -- user_id của manager phản hồi (nếu có)
    response_time DATETIME,
    CONSTRAINT FK_DeviceReport_Equipment FOREIGN KEY (equipment_id) REFERENCES Pool_Equipment(equipment_id),
    CONSTRAINT FK_DeviceReport_Staff FOREIGN KEY (reported_by) REFERENCES Users(user_id),
    CONSTRAINT FK_DeviceReport_Manager FOREIGN KEY (response_by) REFERENCES Users(user_id)
);

CREATE TABLE Device_Maintenance_History (
    history_id INT IDENTITY(1,1) PRIMARY KEY,
    equipment_id INT NOT NULL,
    fixed_by INT NOT NULL, -- user_id của người xử lý (có thể là manager hoặc kỹ thuật viên)
    fix_date DATETIME NOT NULL DEFAULT GETDATE(),
    fix_details NVARCHAR(1000), -- Mô tả việc sửa chữa
    CONSTRAINT FK_MaintenanceHistory_Equipment FOREIGN KEY (equipment_id) REFERENCES Pool_Equipment(equipment_id),
    CONSTRAINT FK_MaintenanceHistory_User FOREIGN KEY (fixed_by) REFERENCES Users(user_id)
);
