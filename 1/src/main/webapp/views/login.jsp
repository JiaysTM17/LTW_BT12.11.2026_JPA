<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng Nhập Hệ Thống - Shopping MVC</title>
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
            background: radial-gradient(circle at 10% 20%, rgba(238, 242, 255, 0.8) 0%, rgba(248, 250, 252, 1) 90%);
            min-height: 100vh;
            color: #0f172a;
        }

        .auth-container {
            max-width: 460px;
            margin: 40px auto 60px;
        }

        .card-auth-premium {
            background: #ffffff;
            border-radius: 20px;
            border: 1px solid rgba(226, 232, 240, 0.8);
            box-shadow: 0 20px 40px -15px rgba(15, 23, 42, 0.08), 0 0 0 1px rgba(15, 23, 42, 0.03);
            overflow: hidden;
            transition: all 0.3s ease;
        }

        .auth-header {
            padding: 36px 32px 24px;
            text-align: center;
            background: linear-gradient(180deg, #f8fafc 0%, #ffffff 100%);
            border-bottom: 1px solid #f1f5f9;
        }

        .auth-icon-circle {
            width: 64px;
            height: 64px;
            margin: 0 auto 16px;
            border-radius: 18px;
            background: linear-gradient(135deg, #4f46e5 0%, #3b82f6 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 26px;
            box-shadow: 0 10px 25px -5px rgba(79, 70, 229, 0.4);
        }

        .form-floating-custom .form-control {
            border-radius: 12px;
            border: 1.5px solid #e2e8f0;
            padding: 12px 16px 12px 46px;
            font-size: 0.95rem;
            height: 52px;
            transition: all 0.2s ease;
            background-color: #f8fafc;
        }

        .form-floating-custom .form-control:focus {
            background-color: #ffffff;
            border-color: #6366f1;
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.12);
        }

        .input-icon-wrap {
            position: relative;
        }

        .input-icon-wrap i {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 1.05rem;
            pointer-events: none;
            transition: color 0.2s ease;
        }

        .form-floating-custom .form-control:focus + i {
            color: #4f46e5;
        }

        .btn-submit-premium {
            background: linear-gradient(135deg, #4f46e5 0%, #3b82f6 100%);
            color: white;
            font-weight: 600;
            font-size: 1rem;
            padding: 13px 20px;
            border-radius: 12px;
            border: none;
            box-shadow: 0 10px 20px -5px rgba(79, 70, 229, 0.35);
            transition: all 0.2s ease;
        }

        .btn-submit-premium:hover {
            transform: translateY(-2px);
            box-shadow: 0 14px 24px -5px rgba(79, 70, 229, 0.45);
            color: white;
            opacity: 0.96;
        }

        .hint-badge {
            cursor: pointer;
            font-size: 0.78rem;
            padding: 6px 12px;
            border-radius: 8px;
            background: #f1f5f9;
            color: #475569;
            border: 1px dashed #cbd5e1;
            transition: all 0.2s ease;
            display: inline-block;
        }

        .hint-badge:hover {
            background: #e0e7ff;
            color: #3730a3;
            border-color: #a5b4fc;
        }
    </style>
</head>
<body>

    <!-- Thanh điều hướng dùng chung sang trọng -->
    <jsp:include page="/views/common/topbar.jsp"></jsp:include>

    <div class="container">
        <div class="auth-container">
            <div class="card card-auth-premium">
                <!-- Tiêu đề và biểu tượng -->
                <div class="auth-header">
                    <div class="auth-icon-circle">
                        <i class="fa-solid fa-lock"></i>
                    </div>
                    <h3 class="fw-bold mb-1" style="letter-spacing: -0.02em;">Đăng Nhập</h3>
                    <p class="text-muted small mb-0">Hệ thống Quản Trị & Mua Sắm Shopping MVC</p>
                </div>

                <div class="card-body p-4 p-md-5 pt-4">
                    <!-- Thông báo cảnh báo lỗi nếu có -->
                    <c:if test="${not empty alert}">
                        <div class="alert alert-danger d-flex align-items-center rounded-3 py-2 px-3 mb-4 shadow-sm" role="alert" style="border-left: 4px solid #ef4444;">
                            <i class="fa-solid fa-circle-exclamation me-2 fs-5 text-danger"></i>
                            <div class="small fw-semibold">${alert}</div>
                        </div>
                    </c:if>

                    <form action="${pageContext.request.contextPath}/login" method="post">
                        <!-- Tên đăng nhập -->
                        <div class="mb-3">
                            <label for="username" class="form-label fw-semibold small text-secondary">TÊN ĐĂNG NHẬP</label>
                            <div class="input-icon-wrap form-floating-custom">
                                <input type="text" class="form-control" id="username" name="username" 
                                       placeholder="Tài khoản đăng nhập" required autofocus>
                                <i class="fa-regular fa-user"></i>
                            </div>
                        </div>

                        <!-- Mật khẩu -->
                        <div class="mb-3">
                            <div class="d-flex justify-content-between align-items-center mb-1">
                                <label for="password" class="form-label fw-semibold small text-secondary mb-0">MẬT KHẨU</label>
                            </div>
                            <div class="input-icon-wrap form-floating-custom">
                                <input type="password" class="form-control" id="password" name="password" 
                                       placeholder="Mật khẩu" required>
                                <i class="fa-solid fa-key"></i>
                            </div>
                        </div>

                        <!-- Ghi nhớ đăng nhập (Remember Me) -->
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <div class="form-check">
                                <input type="checkbox" class="form-check-input" id="remember" name="remember" checked>
                                <label class="form-check-label user-select-none small text-secondary" for="remember">
                                    Ghi nhớ tài khoản (Remember Me)
                                </label>
                            </div>
                        </div>

                        <!-- Nút gửi đăng nhập -->
                        <button type="submit" class="btn btn-submit-premium w-100">
                            <i class="fa-solid fa-arrow-right-to-bracket me-2"></i>Đăng Nhập Hệ Thống
                        </button>
                    </form>

                    <!-- Khung gợi ý tài khoản nhanh -->
                    <div class="mt-4 pt-3 border-top">
                        <div class="small text-muted mb-2 text-center fw-medium">Chọn nhanh tài khoản mẫu để thử nghiệm:</div>
                        <div class="d-flex flex-wrap justify-content-center gap-2">
                            <span class="hint-badge" onclick="fillAccount('admin', '123')">
                                <i class="fa-solid fa-user-shield text-primary me-1"></i><strong>Admin:</strong> admin / 123
                            </span>
                            <span class="hint-badge" onclick="fillAccount('manager', '123')">
                                <i class="fa-solid fa-briefcase text-info me-1"></i><strong>Manager:</strong> manager / 123
                            </span>
                            <span class="hint-badge" onclick="fillAccount('user', '123')">
                                <i class="fa-solid fa-user text-success me-1"></i><strong>User:</strong> user / 123
                            </span>
                        </div>
                    </div>

                    <!-- Chuyển hướng sang đăng ký -->
                    <div class="text-center mt-4 pt-2 text-secondary small">
                        <span>Chưa có tài khoản? </span>
                        <a href="${pageContext.request.contextPath}/register" class="fw-bold text-decoration-none" style="color: #4f46e5;">
                            Đăng ký tài khoản mới <i class="fa-solid fa-arrow-right ms-1"></i>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function fillAccount(u, p) {
            document.getElementById('username').value = u;
            document.getElementById('password').value = p;
        }
    </script>
</body>
</html>
