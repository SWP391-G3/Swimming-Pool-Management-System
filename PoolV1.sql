--CREATE DATABASE SwimmingPoolDB2

CREATE TABLE Roles (
    role_id INT IDENTITY(1,1) PRIMARY KEY,
    role_name NVARCHAR(50) NOT NULL UNIQUE
);

-- Bảng người dùng
CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,                 -- Mã định danh người dùng
    username NVARCHAR(50) NOT NULL UNIQUE,                -- Tên đăng nhập duy nhất
    password NVARCHAR(255) NOT NULL,                      -- Mật khẩu (nên mã hóa)
    full_name NVARCHAR(100) NOT NULL,                     -- Họ tên đầy đủ
    email NVARCHAR(100) NOT NULL UNIQUE,                  -- Email duy nhất
    phone NVARCHAR(15),                                   -- Số điện thoại
    address NVARCHAR(255),                                -- Địa chỉ
    role_id INT NOT NULL,                                 -- Vai trò (Admin, Staff, Customer...)
    status BIT NOT NULL DEFAULT 1,                        -- Trạng thái hoạt động (1: hoạt động, 0: bị khóa)
    dob DATE,                                              -- Ngày sinh
    gender NVARCHAR(10),                                   -- Giới tính
    images NVARCHAR(255),                                  -- Ảnh đại diện
    created_at DATETIME NOT NULL DEFAULT GETDATE(),       -- Ngày tạo tài khoản
    updated_at DATETIME,                                  -- Ngày cập nhật gần nhất
    CONSTRAINT FK_Users_Roles FOREIGN KEY (role_id) REFERENCES Roles(role_id),
);

-- Tạo bảng Branchs
CREATE TABLE Branchs (
    branch_id INT IDENTITY(1,1) PRIMARY KEY,
    branch_name NVARCHAR(100) NOT NULL,
    manager_id INT NULL,
	CONSTRAINT FK_Branchs_Manager FOREIGN KEY (manager_id) REFERENCES Users(user_id)
);

-- Tạo bảng Pools
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
	branch_id INT,
    CONSTRAINT CK_Pools_OpenBeforeClose CHECK (close_time > open_time)
);

CREATE TABLE Staff_Types (
    staff_type_id INT IDENTITY(1,1) PRIMARY KEY,
    type_name NVARCHAR(100) NOT NULL UNIQUE, -- VD: Kỹ thuật, Xoát vé, Kiểm tra thiết bị, Hỗ trợ dịch vụ
    description NVARCHAR(255)
);

CREATE TABLE Staffs(
	staff_id INT IDENTITY(1,1) PRIMARY KEY,
	user_id INT NOT NULL,
	branch_id INT NOT NULL,
	pool_id INT NOT NULL,
	staff_type_id INT,
	CONSTRAINT FK_Staffs_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
	CONSTRAINT FK_Staffs_Branch FOREIGN KEY (branch_id) REFERENCES Branchs(branch_id),
	CONSTRAINT FK_Staffs_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id),
	CONSTRAINT FK_Staffs_StaffType FOREIGN KEY (staff_type_id) REFERENCES Staff_Types(staff_type_id)
);

-- Tạo bảng Pool_Device
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

-- Tạo bảng Discounts
CREATE TABLE Discounts (
    discount_id INT IDENTITY(1,1) PRIMARY KEY,
    discount_code NVARCHAR(50) UNIQUE NOT NULL,
    description NVARCHAR(255),
    discount_percent DECIMAL(5,2) NOT NULL,
	quantity INT,
    valid_from DATETIME NOT NULL,
    valid_to DATETIME NOT NULL,
    status BIT NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME,
	created_by INT NOT NULL,
	CONSTRAINT FK_Discounts_CreatedBy FOREIGN KEY (created_by) REFERENCES Users(user_id)
);

-- Tạo bảng Customer_Discount
CREATE TABLE Customer_Discount(
	customer_discount_id INT IDENTITY(1,1) PRIMARY KEY,
	user_id INT NOT NULL,
	discount_id INT NOT NULL,
	used_discount BIT NOT NULL DEFAULT 0,
	CONSTRAINT FK_CustomerDiscount_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
	CONSTRAINT FK_CustomerDiscount_Discount FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id)
);

