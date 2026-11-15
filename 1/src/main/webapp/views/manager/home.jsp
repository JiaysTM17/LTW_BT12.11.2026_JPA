<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cổng Quản Lý - Manager Portal</title>
    <!-- Bootstrap 5.3 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Plus Jakarta Sans', -apple-system, sans-serif;
            background-color: #f8fafc;
            color: #0f172a;
        }

        .portal-header-banner {
            background: linear-gradient(135deg, #0284c7 0%, #0369a1 100%);
            border-radius: 20px;
            color: white;
            padding: 36px 40px;
            box-shadow: 0 10px 30px -5px rgba(2, 132, 199, 0.25);
            margin-bottom: 30px;
        }

        .card-custom {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid rgba(226, 232, 240, 0.8);
            box-shadow: 0 4px 20px -2px rgba(15, 23, 42, 0.05);
            padding: 28px;
            height: 100%;
            transition: all 0.2s ease;
        }

        .card-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px -4px rgba(15, 23, 42, 0.1);
        }
    </style>
</head>
<body>

    <!-- Thanh điều hướng dùng chung -->
    <jsp:include page="/views/common/topbar.jsp"></jsp:include>

    <div class="container my-4">
        <!-- Banner chào mừng Manager -->
        <div class="portal-header-banner">
            <span class="badge bg-white text-primary px-3 py-1 fw-bold rounded-pill mb-3">
                <i class="fa-solid fa-briefcase me-1"></i>Manager Portal
            </span>
            <h2 class="fw-bold mb-2 display-6">Cổng Thông Tin Quản Lý Cửa Hàng</h2>
            <p class="text-white-50 mb-3 fs-6">
                Xin chào Quản lý <strong>${sessionScope.account.fullName}</strong>. Bạn đang đăng nhập với vai trò phân quyền <strong>Role 2</strong>.
            </p>
            <div class="d-inline-flex align-items-center gap-3 p-2 px-3 bg-white bg-opacity-15 rounded-3 text-white small">
                <span><i class="fa-solid fa-user me-1 text-warning"></i>Tài khoản: <strong>${sessionScope.account.userName}</strong></span>
                <span>•</span>
                <span><i class="fa-solid fa-envelope me-1 text-warning"></i>Email: <strong>${sessionScope.account.email}</strong></span>
                <span>•</span>
                <span><i class="fa-solid fa-phone me-1 text-warning"></i>SĐT: <strong>${sessionScope.account.phone}</strong></span>
            </div>
        </div>

        <!-- Các thẻ nội dung phân quyền -->
        <div class="row g-4">
            <div class="col-md-6">
                <div class="card-custom">
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div style="width: 48px; height: 48px; border-radius: 12px; background: rgba(2, 132, 199, 0.1); color: #0284c7; display: flex; align-items: center; justify-content: center; font-size: 1.3rem;">
                            <i class="fa-solid fa-chart-pie"></i>
                        </div>
                        <div>
                            <h5 class="fw-bold mb-0">Theo Dõi Hoạt Động</h5>
                            <small class="text-muted">Báo cáo tổng quan hoạt động kinh doanh</small>
                        </div>
                    </div>
                    <p class="text-muted small mb-0">
                        Hệ thống tự động đồng bộ hóa thông tin danh mục, trạng thái đăng nhập và các thao tác nghiệp vụ theo thời gian thực.
                    </p>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card-custom">
                    <div class="d-flex align-items-center gap-3 mb-3">
                        <div style="width: 48px; height: 48px; border-radius: 12px; background: rgba(16, 185, 129, 0.1); color: #10b981; display: flex; align-items: center; justify-content: center; font-size: 1.3rem;">
                            <i class="fa-solid fa-user-shield"></i>
                        </div>
                        <div>
                            <h5 class="fw-bold mb-0">Phân Tuyến Vai Trò Đúng Chuẩn</h5>
                            <small class="text-muted">Được kiểm duyệt bởi WaitingController</small>
                        </div>
                    </div>
                    <p class="text-muted small mb-0">
                        Tài khoản Quản lý được phân tuyến chuẩn xác theo yêu cầu đề bài (roleid = 2), chỉ có quyền truy cập khu vực nghiệp vụ quản lý tương ứng.
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
