
insert into Roles(role_name) values (N'admin'),(N'manager'),(N'staff'),(N'customer');

INSERT INTO Pools (pool_name, pool_road, pool_address, max_slot, open_time, close_time, pool_status, created_at, pool_image, pool_description) VALUES
(N'Hồ bơi Thanh Xuân', N'Đường Nguyễn Trãi', N'Hà Nội', 50, '06:00:00', '20:00:00', 1, GETDATE(), N'https://villas-guide.com/wp/wp-content/uploads/2024/03/villas_1.jpeg',N'Bể bơi ngoài trời với không gian xanh mát, lý tưởng cho gia đình.'),
(N'Hồ bơi Cầu Giấy', N'Đường Cầu Giấy', N'Hà Nội', 45, '06:30:00', '19:30:00', 1, GETDATE(), N'https://xaydunghoboigiare.com/upload/images/5-tieu-chuan-quan-trong-trong-thiet-ke-be-boi-gia-dinh-1(1).jpg',N'Hồ bơi trong nhà với hệ thống nước nóng hiện đại.'),
(N'Hồ bơi Đống Đa', N'Đường Xã Đàn', N'Hà Nội', 40, '07:00:00', '20:00:00', 1, GETDATE(), N'https://png.pngtree.com/background/20230408/original/pngtree-beautiful-indoor-swimming-pool-picture-image_2336818.jpg',N'Bể bơi có khu vui chơi trẻ em an toàn và sôi động.'),
(N'Hồ bơi Long Biên', N'Đường Nguyễn Văn Cừ', N'Hà Nội', 60, '05:30:00', '21:00:00', 1, GETDATE(), N'https://booking.pystravel.vn/uploads/posts/avatar/1601051675.jpg',N'Bể bơi đạt chuẩn thi đấu quốc gia, phù hợp luyện tập chuyên nghiệp.'),
(N'Hồ bơi Ba Đình', N'Đường Kim Mã', N'Hà Nội', 55, '06:00:00', '20:00:00', 1, GETDATE(), N'https://i.pinimg.com/originals/36/64/43/366443b18bf1e6e94dbd3213d0fe005a.jpg',N'Khu hồ bơi thư giãn với dịch vụ spa liền kề.'),

(N'Hồ bơi Quận 1', N'Đường Lê Lợi', N'Hồ Chí Minh', 60, '05:00:00', '20:00:00', 1, GETDATE(), N'https://maxtanzt.de/wp-content/uploads/17_vrh-t_pool_victors-hotel-teistungen-scaled.jpg',N'Hồ bơi vô cực hướng nhìn ra công viên thành phố.'),
(N'Hồ bơi Quận 3', N'Đường Cách Mạng Tháng 8', N'Hồ Chí Minh', 50, '06:00:00', '21:00:00', 1, GETDATE(), N'https://slovenskycestovatel.sk/images/items/1171/aqua-relax-titris7355451.jpg',N'Bể bơi gia đình với thiết kế hiện đại, sạch sẽ.'),
(N'Hồ bơi Quận 5', N'Đường Trần Hưng Đạo', N'Hồ Chí Minh', 45, '06:30:00', '20:00:00', 1, GETDATE(), N'https://th.bing.com/th/id/R.7c13bf7145846ee447f8cfd562336c7a?rik=YWYyLwj5s9kKbA&riu=http%3a%2f%2fhanteco.vn%2fhinhanh%2ftintuc%2fbe-boi-vo-cuc-3.jpeg&ehk=sT%2b135Jd5ASbRygifVdn7oaga3jYLIjBgkgforNif%2bM%3d&risl=&pid=ImgRaw&r=0',N'Hồ bơi kết hợp cafe và khu ngồi nghỉ thư giãn.'),
(N'Hồ bơi Thủ Đức', N'Đường Võ Văn Ngân', N'Hồ Chí Minh', 70, '05:30:00', '19:30:00', 1, GETDATE(), N'https://www.prachachat.net/wp-content/uploads/2020/04/S__19570748.jpg',N'Bể bơi nước mặn sử dụng công nghệ lọc tự nhiên.'),
(N'Hồ bơi Quận 7', N'Đường Nguyễn Thị Thập', N'Hồ Chí Minh', 55, '06:00:00', '20:30:00', 1, GETDATE(), N'https://wanderonwards.co/wp-content/uploads/2019/04/padma-1024x683.jpg',N'Bể bơi có hệ thống âm thanh dưới nước độc đáo.'),

