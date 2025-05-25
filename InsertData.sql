INSERT INTO Roles (role_name)
VALUES 
    (N'admin'),
    (N'manager'),
    (N'staff'),
    (N'customer');

-- Hà Nội
-- Hà Nội
-- dữ liệu mới
INSERT INTO Pools (pool_name, pool_road, pool_address, max_slot, open_time, close_time, pool_status, created_at, pool_image) VALUES
(N'Hồ bơi Thanh Xuân', N'Đường Nguyễn Trãi', N'Hà Nội', 50, '06:00:00', '20:00:00', 1, GETDATE(), N'https://villas-guide.com/wp/wp-content/uploads/2024/03/villas_1.jpeg'),
(N'Hồ bơi Cầu Giấy', N'Đường Cầu Giấy', N'Hà Nội', 45, '06:30:00', '19:30:00', 1, GETDATE(), N'https://xaydunghoboigiare.com/upload/images/5-tieu-chuan-quan-trong-trong-thiet-ke-be-boi-gia-dinh-1(1).jpg'),
(N'Hồ bơi Đống Đa', N'Đường Xã Đàn', N'Hà Nội', 40, '07:00:00', '20:00:00', 1, GETDATE(), N'https://png.pngtree.com/background/20230408/original/pngtree-beautiful-indoor-swimming-pool-picture-image_2336818.jpg'),
(N'Hồ bơi Long Biên', N'Đường Nguyễn Văn Cừ', N'Hà Nội', 60, '05:30:00', '21:00:00', 1, GETDATE(), N'https://booking.pystravel.vn/uploads/posts/avatar/1601051675.jpg'),
(N'Hồ bơi Ba Đình', N'Đường Kim Mã', N'Hà Nội', 55, '06:00:00', '20:00:00', 1, GETDATE(), N'https://i.pinimg.com/originals/36/64/43/366443b18bf1e6e94dbd3213d0fe005a.jpg'),

(N'Hồ bơi Quận 1', N'Đường Lê Lợi', N'Hồ Chí Minh', 60, '05:00:00', '20:00:00', 1, GETDATE(), N'https://maxtanzt.de/wp-content/uploads/17_vrh-t_pool_victors-hotel-teistungen-scaled.jpg'),
(N'Hồ bơi Quận 3', N'Đường Cách Mạng Tháng 8', N'Hồ Chí Minh', 50, '06:00:00', '21:00:00', 1, GETDATE(), N'https://slovenskycestovatel.sk/images/items/1171/aqua-relax-titris7355451.jpg'),
(N'Hồ bơi Quận 5', N'Đường Trần Hưng Đạo', N'Hồ Chí Minh', 45, '06:30:00', '20:00:00', 1, GETDATE(), N'https://th.bing.com/th/id/R.7c13bf7145846ee447f8cfd562336c7a?rik=YWYyLwj5s9kKbA&riu=http%3a%2f%2fhanteco.vn%2fhinhanh%2ftintuc%2fbe-boi-vo-cuc-3.jpeg&ehk=sT%2b135Jd5ASbRygifVdn7oaga3jYLIjBgkgforNif%2bM%3d&risl=&pid=ImgRaw&r=0'),
(N'Hồ bơi Thủ Đức', N'Đường Võ Văn Ngân', N'Hồ Chí Minh', 70, '05:30:00', '19:30:00', 1, GETDATE(), N'https://www.prachachat.net/wp-content/uploads/2020/04/S__19570748.jpg'),
(N'Hồ bơi Quận 7', N'Đường Nguyễn Thị Thập', N'Hồ Chí Minh', 55, '06:00:00', '20:30:00', 1, GETDATE(), N'https://wanderonwards.co/wp-content/uploads/2019/04/padma-1024x683.jpg'),

-- Đà Nẵng

