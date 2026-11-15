# BÀI TẬP 02: CRUD CATEGORY & VIDEO VỚI JPA 3.0 VÀ JAKARTA 6.0
**Môn học:** Lập Trình Web (WEBPR330479) - Trường ĐH Sư Phạm Kỹ Thuật TP.HCM (HCMUTE)  
**Giảng viên hướng dẫn:** ThS. Nguyễn Hữu Trung  
**Sinh viên thực hiện:** Trương Gia Kiệt - **MSSV:** 24110032  
**Thời gian hoàn thành:** 12/11/2026  

---

## 1. Giới thiệu bài tập
Bài tập 2 hiện thực chức năng quản lý toàn diện danh mục sản phẩm (Category) và Video liên kết với công nghệ **JPA 3.0 (Hibernate ORM 6.6)** và **Jakarta Servlet 6.0** (chuẩn Tomcat 10.1 / 11).

### Các tính năng chính:
- **CRUD Danh mục:** Xem danh sách, thêm mới, sửa đổi, xóa, tìm kiếm theo tên, đếm tổng số lượng, phân trang (`findAll(int page, int pagesize)`).
- **Quản lý Hình ảnh:** Hỗ trợ link ảnh trực tuyến (URL) và tải tệp tin ảnh từ máy tính (`@MultipartConfig`, `Part`), hiển thị ảnh thông qua servlet `/image?fname=...`.
- **Quan hệ 2 chiều (Bidirectional Mapping):** Thiết lập quan hệ `@OneToMany` giữa `Category` và `Video` cùng `@ManyToOne`, hỗ trợ cascade thao tác dữ liệu.
- **Tối ưu hóa Code:** Tích hợp thư viện **Project Lombok** (`@Data`, `@NoArgsConstructor`, `@AllArgsConstructor`) và **Bean Validation** (`@NotEmpty`).
- **Giao diện Quản trị:** Thiết kế chuẩn Bootstrap 5 hiện đại, thân thiện, trực quan.

---

## 2. Cấu trúc mã nguồn Bài 2
```text
2/
├── pom.xml                                      # Quản lý thư viện Maven
└── src/
    └── main/
        ├── java/
        │   └── vn/iotstar/
        │       ├── config/
        │       │   ├── JPAConfig.java           # Quản lý EntityManagerFactory (Singleton)
        │       │   └── Test.java                # Lớp kiểm thử JPA độc lập
        │       ├── entity/
        │       │   ├── Category.java            # Entity Category (Lombok + JPA)
        │       │   └── Video.java               # Entity Video (Lombok + JPA)
        │       ├── dao/
        │       │   ├── ICategoryDao.java        # Interface DAO
        │       │   └── impl/
        │       │       └── CategoryDao.java     # Triển khai DAO với JPA EntityManager
        │       ├── service/
        │       │   ├── ICategoryService.java    # Interface Service
        │       │   └── impl/
        │       │       └── CategoryServiceImpl.java # Triển khai Service
        │       ├── controller/
        │       │   ├── CategoryController.java  # Servlet điều hướng CRUD & upload ảnh
        │       │   └── DownloadImageController.java # Servlet hiển thị hình ảnh
        │       └── util/
        │           └── constants.java           # Hằng số cấu hình thư mục upload
        ├── resources/
        │   └── META-INF/
        │       └── persistence.xml              # Cấu hình kết nối CSDL (MySQL / SQL Server)
        └── webapp/
            ├── WEB-INF/
            │   └── web.xml                      # Cấu hình Web Application
            ├── index.jsp                        # Chuyển hướng mặc định về /admin/categories
            └── views/
                └── admin/
                    ├── category-list.jsp        # Giao diện danh sách danh mục
                    ├── category-add.jsp         # Giao diện thêm mới danh mục
                    └── category-edit.jsp        # Giao diện chỉnh sửa danh mục
```

---

## 3. Hướng dẫn chạy và kiểm thử

### Kiểm thử độc lập với Maven:
```bash
mvn compile exec:java
```

### Đóng gói WAR triển khai trên Tomcat 10.1 / 11:
```bash
mvn clean package
```
File WAR xuất ra tại: `target/24110032_TruongGiaKiet_BT12.11.2026_Bai2.war`.
Truy cập đường dẫn quản trị: `http://localhost:8080/24110032_TruongGiaKiet_BT12.11.2026_Bai2/admin/categories`.