-- Đà Nẵng

(N'Hồ bơi Hải Châu', N'Đường Lê Duẩn', N'Đà Nẵng', 50, '06:00:00', '19:00:00', 1, GETDATE(), N'https://th.bing.com/th/id/R.905c0c37b9ed2c8ba141fb95826bc5df?rik=TN2AwKdoi0LE9w&riu=http%3a%2f%2fwww.worldwayhk.com%2fUpLoadFiles%2f20151110%2f2015111010202846.jpg&ehk=F9q02sqTyInEk4Se%2fDfeWNSV6sovHG2qe2vi3nrb9%2bM%3d&risl=&pid=ImgRaw&r=0',N'Bể bơi trong khu nghỉ dưỡng cao cấp ven sông.'),
(N'Hồ bơi Sơn Trà', N'Đường Trần Hưng Đạo', N'Đà Nẵng', 45, '06:30:00', '18:30:00', 1, GETDATE(), N'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/13/2a/a1/f6/centara-ras-fushi-resort.jpg?w=1200&h=-1&s=1',N'Hồ bơi lộ thiên với thiết kế thân thiện với môi trường.'),
(N'Hồ bơi Thanh Khê', N'Đường Hà Huy Tập', N'Đà Nẵng', 40, '07:00:00', '19:30:00', 1, GETDATE(), N'https://thethaodonga.com/wp-content/uploads/2022/06/ho-boi-o-tphcm-2.jpg',N'Bể bơi có đường bơi phân làn cho người tập thể thao.'),
(N'Hồ bơi Liên Chiểu', N'Đường Nguyễn Lương Bằng', N'Đà Nẵng', 60, '05:30:00', '20:00:00', 1, GETDATE(), N'https://ktmt.vnmediacdn.com/images/2024/04/10/83-1712742140-352375012-699494991981699-6157285300830981686-n.jpg',N'Bể bơi dành riêng cho người lớn, yên tĩnh và riêng tư.'),
(N'Hồ bơi Ngũ Hành Sơn', N'Đường Ngũ Hành Sơn', N'Đà Nẵng', 55, '06:00:00', '19:30:00', 1, GETDATE(), N'https://vnanet.vn/Data/Articles/2024/06/17/7435552/vna_potal_hai_duong_tang_cuong_day_boi_cho_tre_em_dip_he_de_phong_tranh_duoi_nuoc__stand.jpg',N'Bể bơi giải trí có cầu trượt nước và vòi phun vui nhộn.'),

-- Cần Thơ