-- Tạo bảng Booking
CREATE TABLE Booking (
    booking_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NULL,
    pool_id INT NOT NULL,
    discount_id INT NULL,
    booking_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    slot_count INT NOT NULL CHECK (slot_count > 0),
    booking_status NVARCHAR(20) NOT NULL DEFAULT 'pending', --pending/comfirmed/canceled
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    updated_at DATETIME,
    CONSTRAINT FK_Booking_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT FK_Booking_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id),
    CONSTRAINT FK_Booking_Discount FOREIGN KEY (discount_id) REFERENCES Discounts(discount_id),
    CONSTRAINT CK_Booking_Time CHECK (end_time > start_time)
);

-- Tạo bảng Pool_Service
CREATE TABLE Pool_Service (
    pool_service_id INT IDENTITY(1,1) PRIMARY KEY,
    pool_id INT NOT NULL,
	service_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(255),
    price DECIMAL(10, 2) NOT NULL,
	service_image NVARCHAR(255),
    quantity INT NOT NULL CHECK (quantity >= 0),
    service_status NVARCHAR(20) NOT NULL DEFAULT 'available', -- available, broken, maintenance
    CONSTRAINT FK_PoolService_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id)
);

--Thêm bảng Booking-Service
CREATE TABLE Booking_Service (
    booking_service_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT NOT NULL,
    pool_service_id INT NOT NULL,
	branch_id INT NOT NULL,
    quantity INT DEFAULT 1, -- Số lượng dịch vụ đặt (nếu có)
    total_service_price DECIMAL(12, 2) NOT NULL, -- Lưu tĩnh giá tại thời điểm booking

    CONSTRAINT FK_Booking_Service_Booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    CONSTRAINT FK_Booking_Service_Service FOREIGN KEY (pool_service_id) REFERENCES Pool_Service(pool_service_id),
	CONSTRAINT FK_Booking_Service_Branchs FOREIGN KEY (branch_id) REFERENCES Branchs(branch_id)
);

-- Tạo bảng Feedbacks
CREATE TABLE Feedbacks (
    feedback_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    pool_id INT NOT NULL,
    rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment NVARCHAR(1000),
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Feedbacks_Users FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT FK_Feedbacks_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id)
);

-- Tạo bảng Payments
CREATE TABLE Payments (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT NOT NULL,
    payment_method NVARCHAR(50) NOT NULL CHECK (payment_method IN ('Bank_transfers', 'Cash')),
    payment_status NVARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (payment_status IN ('pending', 'completed', 'canceled', 'refunded')),
    payment_date DATETIME NOT NULL DEFAULT GETDATE(),
	total_amount DECIMAL(10,2),
	discount_amount DECIMAL(10,2),
    transaction_reference NVARCHAR(100),
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    CONSTRAINT FK_Payments_Booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

-- Tạo bảng Ticket_Types (có thêm type_code để hỗ trợ sinh mã vé)
CREATE TABLE Ticket_Types (
    ticket_type_id INT IDENTITY(1,1) PRIMARY KEY,
    type_code NVARCHAR(20) NOT NULL UNIQUE,     -- VD: ADULT, CHILD, COMBO1
    type_name NVARCHAR(100) NOT NULL,
    description NVARCHAR(255),
    base_price DECIMAL(10,2) NOT NULL,
    is_combo BIT NOT NULL DEFAULT 0,             -- nếu là combo (1), thường (0)
	created_at DATETIME DEFAULT GETDATE(),
	discount_percent DECIMAL DEFAULT 0
);

-- Bảng định nghĩa chi tiết combo: combo gồm những loại vé nào và số lượng
CREATE TABLE Combo_Detail (
    combo_type_id INT NOT NULL,
    included_type_id INT NOT NULL,
    quantity INT NOT NULL CHECK (quantity > 0),
    PRIMARY KEY (combo_type_id, included_type_id),
    FOREIGN KEY (combo_type_id) REFERENCES Ticket_Types(ticket_type_id),
    FOREIGN KEY (included_type_id) REFERENCES Ticket_Types(ticket_type_id)
);

--Tạo bảng Pool_Ticket_Type (Quản lý ticket theo bể)
CREATE TABLE Pool_Ticket_Types (
    pool_id INT NOT NULL,
    ticket_type_id INT NOT NULL,
	status NVARCHAR(20) DEFAULT 'active',
    PRIMARY KEY (pool_id, ticket_type_id),
    CONSTRAINT FK_Pool_Ticket_Type_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id),
    CONSTRAINT FK_Pool_Ticket_Types FOREIGN KEY (ticket_type_id) REFERENCES Ticket_Types(ticket_type_id)
);

