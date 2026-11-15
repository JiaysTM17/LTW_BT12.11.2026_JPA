<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thêm Danh Mục Mới - Add Category</title>
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

        .form-card {
            background: #ffffff;
            border-radius: 20px;
            border: 1px solid rgba(226, 232, 240, 0.8);
            box-shadow: 0 10px 30px -5px rgba(15, 23, 42, 0.06);
            overflow: hidden;
        }

        .card-header-gradient {
            background: linear-gradient(135deg, #059669 0%, #10b981 100%);
            color: white;
            padding: 24px 28px;
        }

        .input-custom {
            border-radius: 12px;
            border: 1.5px solid #e2e8f0;
            padding: 12px 16px;
            font-size: 0.95rem;
            transition: all 0.2s ease;
        }

        .input-custom:focus {
            border-color: #10b981;
            box-shadow: 0 0 0 4px rgba(16, 185, 129, 0.12);
        }

        .preview-box {
            width: 120px;
            height: 120px;
            border-radius: 16px;
            border: 2px dashed #cbd5e1;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8fafc;
            overflow: hidden;
            position: relative;
        }

        .preview-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: none;
        }

        .preview-placeholder {
            color: #94a3b8;
            text-align: center;
            font-size: 0.8rem;
        }

        .btn-submit-action {
            background: linear-gradient(135deg, #059669 0%, #10b981 100%);
            color: white !important;
            font-weight: 600;
            border-radius: 10px;
            padding: 11px 24px;
            border: none;
            box-shadow: 0 4px 14px rgba(16, 185, 129, 0.3);
            transition: all 0.2s ease;
        }

        .btn-submit-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.4);
        }
    </style>
</head>
<body>

    <!-- Thanh điều hướng dùng chung -->
    <jsp:include page="/views/common/topbar.jsp"></jsp:include>

    <div class="container my-4">
        <!-- Breadcrumb điều hướng -->
        <nav aria-label="breadcrumb" class="mb-3">
            <ol class="breadcrumb small">
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/home" class="text-decoration-none text-secondary"><i class="fa-solid fa-gauge me-1"></i>Dashboard</a></li>
                <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/category/list" class="text-decoration-none text-secondary">Danh Mục</a></li>
                <li class="breadcrumb-item active fw-semibold text-success" aria-current="page">Thêm Mới</li>
            </ol>
        </nav>

        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="form-card">
                    <div class="card-header-gradient">
                        <div class="d-flex align-items-center gap-3">
                            <div style="width: 44px; height: 44px; border-radius: 12px; background: rgba(255,255,255,0.2); display: flex; align-items: center; justify-content: center; font-size: 1.2rem;">
                                <i class="fa-solid fa-folder-plus"></i>
                            </div>
                            <div>
                                <h5 class="fw-bold mb-0">Thêm Mới Danh Mục Sản Phẩm</h5>
                                <small class="text-white-50">Tải lên hình ảnh và lưu danh mục vào hệ thống</small>
                            </div>
                        </div>
                    </div>

                    <div class="card-body p-4 p-md-5">
                        <!-- Thông báo lỗi nếu có -->
                        <c:if test="${not empty alert}">
                            <div class="alert alert-danger d-flex align-items-center rounded-3 py-2 px-3 mb-4 shadow-sm" role="alert" style="border-left: 4px solid #ef4444;">
                                <i class="fa-solid fa-circle-exclamation me-2 fs-5 text-danger"></i>
                                <div class="small fw-semibold">${alert}</div>
                            </div>
                        </c:if>

                        <c:url value="/admin/category/add" var="addUrl"/>
                        <form action="${addUrl}" method="post" enctype="multipart/form-data">
                            <!-- Tên danh mục -->
                            <div class="mb-4">
                                <label for="catename" class="form-label fw-bold small text-secondary">
                                    TÊN DANH MỤC <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control input-custom" id="catename" name="catename" 
                                       placeholder="Ví dụ: Giày Dép Cao Cấp, Thời Trang Nữ..." required autofocus>
                                <div class="form-text small text-muted mt-1">Hỗ trợ đầy đủ tiếng Việt có dấu.</div>
                            </div>

                            <!-- Ảnh đại diện và Khung xem trước -->
                            <div class="mb-4">
                                <label for="icon" class="form-label fw-bold small text-secondary">HÌNH ẢNH ĐẠI DIỆN</label>
                                <div class="d-flex align-items-center gap-3">
                                    <div class="preview-box" id="previewContainer">
                                        <div class="preview-placeholder" id="previewText">
                                            <i class="fa-solid fa-cloud-arrow-up fa-2x mb-1 text-secondary opacity-50"></i>
                                            <div>Xem trước</div>
                                        </div>
                                        <img id="imagePreview" alt="Xem trước hình ảnh" />
                                    </div>
                                    <div class="flex-grow-1">
                                        <input type="file" class="form-control input-custom" id="icon" name="icon" accept="image/*" onchange="previewSelectedImage(this)">
                                        <div class="form-text small text-muted mt-1">Hỗ trợ PNG, JPG, JPEG, WEBP. Nếu không chọn, hệ thống tự động gán ảnh mặc định.</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Nút hành động -->
                            <div class="d-flex justify-content-between align-items-center pt-3 border-top mt-4">
                                <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-secondary rounded-3 px-3 py-2 fw-semibold small">
                                    <i class="fa-solid fa-arrow-left me-1"></i>Hủy Bỏ
                                </a>
                                <button type="submit" class="btn-submit-action">
                                    <i class="fa-solid fa-check me-1"></i>Lưu Danh Mục
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function previewSelectedImage(input) {
            const preview = document.getElementById('imagePreview');
            const placeholder = document.getElementById('previewText');
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    preview.src = e.target.result;
                    preview.style.display = 'block';
                    placeholder.style.display = 'none';
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</body>
</html>
