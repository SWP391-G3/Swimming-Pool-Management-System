--CREATE DATABASE SwimmingPoolDB

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
    manager_id INT NOT NULL,
	CONSTRAINT FK_Branchs_Manager FOREIGN KEY (manager_id) REFERENCES Users(user_id)
);

CREATE TABLE Staffs(
	staff_id INT IDENTITY(1,1) PRIMARY KEY,
	user_id INT NOT NULL,
	branch_id INT NOT NULL,
	CONSTRAINT FK_Staffs_User FOREIGN KEY (user_id) REFERENCES Users(user_id),
	CONSTRAINT FK_Staffs_Branch FOREIGN KEY (branch_id) REFERENCES Branchs(branch_id)
)

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
    updated_at DATETIME
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
    user_id INT NOT NULL,
    pool_id INT NOT NULL,
    discount_id INT NULL,
    booking_date DATE NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL,
    slot_count INT NOT NULL CHECK (slot_count > 0),
    booking_status NVARCHAR(20) NOT NULL DEFAULT 'pending', --pending/comfirmed/c
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
    is_combo BIT NOT NULL DEFAULT 0             -- nếu là combo (1), thường (0)
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
CREATE TABLE Pool_Ticket_Type (
    pool_id INT NOT NULL,
    ticket_type_id INT NOT NULL,
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



-- Phần này chạy sau
-- Tạo view hỗ trợ tổng tiền theo booking
GO
CREATE VIEW vw_BookingTotalAmount AS
SELECT 
    b.booking_id,
    SUM(ISNULL(pt.amount * pt.quantity, 0)) AS total_ticket_amount,
    SUM(ISNULL(pr.amount * pr.quantity, 0)) AS total_rent_amount,
    SUM(ISNULL(pt.amount * pt.quantity, 0) + ISNULL(pr.amount * pr.quantity, 0)) AS total_amount
FROM Booking b
	LEFT JOIN Payments p ON b.booking_id = p.booking_id
	LEFT JOIN Payment_Ticket pt ON p.payment_id = pt.payment_id
	LEFT JOIN Payment_RentItem pr ON p.payment_id = pr.payment_id
GROUP BY b.booking_id;

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

-- View hiển thị chi tiết các loại vé trong mỗi booking (tổng hợp theo loại vé)
GO
CREATE VIEW vw_Booking_TicketDetails AS
SELECT 
    b.booking_id,
    u.full_name AS customer_name,
    p.payment_method,
    tt.type_name AS ticket_type,
    pt.amount AS unit_price,
    SUM(pt.quantity) AS quantity,
    SUM(pt.amount * pt.quantity) AS total_price
FROM Booking b
JOIN Users u ON b.user_id = u.user_id
JOIN Payments p ON b.booking_id = p.booking_id
JOIN Payment_Ticket pt ON p.payment_id = pt.payment_id
JOIN Ticket t ON pt.ticket_id = t.ticket_id
JOIN Ticket_Types tt ON t.ticket_type_id = tt.ticket_type_id
GROUP BY b.booking_id, u.full_name, p.payment_method, tt.type_name, pt.amount;

-- View hiển thị chi tiết từng vé của mỗi booking (mỗi dòng là 1 vé cụ thể)
GO
CREATE VIEW vw_TicketPerBookingDetail AS
SELECT 
    b.booking_id,
    u.full_name AS customer_name,
    p.payment_method,
    t.ticket_code,
    tt.type_name AS ticket_type,
    pt.amount AS ticket_price,
    pt.quantity,
    (pt.amount * pt.quantity) AS total_price,
    t.issued_at
FROM Booking b
JOIN Users u ON b.user_id = u.user_id
JOIN Payments p ON b.booking_id = p.booking_id
JOIN Payment_Ticket pt ON p.payment_id = pt.payment_id
JOIN Ticket t ON pt.ticket_id = t.ticket_id
JOIN Ticket_Types tt ON t.ticket_type_id = tt.ticket_type_id;

-- View hiển thị chi tiết Combo gồm những gì
GO
CREATE VIEW vw_Combo_Structure AS
SELECT 
    ct.type_name AS combo_name,
    it.type_name AS included_name,
    cd.quantity
FROM Combo_Detail cd
JOIN Ticket_Types ct ON cd.combo_type_id = ct.ticket_type_id
JOIN Ticket_Types it ON cd.included_type_id = it.ticket_type_id;

--Stored Procedure – Xử lý giảm giá khi thanh toán
GO
CREATE PROCEDURE CreatePaymentWithDiscount
    @booking_id INT,
    @payment_method NVARCHAR(50),
    @transaction_reference NVARCHAR(100) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE 
        @discount_percent DECIMAL(5,2) = 0,
        @discount_amount DECIMAL(10,2) = 0,
        @total_before_discount DECIMAL(10,2) = 0,
        @total_after_discount DECIMAL(10,2) = 0,
        @discount_id INT;

    -- Lấy discount_id từ Booking
    SELECT @discount_id = discount_id FROM Booking WHERE booking_id = @booking_id;

    -- Lấy tổng tiền gốc từ các vé + vật dụng thuê
    SELECT @total_before_discount = 
        ISNULL(SUM(pt.amount * pt.quantity), 0)
        FROM Payments p
        JOIN Payment_Ticket pt ON p.payment_id = pt.payment_id
        WHERE p.booking_id = @booking_id;

    SELECT @total_before_discount = @total_before_discount + 
        ISNULL(SUM(pr.amount * pr.quantity), 0)
        FROM Payments p
        JOIN Payment_RentItem pr ON p.payment_id = pr.payment_id
        WHERE p.booking_id = @booking_id;

    -- Nếu có mã giảm giá thì lấy phần trăm
    IF @discount_id IS NOT NULL
    BEGIN
        SELECT @discount_percent = discount_percent
        FROM Discounts
        WHERE discount_id = @discount_id
          AND status = 1
          AND GETDATE() BETWEEN valid_from AND valid_to;
    END

    -- Tính tiền giảm và tổng tiền cuối cùng
    SET @discount_amount = @total_before_discount * (@discount_percent / 100.0);
    SET @total_after_discount = @total_before_discount - @discount_amount;

    -- Tạo bản ghi Payment
    INSERT INTO Payments (
        booking_id,
        payment_method,
        payment_status,
        payment_date,
        transaction_reference,
        created_at,
        discount_amount,
        total_amount
    )
    VALUES (
        @booking_id,
        @payment_method,
        'pending',
        GETDATE(),
        @transaction_reference,
        GETDATE(),
        @discount_amount,
        @total_after_discount
    );
END;

--EXEC CreatePaymentWithDiscount 
--    @booking_id = 101, 
--    @payment_method = 'Cash',
--    @transaction_reference = 'TXN20250614-0001';