-- Tạo bảng Ticket
CREATE TABLE Ticket (
    ticket_id INT IDENTITY(1,1) PRIMARY KEY,
    booking_id INT NOT NULL,
    ticket_type_id INT NOT NULL,
    ticket_price DECIMAL(10,2) NOT NULL,
    ticket_code NVARCHAR(50) UNIQUE, -- sẽ được sinh tự động bằng trigger ADULT-TICKET-0001
    issued_by INT, --ROle nào tạo ticket này
    issued_at DATETIME,
    CONSTRAINT FK_Ticket_Booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id),
    CONSTRAINT FK_Ticket_IssuedBy FOREIGN KEY (issued_by) REFERENCES Users(user_id),
    CONSTRAINT FK_Ticket_TicketType FOREIGN KEY (ticket_type_id) REFERENCES Ticket_Types(ticket_type_id)
);

-- Bảng Payment_Ticket
CREATE TABLE Payment_Ticket (
    payment_ticket_id INT IDENTITY(1,1) PRIMARY KEY,
    payment_id INT NOT NULL,
    ticket_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
    CONSTRAINT FK_PaymentTicket_Payment FOREIGN KEY (payment_id) REFERENCES Payments(payment_id),
    CONSTRAINT FK_PaymentTicket_Ticket FOREIGN KEY (ticket_id) REFERENCES Ticket(ticket_id)
);

-- Bảng Payment_RentItem
CREATE TABLE Payment_RentItem (
    payment_rent_id INT IDENTITY(1,1) PRIMARY KEY,
    payment_id INT NOT NULL,
    service_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL DEFAULT 1 CHECK (quantity > 0),
    CONSTRAINT FK_PaymentRent_Payment FOREIGN KEY (payment_id) REFERENCES Payments(payment_id),
    CONSTRAINT FK_PaymentRent_Service FOREIGN KEY (service_id) REFERENCES  Pool_Service(pool_service_id)
);

