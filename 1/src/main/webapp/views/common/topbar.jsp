<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- Google Fonts: Plus Jakarta Sans -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<style>
    :root {
        --primary-gradient: linear-gradient(135deg, #4f46e5 0%, #3b82f6 100%);
        --primary-color: #4f46e5;
        --secondary-color: #0ea5e9;
        --dark-bg: #0f172a;
        --card-border: rgba(226, 232, 240, 0.8);
    }
    
    body {
        font-family: 'Plus Jakarta Sans', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif !important;
        background-color: #f8fafc;
        color: #1e293b;
        letter-spacing: -0.01em;
    }

    .custom-navbar {
        background: rgba(15, 23, 42, 0.92) !important;
        backdrop-filter: blur(12px);
        -webkit-backdrop-filter: blur(12px);
        border-bottom: 1px solid rgba(255, 255, 255, 0.08);
        transition: all 0.3s ease;
    }

    .navbar-brand-custom {
        display: flex;
        align-items: center;
        gap: 10px;
        font-weight: 800;
        letter-spacing: -0.02em;
        font-size: 1.25rem;
        color: #ffffff !important;
        text-decoration: none;
    }

    .brand-icon-box {
        width: 38px;
        height: 38px;
        border-radius: 10px;
        background: var(--primary-gradient);
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 4px 12px rgba(79, 70, 229, 0.35);
        color: white;
    }

    .nav-link-custom {
        font-size: 0.92rem;
        font-weight: 500;
        color: #94a3b8 !important;
        padding: 8px 14px !important;
        border-radius: 8px;
        transition: all 0.2s ease;
        display: inline-flex;
        align-items: center;
        gap: 6px;
    }

    .nav-link-custom:hover {
        color: #ffffff !important;
        background-color: rgba(255, 255, 255, 0.06);
    }

    .nav-link-custom.active-link {
        color: #ffffff !important;
        background: rgba(79, 70, 229, 0.25);
        border: 1px solid rgba(99, 102, 241, 0.3);
    }

    .user-badge-pill {
        background: rgba(255, 255, 255, 0.06);
        border: 1px solid rgba(255, 255, 255, 0.12);
        border-radius: 50px;
        padding: 6px 14px;
        color: #f1f5f9;
        font-size: 0.88rem;
        display: flex;
        align-items: center;
        gap: 8px;
    }

    .btn-gradient-primary {
        background: var(--primary-gradient);
        border: none;
        color: white !important;
        font-weight: 600;
        border-radius: 8px;
        padding: 7px 18px;
        box-shadow: 0 4px 12px rgba(79, 70, 229, 0.25);
        transition: all 0.2s ease;
    }

    .btn-gradient-primary:hover {
        transform: translateY(-1px);
        box-shadow: 0 6px 16px rgba(79, 70, 229, 0.35);
        opacity: 0.95;
    }

    .btn-outline-glass {
        border: 1px solid rgba(255, 255, 255, 0.2);
        color: #f8fafc !important;
        font-weight: 500;
        border-radius: 8px;
        padding: 6px 16px;
        background: rgba(255, 255, 255, 0.04);
        transition: all 0.2s ease;
    }

    .btn-outline-glass:hover {
        background: rgba(255, 255, 255, 0.12);
        border-color: rgba(255, 255, 255, 0.4);
    }
</style>

<nav class="navbar navbar-expand-lg custom-navbar sticky-top mb-4">
    <div class="container">
        <!-- Logo thương hiệu sang trọng -->
        <a class="navbar-brand-custom" href="${pageContext.request.contextPath}/home">
            <div class="brand-icon-box">
                <i class="fa-solid fa-gem"></i>
            </div>
            <span>Shopping<span style="background: var(--primary-gradient); -webkit-background-clip: text; -webkit-text-fill-color: transparent;">MVC</span></span>
        </a>

        <!-- Nút toggle cho thiết bị di động -->
        <button class="navbar-toggler border-0 text-white" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain"
                aria-controls="navbarMain" aria-expanded="false" aria-label="Toggle navigation">
            <i class="fa-solid fa-bars-staggered text-light"></i>
        </button>

        <div class="collapse navbar-collapse" id="navbarMain">
            <!-- Menu chính -->
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-3 gap-1">
                <li class="nav-item">
                    <a class="nav-link-custom" href="${pageContext.request.contextPath}/home">
                        <i class="fa-solid fa-house-chimney"></i>Trang Chủ
                    </a>
                </li>
                <c:if test="${not empty sessionScope.account and sessionScope.account.roleid == 1}">
                    <li class="nav-item">
                        <a class="nav-link-custom" href="${pageContext.request.contextPath}/admin/home">
                            <i class="fa-solid fa-gauge-high text-warning"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link-custom active-link" href="${pageContext.request.contextPath}/admin/category/list">
                            <i class="fa-solid fa-boxes-stacked text-info"></i>Quản Lý Danh Mục
                        </a>
                    </li>
                </c:if>
                <c:if test="${not empty sessionScope.account and sessionScope.account.roleid == 2}">
                    <li class="nav-item">
                        <a class="nav-link-custom" href="${pageContext.request.contextPath}/manager/home">
                            <i class="fa-solid fa-briefcase text-info"></i>Manager Portal
                        </a>
                    </li>
                </c:if>
            </ul>

            <!-- Khu vực tài khoản / hành động -->
            <ul class="navbar-nav ms-auto align-items-center gap-2">
                <c:choose>
                    <c:when test="${empty sessionScope.account}">
                        <li class="nav-item">
                            <a class="btn-outline-glass btn-sm text-decoration-none" href="${pageContext.request.contextPath}/login">
                                <i class="fa-solid fa-arrow-right-to-bracket me-1"></i>Đăng Nhập
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="btn-gradient-primary btn-sm text-decoration-none" href="${pageContext.request.contextPath}/register">
                                <i class="fa-solid fa-user-plus me-1"></i>Đăng Ký
                            </a>
                        </li>
                    </c:when>
                    <c:otherwise>
                        <li class="nav-item">
                            <div class="user-badge-pill">
                                <i class="fa-solid fa-circle-user text-warning fs-6"></i>
                                <span>Xin chào, <strong class="text-white">${sessionScope.account.fullName}</strong></span>
                                <span class="badge bg-primary rounded-pill px-2 py-1" style="font-size: 0.72rem;">
                                    <c:choose>
                                        <c:when test="${sessionScope.account.roleid == 1}">Admin</c:when>
                                        <c:when test="${sessionScope.account.roleid == 2}">Manager</c:when>
                                        <c:otherwise>Member</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </li>
                        <li class="nav-item">
                            <a class="btn btn-outline-danger btn-sm rounded-3 px-3 py-1 fw-semibold" href="${pageContext.request.contextPath}/logout" title="Đăng xuất khỏi hệ thống">
                                <i class="fa-solid fa-arrow-right-from-bracket me-1"></i>Thoát
                            </a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</nav>
