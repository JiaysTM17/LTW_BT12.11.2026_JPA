<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản Lý Danh Mục - Admin Category Management</title>
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

        .page-header-card {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid rgba(226, 232, 240, 0.8);
            box-shadow: 0 4px 20px -2px rgba(15, 23, 42, 0.05);
            padding: 24px 28px;
            margin-bottom: 24px;
        }

        .table-card {
            background: #ffffff;
            border-radius: 16px;
            border: 1px solid rgba(226, 232, 240, 0.8);
            box-shadow: 0 10px 25px -5px rgba(15, 23, 42, 0.05);
            overflow: hidden;
        }

        .custom-table {
            margin-bottom: 0;
        }

        .custom-table thead th {
            background-color: #0f172a;
            color: #f8fafc;
            font-size: 0.82rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.05em;
            padding: 16px 20px;
            border: none;
        }

        .custom-table tbody td {
            padding: 16px 20px;
            vertical-align: middle;
            border-bottom: 1px solid #f1f5f9;
            font-size: 0.94rem;
        }

        .custom-table tbody tr {
            transition: all 0.2s ease;
        }

        .custom-table tbody tr:hover {
            background-color: #f1f5f9;
        }

        .cate-img-thumbnail {
            width: 60px;
            height: 60px;
            object-fit: cover;
            border-radius: 12px;
            border: 2px solid #ffffff;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.08);
            transition: transform 0.2s ease;
        }

        .cate-img-thumbnail:hover {
            transform: scale(1.1);
        }

        .btn-action-edit {
            background-color: #fef3c7;
            color: #b45309;
            border: 1px solid #fde68a;
            border-radius: 8px;
            padding: 6px 14px;
            font-weight: 600;
            font-size: 0.85rem;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .btn-action-edit:hover {
            background-color: #fde68a;
            color: #92400e;
            transform: translateY(-1px);
        }

        .btn-action-delete {
            background-color: #fee2e2;
            color: #b91c1c;
            border: 1px solid #fecaca;
            border-radius: 8px;
            padding: 6px 14px;
            font-weight: 600;
            font-size: 0.85rem;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .btn-action-delete:hover {
            background-color: #fecaca;
            color: #991b1b;
            transform: translateY(-1px);
        }

        .btn-add-primary {
            background: linear-gradient(135deg, #059669 0%, #10b981 100%);
            color: white !important;
            font-weight: 600;
            border-radius: 10px;
            padding: 10px 20px;
            border: none;
            box-shadow: 0 4px 14px rgba(16, 185, 129, 0.3);
            transition: all 0.2s ease;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            text-decoration: none;
        }

        .btn-add-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.4);
            opacity: 0.95;
        }

        .search-box-custom {
            border-radius: 10px;
            border: 1.5px solid #e2e8f0;
            padding: 10px 16px;
            font-size: 0.92rem;
            transition: all 0.2s ease;
        }

        .search-box-custom:focus {
            border-color: #4f46e5;
            box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.12);
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
                <li class="breadcrumb-item active fw-semibold text-primary" aria-current="page">Quản Lý Danh Mục</li>
            </ol>
        </nav>

        <!-- Khung tiêu đề và hành động -->
        <div class="page-header-card">
            <div class="d-flex flex-wrap justify-content-between align-items-center gap-3">
                <div>
                    <h3 class="fw-bold mb-1" style="letter-spacing: -0.02em;">
                        <i class="fa-solid fa-boxes-stacked text-primary me-2"></i>Danh Mục Sản Phẩm
                    </h3>
                    <p class="text-muted small mb-0">Quản lý các danh mục hàng hóa, tải ảnh đại diện và tìm kiếm nhanh</p>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/admin/category/add" class="btn-add-primary">
                        <i class="fa-solid fa-plus-circle"></i>Thêm Danh Mục Mới
                    </a>
                </div>
            </div>

            <!-- Thanh tìm kiếm danh mục -->
            <div class="row mt-4">
                <div class="col-md-6 col-lg-5">
                    <form action="${pageContext.request.contextPath}/admin/category/list" method="get" class="d-flex gap-2">
                        <div class="input-group">
                            <span class="input-group-text bg-white border-end-0 text-muted" style="border-radius: 10px 0 0 10px; border-color: #e2e8f0;">
                                <i class="fa-solid fa-magnifying-glass"></i>
                            </span>
                            <input type="text" name="keyword" value="${param.keyword}" class="form-control border-start-0 search-box-custom ps-0" placeholder="Tìm theo tên danh mục..." style="border-radius: 0 10px 10px 0;" />
                        </div>
                        <button type="submit" class="btn btn-primary px-3 fw-semibold rounded-3">Tìm</button>
                        <c:if test="${not empty param.keyword}">
                            <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-secondary rounded-3" title="Xóa bộ lọc">
                                <i class="fa-solid fa-rotate-left"></i>
                            </a>
                        </c:if>
                    </form>
                </div>
            </div>
        </div>

        <!-- Bảng danh sách danh mục -->
        <div class="table-card">
            <div class="table-responsive">
                <table class="table custom-table">
                    <thead>
                        <tr>
                            <th scope="col" class="text-center" style="width: 70px;">STT</th>
                            <th scope="col" class="text-center" style="width: 120px;">Hình Ảnh</th>
                            <th scope="col">Tên Danh Mục Sản Phẩm</th>
                            <th scope="col" class="text-center" style="width: 220px;">Thao Tác</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty cateList}">
                                <c:forEach items="${cateList}" var="cate" varStatus="STT">
                                    <tr>
                                        <!-- STT -->
                                        <td class="text-center fw-bold text-secondary">${STT.index + 1}</td>

                                        <!-- Hình ảnh -->
                                        <td class="text-center py-2">
                                            <c:url value="/image?fname=${cate.icon}" var="imgUrl"/>
                                            <img src="${imgUrl}" alt="${cate.name}" class="cate-img-thumbnail" />
                                        </td>

                                        <!-- Tên danh mục -->
                                        <td>
                                            <div class="fw-bold text-dark fs-6">${cate.name}</div>
                                            <div class="d-flex align-items-center gap-2 mt-1">
                                                <span class="badge bg-light text-secondary border">Mã ID: #${cate.id}</span>
                                                <span class="text-muted small"><i class="fa-regular fa-image me-1"></i>${cate.icon}</span>
                                            </div>
                                        </td>

                                        <!-- Thao tác Sửa / Xóa -->
                                        <td class="text-center">
                                            <a href="${pageContext.request.contextPath}/admin/category/edit?id=${cate.id}" class="btn-action-edit me-1">
                                                <i class="fa-regular fa-pen-to-square"></i>Sửa
                                            </a>
                                            <a href="${pageContext.request.contextPath}/admin/category/delete?id=${cate.id}" class="btn-action-delete" 
                                               onclick="return confirm('Bạn có chắc chắn muốn xóa danh mục [${cate.name}] không?');">
                                                <i class="fa-regular fa-trash-can"></i>Xóa
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="4" class="text-center text-muted py-5">
                                        <i class="fa-solid fa-box-open fa-3x mb-3 text-secondary opacity-50 d-block"></i>
                                        <h6 class="fw-bold text-secondary">Không tìm thấy danh mục nào phù hợp!</h6>
                                        <p class="small text-muted mb-3">Hãy thử tìm từ khóa khác hoặc bấm nút thêm danh mục mới bên trên.</p>
                                        <a href="${pageContext.request.contextPath}/admin/category/list" class="btn btn-outline-primary btn-sm rounded-3">
                                            Xem tất cả danh mục
                                        </a>
                                    </td>
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>

            <!-- Footer thống kê -->
            <div class="p-3 bg-white border-top d-flex justify-content-between align-items-center text-secondary small">
                <div>
                    Tổng số danh mục: <strong class="text-dark">${not empty cateList ? cateList.size() : 0}</strong>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/admin/home" class="text-decoration-none fw-semibold" style="color: #4f46e5;">
                        <i class="fa-solid fa-arrow-left me-1"></i>Quay lại Dashboard
                    </a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap 5 JS Bundle -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