-- Bảng Contacts
CREATE TABLE Contacts (
    contact_id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
    user_id INT NULL,
    name NVARCHAR(100) NOT NULL,
    email NVARCHAR(100) NOT NULL,
    subject NVARCHAR(150) NULL,
    content NVARCHAR(2000) NOT NULL,
    created_at DATETIME NOT NULL,
    is_resolved BIT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Bảng Notifications
CREATE TABLE Notifications (
    notification_id INT IDENTITY(1,1) PRIMARY KEY,
    title NVARCHAR(200) NOT NULL,
    content NVARCHAR(2000) NOT NULL,
    created_by INT NOT NULL,                    -- user_id của Manager
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    target_role_id INT NULL,                    -- Gửi cho role cụ thể (VD: chỉ gửi cho Customer), hoặc NULL nếu gửi toàn bộ
    target_branch_id INT NULL,                  -- Gửi cho chi nhánh cụ thể, hoặc NULL nếu không phân biệt
    CONSTRAINT FK_Notifications_Creator FOREIGN KEY (created_by) REFERENCES Users(user_id),
    CONSTRAINT FK_Notifications_Role FOREIGN KEY (target_role_id) REFERENCES Roles(role_id),
    CONSTRAINT FK_Notifications_Branch FOREIGN KEY (target_branch_id) REFERENCES Branchs(branch_id)
);

-- Bảng Discount_Audit_Log
CREATE TABLE Discount_Audit_Log (
    log_id INT IDENTITY(1,1) PRIMARY KEY,
    discount_id INT NOT NULL,
    manager_id INT NOT NULL,
    action_type NVARCHAR(10) NOT NULL, -- 'INSERT', 'UPDATE', 'DELETE'
    action_time DATETIME NOT NULL DEFAULT GETDATE(),
    old_description NVARCHAR(255),
    new_description NVARCHAR(255),
    old_discount_percent DECIMAL(5,2),
    new_discount_percent DECIMAL(5,2),
    old_quantity INT,
    new_quantity INT,
    old_valid_from DATETIME,
    new_valid_from DATETIME,
    old_valid_to DATETIME,
    new_valid_to DATETIME,
    old_status BIT,
    new_status BIT,
    notes NVARCHAR(255) NULL
);

-- Bảng Service_Reports
CREATE TABLE Service_Reports (
    report_id INT IDENTITY(1,1) PRIMARY KEY,
    staff_id INT NOT NULL,
    pool_id INT NOT NULL,
    branch_id INT NOT NULL,
    service_id INT NOT NULL,
    service_name NVARCHAR(100) NOT NULL,
    report_reason NVARCHAR(255) NOT NULL,
    suggestion NVARCHAR(255),
    report_date DATETIME NOT NULL DEFAULT GETDATE(),
    status NVARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'done')),
	manager_note NVARCHAR(255),
	processed_at DATETIME,
	processed_by INT NULL,
	CONSTRAINT FK_ServiceReports_Manager FOREIGN KEY (processed_by) REFERENCES Users(user_id),
    CONSTRAINT FK_ServiceReports_Staff FOREIGN KEY (staff_id) REFERENCES Staffs(staff_id),
    CONSTRAINT FK_ServiceReports_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id),
    CONSTRAINT FK_ServiceReports_Branch FOREIGN KEY (branch_id) REFERENCES Branchs(branch_id),
    CONSTRAINT FK_ServiceReports_Service FOREIGN KEY (service_id) REFERENCES Pool_Service(pool_service_id)
);

-- Bảng Device_Reports
CREATE TABLE Device_Reports (
    report_id INT IDENTITY(1,1) PRIMARY KEY,
    staff_id INT  NOT NULL,
    pool_id INT  NOT NULL,
    branch_id INT  NOT NULL,
    device_id INT  NULL,
    device_name NVARCHAR(100) NOT NULL,
    report_reason NVARCHAR(255) NOT NULL,
    suggestion NVARCHAR(255),
    report_date DATETIME NOT NULL DEFAULT GETDATE(),
    status NVARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'done')), -- Chỉ “pending” hoặc “done”
	manager_note NVARCHAR(255),
	processed_at DATETIME,
	processed_by INT NULL,
	CONSTRAINT FK_DeviceReports_Manager FOREIGN KEY (processed_by) REFERENCES Users(user_id),
    CONSTRAINT FK_DeviceReports_Staff FOREIGN KEY (staff_id)  REFERENCES Staffs(staff_id),
    CONSTRAINT FK_DeviceReports_Pool FOREIGN KEY (pool_id)   REFERENCES Pools(pool_id),
    CONSTRAINT FK_DeviceReports_Branch FOREIGN KEY (branch_id) REFERENCES Branchs(branch_id),
    CONSTRAINT FK_DeviceReports_Device FOREIGN KEY (device_id) REFERENCES Pool_Device(device_id)
);

CREATE TABLE Customer_Checkin (
    checkinId INT IDENTITY(1,1) PRIMARY KEY,       -- Sử dụng IDENTITY cho SQL Server
    userId INT NOT NULL,
    bookingId INT NOT NULL,
    checkinStatus TINYINT NOT NULL DEFAULT 0,      -- 0: chưa check-in, 1: đã check-in
    checkinTime DATETIME DEFAULT NULL,
    CONSTRAINT UQ_CustomerCheckin_User_Booking UNIQUE (userId, bookingId),
    CONSTRAINT FK_CustomerCheckin_User FOREIGN KEY (userId) REFERENCES Users(user_id),
    CONSTRAINT FK_CustomerCheckin_Booking FOREIGN KEY (bookingId) REFERENCES Booking(booking_id)
);