(N'Hồ bơi Hải Châu', N'Đường Lê Duẩn', N'Đà Nẵng', 50, '06:00:00', '19:00:00', 1, GETDATE(), N'https://th.bing.com/th/id/R.905c0c37b9ed2c8ba141fb95826bc5df?rik=TN2AwKdoi0LE9w&riu=http%3a%2f%2fwww.worldwayhk.com%2fUpLoadFiles%2f20151110%2f2015111010202846.jpg&ehk=F9q02sqTyInEk4Se%2fDfeWNSV6sovHG2qe2vi3nrb9%2bM%3d&risl=&pid=ImgRaw&r=0'),
(N'Hồ bơi Sơn Trà', N'Đường Trần Hưng Đạo', N'Đà Nẵng', 45, '06:30:00', '18:30:00', 1, GETDATE(), N'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/13/2a/a1/f6/centara-ras-fushi-resort.jpg?w=1200&h=-1&s=1'),
(N'Hồ bơi Thanh Khê', N'Đường Hà Huy Tập', N'Đà Nẵng', 40, '07:00:00', '19:30:00', 1, GETDATE(), N'https://thethaodonga.com/wp-content/uploads/2022/06/ho-boi-o-tphcm-2.jpg'),
(N'Hồ bơi Liên Chiểu', N'Đường Nguyễn Lương Bằng', N'Đà Nẵng', 60, '05:30:00', '20:00:00', 1, GETDATE(), N'https://ktmt.vnmediacdn.com/images/2024/04/10/83-1712742140-352375012-699494991981699-6157285300830981686-n.jpg'),
(N'Hồ bơi Ngũ Hành Sơn', N'Đường Ngũ Hành Sơn', N'Đà Nẵng', 55, '06:00:00', '19:30:00', 1, GETDATE(), N'https://vnanet.vn/Data/Articles/2024/06/17/7435552/vna_potal_hai_duong_tang_cuong_day_boi_cho_tre_em_dip_he_de_phong_tranh_duoi_nuoc__stand.jpg'),

-- Cần Thơ

