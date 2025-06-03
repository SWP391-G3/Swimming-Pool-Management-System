--Create Database PoolDB;  

--use PoolDB;
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
	pool_description NVARCHAR(255),
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
    booking_status NVARCHAR(20) NOT NULL DEFAULT 'pending', -- pending, confirmed, cancelled
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME,
    CONSTRAINT FK_Booking_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT FK_Booking_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id),
    CONSTRAINT CK_Booking_Time CHECK (end_time > start_time)
);

CREATE TABLE Ticket_Types (
    ticket_type_id INT IDENTITY(1,1) PRIMARY KEY,
    type_name NVARCHAR(50) NOT NULL UNIQUE,  -- Ví dụ: Vé trẻ em, người lớn
    description NVARCHAR(255),
    base_price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Ticket (
    ticket_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT NOT NULL,
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

CREATE TABLE Feedbacks (
    feedback_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    pool_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment NVARCHAR(1000),
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Feedback_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT FK_Feedback_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id)
);

CREATE TABLE FeedbackResponse (
    response_id INT IDENTITY(1,1) PRIMARY KEY,
    feedback_id INT NOT NULL,
    responseder_id INT NOT NULL,
    response_note NVARCHAR(1000),
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_FeedbackResponse_User FOREIGN KEY (responseder_id) REFERENCES Users(user_id)
);

CREATE TABLE Pool_Device (
    device_id INT IDENTITY(1,1) PRIMARY KEY,
    pool_id INT NOT NULL,
	device_image NVARCHAR(255),
    device_name NVARCHAR(100) NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    device_status NVARCHAR(20) NOT NULL DEFAULT 'available', -- available, broken, maintenance
    notes NVARCHAR(255),
    CONSTRAINT FK_PoolDevices_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id)
);

CREATE TABLE Device_Report (
    report_id INT IDENTITY(1,1) PRIMARY KEY,
    device_id INT NOT NULL,
    reported_by INT NOT NULL, -- user_id của staff
    report_time DATETIME NOT NULL DEFAULT GETDATE(),
    description NVARCHAR(1000) NOT NULL, -- mô tả sự cố
    status NVARCHAR(20) NOT NULL DEFAULT 'Chưa xử lý', -- Chưa xử lý | Đang xử lý | Đã xử lý
    response_note NVARCHAR(1000),
    response_by INT, -- user_id của manager phản hồi (nếu có)
    response_time DATETIME,
    CONSTRAINT FK_DeviceReport_Device FOREIGN KEY (device_id) REFERENCES Pool_Device(device_id),
    CONSTRAINT FK_DeviceReport_Staff FOREIGN KEY (reported_by) REFERENCES Users(user_id),
    CONSTRAINT FK_DeviceReport_Manager FOREIGN KEY (response_by) REFERENCES Users(user_id)
);

CREATE TABLE Pool_RentItem (
    item_id INT IDENTITY(1,1) PRIMARY KEY,
    pool_id INT NOT NULL,
	item_image NVARCHAR(255),
    item_name NVARCHAR(100) NOT NULL,
    quantity INT NOT NULL CHECK (quantity >= 0),
    item_status NVARCHAR(20) NOT NULL DEFAULT 'available', -- available, broken, maintenance
    notes NVARCHAR(255),
    CONSTRAINT FK_PoolRentItem_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id)
);

CREATE TABLE Pool_RentItemReport (
    report_id INT IDENTITY(1,1) PRIMARY KEY,
    item_id INT NOT NULL,
    reported_by INT NOT NULL, -- user_id của staff
    report_time DATETIME NOT NULL DEFAULT GETDATE(),
    description NVARCHAR(1000) NOT NULL, -- mô tả sự cố
    status NVARCHAR(20) NOT NULL DEFAULT 'Chưa xử lý', -- Chưa xử lý | Đang xử lý | Đã xử lý
    response_note NVARCHAR(1000),
    response_by INT, -- user_id của manager phản hồi (nếu có)
    response_time DATETIME,
    CONSTRAINT FK_RentItemReport_RentItem FOREIGN KEY (item_id) REFERENCES Pool_RentItem(item_id),
    CONSTRAINT FK_RentItemReport_User FOREIGN KEY (reported_by) REFERENCES Users(user_id),
    CONSTRAINT FK_RentItemReport_Manager FOREIGN KEY (response_by) REFERENCES Users(user_id)
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

CREATE TABLE Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method NVARCHAR(50) NOT NULL,
    payment_status NVARCHAR(20) NOT NULL DEFAULT 'pending',
    payment_date DATETIME NOT NULL DEFAULT GETDATE(),
    transaction_reference NVARCHAR(100),
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Payments_Booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

CREATE TABLE Payment_Details (
    payment_detail_id INT IDENTITY(1,1) PRIMARY KEY,
    payment_id INT NOT NULL,
    ticket_id INT,
    item_id INT,
    amount DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL DEFAULT 1,
    CONSTRAINT FK_PaymentDetails_Payment FOREIGN KEY (payment_id) REFERENCES Payments(payment_id),
    CONSTRAINT FK_PaymentDetails_Ticket FOREIGN KEY (ticket_id) REFERENCES Ticket(ticket_id),
    CONSTRAINT FK_PaymentDetails_Service FOREIGN KEY (item_id) REFERENCES Pool_RentItem(item_id)
);

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

CREATE TABLE Customer_Discount(
	customer_discount_id INT IDENTITY(1,1) PRIMARY KEY,
	user_id INT NOT NULL,
	discount_id INT NOT NULL,
	used_discount BIT NOT NULL DEFAULT 0,
	CONSTRAINT FK_CustomerDiscount_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
	CONSTRAINT FK_CustomerDiscount_Discount FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id)
);

CREATE TABLE Customer_CheckIn(
	CheckIn_id INT IDENTITY(1,1) PRIMARY KEY,
	booking_id INT NOT NULL,
	staff_id INT NOT NULL,
	CheckInTime DATETIME,
	CheckOutTime DATETIME,
	CONSTRAINT FK_CheckIn_User FOREIGN KEY (staff_id) REFERENCES Users(user_id),
	CONSTRAINT FK_CheckIn_Booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

--- Update quản lí thêm bảng branch 1 quản lý 1 chi nhánh , 1 chi nhánh gồm có 5 bể 

CREATE TABLE Branchs (
    branch_id INT IDENTITY(1,1) PRIMARY KEY,
    branch_name NVARCHAR(100) NOT NULL,
    manager_id INT NOT NULL,
    CONSTRAINT FK_Branchs_Manager FOREIGN KEY (manager_id) REFERENCES Users(user_id)
);


ALTER TABLE Pools
ADD branch_id INT;

ALTER TABLE Pools
ADD CONSTRAINT FK_Pools_Branch FOREIGN KEY (branch_id) REFERENCES Branchs(branch_id);