(N'Hồ bơi Ninh Kiều', N'Đường 30 Tháng 4', N'Cần Thơ', 50, '06:00:00', '20:00:00', 1, GETDATE(), N'https://turftown.in/_next/image?url=https%3A%2F%2Fturftown.s3.ap-south-1.amazonaws.com%2Fsuper_admin%2Ftt-1722768448280.webp&w=3840&q=75',N'Hồ bơi nhỏ dành cho trẻ sơ sinh với độ sâu an toàn.'),
(N'Hồ bơi Bình Thủy', N'Đường Nguyễn Trãi', N'Cần Thơ', 45, '06:30:00', '19:30:00', 1, GETDATE(), N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx26g6WKHSQW34d2dRT6KVuG3KqJ0BPNuLLw&s',N'Hồ bơi trên tầng thượng khách sạn với tầm nhìn toàn cảnh.'),
(N'Hồ bơi Cái Răng', N'Đường Quốc lộ 91B', N'Cần Thơ', 40, '07:00:00', '20:00:00', 1, GETDATE(), N'https://hoboinhatrang.vn/filestorage/article/large/lc2.jpg',N'Bể bơi ban đêm có hệ thống đèn LED đổi màu hiện đại.'),
(N'Hồ bơi Ô Môn', N'Đường Phan Văn Trị', N'Cần Thơ', 60, '05:30:00', '21:00:00', 1, GETDATE(), N'https://www.srsmith.com/media/180835/build-your-own-pool-slide-beauty-923x730.jpg?mode=pad&width=725&height=573&bgcolor=fff&rnd=133054065692270000',N'Bể bơi có lớp học bơi hàng ngày cho mọi lứa tuổi.'),
(N'Hồ bơi Thốt Nốt', N'Đường Trần Hưng Đạo', N'Cần Thơ', 55, '06:00:00', '20:00:00', 1, GETDATE(), N'https://www.eugene-or.gov/ImageRepository/Document?documentID=67182',N'Hồ bơi có mái che linh hoạt, sử dụng quanh năm.'),

-- Quy Nhơn

(N'Hồ bơi Nguyễn Huệ', N'Đường Nguyễn Huệ', N'Quy Nhơn', 50, '06:00:00', '19:00:00', 1, GETDATE(), N'https://cdn.baogialai.com.vn/images/b6e9e273388cf373c7197a59d2310437352c2851cd5b8e027e0695c8f296f53af1dc3f5b91b26aae470176cec4d4439d2e69976aae899185fffdddb094a72d3e/1vn-5274.jpg',N'Bể bơi phong cách resort giữa lòng thành phố.'),
(N'Hồ bơi An Dương Vương', N'Đường An Dương Vương', N'Quy Nhơn', 45, '06:30:00', '19:30:00', 1, GETDATE(), N'https://static.vinwonders.com/production/ho-boi-quan-9.jpg',N'Hồ bơi nước ấm, phù hợp cho người cao tuổi.'),
(N'Hồ bơi Lê Lợi', N'Đường Lê Lợi', N'Quy Nhơn', 40, '07:00:00', '20:00:00', 1, GETDATE(), N'https://streamline.imgix.net/eb0267a4-922d-4297-a476-194d6c689471/82abffc9-632a-44b3-abed-d0ea03d20d84/IMG_5342_edited.jpg?ixlib=rb-1.1.0&w=2000&h=2000&fit=max&or=0&s=58e787b840cd62bfacb839b701e5e9e0',N'Bể bơi thiết kế hình dạng đặc biệt, tạo cảm hứng sáng tạo.'),
(N'Hồ bơi Trần Phú', N'Đường Trần Phú', N'Quy Nhơn', 60, '05:30:00', '21:00:00', 1, GETDATE(), N'https://bcp.cdnchinhphu.vn/334894974524682240/2024/4/11/an-toan-thiet-bi-be-boi-17128195925281735826251.jpg',N'Bể bơi nằm cạnh vườn cây nhiệt đới, không khí trong lành.'),
(N'Hồ bơi Phú Tài', N'Đường Tây Sơn', N'Quy Nhơn', 55, '06:00:00', '20:00:00', 1, GETDATE(), N'https://prihoda.co.uk/wp-content/uploads/2015/09/Swiming-pool-fabric-ducting-prihoda-8.jpg',N'Bể bơi dịch vụ cao cấp với phòng thay đồ riêng biệt.');

INSERT INTO dbo.Users 
(username, password, full_name, email, phone, address, role_id, status, dob, gender, images, created_at, updated_at) 
VALUES
('admin',     '7676aaafb027c825bd9abab78b234070e702752f625b752e55e55b48e607e358', 'Admin', 'admin@example.com', '0123456789', '123 Admin St', 1, 1, '1980-01-01', 'Male', NULL, GETDATE(), NULL),
('manager1',  '324d52ea400e79ae65163f0b369e295c4993d26204c66317ee8e53f31ae003e3', 'Manager One', 'manager1@example.com', '0987654321', '456 Manager Rd', 2, 1, '1985-05-15', 'Female', NULL, GETDATE(), NULL),
('staff1',    'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', 'Staff One', 'staff1@example.com', '0912345678', '789 Staff Ln', 3, 1, '1990-07-20', 'Male', NULL, GETDATE(), NULL),
('customer1', 'fbc9f3ebc980d43734b788d27bf5b945ddd209719949ebba1578bb98bbbccada', 'Customer One', 'customer1@example.com', '0901234567', '101 Customer Ave', 4, 1, '2000-10-10', 'Female', NULL, GETDATE(), NULL),
('staff2',    '67ee044f8066e4bec6b9ecdcceadedaede4a0b5173902cde5c61d8fae16c41cc', 'Staff Two', 'staff2@example.com', '0912345679', '112 Staff St', 3, 1, '1991-02-02', 'Female', NULL, GETDATE(), NULL),
('staff3',    '205945b3287cef0db516a6bf8b23c9cbb621fd13cfa9859812f732c2c81127ad', 'Staff Three', 'staff3@example.com', '0912345680', '113 Staff St', 3, 1, '1992-03-03', 'Male', NULL, GETDATE(), NULL),
('staff4',    '91b1929f24b57342184ae9383ac8a5e0868e80eb112e2fc725de4f9b97bea32e', 'Staff Four', 'staff4@example.com', '0912345681', '114 Staff St', 3, 1, '1993-04-04', 'Female', NULL, GETDATE(), NULL),
('customer2', '4334ee6e3c800c991aea10633c0422eeb238d2dcd0d555f0e61196107bb9594b', 'Customer Two', 'customer2@example.com', '0901234568', '201 Customer Blvd', 4, 1, '2001-11-11', 'Male', NULL, GETDATE(), NULL),
('customer3', 'dfaf6a95ba1358cf6425f7df3abf5e3c3c2abd27e5925d6c3a3f63eda73b5e59', 'Customer Three', 'customer3@example.com', '0901234569', '202 Customer Blvd', 4, 1, '2002-12-12', 'Female', NULL, GETDATE(), NULL),
('customer4', '35f289d5bc12e6c4f6964dbd19e5f46cb625ccd72a316f328a3cd175fa07e354', 'Customer Four', 'customer4@example.com', '0901234570', '203 Customer Blvd', 4, 1, '2003-09-09', 'Male', NULL, GETDATE(), NULL);

INSERT INTO Discounts (discount_code, description, discount_percent, valid_from, valid_to, status)
VALUES
('NEWUSER10', N'Giảm 10% cho người dùng mới', 10.00, '2025-05-01', '2025-12-31', 1),
('SUMMER15', N'Khuyến mãi hè giảm 15%', 15.00, '2025-06-01', '2025-08-31', 1),
('WEEKEND5', N'Giảm 5% vào cuối tuần', 5.00, '2025-05-01', '2025-12-31', 1),
('VIP20', N'Giảm 20% cho thành viên VIP', 20.00, '2025-01-01', '2025-12-31', 1),
('FLASH25', N'Giảm 25% trong khung giờ vàng', 25.00, '2025-05-28', '2025-06-10', 1);

INSERT INTO Customer_Discount (user_id, discount_id, used_discount)
VALUES 
(1, 1, 0),
(2, 2, 1),
(3, 1, 0),
(4, 3, 0),
(5, 2, 1);

INSERT INTO Booking (user_id, pool_id, booking_date, start_time, end_time, slot_count, booking_status)
VALUES
(1, 1, '2025-06-01', '08:00:00', '09:30:00', 2, 'confirmed'),
(2, 1, '2025-06-02', '10:00:00', '11:00:00', 1, 'pending'),
(3, 2, '2025-06-03', '15:00:00', '16:30:00', 3, 'cancelled'),
(1, 2, '2025-06-04', '07:00:00', '08:00:00', 1, 'confirmed'),
(2, 1, '2025-06-05', '17:00:00', '18:30:00', 2, 'confirmed');


INSERT INTO Ticket_Types (type_name, description, base_price)
VALUES
('Vé theo ngày', 'Vé sử dụng trong 1 ngày', 50.00),
('Vé theo tuần', 'Vé sử dụng trong 1 tuần', 300.00),
('Vé theo tháng', 'Vé sử dụng trong 1 tháng', 1000.00),
('Vé trên 2 người theo ngày', 'Vé sử dụng cho 2 người trở lên trong 1 ngày', 90.00),
('Vé trên 2 người theo tuần', 'Vé sử dụng cho 2 người trở lên trong 1 tuần', 550.00),
('Vé trên 2 người theo tháng', 'Vé sử dụng cho 2 người trở lên trong 1 tháng', 1800.00);

INSERT INTO Ticket (booking_id, ticket_type_id, ticket_price, payment_status, payment_time, ticket_code, issued_by, issued_at)
VALUES
(1, 1, 50.00, 'paid', '2025-05-01 10:00:00', 'TCKT20250501A', 2, '2025-05-01 09:55:00'),
(2, 2, 300.00, 'unpaid', NULL, 'TCKT20250502B', 3, '2025-05-02 11:00:00'),
(3, 3, 1000.00, 'paid', '2025-05-03 15:30:00', 'TCKT20250503C', 2, '2025-05-03 15:00:00'),
(4, 4, 90.00, 'refunded', '2025-05-04 12:00:00', 'TCKT20250504D', 4, '2025-05-04 11:50:00'),
(5, 5, 550.00, 'paid', '2025-05-05 14:00:00', 'TCKT20250505E', 3, '2025-05-05 13:45:00');


INSERT INTO Feedbacks (user_id, pool_id, rating, comment, created_at)
VALUES
(1, 1, 5, N'Rất hài lòng với dịch vụ và cơ sở vật chất.', '2025-05-20 09:00:00'),
(2, 1, 4, N'Không gian rộng rãi, nhưng cần cải thiện khu vực thay đồ.', '2025-05-21 10:30:00'),
(3, 2, 3, N'Hồ bơi sạch nhưng nước hơi lạnh.', '2025-05-22 14:15:00'),
(4, 3, 2, N'Nhân viên chưa thân thiện và phục vụ chưa tốt.', '2025-05-23 16:45:00'),
(5, 2, 4, N'Thời gian mở cửa hợp lý, trang thiết bị đầy đủ.', '2025-05-24 11:20:00');


INSERT INTO Payments (booking_id, amount, payment_method, payment_status, payment_date, transaction_reference, created_at)
VALUES
(1, 150.00, N'Credit Card', 'paid', '2025-05-20 10:00:00', 'TXN123456', '2025-05-20 10:00:00'),
(2, 300.00, N'Cash', 'paid', '2025-05-21 11:15:00', 'TXN123457', '2025-05-21 11:15:00'),
(3, 450.00, N'Bank Transfer', 'pending', '2025-05-22 14:30:00', 'TXN123458', '2025-05-22 14:30:00'),
(4, 200.00, N'Mobile Payment', 'paid', '2025-05-23 09:45:00', 'TXN123459', '2025-05-23 09:45:00'),
(5, 350.00, N'Credit Card', 'refunded', '2025-05-24 16:00:00', 'TXN123460', '2025-05-24 16:00:00');

INSERT INTO Pool_Device (pool_id, device_image, device_name, quantity, device_status, notes) VALUES
(1, 'https://s.alicdn.com/@sc04/kf/H0e61e19f0f80433cae45dd3287194cc48.jpg_720x720q50.jpg', N'Máy bơm nước hồ bơi', 4, 'available', NULL),
(2, 'https://kapano.vn/wp-content/uploads/2021/10/Sand-Filter-08.jpg', N'Bộ lọc cát', 1, 'available', NULL),
(3, 'https://th.bing.com/th/id/OIP.TMz_zJzbYdW0dZLUZcStXwHaD4?w=314&h=180&c=7&r=0&o=5&dpr=1.3&pid=1.7', N'Máy châm Clo tự động', 1, 'available', NULL),
(4, 'https://mvtek.vn/media/product/2416_593a3db74d515ba20a22fc66bbd603b3.jpg', N'Máy đo và điều chỉnh pH', 1, 'available', NULL),
(5, 'https://www.vinasaco.com/wp-content/uploads/2021/09/skimmer-hut-nuoc-mat-be-boi-kripsol-sks-anh-1.jpg', N'Skimmer hút rác mặt nước', 8, 'available', NULL),
(1, 'https://denledsct.com/wp-content/uploads/2019/11/Den-Led-am-nuoc-doi-mau-12w-768x768.jpg', N'Đèn LED âm nước', 20, 'available', NULL),
(2, 'https://nvcons.com/uploads/lua-chon-cau-thang-inox-ho-boi-phu-hop.jpg', N'Thang inox', 4, 'available', NULL),
(3, 'https://bilico.vn/wp-content/uploads/2020/12/vot-vot-rac-be-boi-tafuma-viet-nam.jpg', N'Vợt vớt rác', 2, 'available', NULL),
(4, 'https://nvcons.com/uploads/choi-co-be-boi-emaux.jpg', N'Chổi cọ tường', 5, 'available', NULL),
(5, 'https://bilico.vn/wp-content/uploads/2020/06/s1-robot-don-ve-sinh-atlantis-kripsol-cho-be-boi-ho-boi-600x600.gif', N'Robot hút vệ sinh tự động', 4, 'available', NULL),
(1, 'https://hoanghaico.com/wp-content/uploads/2022/11/9a44b566c70ebd339f99dd8446bbaa6b.jpg', N'Ống hút vệ sinh', 3, 'available', NULL),
(2, 'https://thietbihoboichinhhang.vn/uploads/product_resize/mat-hut-ve-sinh-ho-boi.jpg', N'Đầu hút vệ sinh', 3, 'available', NULL),
(3, 'https://www.hannavietnam.com/assets/images/bo-may-quang-do-ph-clo-du-va-clo-tong-co-dung-dich-chuan/HI97710C.jpg', N'Bộ test Clo', 2, 'available', NULL),
(4, 'https://www.hannavietnam.com/assets/images/man-hinh-do-ph-do-man-dung-cho-thuy-san-nuoc-man/HI981520_with-probes.jpg', N'Bộ test pH', 2, 'available', NULL),
(5, 'https://nvcons.com/uploads/may-tao-song-nguoc-dong.jpg', N'Máy tạo dòng bơi ngược', 1, 'available', NULL),
(1, 'https://vanbidien.com/wp-content/uploads/2023/10/Ung-dung-dong-ho-do-ap-suat-nuoc.jpg', N'Đồng hồ đo áp suất hệ thống lọc', 4, 'available', NULL),
(2, 'https://camerasaoviet.com/wp-content/uploads/2021/11/camera-giam-sat-khong-day.jpg', N'Camera giám sát hồ bơi', 10, 'available', NULL),
(3, 'https://bizweb.dktcdn.net/100/199/703/files/tu-dung-do-ca-nhan-cho-nhan-vien-1.png?v=1657249921031', N'Tủ đồ cá nhân', 60, 'available', NULL),
(4, 'https://viethansecurity.com/media/product/1247_dau_do_khoi_quang_horing_ah_0311_4_nguon_12v_dc_anh_dai_dien123.jpg', N'Thiết bị báo cháy', 5, 'available', NULL),
(5, 'https://toavietnam.net/images/202107/goods_img/Loa-nen-30W-tro-khang-cao-TOA-TC-631M-P164-23.jpg', N'Hệ thống loa thông báo',5, 'available', NULL),
(1, 'https://kythuatdo.vn/wp-content/uploads/2020/10/cac-loai-cam-bien-do-muc-chat-long.png', N'Thiết bị cảm biến mực nước', 2, 'available', NULL),
(2, 'https://smarttech247.vn/wp-content/uploads/2022/08/he-thong-bao-trom-wifi-sim-komax-5a-f10-600x304.jpg', N'Hệ thống báo động an ninh', 1, 'available', NULL),
(3, 'https://suckhoedoisong.qltns.mediacdn.vn/2013/a2-1388061713956.jpg', N'Tủ thuốc sơ cứu', 5, 'available', NULL),
(4, 'https://heesun.com.vn/public/media//thumb/banner_am_n%C6%B0%E1%BB%9Bc-min-1349x495.jpg', N'Hệ thống đèn chiếu sáng khu vực hồ (ngoài đèn âm nước)', 15, 'available', NULL);

