INSERT INTO Roles (role_name)
VALUES 
    (N'admin'),
    (N'manager'),
    (N'staff'),
    (N'customer');

-- Hà Nội
INSERT INTO Pools (pool_name, pool_road, pool_address, max_slot, open_time, close_time)
VALUES 
(N'Hồ bơi Kim Mã', N'1 Kim Mã', N'Hà Nội', 100, '06:00', '20:00'),
(N'Hồ bơi Hoàng Hoa Thám', N'2 Hoàng Hoa Thám', N'Hà Nội', 90, '06:00', '20:00'),
(N'Hồ bơi Láng Hạ', N'3 Láng Hạ', N'Hà Nội', 80, '06:00', '20:00'),
(N'Hồ bơi Phạm Hùng', N'4 Phạm Hùng', N'Hà Nội', 110, '06:00', '20:00'),
(N'Hồ bơi Nguyễn Trãi', N'5 Nguyễn Trãi', N'Hà Nội', 85, '06:00', '20:00'),
(N'Hồ bơi Xuân Thủy', N'6 Xuân Thủy', N'Hà Nội', 95, '06:00', '20:00'),
(N'Hồ bơi Trần Duy Hưng', N'7 Trần Duy Hưng', N'Hà Nội', 100, '06:00', '20:00'),
(N'Hồ bơi Cầu Giấy', N'8 Cầu Giấy', N'Hà Nội', 70, '06:00', '20:00'),
(N'Hồ bơi Lê Văn Lương', N'9 Lê Văn Lương', N'Hà Nội', 60, '06:00', '20:00'),
(N'Hồ bơi Tây Sơn', N'10 Tây Sơn', N'Hà Nội', 90, '06:00', '20:00'),

-- TP.HCM
(N'Hồ bơi Nguyễn Thị Minh Khai', N'1 Nguyễn Thị Minh Khai', N'Hồ Chí Minh', 100, '06:00', '20:00'),
(N'Hồ bơi Cách Mạng Tháng 8', N'2 Cách Mạng Tháng 8', N'Hồ Chí Minh', 90, '06:00', '20:00'),
(N'Hồ bơi Võ Thị Sáu', N'3 Võ Thị Sáu', N'Hồ Chí Minh', 80, '06:00', '20:00'),
(N'Hồ bơi Nguyễn Trãi (SG)', N'4 Nguyễn Trãi', N'Hồ Chí Minh', 85, '06:00', '20:00'),
(N'Hồ bơi Điện Biên Phủ', N'5 Điện Biên Phủ', N'Hồ Chí Minh', 95, '06:00', '20:00'),
(N'Hồ bơi Trường Chinh', N'6 Trường Chinh', N'Hồ Chí Minh', 90, '06:00', '20:00'),
(N'Hồ bơi Lý Thường Kiệt (SG)', N'7 Lý Thường Kiệt', N'Hồ Chí Minh', 100, '06:00', '20:00'),
(N'Hồ bơi Pasteur', N'8 Pasteur', N'Hồ Chí Minh', 75, '06:00', '20:00'),
(N'Hồ bơi Lê Văn Sỹ', N'9 Lê Văn Sỹ', N'Hồ Chí Minh', 70, '06:00', '20:00'),
(N'Hồ bơi Nguyễn Văn Cừ (SG)', N'10 Nguyễn Văn Cừ', N'Hồ Chí Minh', 85, '06:00', '20:00'),

-- Đà Nẵng
(N'Hồ bơi Bạch Đằng', N'1 Bạch Đằng', N'Đà Nẵng', 100, '06:00', '20:00'),
(N'Hồ bơi Nguyễn Văn Linh', N'2 Nguyễn Văn Linh', N'Đà Nẵng', 90, '06:00', '20:00'),
(N'Hồ bơi Lê Duẩn', N'3 Lê Duẩn', N'Đà Nẵng', 85, '06:00', '20:00'),
(N'Hồ bơi Trần Phú (ĐN)', N'4 Trần Phú', N'Đà Nẵng', 80, '06:00', '20:00'),
(N'Hồ bơi Hoàng Diệu', N'5 Hoàng Diệu', N'Đà Nẵng', 95, '06:00', '20:00'),
(N'Hồ bơi 2 Tháng 9', N'6 2 Tháng 9', N'Đà Nẵng', 90, '06:00', '20:00'),
(N'Hồ bơi Hàm Nghi', N'7 Hàm Nghi', N'Đà Nẵng', 100, '06:00', '20:00'),
(N'Hồ bơi Trưng Nữ Vương', N'8 Trưng Nữ Vương', N'Đà Nẵng', 70, '06:00', '20:00'),
(N'Hồ bơi Nguyễn Tri Phương', N'9 Nguyễn Tri Phương', N'Đà Nẵng', 65, '06:00', '20:00'),
(N'Hồ bơi Tôn Đức Thắng', N'10 Tôn Đức Thắng', N'Đà Nẵng', 85, '06:00', '20:00'),

