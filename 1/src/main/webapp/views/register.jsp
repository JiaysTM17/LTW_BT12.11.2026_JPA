<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Ký Thành Viên - Shopping MVC</title>
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
            background: radial-gradient(circle at 10% 20%, rgba(236, 253, 245, 0.8) 0%, rgba(248, 250, 252, 1) 90%);
            min-height: 100vh;
            color: #0f172a;
        }

        .auth-container {
            max-width: 520px;
            margin: 30px auto 60px;
        }

        .card-auth-premium {
            background: #ffffff;
            border-radius: 20px;
            border: 1px solid rgba(226, 232, 240, 0.8);
            box-shadow: 0 20px 40px -15px rgba(15, 23, 42, 0.08), 0 0 0 1px rgba(15, 23, 42, 0.03);
            overflow: hidden;
        }

        .auth-header {
            padding: 32px 32px 20px;
            text-align: center;
            background: linear-gradient(180deg, #f8fafc 0%, #ffffff 100%);
            border-bottom: 1px solid #f1f5f9;
        }

        .auth-icon-circle-success {
            width: 64px;
            height: 64px;
            margin: 0 auto 16px;
            border-radius: 18px;
            background: linear-gradient(135deg, #059669 0%, #10b981 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 26px;
            box-shadow: 0 10px 25px -5px rgba(16, 185, 129, 0.4);
        }

        .form-floating-custom .form-control {
            border-radius: 12px;
            border: 1.5px solid #e2e8f0;
            padding: 10px 16px 10px 44px;
            font-size: 0.92rem;
            height: 48px;
            transition: all 0.2s ease;
            background-color: #f8fafc;
        }

        .form-floating-custom .form-control:focus {
            background-color: #ffffff;
            border-color: #10b981;
            box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.12);
        }

        .input-icon-wrap {
            position: relative;
        }

        .input-icon-wrap i {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 1rem;
            pointer-events: none;
            transition: color 0.2s ease;
        }

        .form-floating-custom .form-control:focus + i {
            color: #059669;
        }

        .btn-submit-success {
            background: linear-gradient(135deg, #059669 0%, #10b981 100%);
            color: white;
            font-weight: 600;
            font-size: 0.98rem;
            padding: 12px 20px;
            border-radius: 12px;
            border: none;
            box-shadow: 0 10px 20px -5px rgba(16, 185, 129, 0.35);
            transition: all 0.2s ease;
        }

        .btn-submit-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 14px 24px -5px rgba(16, 185, 129, 0.45);
            color: white;
            opacity: 0.96;
        }
    </style>
</head>
<body>

    <!-- Thanh điều hướng chung -->
    <jsp:include page="/views/common/topbar.jsp"></jsp:include>

    <div class="container">
        <div class="auth-container">
            <div class="card card-auth-premium">
                <!-- Tiêu đề -->
                <div class="auth-header">
                    <div class="auth-icon-circle-success">
                        <i class="fa-solid fa-user-plus"></i>
                    </div>
                    <h3 class="fw-bold mb-1" style="letter-spacing: -0.02em;">Tạo Tài Khoản Mới</h3>
                    <p class="text-muted small mb-0">Tham gia hệ thống Shopping MVC ngay hôm nay</p>
                </div>

                <div class="card-body p-4 p-md-5 pt-4">
                    <!-- Thông báo lỗi nếu có -->
                    <c:if test="${not empty alert}">
                        <div class="alert alert-danger d-flex align-items-center rounded-3 py-2 px-3 mb-4 shadow-sm" role="alert" style="border-left: 4px solid #ef4444;">
                            <i class="fa-solid fa-circle-exclamation me-2 fs-5 text-danger"></i>
                            <div class="small fw-semibold">${alert}</div>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/register" method="post">
                        <!-- Tên tài khoản -->
                        <div class="mb-3">
                            <label for="username" class="form-label fw-semibold small text-secondary">TÊN ĐĂNG NHẬP <span class="text-danger">*</span></label>
                            <div class="input-icon-wrap form-floating-custom">
                                <input type="text" class="form-control" id="username" name="username" 
                                       placeholder="Ví dụ: kiettruong" required autofocus>
                                <i class="fa-regular fa-user"></i>
                            </div>
                        </div>

                        <!-- Mật khẩu -->
                        <div class="mb-3">
                            <label for="password" class="form-label fw-semibold small text-secondary">MẬT KHẨU <span class="text-danger">*</span></label>
                            <div class="input-icon-wrap form-floating-custom">
                                <input type="password" class="form-control" id="password" name="password" 
                                       placeholder="Nhập mật khẩu an toàn" required>
                                <i class="fa-solid fa-key"></i>
                            </div>
                        </div>

                        <!-- Họ và tên -->
                        <div class="mb-3">
                            <label for="fullname" class="form-label fw-semibold small text-secondary">HỌ VÀ TÊN</label>
                            <div class="input-icon-wrap form-floating-custom">
                                <input type="text" class="form-control" id="fullname" name="fullname" 
                                       placeholder="Ví dụ: Trương Gia Kiệt">
                                <i class="fa-regular fa-id-badge"></i>
                            </div>
                        </div>

                        <!-- Email & Điện thoại (2 cột) -->
                        <div class="row g-2 mb-4">
                            <div class="col-md-7">
                                <label for="email" class="form-label fw-semibold small text-secondary">ĐỊA CHỈ EMAIL</label>
                                <div class="input-icon-wrap form-floating-custom">
                                    <input type="email" class="form-control" id="email" name="email" 
                                           placeholder="email@example.com">
                                    <i class="fa-regular fa-envelope"></i>
                                </div>
                            </div>
                            <div class="col-md-5">
                                <label for="phone" class="form-label fw-semibold small text-secondary">SỐ ĐIỆN THOẠI</label>
                                <div class="input-icon-wrap form-floating-custom">
                                    <input type="tel" class="form-control" id="phone" name="phone" 
                                           placeholder="0901234567">
                                    <i class="fa-solid fa-phone"></i>
                                </div>
                            </div>
                        </div>

                        <!-- Nút đăng ký -->
                        <button type="submit" class="btn btn-submit-success w-100">
                            <i class="fa-solid fa-check me-2"></i>Hoàn Tất Đăng Ký
                        </button>
                    </form>

                    <!-- Chuyển hướng sang đăng nhập -->
                    <div class="text-center mt-4 pt-2 text-secondary small">
                        <span>Đã có tài khoản thành viên? </span>
                        <a href="${pageContext.request.contextPath}/login" class="fw-bold text-decoration-none" style="color: #059669;">
                            Đăng nhập ngay <i class="fa-solid fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
