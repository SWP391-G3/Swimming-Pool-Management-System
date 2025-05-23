
--create database PoolsDB

CREATE TABLE Roles(
	role_id INT IDENTITY(1,1) PRIMARY KEY,
	role_name NVARCHAR(50)
);

CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    username NVARCHAR(50) NOT NULL UNIQUE,
    password NVARCHAR(255) NOT NULL,
    full_name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL UNIQUE,
    phone NVARCHAR(15) NULL,
    address NVARCHAR(255) NULL,
    role_id INT NOT NULL,
    status BIT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NULL
	CONSTRAINT FK_Users_Roles FOREIGN KEY (role_id) REFERENCES Roles(role_id)
);

CREATE TABLE Pools (
    pool_id INT IDENTITY(1,1) PRIMARY KEY,
    pool_name NVARCHAR(100) NOT NULL,
    pool_road NVARCHAR(255) NOT NULL,
    pool_address NVARCHAR(100) NOT NULL,
    max_slot INT NOT NULL CHECK (max_slot > 0),
    open_time TIME NOT NULL,
    close_time TIME NOT NULL,
    pool_status BIT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NULL,
    CONSTRAINT CK_Pools_OpenBeforeClose CHECK (close_time > open_time)
);

CREATE TABLE Booking (
    booking_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    pool_id INT NOT NULL,
    booking_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    slot_count INT NOT NULL CHECK (slot_count > 0),
    booking_status NVARCHAR(20) NOT NULL DEFAULT 'pending', -- ví dụ: pending, confirmed, cancelled
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NULL,

    CONSTRAINT FK_Booking_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT FK_Booking_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id),
    CONSTRAINT CK_Booking_Time CHECK (end_time > start_time)
);


CREATE TABLE Ticket (
    ticket_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT NOT NULL UNIQUE,
    ticket_price DECIMAL(10,2) NOT NULL,
    payment_status NVARCHAR(20) NOT NULL DEFAULT 'unpaid', -- unpaid, paid, refunded
    payment_time DATETIME NULL,
    ticket_code NVARCHAR(50) UNIQUE NULL, -- mã vé, dùng khi xuất vé, check vé
    issued_by INT NULL, -- user_id nhân viên phát vé (nếu có)
    issued_at DATETIME NULL, -- thời gian phát vé
    CONSTRAINT FK_Ticket_Booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    CONSTRAINT FK_Ticket_IssuedBy FOREIGN KEY (issued_by) REFERENCES Users(user_id)
);


CREATE TABLE Feedbacks (
    feedback_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    pool_id INT NOT NULL,
    rating INT CHECK (rating BETWEEN 1 AND 5) NOT NULL,
    comment NVARCHAR(1000) NULL,
    Fstatus NVARCHAR(20) NOT NULL DEFAULT 'pending',  -- pending, approved, rejected
    response NVARCHAR(1000) NULL,                     -- phản hồi của quản lý
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NULL,
    CONSTRAINT FK_Feedback_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT FK_Feedback_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id)
);

CREATE TABLE Pool_Equipment (
    equipment_id INT IDENTITY(1,1) PRIMARY KEY,
    pool_id INT NOT NULL,
    equipment_name NVARCHAR(100) NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    status NVARCHAR(20) NOT NULL DEFAULT 'available', -- available, broken, maintenance
    purchase_date DATE NULL,
    last_maintenance_date DATE NULL,
    notes NVARCHAR(255) NULL,
    CONSTRAINT FK_PoolEquipment_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id)
);

CREATE TABLE Staff_Assignment (
    assignment_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    pool_id INT NOT NULL,
    role NVARCHAR(50) NOT NULL,        -- Vai trò công việc
    shift_name NVARCHAR(50) NOT NULL,  -- Tên ca làm việc
    assigned_date DATE NOT NULL,
    CONSTRAINT FK_StaffAssign_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT FK_StaffAssign_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id)
);

CREATE TABLE Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method NVARCHAR(50) NOT NULL,
    payment_status NVARCHAR(20) NOT NULL DEFAULT 'pending',
    payment_date DATETIME NOT NULL DEFAULT GETDATE(),
    transaction_reference NVARCHAR(100) NULL,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NULL,
    CONSTRAINT FK_Payments_Booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);



CREATE TABLE Payment_Details (
    payment_detail_id INT IDENTITY(1,1) PRIMARY KEY,
    payment_id INT NOT NULL,
    ticket_id INT NULL,
    service_id INT NULL, -- nếu có thêm dịch vụ khác ngoài ticket
    amount DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    CONSTRAINT FK_PaymentDetails_Payment FOREIGN KEY (payment_id) REFERENCES Payments(payment_id),
    CONSTRAINT FK_PaymentDetails_Ticket FOREIGN KEY (ticket_id) REFERENCES Ticket(ticket_id)
);

CREATE TABLE Notifications (
    notification_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    title NVARCHAR(150) NOT NULL,
    message NVARCHAR(MAX) NOT NULL,
    is_read BIT NOT NULL DEFAULT 0,
    sent_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Notifications_User FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

CREATE TABLE Discounts (
    discount_id INT IDENTITY(1,1) PRIMARY KEY,
    discount_code NVARCHAR(50) UNIQUE NOT NULL,
    description NVARCHAR(255),
    discount_percent DECIMAL(5,2) NOT NULL, -- ví dụ 10.00 cho 10%
    valid_from DATETIME NOT NULL,
    valid_to DATETIME NOT NULL,
    status BIT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME NULL
);

CREATE TABLE Booking_Discounts (
    booking_discount_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT NOT NULL,
    discount_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL, -- số tiền giảm
    CONSTRAINT FK_BookingDiscounts_Booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    CONSTRAINT FK_BookingDiscounts_Discount FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id)
);

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







