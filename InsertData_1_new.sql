-- Thêm dữ liệu vào bảng Roles
INSERT INTO Roles(role_name) VALUES (N'admin'),(N'manager'),(N'staff'),(N'customer'); 

-- Thêm dữ liệu vào bảng Users
INSERT INTO Users(username, password, full_name, email, phone, address, role_id, status, dob, gender, images, created_at, updated_at) VALUES
('admin1', '7676aaafb027c825bd9abab78b234070e702752f625b752e55e55b48e607e358', N'Nguyễn Văn Chính', 'admin1@example.com', '0900000001', 'Trụ sở chính', 1, 1, '1980-01-01', 'Male', NULL, GETDATE(), NULL), --pass: admin@123
('manager1', '324d52ea400e79ae65163f0b369e295c4993d26204c66317ee8e53f31ae003e3', 'Manager One', 'manager1@example.com', '0987654321', '456 Manager Rd', 2, 1, '1985-05-15', 'Female', NULL, GETDATE(), NULL), --pass: manager@123
('manager2', '7bf6c1f1dc6875e22262f4db1b36336792e3acf2731803bbd659e279134387b7', N'Manager HCM', 'manager2@example.com', '0900000002', 'Hồ Chí Minh', 2, 1, '1986-02-02', 'Female', NULL, GETDATE(), NULL), --pass: manager2@123
('manager3', 'c9b9b308dfc897e1d60b63ab260f59e9d210a6982f2f6ad74ccc5d89115b815a', N'Manager Đà Nẵng', 'manager3@example.com', '0900000003', 'Đà Nẵng', 2, 1, '1987-03-03', 'Male', NULL, GETDATE(), NULL), --pass: manager3@123
('manager4', '1763bac215e28c909dcbd0a094b15eb66e7a5d5f1688157dddb053f584cfdce5', N'Manager Cần Thơ', 'manager4@example.com', '0900000004', 'Cần Thơ', 2, 1, '1988-04-04', 'Female', NULL, GETDATE(), NULL), --pass: manager4@123
('manager5', '58bde54eb7266c46bb244b48dc0a8408412bb99d27ad57cd3812d2b2ed1aa747', N'Manager Quy Nhơn', 'manager5@example.com', '0900000005', 'Quy Nhơn', 2, 1, '1989-05-05', 'Male', NULL, GETDATE(), NULL), --pass: manager5@123
('staff1', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Nguyễn Văn An', 'staff1@example.com', '0910000001', N'Trụ sở phụ', 3, 1, '1995-01-01', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff2', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Trần Thị Bích', 'staff2@example.com', '0910000002', N'Trụ sở phụ', 3, 1, '1995-01-02', 'Female', NULL, GETDATE(), NULL), --pass: staff@123
('staff3', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Lê Văn Cường', 'staff3@example.com', '0910000003', N'Trụ sở phụ', 3, 1, '1995-01-03', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff4', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Phạm Thị Dung', 'staff4@example.com', '0910000004', N'Trụ sở phụ', 3, 1, '1995-01-04', 'Female', NULL, GETDATE(), NULL), --pass: staff@123
('staff5', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Hoàng Văn Đức', 'staff5@example.com', '0910000005', N'Trụ sở phụ', 3, 1, '1995-01-05', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff6', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Nguyễn Thị Hạnh', 'staff6@example.com', '0910000006', N'Trụ sở phụ', 3, 1, '1995-01-06', 'Female', NULL, GETDATE(), NULL), --pass: staff@123
('staff7', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Lê Quốc Huy', 'staff7@example.com', '0910000007', N'Trụ sở phụ', 3, 1, '1995-01-07', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff8', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Phan Thị Hương', 'staff8@example.com', '0910000008', N'Trụ sở phụ', 3, 1, '1995-01-08', 'Female', NULL, GETDATE(), NULL), --pass: staff@123
('staff9', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Trịnh Văn Khoa', 'staff9@example.com', '0910000009', N'Trụ sở phụ', 3, 1, '1995-01-09', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff10', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Vũ Thị Lan', 'staff10@example.com', '0910000010', N'Trụ sở phụ', 3, 1, '1995-01-10', 'Female', NULL, GETDATE(), NULL), --pass: staff@123
('staff11', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Đặng Văn Long', 'staff11@example.com', '0910000011', N'Trụ sở phụ', 3, 1, '1995-01-11', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff12', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Bùi Thị Mai', 'staff12@example.com', '0910000012', N'Trụ sở phụ', 3, 1, '1995-01-12', 'Female', NULL, GETDATE(), NULL), --pass: staff@123
('staff13', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Ngô Văn Minh', 'staff13@example.com', '0910000013', N'Trụ sở phụ', 3, 1, '1995-01-13', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff14', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Huỳnh Thị Nga', 'staff14@example.com', '0910000014', N'Trụ sở phụ', 3, 1, '1995-01-14', 'Female', NULL, GETDATE(), NULL), --pass: staff@123
('staff15', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Tống Văn Nam', 'staff15@example.com', '0910000015', N'Trụ sở phụ', 3, 1, '1995-01-15', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff16', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Thái Thị Oanh', 'staff16@example.com', '0910000016', N'Trụ sở phụ', 3, 1, '1995-01-16', 'Female', NULL, GETDATE(), NULL), --pass: staff@123
('staff17', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Đỗ Văn Phúc', 'staff17@example.com', '0910000017', N'Trụ sở phụ', 3, 1, '1995-01-17', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff18', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Nguyễn Thị Quỳnh', 'staff18@example.com', '0910000018', N'Trụ sở phụ', 3, 1, '1995-01-18', 'Female', NULL, GETDATE(), NULL), --pass: staff@123
('staff19', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Trương Văn Quốc', 'staff19@example.com', '0910000019', N'Trụ sở phụ', 3, 1, '1995-01-19', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff20', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Tạ Thị Sương', 'staff20@example.com', '0910000020', N'Trụ sở phụ', 3, 1, '1995-01-20', 'Female', NULL, GETDATE(), NULL), --pass: staff@123
('staff21', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Lương Văn Sơn', 'staff21@example.com', '0910000021', N'Trụ sở phụ', 3, 1, '1995-01-21', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff22', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Phạm Thị Trang', 'staff22@example.com', '0910000022', N'Trụ sở phụ', 3, 1, '1995-01-22', 'Female', NULL, GETDATE(), NULL), --pass: staff@123
('staff23', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Lý Văn Thắng', 'staff23@example.com', '0910000023', N'Trụ sở phụ', 3, 1, '1995-01-23', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff24', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Trịnh Thị Tuyết', 'staff24@example.com', '0910000024', N'Trụ sở phụ', 3, 1, '1995-01-24', 'Female', NULL, GETDATE(), NULL), --pass: staff@123
('staff25', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Vinh', 'staff25@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('customer1', '02f7f6b0cf1fd5bd487acaf5fbfcfbcac78726ef006273bcfeb76e5cfe9a0d68', N'Nguyễn Văn A', 'cust1@example.com', '0900001001', 'Hà Nội', 4, 1, '2000-01-01', 'Male', NULL, GETDATE(), NULL), --pass: cust@123
('customer2', '02f7f6b0cf1fd5bd487acaf5fbfcfbcac78726ef006273bcfeb76e5cfe9a0d68', N'Trần Thị B', 'cust2@example.com', '0900001002', 'Hồ Chí Minh', 4, 1, '2001-02-02', 'Female', NULL, GETDATE(), NULL), --pass: cust@123
('customer3', '02f7f6b0cf1fd5bd487acaf5fbfcfbcac78726ef006273bcfeb76e5cfe9a0d68', N'Lê Văn C', 'cust3@example.com', '0900001003', 'Đà Nẵng', 4, 1, '2002-03-03', 'Male', NULL, GETDATE(), NULL), --pass: cust@123
('customer4', '02f7f6b0cf1fd5bd487acaf5fbfcfbcac78726ef006273bcfeb76e5cfe9a0d68', N'Phạm Thị D', 'cust4@example.com', '0900001004', 'Cần Thơ', 4, 1, '2003-04-04', 'Female', NULL, GETDATE(), NULL), --pass: cust@123
('customer5', '02f7f6b0cf1fd5bd487acaf5fbfcfbcac78726ef006273bcfeb76e5cfe9a0d68', N'Hoàng Văn E', 'cust5@example.com', '0900001005', 'Huế', 4, 1, '2004-05-05', 'Male', NULL, GETDATE(), NULL), --pass: cust@123
('customer6', '02f7f6b0cf1fd5bd487acaf5fbfcfbcac78726ef006273bcfeb76e5cfe9a0d68', N'Đỗ Thị F', 'cust6@example.com', '0900001006', 'Nha Trang', 4, 1, '2000-06-06', 'Female', NULL, GETDATE(), NULL), --pass: cust@123
('customer7', '02f7f6b0cf1fd5bd487acaf5fbfcfbcac78726ef006273bcfeb76e5cfe9a0d68', N'Ngô Văn G', 'cust7@example.com', '0900001007', 'Vũng Tàu', 4, 1, '2001-07-07', 'Male', NULL, GETDATE(), NULL), --pass: cust@123
('customer8', '02f7f6b0cf1fd5bd487acaf5fbfcfbcac78726ef006273bcfeb76e5cfe9a0d68', N'Huỳnh Thị H', 'cust8@example.com', '0900001008', 'Long An', 4, 1, '2002-08-08', 'Female', NULL, GETDATE(), NULL), --pass: cust@123
('customer9', '02f7f6b0cf1fd5bd487acaf5fbfcfbcac78726ef006273bcfeb76e5cfe9a0d68', N'Bùi Văn I', 'cust9@example.com', '0900001009', 'Tiền Giang', 4, 1, '2003-09-09', 'Male', NULL, GETDATE(), NULL), --pass: cust@123
('customer10', '02f7f6b0cf1fd5bd487acaf5fbfcfbcac78726ef006273bcfeb76e5cfe9a0d68', N'Vũ Thị K', 'cust10@example.com', '0900001010', 'Quảng Ninh', 4, 1, '2004-10-10', 'Female', NULL, GETDATE(), NULL), --pass: cust@123
('customer11', '02f7f6b0cf1fd5bd487acaf5fbfcfbcac78726ef006273bcfeb76e5cfe9a0d68', N'Trịnh Văn L', 'cust11@example.com', '0900001011', 'Phú Yên', 4, 1, '2000-11-11', 'Male', NULL, GETDATE(), NULL), --pass: cust@123
('customer12', '02f7f6b0cf1fd5bd487acaf5fbfcfbcac78726ef006273bcfeb76e5cfe9a0d68', N'Tống Thị M', 'cust12@example.com', '0900001012', 'Bình Thuận', 4, 1, '2001-12-12', 'Female', NULL, GETDATE(), NULL), --pass: cust@123
('customer13', '02f7f6b0cf1fd5bd487acaf5fbfcfbcac78726ef006273bcfeb76e5cfe9a0d68', N'Thân Văn N', 'cust13@example.com', '0900001013', 'Lâm Đồng', 4, 1, '2002-01-13', 'Male', NULL, GETDATE(), NULL), --pass: cust@123
('customer14', '02f7f6b0cf1fd5bd487acaf5fbfcfbcac78726ef006273bcfeb76e5cfe9a0d68', N'Trần Thị O', 'cust14@example.com', '0900001014', 'Quảng Nam', 4, 1, '2003-02-14', 'Female', NULL, GETDATE(), NULL), --pass: cust@123
('customer15', '02f7f6b0cf1fd5bd487acaf5fbfcfbcac78726ef006273bcfeb76e5cfe9a0d68', N'Phan Văn P', 'cust15@example.com', '0900001015', 'Bắc Giang', 4, 1, '2004-03-15', 'Male', NULL, GETDATE(), NULL), --pass: cust@123
('customer16', '02f7f6b0cf1fd5bd487acaf5fbfcfbcac78726ef006273bcfeb76e5cfe9a0d68', N'Trần Thị O', 'cust16@example.com', '0900001014', 'Quảng Nam', 4, 1, '2003-02-14', 'Female', NULL, GETDATE(), NULL), --pass: cust@123
('customer17', '02f7f6b0cf1fd5bd487acaf5fbfcfbcac78726ef006273bcfeb76e5cfe9a0d68', N'Trần Thị O', 'cust17@example.com', '0900001014', 'Quảng Nam', 4, 1, '2003-02-14', 'Female', NULL, GETDATE(), NULL), --pass: cust@123
('staff26', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Vinh', 'staff26@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff27', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Vu', 'staff27@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff28', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Vin', 'staff28@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff29', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Veo', 'staff29@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff30', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Van', 'staff30@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff31', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Vit', 'staff31@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff32', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Vo', 'staff32@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff33', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Vem', 'staff33@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff34', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Vot', 'staff34@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff35', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Vut', 'staff35@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff36', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Me', 'staff36@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff37', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Meo', 'staff37@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff38', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Teo', 'staff38@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff39', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Cu', 'staff39@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff40', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Ô', 'staff40@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff41', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Soc', 'staff41@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff42', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Tran', 'staff42@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff43', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Te', 'staff43@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff44', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Vuc', 'staff44@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff45', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Mit', 'staff45@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff46', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Va', 'staff46@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff47', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Vau', 'staff47@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff49', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Môi', 'staff48@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff50', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Muỗi', 'staff49@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff51', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Tít', 'staff50@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff52', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Tao', 'staff51@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff53', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Bôi', 'staff52@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff54', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Cười', 'staff53@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff55', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Nút', 'staff54@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff56', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Nít', 'staff55@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff57', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Ma', 'staff56@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff58', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Quỷ', 'staff57@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff59', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Hẹo', 'staff58@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff60', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Chiến', 'staff59@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff61', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn C', 'staff60@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff62', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VB', 'staff61@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff63', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VS', 'staff62@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff64', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VD', 'staff63@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff65', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VF', 'staff64@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff66', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VB', 'staff65@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff67', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VQ', 'staff66@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff68', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VR', 'staff67@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff69', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VT', 'staff68@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff70', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VY', 'staff69@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff71', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VU', 'staff70@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff72', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VO', 'staff71@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff73', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VP', 'staff72@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff74', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VYE', 'staff73@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff75', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VE', 'staff74@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff76', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VL', 'staff75@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff77', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VM', 'staff76@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff78', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VMB', 'staff77@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff79', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VHH', 'staff78@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff80', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VĐ', 'staff79@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff81', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VDD', 'staff80@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff82', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VFF', 'staff81@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff83', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn VGG', 'staff82@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff84', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn HGH', 'staff83@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff85', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn BBB', 'staff84@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff86', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn CCC', 'staff85@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff87', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn ABC', 'staff86@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff88', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn BBC', 'staff87@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff89', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn NNG', 'staff88@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff90', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn MML', 'staff89@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff91', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn JJJ', 'staff90@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff92', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn AAa', 'staff91@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff93', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn afF', 'staff92@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff94', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn TTT', 'staff93@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff95', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn CCV', 'staff94@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff96', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn CHU', 'staff95@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff97', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Bro', 'staff97@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff98', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Bưởi', 'staff98@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff99', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn Chuối', 'staff99@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff100', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn CAM', 'staff100@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL), --pass: staff@123
('staff101', 'b5465d786a2b98bbd4b8b798da4f86b34c52f64dc9a382b50c0fdb0f73f8baf1', N'Cao Văn CHia', 'staff101@example.com', '0910000025', N'Trụ sở phụ', 3, 1, '1995-01-25', 'Male', NULL, GETDATE(), NULL); --pass: staff@123
-- Tạo chi nhánh gắn với từng manager
INSERT INTO Branchs (branch_name, manager_id) VALUES
(N'Chi nhánh Hà Nội', 2),
(N'Chi nhánh Hồ Chí Minh', 3),
(N'Chi nhánh Đà Nẵng', 4),
(N'Chi nhánh Cần Thơ', 5),
(N'Chi nhánh Quy Nhơn', 6);

-- Gán branch_id cho các hồ bơi theo địa chỉ
UPDATE Pools SET branch_id = 1 WHERE pool_address = N'Hà Nội'
UPDATE Pools SET branch_id = 2 WHERE pool_address = N'Hồ Chí Minh'
UPDATE Pools SET branch_id = 3 WHERE pool_address = N'Đà Nẵng'
UPDATE Pools SET branch_id = 4 WHERE pool_address = N'Cần Thơ'
UPDATE Pools SET branch_id = 5 WHERE pool_address = N'Quy Nhơn';



-- Thêm dữ liệu vào bảng Pools
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
(N'Hồ bơi Hải Châu', N'Đường Lê Duẩn', N'Đà Nẵng', 50, '06:00:00', '19:00:00', 1, GETDATE(), N'https://th.bing.com/th/id/R.905c0c37b9ed2c8ba141fb95826bc5df?rik=TN2AwKdoi0LE9w&riu=http%3a%2f%2fwww.worldwayhk.com%2fUpLoadFiles%2f20151110%2f2015111010202846.jpg&ehk=F9q02sqTyInEk4Se%2fDfeWNSV6sovHG2qe2vi3nrb9%2bM%3d&risl=&pid=ImgRaw&r=0',N'Bể bơi trong khu nghỉ dưỡng cao cấp ven sông.'),
(N'Hồ bơi Sơn Trà', N'Đường Trần Hưng Đạo', N'Đà Nẵng', 45, '06:30:00', '18:30:00', 1, GETDATE(), N'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/13/2a/a1/f6/centara-ras-fushi-resort.jpg?w=1200&h=-1&s=1',N'Hồ bơi lộ thiên với thiết kế thân thiện với môi trường.'),
(N'Hồ bơi Thanh Khê', N'Đường Hà Huy Tập', N'Đà Nẵng', 40, '07:00:00', '19:30:00', 1, GETDATE(), N'https://thethaodonga.com/wp-content/uploads/2022/06/ho-boi-o-tphcm-2.jpg',N'Bể bơi có đường bơi phân làn cho người tập thể thao.'),
(N'Hồ bơi Liên Chiểu', N'Đường Nguyễn Lương Bằng', N'Đà Nẵng', 60, '05:30:00', '20:00:00', 1, GETDATE(), N'https://ktmt.vnmediacdn.com/images/2024/04/10/83-1712742140-352375012-699494991981699-6157285300830981686-n.jpg',N'Bể bơi dành riêng cho người lớn, yên tĩnh và riêng tư.'),
(N'Hồ bơi Ngũ Hành Sơn', N'Đường Ngũ Hành Sơn', N'Đà Nẵng', 55, '06:00:00', '19:30:00', 1, GETDATE(), N'https://vnanet.vn/Data/Articles/2024/06/17/7435552/vna_potal_hai_duong_tang_cuong_day_boi_cho_tre_em_dip_he_de_phong_tranh_duoi_nuoc__stand.jpg',N'Bể bơi giải trí có cầu trượt nước và vòi phun vui nhộn.'),
(N'Hồ bơi Ninh Kiều', N'Đường 30 Tháng 4', N'Cần Thơ', 50, '06:00:00', '20:00:00', 1, GETDATE(), N'https://turftown.in/_next/image?url=https%3A%2F%2Fturftown.s3.ap-south-1.amazonaws.com%2Fsuper_admin%2Ftt-1722768448280.webp&w=3840&q=75',N'Hồ bơi nhỏ dành cho trẻ sơ sinh với độ sâu an toàn.'),
(N'Hồ bơi Bình Thủy', N'Đường Nguyễn Trãi', N'Cần Thơ', 45, '06:30:00', '19:30:00', 1, GETDATE(), N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx26g6WKHSQW34d2dRT6KVuG3KqJ0BPNuLLw&s',N'Hồ bơi trên tầng thượng khách sạn với tầm nhìn toàn cảnh.'),
(N'Hồ bơi Cái Răng', N'Đường Quốc lộ 91B', N'Cần Thơ', 40, '07:00:00', '20:00:00', 1, GETDATE(), N'https://hoboinhatrang.vn/filestorage/article/large/lc2.jpg',N'Bể bơi ban đêm có hệ thống đèn LED đổi màu hiện đại.'),
(N'Hồ bơi Ô Môn', N'Đường Phan Văn Trị', N'Cần Thơ', 60, '05:30:00', '21:00:00', 1, GETDATE(), N'https://www.srsmith.com/media/180835/build-your-own-pool-slide-beauty-923x730.jpg?mode=pad&width=725&height=573&bgcolor=fff&rnd=133054065692270000',N'Bể bơi có lớp học bơi hàng ngày cho mọi lứa tuổi.'),
(N'Hồ bơi Thốt Nốt', N'Đường Trần Hưng Đạo', N'Cần Thơ', 55, '06:00:00', '20:00:00', 1, GETDATE(), N'https://www.eugene-or.gov/ImageRepository/Document?documentID=67182',N'Hồ bơi có mái che linh hoạt, sử dụng quanh năm.'),
(N'Hồ bơi Nguyễn Huệ', N'Đường Nguyễn Huệ', N'Quy Nhơn', 50, '06:00:00', '19:00:00', 1, GETDATE(), N'https://cdn.baogialai.com.vn/images/b6e9e273388cf373c7197a59d2310437352c2851cd5b8e027e0695c8f296f53af1dc3f5b91b26aae470176cec4d4439d2e69976aae899185fffdddb094a72d3e/1vn-5274.jpg',N'Bể bơi phong cách resort giữa lòng thành phố.'),
(N'Hồ bơi An Dương Vương', N'Đường An Dương Vương', N'Quy Nhơn', 45, '06:30:00', '19:30:00', 1, GETDATE(), N'https://static.vinwonders.com/production/ho-boi-quan-9.jpg',N'Hồ bơi nước ấm, phù hợp cho người cao tuổi.'),
(N'Hồ bơi Lê Lợi', N'Đường Lê Lợi', N'Quy Nhơn', 40, '07:00:00', '20:00:00', 1, GETDATE(), N'https://streamline.imgix.net/eb0267a4-922d-4297-a476-194d6c689471/82abffc9-632a-44b3-abed-d0ea03d20d84/IMG_5342_edited.jpg?ixlib=rb-1.1.0&w=2000&h=2000&fit=max&or=0&s=58e787b840cd62bfacb839b701e5e9e0',N'Bể bơi thiết kế hình dạng đặc biệt, tạo cảm hứng sáng tạo.'),
(N'Hồ bơi Trần Phú', N'Đường Trần Phú', N'Quy Nhơn', 60, '05:30:00', '21:00:00', 1, GETDATE(), N'https://bcp.cdnchinhphu.vn/334894974524682240/2024/4/11/an-toan-thiet-bi-be-boi-17128195925281735826251.jpg',N'Bể bơi nằm cạnh vườn cây nhiệt đới, không khí trong lành.'),
(N'Hồ bơi Phú Tài', N'Đường Tây Sơn', N'Quy Nhơn', 55, '06:00:00', '20:00:00', 1, GETDATE(), N'https://prihoda.co.uk/wp-content/uploads/2015/09/Swiming-pool-fabric-ducting-prihoda-8.jpg',N'Bể bơi dịch vụ cao cấp với phòng thay đồ riêng biệt.');

INSERT INTO Staff_Types (type_name, description) VALUES
(N'Nhân viên kỹ thuật', N'Bảo trì thiết bị và cơ sở hạ tầng'),
(N'Nhân viên soát vé', N'Kiểm tra vé khách hàng tại bể bơi'),
(N'Nhân viên kiểm tra thiết bị', N'Theo dõi và báo cáo tình trạng thiết bị'),
(N'Nhân viên hỗ trợ dịch vụ', N'Hỗ trợ khách hàng sử dụng dịch vụ tại bể bơi'); 

INSERT INTO Staffs (user_id, branch_id, pool_id, staff_type_id)
VALUES 
(7, 1, 1, 1),  
(8, 1, 1, 2), 
(9, 1, 1, 3),  
(10, 1, 1, 4),

(11, 1, 2, 1),  
(12, 1, 2, 2), 
(13, 1, 2, 3),  
(14, 1, 2, 4),

(15, 1, 3, 1),  
(16, 1, 3, 2), 
(17, 1, 3, 3),  
(18, 1, 3, 4),

(19, 1, 4, 1),  
(20, 1, 4, 2), 
(21, 1, 4, 3),  
(22, 1, 4, 4),

(23, 1, 5, 1),
(24, 1, 5, 2),  
(25, 1, 5, 3), 
(26, 1, 5, 4), 
---------------------------
(27, 2, 6, 1),
(28, 2, 6, 2),  
(29, 2, 6, 3), 
(30, 2, 6, 4),  

(31, 2, 7, 1),
(49, 2, 7, 2),
(50, 2, 7, 3),  
(51, 2, 7, 4),

(52, 2, 8, 1),
(53, 2, 8, 2),
(54, 2, 8, 3),  
(55, 2, 8, 4),

(56, 2, 9, 1),
(57, 2, 9, 2),
(58, 2, 9, 3),  
(59, 2, 9, 4),

(60, 2, 10, 1),
(61, 2, 10, 2),
(62, 2, 10, 3),  
(63, 2, 10, 4),
----------------------------
(64, 3, 11, 1),
(65, 3, 11, 2),
(66, 3, 11, 3),  
(67, 3, 11, 4),

(68, 3, 12, 1),
(69, 3, 12, 2),
(70, 3, 12, 3),  
(71, 3, 12, 4),

(72, 3, 13, 1),
(73, 3, 13, 2),
(74, 3, 13, 3),  
(75, 3, 13, 4),

(76, 3, 14, 1),
(77, 3, 14, 2),
(78, 3, 14, 3),  
(79, 3, 14, 4),

(80, 3, 15, 1),
(81, 3, 15, 2),
(82, 3, 15, 3),  
(83, 3, 15, 4),
----------------------------------
(84, 4, 16, 1),
(85, 4, 16, 2),
(86, 4, 16, 3),  
(87, 4, 16, 4),

(88, 4, 17, 1),
(89, 4, 17, 2),
(90, 4, 17, 3),  
(91, 4, 17, 4),

(92, 4, 18, 1),
(93, 4, 18, 2),
(94, 4, 18, 3),  
(95, 4, 18, 4),

(96, 4, 19, 1),
(97, 4, 19, 2),
(98, 4, 19, 3),  
(99, 4, 19, 4),

(100, 4, 20, 1),
(101, 4, 20, 2),
(102, 4, 20, 3),  
(103, 4, 20, 4),

(104, 5, 21, 1),
(105, 5, 21, 2),
(106, 5, 21, 3),  
(107, 5, 21, 4),

(108, 5, 22, 1),
(109, 5, 22, 2),
(110, 5, 22, 3),  
(111, 5, 22, 4),
	  
(112, 5, 23, 1),
(113, 5, 23, 2),
(114, 5, 23, 3),  
(115, 5, 23, 4),

(116, 5, 24, 1),
(117, 5, 24, 2),
(118, 5, 24, 3),  
(119, 5, 24, 4),
	  
(120, 5, 25, 1),
(121, 5, 25, 2),
(122, 5, 25, 3),  
(123, 5, 25, 4);

-- Thêm dữ liệu vào bảng Pool_Device
INSERT INTO Pool_Device (pool_id, device_image, device_name, quantity, device_status, notes) VALUES
(1, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(1, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(1, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(1, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(1, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(1, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(1, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(1, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(1, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(1, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(1, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(1, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(1, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(1, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(1, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(1, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(1, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(1, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(1, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(2, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(2, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(2, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(2, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(2, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(2, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(2, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(2, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(2, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(2, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(2, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(2, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(2, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(2, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(2, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(2, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(2, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(2, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(2, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(2, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(3, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(3, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(3, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(3, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(3, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(3, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(3, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(3, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(3, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(3, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(3, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(3, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(3, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(3, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(3, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(3, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(3, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(3, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(3, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(3, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(4, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(4, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(4, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(4, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(4, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(4, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(4, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(4, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(4, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(4, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(4, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(4, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(4, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(4, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(4, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(4, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(4, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(4, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(4, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(4, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(5, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(5, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(5, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(5, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(5, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(5, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(5, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(5, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(5, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(5, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(5, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(5, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(5, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(5, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(5, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(5, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(5, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(5, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(5, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(5, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(6, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(6, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(6, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(6, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(6, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(6, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(6, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(6, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(6, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(6, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(6, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(6, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(6, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(6, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(6, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(6, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(6, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(6, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(6, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(6, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(7, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(7, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(7, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(7, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(7, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(7, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(7, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(7, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(7, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(7, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(7, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(7, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(7, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(7, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(7, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(7, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(7, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(7, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(7, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(7, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(8, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(8, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(8, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(8, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(8, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(8, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(8, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(8, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(8, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(8, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(8, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(8, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(8, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(8, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(8, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(8, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(8, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(8, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(8, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(8, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(9, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(9, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(9, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(9, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(9, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(9, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(9, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(9, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(9, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(9, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(9, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(9, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(9, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(9, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(9, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(9, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(9, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(9, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(9, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(9, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(10, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(10, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(10, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(10, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(10, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(10, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(10, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(10, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(10, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(10, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(10, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(10, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(10, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(10, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(10, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(10, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(10, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(10, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(10, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(10, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(11, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(11, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(11, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(11, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(11, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(11, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(11, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(11, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(11, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(11, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(11, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(11, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(11, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(11, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(11, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(11, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(11, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(11, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(11, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(11, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(12, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(12, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(12, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(12, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(12, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(12, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(12, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(12, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(12, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(12, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(12, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(12, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(12, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(12, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(12, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(12, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(12, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(12, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(12, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(12, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(13, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(13, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(13, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(13, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(13, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(13, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(13, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(13, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(13, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(13, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(13, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(13, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(13, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(13, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(13, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(13, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(13, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(13, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(13, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(13, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(14, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(14, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(14, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(14, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(14, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(14, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(14, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(14, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(14, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(14, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(14, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(14, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(14, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(14, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(14, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(14, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(14, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(14, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(14, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(14, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(15, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(15, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(15, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(15, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(15, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(15, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(15, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(15, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(15, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(15, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(15, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(15, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(15, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(15, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(15, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(15, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(15, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(15, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(15, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(15, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(16, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(16, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(16, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(16, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(16, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(16, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(16, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(16, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(16, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(16, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(16, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(16, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(16, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(16, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(16, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(16, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(16, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(16, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(16, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(16, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(17, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(17, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(17, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(17, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(17, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(17, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(17, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(17, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(17, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(17, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(17, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(17, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(17, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(17, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(17, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(17, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(17, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(17, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(17, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(17, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(18, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(18, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(18, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(18, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(18, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(18, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(18, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(18, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(18, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(18, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(18, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(18, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(18, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(18, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(18, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(18, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(18, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(18, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(18, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(18, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(19, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(19, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(19, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(19, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(19, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(19, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(19, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(19, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(19, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(19, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(19, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(19, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(19, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(19, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(19, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(19, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(19, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(19, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(19, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(19, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(20, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(20, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(20, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(20, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(20, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(20, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(20, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(20, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(20, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(20, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(20, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(20, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(20, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(20, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(20, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(20, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(20, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(20, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(20, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(20, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(21, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(21, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(21, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(21, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(21, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(21, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(21, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(21, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(21, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(21, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(21, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(21, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(21, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(21, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(21, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(21, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(21, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(21, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(21, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(21, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(22, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(22, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(22, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(22, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(22, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(22, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(22, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(22, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(22, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(22, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(22, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(22, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(22, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(22, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(22, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(22, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(22, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(22, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(22, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(22, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(23, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(23, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(23, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(23, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(23, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(23, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(23, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(23, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(23, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(23, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(23, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(23, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(23, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(23, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(23, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(23, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(23, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(23, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(23, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(23, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(24, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(24, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(24, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(24, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(24, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(24, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(24, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(24, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(24, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(24, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(24, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(24, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(24, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(24, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(24, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(24, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(24, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(24, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(24, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(24, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL),
(25, N'https://th.bing.com/th/id/OIP.VuLqwyno-aqvXZ2Yco6S_QHaHa?w=217&h=217&c=7&r=0&o=5&pid=1.7', N'Tủ đồ cá nhân', 20, 'available', NULL),
(25, N'https://cameraluuphuc.com/wp-content/uploads/2021/10/DH-HAC-HDW1200R-VF.png', N'Camera giám sát', 20, 'available', NULL),
(25, N'https://noithattheones.com/wp-content/uploads/2023/05/tu-thuoc-y-te-dep-TYT02I430.jpg', N'Tủ thuốc sơ cứu', 20, 'available', NULL),
(25, N'https://amthanhthudo.com/wp-content/uploads/hinh-anh-loa-thong-bao-Aplus-A-H150T.jpg', N'Loa thông báo', 20, 'available', NULL),
(25, N'https://banghexanh.vn/wp-content/uploads/2024/02/Giuong-Tam-Nang-Be-Boi-TL813.jpg', N'Ghế tắm nắng', 20, 'available', NULL),
(25, N'https://th.bing.com/th/id/OIP.ne1Rv1HeeEPi4haW4MHUAgHaE-?rs=1&pid=ImgDetMain', N'Ô che nắng', 20, 'available', NULL),
(25, N'https://th.bing.com/th/id/OIP.5BAEvEdVd_VsZ-j5hAp6hQHaHa?w=197&h=197&c=7&r=0&o=5&pid=1.7', N'Phao cứu hộ', 20, 'available', NULL),
(25, N'https://www.travelingan.net/wp-content/uploads/2019/07/Wahana-Jogja-Bay-Waterpark.jpg', N'Cầu trượt nước', 20, 'available', NULL),
(25, N'https://th.bing.com/th/id/OIP.e2Mny9THyddXLj0Qlhs9vgHaHa?rs=1&pid=ImgDetMain', N'Đồng hồ đo nhiệt độ nước', 20, 'available', NULL),
(25, N'https://th.bing.com/th/id/OIP.UJIBD9OAoPmy2TG-wgb1ZAAAAA?rs=1&pid=ImgDetMain', N'Thiết bị đo chất lượng nước (pH, Clo)', 20, 'available', NULL),
(25, N'https://nwzimg.wezhan.cn/contents/sitefiles2066/10332247/images/48333183.jpg', N'Máy bán hàng tự động', 20, 'available', NULL),
(25, N'https://i.pinimg.com/474x/61/fd/66/61fd665a4cee278ca7350b0d93954d63.jpg', N'Vòi sen ngoài trời', 20, 'available', NULL),
(25, N'https://th.bing.com/th/id/OIP.JHwxdZYNKl2YCojmAr6QQAHaEz?rs=1&pid=ImgDetMain', N'Thảm chống trơn trượt', 20, 'available', NULL),
(25, N'https://th.bing.com/th/id/OIP.7GZAVYKI3C5KXdduktHM4wHaHa?rs=1&pid=ImgDetMain', N'Giá treo khăn', 20, 'available', NULL),
(25, N'https://th.bing.com/th/id/OIP.9tXCgr7wlVgTvOdYw6DH1wHaHa?rs=1&pid=ImgDetMain', N'Máy sấy tóc', 20, 'available', NULL),
(25, N'https://hoabico.com/wp-content/uploads/2022/05/noi-quy-be-boi.jpg', N'Bảng nội quy/hướng dẫn an toàn', 20, 'available', NULL),
(25, N'https://nclighting.vn/wp-content/uploads/2021/07/Den-Led-be-boi-chieu-sang.jpg', N'Đèn chiếu sáng khu vực hồ', 20, 'available', NULL),
(25, N'https://th.bing.com/th/id/OIP.nOLn0XWcvysYz38_1RT9XQHaHa?rs=1&pid=ImgDetMain', N'Hệ thống báo động khẩn cấp', 20, 'available', NULL),
(25, N'https://down-vn.img.susercontent.com/file/vn-11134201-7qukw-lglyflm1se9e9d', N'Tủ giữ điện thoại/chìa khóa', 20, 'available', NULL),
(25, N'https://sanakyvietnam.net/wp-content/uploads/binh-nong-lanh-alaska-co-tot-khong.jpg', N'Cây nước lọc uống trực tiếp', 20, 'available', NULL);

--Thêm bảng Feedbacks
INSERT INTO Feedbacks (user_id, pool_id, rating, comment, created_at) VALUES
(32, 1, 5, N'Rất hài lòng, hồ bơi sạch sẽ.', GETDATE()),
(33, 2, 4, N'Nhân viên thân thiện.', GETDATE()),
(34, 3, 3, N'Nước hơi lạnh, cần cải thiện.', GETDATE()),
(35, 1, 5, N'Môi trường an toàn cho trẻ em.', GETDATE()),
(36, 2, 4, N'Có nhiều tiện nghi.', GETDATE()),
(37, 3, 5, N'Dịch vụ tuyệt vời, rất đáng tiền.', GETDATE()),
(38, 1, 4, N'Hồ bơi rộng rãi, nước sạch.', GETDATE()),
(39, 2, 3, N'Tạm ổn, cần cải thiện phòng thay đồ.', GETDATE()),
(40, 3, 5, N'Không gian thoáng mát, thích hợp cho gia đình.', GETDATE()),
(41, 1, 2, N'Nước hơi bẩn vào buổi chiều.', GETDATE()),
(42, 2, 4, N'Nhân viên nhiệt tình, hồ bơi đẹp.', GETDATE()),
(43, 1, 3, N'Thời gian mở cửa chưa linh hoạt.', GETDATE()),
(44, 3, 5, N'Hồ bơi sạch sẽ, có cả huấn luyện viên.', GETDATE()),
(45, 2, 4, N'Cơ sở vật chất hiện đại.', GETDATE()),
(46, 1, 5, N'Trải nghiệm tuyệt vời cho cả nhà.', GETDATE());

--Thêm bảng Discounts
INSERT INTO Discounts (discount_code, description, discount_percent, quantity, valid_from, valid_to, status, created_at, updated_at)VALUES 
('WELCOME10', N'Giảm 10% cho khách hàng mới', 10.00, 20, '2025-06-01', '2025-12-31', 1, GETDATE(), NULL),
('SUMMER20', N'Ưu đãi hè lên đến 20%', 20.00, 20, '2025-06-01', '2025-08-31', 1, GETDATE(), NULL),
('LOYALTY15', N'Khuyến mãi cho khách hàng thân thiết', 15.00, 20, '2025-01-01', '2025-12-31', 1, GETDATE(), NULL),
('FAMILY5', N'Ưu đãi nhóm gia đình 5%', 5.00, 20, '2025-06-01', '2025-12-31', 1, GETDATE(), NULL),
('BLACKFRIDAY25', N'Siêu giảm giá Black Friday', 25.00, 20, '2025-11-20', '2025-11-30', 1, GETDATE(), NULL);

--Thêm bảng Customer_Discount
INSERT INTO Customer_Discount (user_id, discount_id, used_discount) VALUES
(32, 1, 1),  -- customer1 đã dùng WELCOME10
(33, 2, 0),  -- customer2 được gán SUMMER20
(34, 1, 1),  -- customer3 đã dùng WELCOME10
(35, 3, 0),  -- customer4 được gán LOYALTY15
(36, 4, 0), -- customer5 được gán FAMILY5
(37, 1, 0), -- customer6 chưa dùng WELCOME10
(38, 2, 1), -- customer7 đã dùng SUMMER20
(39, 3, 1), -- customer8 đã dùng LOYALTY15
(40, 5, 0), -- customer9 được gán BLACKFRIDAY25
(41, 2, 0), -- customer10 được gán SUMMER20
(42, 1, 0), -- customer11 được gán WELCOME10
(43, 3, 1), -- customer12 đã dùng LOYALTY15
(44, 4, 0), -- customer13 được gán FAMILY5
(45, 1, 0), -- customer14 được gán WELCOME10
(46, 5, 0); -- customer15 được gán BLACKFRIDAY25

-- Thêm bảng Booking
INSERT INTO Booking (user_id, pool_id, discount_id, booking_date, start_time, end_time, slot_count, booking_status, created_at, updated_at) VALUES
(32, 1, 1, '2025-06-10', '08:00', '10:00', 3, 'confirmed', GETDATE(), NULL),
(33, 2, NULL, '2025-06-11', '09:00', '11:00', 4, 'confirmed', GETDATE(), NULL),
(34, 3, 1, '2025-06-12', '07:00', '09:00', 2, 'confirmed', GETDATE(), NULL),
(35, 1, 3, '2025-06-13', '10:00', '12:00', 5, 'confirmed', GETDATE(), NULL),
(36, 2, 4, '2025-06-14', '17:00', '19:00', 2, 'pending', GETDATE(), NULL),
(37, 3, 1, '2025-06-15', '13:00', '15:00', 2, 'pending', GETDATE(), NULL),
(38, 1, 2, '2025-06-16', '16:00', '18:00', 3, 'confirmed', GETDATE(), NULL),
(39, 2, 3, '2025-06-17', '18:00', '20:00', 2, 'confirmed', GETDATE(), NULL),
(40, 3, 5, '2025-06-18', '09:00', '11:00', 3, 'confirmed', GETDATE(), NULL),
(41, 1, 2, '2025-06-19', '14:00', '16:00', 2, 'pending', GETDATE(), NULL);

--Thêm bảng Pool_service_id
INSERT INTO Pool_Service(pool_id, service_name, description, price, service_image, quantity) VALUES
(1,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(1,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(1,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(1,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(1,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(1,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(2,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(2,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(2,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(2,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(2,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(2,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(3,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(3,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(3,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(3,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(3,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(3,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(4,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(4,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(4,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(4,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(4,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(4,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(5,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(5,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(5,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(5,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(5,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(5,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(6,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(6,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(6,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(6,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(6,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(6,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(7,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(7,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(7,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(7,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(7,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(7,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(8,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(8,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(8,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(8,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(8,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(8,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(9,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(9,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(9,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(9,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(9,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(9,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(10,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(10,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(10,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(10,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(10,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(10,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(11,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(11,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(11,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(11,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(11,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(11,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(12,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(12,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(12,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(12,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(12,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(12,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(13,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(13,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(13,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(13,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(13,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(13,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(14,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(14,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(14,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(14,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(14,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(14,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(15,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(15,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(15,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(15,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(15,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(15,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(16,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(16,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(16,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(16,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(16,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(16,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(17,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(17,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(17,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(17,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(17,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(17,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(18,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(18,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(18,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(18,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(18,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(18,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(19,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(19,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(19,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(19,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(19,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(19,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(20,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(20,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(20,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(20,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(20,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(20,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(21,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(21,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(21,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(21,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(21,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(21,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(22,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(22,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(22,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(22,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(22,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(22,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(23,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(23,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(23,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(23,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(23,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(23,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(24,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(24,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(24,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(24,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(24,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(24,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60),

(25,N'Tủ đựng đồ',N'Dùng để đựng các đồ dùng cá nhân như điện thoại, laptop, giấy tờ tùy thân',30000,N'https://aicahpl.com/content_hpl/upload/Image/compact-laminate-lockers-nhmzh7.jpg',60),
(25,N'Áo phao',N'Giúp đảm bảo an toàn cho người không biết bơi',20000,N'https://nathaco.com/image/catalog/cuu-ho-be-boi/ao-phao-boi-cuu-ho.jpg',60),
(25,N'Đồ bơi trẻ em',N'Đồ bơi trẻ em giúp bảo vệ cơ thể, tạo cảm giác thoải mái khi bơi và hỗ trợ vận động an toàn trong môi trường nước',40000,N'https://sudospaces.com/babycuatoi/2020/03/ang-ao-boi-giu-nhiet-can-gio-cho-be-3.jpg',60),
(25,N'Đồ bơi người lớn',N'Đồ bơi người lớn giúp bảo vệ cơ thể, tăng sự linh hoạt khi bơi và đảm bảo vệ sinh trong môi trường nước',60000,N'https://product.hstatic.net/1000349730/product/do-boi-cap-doi-di-bien-qa9589_fb0cb7c9304c4b23a98cc70013ed9b54_large.jpg',60),
(25,N'Kính Bơi',N'Kính bơi giúp bảo vệ mắt khỏi hóa chất trong nước và tăng tầm nhìn rõ ràng khi bơi',20000,N'https://yeuboiloi.com/wp-content/uploads/2022/05/view-v500s_bl_001b.jpg',60),
(25,N'Mũ bơi',N'Mũ bơi giúp bảo vệ tóc, giữ vệ sinh nước bể và giảm lực cản khi bơi',20000,N'https://huyphu.com/cdn/720/Product/_2jLd53DPGe/1572874168438.jpg',60);

--Thêm bảng Booking_Service: chỉ sử dụng các service_id 1-4 ở trên, booking_id từ 1 đến 15
INSERT INTO Booking_Service (booking_id, pool_service_id, branch_id, quantity, total_service_price) VALUES
(1, 1, 1, 2, 40000),    -- Thuê 2 tủ đồ
(1, 2, 1, 2, 80000),    -- Thuê 2 đồ bơi
(2, 3, 1, 1, 12000),    -- Thuê 1 phao bơi
(2, 4, 1, 1, 15000),    -- Thuê 1 áo phao
(3, 1, 1, 1, 20000),    -- Thuê 1 tủ đồ
(4, 2, 1, 1, 40000),    -- Thuê 1 đồ bơi
(5, 3, 1, 2, 24000),    -- Thuê 2 phao bơi
(6, 4, 1, 1, 15000),    -- Thuê 1 áo phao
(7, 1, 1, 1, 20000),    -- Thuê 1 tủ đồ
(8, 2, 1, 1, 40000),    -- Thuê 1 đồ bơi
(9, 3, 1, 1, 12000),    -- Thuê 1 phao bơi
(9, 4, 1, 1, 15000),    -- Thuê 1 áo phao
(10, 1, 1, 1, 20000),   -- Thuê 1 tủ đồ
(10, 2, 1, 1, 40000);   -- Thuê 1 đồ bơi

--Thêm bảng Ticket_Types
INSERT INTO Ticket_Types (type_code, type_name, description, base_price, is_combo) VALUES 
(N'ADULT', N'Người lớn', N'Vé dành cho người lớn', 100000.00, 0),
(N'CHILD', N'Trẻ em', N'Vé dành cho trẻ em', 70000.00, 0),
(N'SENIOR', N'Người già', N'Vé dành cho người cao tuổi', 80000.00, 0),
(N'FAMILY', N'Combo Gia Đình', N'2 người lớn + 2 trẻ em', 300000.00, 1),
(N'TRIPLE', N'Combo Nhóm 3', N'3 người lớn', 270000.00, 1);

-- Thêm bảng Combo_Detail
INSERT INTO Combo_Detail (combo_type_id, included_type_id, quantity)VALUES 
(4, 1, 2), -- FAMILY combo includes 2 ADULT
(4, 2, 2), -- FAMILY combo includes 2 CHILD
(5, 1, 3); -- TRIPLE combo includes 3 ADULT

-- Thêm bảng Ticket
INSERT INTO Ticket (booking_id, ticket_type_id, ticket_price, ticket_code, issued_by, issued_at)VALUES 
(1, 1, 100000, 'ADULT-TICKET-0001', 1, GETDATE()), -- Người lớn
(1, 2, 70000, 'CHILD-TICKET-0002', 1, GETDATE()), -- Trẻ em
(1, 2, 70000, 'CHILD-TICKET-0003', 1, GETDATE()), -- Trẻ em
(2, 4, 300000, 'FAMILY-TICKET-0004', 1, GETDATE()), -- Combo Gia đình
(3, 1, 100000, 'ADULT-TICKET-0005', 1, GETDATE()), -- Người lớn
(3, 3, 80000, 'SENIOR-TICKET-0006', 1, GETDATE()), -- Người già
(4, 4, 300000, 'FAMILY-TICKET-0007', 1, GETDATE()),-- Combo Gia đình
(5, 5, 270000, 'TRIPLE-TICKET-0008', 1, GETDATE());-- Combo 3 Người lớn

--Thêm bảng Payment
INSERT INTO Payments (booking_id, payment_method, payment_status, payment_date, total_amount, discount_amount, transaction_reference, created_at) VALUES 
(1, N'Bank_transfers', N'completed', GETDATE(), 300000, 30000, 'TX200', GETDATE()),
(2, N'Cash', N'completed', GETDATE(), 200000, 0, 'TX201', GETDATE()),
(3, N'Bank_transfers', N'pending', GETDATE(), 100000, 10000, 'TX202', GETDATE()),
(4, N'Cash', N'completed', GETDATE(), 500000, 0, 'TX203', GETDATE()),
(5, N'Bank_transfers', N'refunded', GETDATE(), 200000, 20000, 'TX204', GETDATE()),
(6, N'Cash', N'pending', GETDATE(), 400000, 0, 'TX205', GETDATE()),
(7, N'Bank_transfers', N'completed', GETDATE(), 200000, 0, 'TX206', GETDATE()),
(8, N'Cash', N'completed', GETDATE(), 100000, 10000, 'TX207', GETDATE()),
(9, N'Bank_transfers', N'completed', GETDATE(), 300000, 75000, 'TX210', GETDATE()),
(10, N'Cash', N'pending', GETDATE(), 200000, 40000, 'TX211', GETDATE());

--Thêm bảng Payment_Ticket
INSERT INTO Payment_Ticket (payment_id, ticket_id, amount, quantity) VALUES 
(1, 1, 100000.00, 1),
(2, 2, 120000.00, 2),
(3, 3, 140000.00, 1),
(4, 1, 100000.00, 2),
(5, 2, 120000.00, 1),
(6, 3, 140000.00, 2),
(7, 1, 100000.00, 1),
(8, 2, 120000.00, 2),
(9, 3, 140000.00, 1),
(10, 1, 100000.00, 2);

--Thêm bảng Payment_RentItem
INSERT INTO Payment_RentItem (payment_id, service_id, amount, quantity) VALUES 
(1, 1, 50000.00, 1),
(2, 2, 60000.00, 1),
(3, 3, 70000.00, 1),
(4, 1, 50000.00, 1),
(5, 2, 60000.00, 1),
(6, 3, 70000.00, 1),
(7, 1, 50000.00, 1),
(8, 2, 60000.00, 1),
(9, 3, 70000.00, 1),
(10, 1, 50000.00, 1);




-- Tuấn Anh insert vào bẳng Ticket_Type để set lại tất cả hồ bơi vé đều đang hoạt động
INSERT INTO Pool_Ticket_Types (pool_id, ticket_type_id, price, status)
SELECT p.pool_id, t.ticket_type_id, t.base_price, 'active'
FROM Pools p
CROSS JOIN Ticket_Types t; 