(N'Hồ bơi Ninh Kiều', N'Đường 30 Tháng 4', N'Cần Thơ', 50, '06:00:00', '20:00:00', 1, GETDATE(), N'https://turftown.in/_next/image?url=https%3A%2F%2Fturftown.s3.ap-south-1.amazonaws.com%2Fsuper_admin%2Ftt-1722768448280.webp&w=3840&q=75'),
(N'Hồ bơi Bình Thủy', N'Đường Nguyễn Trãi', N'Cần Thơ', 45, '06:30:00', '19:30:00', 1, GETDATE(), N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx26g6WKHSQW34d2dRT6KVuG3KqJ0BPNuLLw&s'),
(N'Hồ bơi Cái Răng', N'Đường Quốc lộ 91B', N'Cần Thơ', 40, '07:00:00', '20:00:00', 1, GETDATE(), N'https://hoboinhatrang.vn/filestorage/article/large/lc2.jpg'),
(N'Hồ bơi Ô Môn', N'Đường Phan Văn Trị', N'Cần Thơ', 60, '05:30:00', '21:00:00', 1, GETDATE(), N'https://www.srsmith.com/media/180835/build-your-own-pool-slide-beauty-923x730.jpg?mode=pad&width=725&height=573&bgcolor=fff&rnd=133054065692270000'),
(N'Hồ bơi Thốt Nốt', N'Đường Trần Hưng Đạo', N'Cần Thơ', 55, '06:00:00', '20:00:00', 1, GETDATE(), N'https://www.eugene-or.gov/ImageRepository/Document?documentID=67182'),

-- Quy Nhơn

(N'Hồ bơi Nguyễn Huệ', N'Đường Nguyễn Huệ', N'Quy Nhơn', 50, '06:00:00', '19:00:00', 1, GETDATE(), N'https://cdn.baogialai.com.vn/images/b6e9e273388cf373c7197a59d2310437352c2851cd5b8e027e0695c8f296f53af1dc3f5b91b26aae470176cec4d4439d2e69976aae899185fffdddb094a72d3e/1vn-5274.jpg'),
(N'Hồ bơi An Dương Vương', N'Đường An Dương Vương', N'Quy Nhơn', 45, '06:30:00', '19:30:00', 1, GETDATE(), N'https://static.vinwonders.com/production/ho-boi-quan-9.jpg'),
(N'Hồ bơi Lê Lợi', N'Đường Lê Lợi', N'Quy Nhơn', 40, '07:00:00', '20:00:00', 1, GETDATE(), N'https://streamline.imgix.net/eb0267a4-922d-4297-a476-194d6c689471/82abffc9-632a-44b3-abed-d0ea03d20d84/IMG_5342_edited.jpg?ixlib=rb-1.1.0&w=2000&h=2000&fit=max&or=0&s=58e787b840cd62bfacb839b701e5e9e0'),
(N'Hồ bơi Trần Phú', N'Đường Trần Phú', N'Quy Nhơn', 60, '05:30:00', '21:00:00', 1, GETDATE(), N'https://bcp.cdnchinhphu.vn/334894974524682240/2024/4/11/an-toan-thiet-bi-be-boi-17128195925281735826251.jpg'),
(N'Hồ bơi Phú Tài', N'Đường Tây Sơn', N'Quy Nhơn', 55, '06:00:00', '20:00:00', 1, GETDATE(), N'https://prihoda.co.uk/wp-content/uploads/2015/09/Swiming-pool-fabric-ducting-prihoda-8.jpg');




INSERT INTO Users (username, password, full_name, email, phone, address, role_id)
VALUES 
(N'admin01', N'admin@123', N'Nguyễn Văn Admin', N'admin01@example.com', N'0909123456', N'123 Trần Hưng Đạo, Hà Nội', 1),
(N'manager01', N'manager@123', N'Lê Thị Quản Lý', N'manager01@example.com', N'0912345678', N'456 Lê Lợi, TP.HCM', 2),
(N'staff01', N'staff@123', N'Phạm Văn Nhân Viên', N'staff01@example.com', N'0923456789', N'789 Phan Chu Trinh, Đà Nẵng', 3),
(N'customer01', N'customer@123', N'Hoàng Thị Khách', N'customer01@example.com', N'0934567890', N'101 Nguyễn Huệ, Cần Thơ', 4),
(N'customer02', N'customer@456', N'Trần Văn Dũng', N'customer02@example.com', N'0945678901', N'202 Nguyễn Trãi, Quy Nhơn', 4);

 -- thêm giữ liệu mới từ đây nhé

INSERT INTO dbo.Booking (
    user_id, pool_id, booking_date, start_time, end_time,
    slot_count, booking_status, created_at, updated_at
)
VALUES
(1, 1, '2025-06-01', '08:00:00', '09:00:00', 1, 'confirmed', GETDATE(), NULL),
(2, 2, '2025-06-01', '09:00:00', '10:00:00', 2, 'pending', GETDATE(), NULL),
(3, 1, '2025-06-02', '10:00:00', '11:00:00', 1, 'cancelled', GETDATE(), NULL),
(4, 3, '2025-06-03', '07:00:00', '08:00:00', 1, 'confirmed', GETDATE(), NULL),
(5, 2, '2025-06-04', '18:00:00', '19:00:00', 3, 'confirmed', GETDATE(), NULL),
(6, 3, '2025-06-04', '17:00:00', '18:00:00', 2, 'pending', GETDATE(), NULL),
(7, 1, '2025-06-05', '06:00:00', '07:00:00', 1, 'confirmed', GETDATE(), NULL),
(8, 2, '2025-06-06', '08:30:00', '09:30:00', 2, 'cancelled', GETDATE(), NULL),
(9, 3, '2025-06-06', '19:00:00', '20:00:00', 1, 'confirmed', GETDATE(), NULL),
(10, 1, '2025-06-07', '10:30:00', '11:30:00', 1, 'confirmed', GETDATE(), NULL);


INSERT INTO dbo.Booking_Discounts (
    booking_id, discount_id, amount
)
VALUES
(1, 1, 20000.00),
(2, 2, 15000.00),
(3, 1, 20000.00),
(4, 3, 10000.00),
(5, 2, 25000.00),
(6, 4, 5000.00),
(7, 1, 20000.00),
(8, 5, 30000.00),
(9, 3, 10000.00),
(10, 2, 15000.00);

