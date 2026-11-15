<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bảng Điều Khiển Quản Trị - Admin Dashboard</title>
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

        .dashboard-welcome-banner {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 100%);
            border-radius: 20px;
            color: white;
            padding: 36px 40px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 10px 30px -5px rgba(15, 23, 42, 0.2);
            margin-bottom: 30px;
        }

        .stat-card-premium {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid rgba(226, 232, 240, 0.8);
            box-shadow: 0 4px 20px -2px rgba(15, 23, 42, 0.05);
            padding: 24px;
            transition: all 0.25s ease;
            position: relative;
            overflow: hidden;
        }

        .stat-card-premium:hover {
            transform: translateY(-4px);
            box-shadow: 0 12px 25px -4px rgba(15, 23, 42, 0.1);
        }

        .stat-icon-wrapper {
            width: 52px;
            height: 52px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.4rem;
        }

        .stat-icon-primary {
            background: rgba(79, 70, 229, 0.1);
            color: #4f46e5;
        }

        .stat-icon-success {
            background: rgba(16, 185, 129, 0.1);
            color: #10b981;
        }

        .stat-icon-warning {
            background: rgba(245, 158, 11, 0.1);
            color: #f59e0b;
        }

        .quick-action-card {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid rgba(226, 232, 240, 0.8);
            padding: 24px;
            transition: all 0.2s ease;
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .quick-action-card:hover {
            border-color: #4f46e5;
            transform: translateY(-3px);
            box-shadow: 0 10px 25px -5px rgba(79, 70, 229, 0.15);
            color: inherit;
        }
    </style>
</head>
<body>

    <!-- Thanh điều hướng dùng chung -->
    <jsp:include page="/views/common/topbar.jsp"></jsp:include>

    <div class="container my-4">
        <!-- Banner chào mừng quản trị viên -->
        <div class="dashboard-welcome-banner">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <span class="badge bg-warning text-dark px-3 py-1 fw-bold rounded-pill mb-3">
                        <i class="fa-solid fa-crown me-1"></i>Administrator Mode
                    </span>
                    <h2 class="fw-bold mb-2 display-6">Bảng Điều Khiển Quản Trị</h2>
                    <p class="text-white-50 mb-3 fs-6">
                        Chào mừng <strong>${sessionScope.account.fullName}</strong>. Hệ thống quản trị nội dung danh mục và phân quyền mô hình 3 lớp.
                    </p>
                    <div class="d-flex flex-wrap gap-2">
                        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-primary rounded-3 px-3 py-2 fw-semibold">
                            <i class="fa-solid fa-boxes-stacked me-2"></i>Quản Lý Danh Mục
                        </a>
                        <a href="${pageContext.request.contextPath}/admin/category/add" class="btn btn-outline-light rounded-3 px-3 py-2 fw-semibold">
                            <i class="fa-solid fa-plus me-2"></i>Thêm Mới Danh Mục
                        </a>
                    </div>
                </div>
                <div class="col-lg-4 text-center text-lg-end d-none d-lg-block">
                    <i class="fa-solid fa-shield-halved fa-7x text-white-50 opacity-25"></i>
                </div>
            </div>
        </div>

        <!-- Các thẻ thống kê nhanh -->
        <div class="row g-4 mb-4">
            <div class="col-md-4">
                <div class="stat-card-premium">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div>
                            <span class="text-muted small fw-semibold text-uppercase">Danh mục hàng hóa</span>
                            <h3 class="fw-bold mb-0 mt-1">Category CRUD</h3>
                        </div>
                        <div class="stat-icon-wrapper stat-icon-primary">
                            <i class="fa-solid fa-layer-group"></i>
                        </div>
                    </div>
                    <div class="d-flex justify-content-between align-items-center pt-2 border-top">
                        <span class="small text-muted">Bảng CSDL: <code>Category</code></span>
                        <a href="${pageContext.request.contextPath}/admin/category/list" class="small fw-bold text-decoration-none" style="color: #4f46e5;">
                            Xem ngay <i class="fa-solid fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="stat-card-premium">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div>
                            <span class="text-muted small fw-semibold text-uppercase">Tải lên hình ảnh</span>
                            <h3 class="fw-bold mb-0 mt-1">D:/upload</h3>
                        </div>
                        <div class="stat-icon-wrapper stat-icon-success">
                            <i class="fa-solid fa-cloud-arrow-up"></i>
                        </div>
                    </div>
                    <div class="d-flex justify-content-between align-items-center pt-2 border-top">
                        <span class="small text-muted">Servlet Stream: <code>/image</code></span>
                        <span class="badge bg-success-subtle text-success border border-success-subtle">Sẵn sàng</span>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="stat-card-premium">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <div>
                            <span class="text-muted small fw-semibold text-uppercase">Tài khoản & Phân quyền</span>
                            <h3 class="fw-bold mb-0 mt-1 text-truncate" style="max-width: 180px;">${sessionScope.account.userName}</h3>
                        </div>
                        <div class="stat-icon-wrapper stat-icon-warning">
                            <i class="fa-solid fa-user-shield"></i>
                        </div>
                    </div>
                    <div class="d-flex justify-content-between align-items-center pt-2 border-top">
                        <span class="small text-muted">Vai trò: <strong>Role 1 (Admin)</strong></span>
                        <span class="badge bg-primary-subtle text-primary border border-primary-subtle">WaitingController</span>
                    </div>
                </div>
            </div>
        </div>

        <!-- Khối điều hướng chức năng chi tiết -->
        <div class="card border-0 shadow-sm rounded-4 p-4 mb-4">
            <h5 class="fw-bold mb-3 text-secondary">
                <i class="fa-solid fa-bolt text-warning me-2"></i>Thao Tác Nhanh
            </h5>
            <div class="row g-3">
                <div class="col-md-6">
                    <a href="${pageContext.request.contextPath}/admin/category/list" class="quick-action-card">
                        <div class="d-flex align-items-center gap-3">
                            <div class="stat-icon-wrapper stat-icon-primary">
                                <i class="fa-solid fa-list-check"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-1">Quản Lý Danh Sách & Tìm Kiếm</h6>
                                <p class="text-muted small mb-0">Xem toàn bộ danh mục sản phẩm, lọc theo từ khóa và tải trực tiếp ảnh qua URL <code>/image</code></p>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="col-md-6">
                    <a href="${pageContext.request.contextPath}/admin/category/add" class="quick-action-card">
                        <div class="d-flex align-items-center gap-3">
                            <div class="stat-icon-wrapper stat-icon-success">
                                <i class="fa-solid fa-file-circle-plus"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-1">Thêm Mới Danh Mục & Upload Ảnh</h6>
                                <p class="text-muted small mb-0">Tải lên tệp ảnh qua Jakarta Multipart, hệ thống tự động đổi tên tệp tin và lưu vào <code>D:\upload</code></p>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
