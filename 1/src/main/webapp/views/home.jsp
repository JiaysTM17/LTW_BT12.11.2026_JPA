<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Trang Chủ - Shopping MVC</title>
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

        .hero-banner-premium {
            background: linear-gradient(135deg, #0f172a 0%, #1e293b 50%, #312e81 100%);
            border-radius: 24px;
            color: white;
            padding: 50px 48px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 20px 40px -15px rgba(15, 23, 42, 0.25);
            margin-bottom: 36px;
        }

        .feature-card-premium {
            background: #ffffff;
            border-radius: 20px;
            border: 1px solid rgba(226, 232, 240, 0.8);
            box-shadow: 0 4px 20px -2px rgba(15, 23, 42, 0.05);
            padding: 32px 24px;
            text-align: center;
            transition: all 0.25s ease;
            height: 100%;
        }

        .feature-card-premium:hover {
            transform: translateY(-6px);
            box-shadow: 0 16px 30px -5px rgba(15, 23, 42, 0.1);
            border-color: #cbd5e1;
        }

        .feature-icon-circle {
            width: 72px;
            height: 72px;
            margin: 0 auto 20px;
            border-radius: 20px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.8rem;
        }
    </style>
</head>
<body>

    <!-- Thanh điều hướng dùng chung -->
    <jsp:include page="/views/common/topbar.jsp"></jsp:include>

    <div class="container my-4">
        <!-- Hero Banner hiện đại -->
        <div class="hero-banner-premium">
            <div class="row align-items-center">
                <div class="col-lg-8">
                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-1 fw-bold rounded-pill mb-3">
                        <i class="fa-solid fa-layer-group me-1"></i>Mô Hình Kiến Trúc 3 Lớp (MVC)
                    </span>
                    <h1 class="display-5 fw-bold mb-3" style="letter-spacing: -0.03em;">
                        Chào Mừng Đến Với <span style="background: linear-gradient(135deg, #818cf8 0%, #38bdf8 100%); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">Shopping MVC</span>
                    </h1>
                    <p class="fs-5 text-white-50 mb-4 col-lg-10">
                        Nền tảng mua sắm và quản lý trực tuyến xây dựng trên Jakarta EE 10, Servlet 6.0, JSP/JSTL, 
                        kết nối cơ sở dữ liệu JDBC với bảo mật phiên làm việc và phân quyền đa cấp.
                    </p>

                    <c:choose>
                        <c:when test="${not empty sessionScope.account}">
                            <div class="d-inline-flex align-items-center gap-3 p-3 bg-white bg-opacity-10 rounded-4 border border-white border-opacity-10 backdrop-blur">
                                <i class="fa-solid fa-circle-check text-success fs-3"></i>
                                <div>
                                    <div class="small text-white-50">Đang đăng nhập thành công</div>
                                    <div class="fw-bold text-white fs-6">
                                        ${sessionScope.account.fullName} 
                                        <span class="badge bg-warning text-dark ms-2">
                                            <c:choose>
                                                <c:when test="${sessionScope.account.roleid == 1}">Quản Trị Viên (Admin)</c:when>
                                                <c:when test="${sessionScope.account.roleid == 2}">Quản Lý (Manager)</c:when>
                                                <c:otherwise>Thành Viên (Member)</c:otherwise>
                                            </c:choose>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </c:when>
                        <c:otherwise>
                            <div class="d-flex flex-wrap gap-3">
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-lg rounded-3 px-4 py-2 fw-semibold">
                                    <i class="fa-solid fa-arrow-right-to-bracket me-2"></i>Đăng Nhập Ngay
                                </a>
                                <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-light btn-lg rounded-3 px-4 py-2 fw-semibold">
                                    <i class="fa-solid fa-user-plus me-2"></i>Tạo Tài Khoản
                                </a>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="col-lg-4 text-center d-none d-lg-block">
                    <i class="fa-solid fa-cart-shopping fa-8x text-white-50 opacity-25"></i>
                </div>
            </div>
        </div>

        <!-- Các thẻ tính năng nổi bật -->
        <div class="row g-4">
            <div class="col-md-4">
                <div class="feature-card-premium">
                    <div class="feature-icon-circle" style="background: rgba(79, 70, 229, 0.1); color: #4f46e5;">
                        <i class="fa-solid fa-shield-halved"></i>
                    </div>
                    <h5 class="fw-bold mb-2">Bảo Mật Phiên & Cookie</h5>
                    <p class="text-muted small mb-0">
                        Xác thực tài khoản với HttpSession và cơ chế Remember Me thông qua Cookie mã hóa an toàn với thời hạn 30 phút.
                    </p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="feature-card-premium">
                    <div class="feature-icon-circle" style="background: rgba(16, 185, 129, 0.1); color: #10b981;">
                        <i class="fa-solid fa-users-gear"></i>
                    </div>
                    <h5 class="fw-bold mb-2">Phân Tuyến Vai Trò</h5>
                    <p class="text-muted small mb-0">
                        Tầng điều phối WaitingController tự động phân chia luồng trang: Admin (Role 1), Manager (Role 2) và Khách hàng.
                    </p>
                </div>
            </div>

            <div class="col-md-4">
                <div class="feature-card-premium">
                    <div class="feature-icon-circle" style="background: rgba(14, 165, 233, 0.1); color: #0ea5e9;">
                        <i class="fa-solid fa-boxes-stacked"></i>
                    </div>
                    <h5 class="fw-bold mb-2">Quản Lý Danh Mục CRUD</h5>
                    <p class="text-muted small mb-0">
                        Hỗ trợ đầy đủ chức năng Thêm, Xóa, Sửa, Tìm kiếm cùng cơ chế tải ảnh multipart và stream trực tiếp qua Servlet <code>/image</code>.
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
