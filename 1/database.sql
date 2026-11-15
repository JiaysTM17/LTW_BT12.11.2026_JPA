/* ====================================================================================
   DỰ ÁN: BÀI TẬP LẬP TRÌNH WEB (HCMUTE - WEBPR330479)
   GIẢNG VIÊN HƯỚNG DẪN: ThS. NGUYỄN HỮU TRUNG
   SINH VIÊN THỰC HIỆN: TRƯƠNG GIA KIỆT - MSSV: 24110032
   TẬP TIN: database.sql
   MÔ TẢ: Script khởi tạo cơ sở dữ liệu ShoppingServiceMVC (hoặc WebLoginDB),
          tạo bảng [User], bảng [Category] và nạp dữ liệu mẫu ban đầu.
   ==================================================================================== */

-- 1. TẠO CƠ SỞ DỮ LIỆU NẾU CHƯA TỒN TẠI
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = N'ShoppingServiceMVC')
BEGIN
    CREATE DATABASE [ShoppingServiceMVC];
END
GO

USE [ShoppingServiceMVC];
GO

-- 2. TẠO BẢNG [User] LƯU TRỮ TÀI KHOẢN VÀ PHÂN QUYỀN
-- Lưu ý: Từ khóa USER là từ khóa hệ thống của T-SQL nên bắt buộc đặt trong ngoặc vuông [User]
IF OBJECT_ID(N'[dbo].[User]', N'U') IS NOT NULL
BEGIN
    DROP TABLE [dbo].[User];
END
GO

CREATE TABLE [dbo].[User] (
    [id]          INT IDENTITY(1,1) NOT NULL,
    [email]       NVARCHAR(255)     NULL,
    [username]    VARCHAR(50)       NOT NULL,
    [fullname]    NVARCHAR(255)     NULL,
    [password]    VARCHAR(255)      NOT NULL,
    [avatar]      NVARCHAR(255)     NULL,
    [roleid]      INT               NOT NULL DEFAULT 3,
    [phone]       VARCHAR(20)       NULL,
    [createddate] DATE              NULL DEFAULT CAST(GETDATE() AS DATE),
    CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED ([id] ASC),
    CONSTRAINT [UQ_User_username] UNIQUE NONCLUSTERED ([username] ASC)
);
GO

-- 3. TẠO BẢNG [Category] QUẢN LÝ DANH MỤC SẢN PHẨM
IF OBJECT_ID(N'[dbo].[Category]', N'U') IS NOT NULL
BEGIN
    DROP TABLE [dbo].[Category];
END
GO

CREATE TABLE [dbo].[Category] (
    [cate_id]   INT IDENTITY(1,1) NOT NULL,
    [cate_name] NVARCHAR(255)     NOT NULL,
    [icons]     NVARCHAR(255)     NULL,
    CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED ([cate_id] ASC)
);
GO

-- 4. CHÈN DỮ LIỆU MẪU CHO BẢNG [User]
-- Ba tài khoản đại diện cho 3 vai trò:
-- + roleid = 1: Quản trị viên (Admin) -> chuyển hướng /admin/home
-- + roleid = 2: Quản lý (Manager)     -> chuyển hướng /manager/home
-- + roleid = 3: Người dùng (User)      -> chuyển hướng /home
-- Mật khẩu mặc định: '123'
INSERT INTO [dbo].[User] ([email], [username], [fullname], [password], [avatar], [roleid], [phone], [createddate])
VALUES 
    (N'admin@gmail.com', 'admin', N'Quản Trị Viên Hệ Thống', '123', NULL, 1, '0901112222', CAST(GETDATE() AS DATE)),
    (N'manager@gmail.com', 'manager', N'Quản Lý Cửa Hàng', '123', NULL, 2, '0903334444', CAST(GETDATE() AS DATE)),
    (N'user@gmail.com', 'user', N'Khách Hàng Mẫu', '123', NULL, 3, '0905556666', CAST(GETDATE() AS DATE));
GO

-- 5. CHÈN DỮ LIỆU MẪU CHO BẢNG [Category]
-- Bốn danh mục tiêu chuẩn minh họa cho chức năng CRUD và hiển thị hình ảnh
INSERT INTO [dbo].[Category] ([cate_name], [icons])
VALUES 
    (N'Quần Áo Nam', N'ao-nam.jpg'),
    (N'Quần Áo Nữ', N'ao-nu.jpg'),
    (N'Giày Dép', N'giay-dep.jpg'),
    (N'Phụ Kiện Thời Trang', N'phu-kien.jpg');
GO

-- 6. KIỂM TRA DỮ LIỆU ĐÃ NẠP
SELECT * FROM [dbo].[User];
SELECT * FROM [dbo].[Category];
GO
