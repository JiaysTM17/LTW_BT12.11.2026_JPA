<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chỉnh Sửa Danh Mục - Edit Category</title>
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
            background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%);
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
            border-color: #f59e0b;
            box-shadow: 0 0 0 4px rgba(245, 158, 11, 0.15);
        }

        .current-img-box {
            width: 100px;
            height: 100px;
            border-radius: 16px;
            border: 2px solid #e2e8f0;
            object-fit: cover;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.06);
        }

        .preview-box {
            width: 100px;
            height: 100px;
            border-radius: 16px;
            border: 2px dashed #cbd5e1;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: #f8fafc;
            overflow: hidden;
        }

        .preview-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: none;
        }

        .btn-submit-action {
            background: linear-gradient(135deg, #4f46e5 0%, #3b82f6 100%);
            color: white !important;
            font-weight: 600;
            border-radius: 10px;
            padding: 11px 24px;
            border: none;
            box-shadow: 0 4px 14px rgba(79, 70, 229, 0.3);
            transition: all 0.2s ease;
        }

        .btn-submit-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(79, 70, 229, 0.4);
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
                <li class="breadcrumb-item active fw-semibold text-warning" aria-current="page">Chỉnh Sửa #${category.id}</li>
            </ol>
        </nav>

        <div class="row justify-content-center">
            <div class="col-md-8 col-lg-6">
                <div class="form-card">
                    <div class="card-header-gradient">
                        <div class="d-flex align-items-center gap-3">
                            <div style="width: 44px; height: 44px; border-radius: 12px; background: rgba(255,255,255,0.2); display: flex; align-items: center; justify-content: center; font-size: 1.2rem;">
                                <i class="fa-solid fa-pen-to-square"></i>
                            </div>
                            <div>
                                <h5 class="fw-bold mb-0">Chỉnh Sửa Danh Mục Sản Phẩm</h5>
                                <small class="text-white-50">Cập nhật tên hoặc hình ảnh đại diện của danh mục</small>
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

                        <c:url value="/admin/category/edit" var="editUrl"/>
                        <form action="${editUrl}" method="post" enctype="multipart/form-data">
                            <!-- Mã ID ẩn -->
                            <input type="hidden" name="id" value="${category.id}" />

                            <!-- Tên danh mục -->
                            <div class="mb-4">
                                <label for="catename" class="form-label fw-bold small text-secondary">
                                    TÊN DANH MỤC <span class="text-danger">*</span>
                                </label>
                                <input type="text" class="form-control input-custom" id="catename" name="catename" 
                                       value="${category.name}" required autofocus>
                            </div>

                            <!-- Hiển thị ảnh hiện tại -->
                            <div class="mb-4">
                                <label class="form-label fw-bold small text-secondary d-block">HÌNH ẢNH HIỆN TẠI</label>
                                <c:url value="/image?fname=${category.icon}" var="imgUrl"/>
                                <div class="d-flex align-items-center gap-3 p-3 bg-light rounded-4 border">
                                    <img src="${imgUrl}" alt="${category.name}" class="current-img-box" />
                                    <div>
                                        <div class="fw-bold text-dark text-truncate" style="max-width: 250px;">${category.icon}</div>
                                        <small class="text-muted d-block">Ảnh đang sử dụng trên hệ thống</small>
                                        <span class="badge bg-success-subtle text-success border border-success-subtle mt-1">Đang kích hoạt</span>
                                    </div>
                                </div>
                            </div>

                            <!-- Chọn ảnh mới thay thế (tùy chọn) -->
                            <div class="mb-4">
                                <label for="icon" class="form-label fw-bold small text-secondary">CHỌN ẢNH MỚI (TÙY CHỌN)</label>
                                <div class="d-flex align-items-center gap-3">
                                    <div class="preview-box" id="newPreviewContainer">
                                        <div class="text-muted small text-center" id="newPreviewText" style="font-size: 0.75rem;">
                                            <i class="fa-solid fa-image text-secondary mb-1"></i>
                                            <div>Ảnh mới</div>
                                        </div>
                                        <img id="newImagePreview" alt="Ảnh mới tải lên" />
                                    </div>
                                    <div class="flex-grow-1">
                                        <input type="file" class="form-control input-custom" id="icon" name="icon" accept="image/*" onchange="previewNewImage(this)">
                                        <div class="form-text small text-muted mt-1">Nếu không chọn ảnh mới, hệ thống sẽ giữ nguyên ảnh hiện tại. Khi đổi ảnh, tệp cũ sẽ tự động được xóa an toàn khỏi ổ đĩa.</div>
                                    </div>
                                </div>
                            </div>

                            <!-- Nút hành động -->
                            <div class="d-flex justify-content-between align-items-center pt-3 border-top mt-4">
                                <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-secondary rounded-3 px-3 py-2 fw-semibold small">
                                    <i class="fa-solid fa-arrow-left me-1"></i>Hủy Bỏ
                                </a>
                                <button type="submit" class="btn-submit-action">
                                    <i class="fa-solid fa-floppy-disk me-1"></i>Lưu Thay Đổi
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
        function previewNewImage(input) {
            const preview = document.getElementById('newImagePreview');
            const placeholder = document.getElementById('newPreviewText');
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