-- Bảng Sale_Ticket_Directly - Quản lý bán vé trực tiếp tại quầy
CREATE TABLE Sale_Ticket_Directly (
    sale_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_name NVARCHAR(100) NOT NULL,-- Thông tin khách hàng (bắt buộc)
    customer_phone NVARCHAR(15) NOT NULL,
    customer_email NVARCHAR(100) NULL,
    user_id INT NULL,-- Liên kết với user nếu khách hàng có tài khoản
    staff_id INT NOT NULL,-- Thông tin nhân viên và địa điểm
    pool_id INT NOT NULL,
    branch_id INT NOT NULL,
    booking_id INT NOT NULL,-- Thông tin booking được tạo
    total_amount DECIMAL(10,2) NOT NULL,-- Thông tin giao dịch
    payment_method NVARCHAR(20) NOT NULL DEFAULT 'Cash' CHECK (payment_method IN ('Cash', 'Bank_transfers')),
    payment_status NVARCHAR(20) NOT NULL DEFAULT 'completed' CHECK (payment_status IN ('completed', 'refunded')),
    sale_date DATETIME NOT NULL DEFAULT GETDATE(),-- Thông tin thời gian
    created_at DATETIME NOT NULL DEFAULT GETDATE(),
    notes NVARCHAR(255) NULL,-- Ghi chú
    CONSTRAINT FK_SaleTicketDirectly_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT FK_SaleTicketDirectly_Staff FOREIGN KEY (staff_id) REFERENCES Staffs(staff_id),
    CONSTRAINT FK_SaleTicketDirectly_Pool FOREIGN KEY (pool_id) REFERENCES Pools(pool_id),
    CONSTRAINT FK_SaleTicketDirectly_Branch FOREIGN KEY (branch_id) REFERENCES Branchs(branch_id),
    CONSTRAINT FK_SaleTicketDirectly_Booking FOREIGN KEY (booking_id) REFERENCES Booking(booking_id)
);

CREATE TABLE Contact_Responses (
    response_id INT IDENTITY(1,1) PRIMARY KEY,
    contact_id INT NOT NULL,                             -- Liên hệ được phản hồi
    responder_id INT NOT NULL,                           -- Người phản hồi (Admin)
    response_content NVARCHAR(2000) NOT NULL,            -- Nội dung phản hồi
    response_time DATETIME NOT NULL DEFAULT GETDATE(),   -- Thời gian phản hồi
    CONSTRAINT FK_Response_Contact FOREIGN KEY (contact_id) REFERENCES Contacts(contact_id),
    CONSTRAINT FK_Response_Responder FOREIGN KEY (responder_id) REFERENCES Users(user_id)
);

-- thêm để update việc tại sao lại  ban account
CREATE TABLE Account_Ban_Log (
    ban_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,                   -- Người bị ban
    banned_by INT NOT NULL,                 -- Người thực hiện ban
    reason NVARCHAR(255) NOT NULL,          -- Lý do ban
    is_permanent BIT NOT NULL DEFAULT 1,    -- 1: vĩnh viễn, 0: tạm thời
    created_at DATETIME DEFAULT GETDATE(),  -- Thời gian ban

    CONSTRAINT FK_Ban_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
    CONSTRAINT FK_Ban_By FOREIGN KEY (banned_by) REFERENCES Users(user_id)
);

CREATE TABLE PoolImage ( 
    image_id INT PRIMARY KEY IDENTITY(1,1),
    pool_id INT NOT NULL REFERENCES Pools(pool_id),
    pool_image NVARCHAR(MAX)
);




-- Phần này chạy sau
-- Trigger sinh mã ticket_code tự động sau khi insert
GO
CREATE TRIGGER trg_AutoGenerate_TicketCode
ON Ticket
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE t
    SET t.ticket_code = CONCAT(tt.type_code, '-TICKET-', FORMAT(t.ticket_id, '0000'))
    FROM Ticket t
    JOIN inserted i ON t.ticket_id = i.ticket_id
    JOIN Ticket_Types tt ON t.ticket_type_id = tt.ticket_type_id
    WHERE t.ticket_code IS NULL;
END;