-- Quy Nhơn
(N'Hồ bơi Nguyễn Huệ', N'1 Nguyễn Huệ', N'Quy Nhơn', 100, '06:00', '20:00'),
(N'Hồ bơi Trần Phú (QNH)', N'2 Trần Phú', N'Quy Nhơn', 90, '06:00', '20:00'),
(N'Hồ bơi Lê Lợi', N'3 Lê Lợi', N'Quy Nhơn', 85, '06:00', '20:00'),
(N'Hồ bơi Tăng Bạt Hổ', N'4 Tăng Bạt Hổ', N'Quy Nhơn', 80, '06:00', '20:00'),
(N'Hồ bơi An Dương Vương', N'5 An Dương Vương', N'Quy Nhơn', 95, '06:00', '20:00'),
(N'Hồ bơi Xuân Diệu', N'6 Xuân Diệu', N'Quy Nhơn', 90, '06:00', '20:00'),
(N'Hồ bơi Hùng Vương', N'7 Hùng Vương', N'Quy Nhơn', 100, '06:00', '20:00'),
(N'Hồ bơi Nguyễn Tất Thành', N'8 Nguyễn Tất Thành', N'Quy Nhơn', 70, '06:00', '20:00'),
(N'Hồ bơi Bạch Đằng (QNH)', N'9 Bạch Đằng', N'Quy Nhơn', 60, '06:00', '20:00'),
(N'Hồ bơi Lý Thường Kiệt (QNH)', N'10 Lý Thường Kiệt', N'Quy Nhơn', 85, '06:00', '20:00'),

-- Cần Thơ
(N'Hồ bơi Nguyễn Văn Cừ (CT)', N'1 Nguyễn Văn Cừ', N'Cần Thơ', 100, '06:00', '20:00'),
(N'Hồ bơi Hòa Bình', N'2 Hòa Bình', N'Cần Thơ', 90, '06:00', '20:00'),
(N'Hồ bơi Trần Hưng Đạo', N'3 Trần Hưng Đạo', N'Cần Thơ', 85, '06:00', '20:00'),
(N'Hồ bơi Mậu Thân', N'4 Mậu Thân', N'Cần Thơ', 80, '06:00', '20:00'),
(N'Hồ bơi Lý Tự Trọng', N'5 Lý Tự Trọng', N'Cần Thơ', 95, '06:00', '20:00'),
(N'Hồ bơi Nguyễn Trãi (CT)', N'6 Nguyễn Trãi', N'Cần Thơ', 90, '06:00', '20:00'),
(N'Hồ bơi Trần Phú (CT)', N'7 Trần Phú', N'Cần Thơ', 100, '06:00', '20:00'),
(N'Hồ bơi 30 Tháng 4', N'8 30 Tháng 4', N'Cần Thơ', 70, '06:00', '20:00'),
(N'Hồ bơi Cách Mạng Tháng 8 (CT)', N'9 Cách Mạng Tháng 8', N'Cần Thơ', 65, '06:00', '20:00'),
(N'Hồ bơi Phan Đình Phùng', N'10 Phan Đình Phùng', N'Cần Thơ', 85, '06:00', '20:00');



INSERT INTO Users (username, password, full_name, email, phone, address, role_id)
VALUES 
(N'admin01', N'admin@123', N'Nguyễn Văn Admin', N'admin01@example.com', N'0909123456', N'123 Trần Hưng Đạo, Hà Nội', 1),
(N'manager01', N'manager@123', N'Lê Thị Quản Lý', N'manager01@example.com', N'0912345678', N'456 Lê Lợi, TP.HCM', 2),
(N'staff01', N'staff@123', N'Phạm Văn Nhân Viên', N'staff01@example.com', N'0923456789', N'789 Phan Chu Trinh, Đà Nẵng', 3),
(N'customer01', N'customer@123', N'Hoàng Thị Khách', N'customer01@example.com', N'0934567890', N'101 Nguyễn Huệ, Cần Thơ', 4),
(N'customer02', N'customer@456', N'Trần Văn Dũng', N'customer02@example.com', N'0945678901', N'202 Nguyễn Trãi, Quy Nhơn', 4);
