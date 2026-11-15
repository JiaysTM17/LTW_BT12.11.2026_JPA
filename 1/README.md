# BÀI TẬP 01: CHUYỂN ĐỔI TẦNG DATA SANG CÔNG NGHỆ JPA (HIBERNATE)
**Môn học:** Lập Trình Web (WEBPR330479) - Trường ĐH Sư Phạm Kỹ Thuật TP.HCM (HCMUTE)  
**Giảng viên:** ThS. Nguyễn Hữu Trung  
**Sinh viên thực hiện:** Trương Gia Kiệt - **MSSV:** 24110032  
**Thời gian hoàn thành:** 12/11/2026  

---

## 1. Giới thiệu dự án
Dự án được kế thừa và phát triển từ **Bài tập 01 (09/11/2026)** theo mô hình kiến trúc 3 tầng (Three-Tier Architecture + MVC 2).  
Yêu cầu trọng tâm: **Giữ nguyên toàn bộ tầng Controller, Service và Views (JSP/JSTL), chỉ thay đổi tầng Data Access và Entity Model từ JDBC truyền thống sang công nghệ JPA (Java/Jakarta Persistence API với Hibernate ORM).**

---

## 2. Cấu trúc và Kiến trúc thay đổi
- **Tầng Entity Model (`vn.iotstar.model`):**
  - `User.java`: Ánh xạ bảng `user` bằng JPA Annotations (`@Entity`, `@Table(name = "user")`, `@Id`, `@GeneratedValue`, `@Column`).
  - `Category.java`: Ánh xạ bảng `category` bằng JPA Annotations (`@Entity`, `@Table(name = "category")`, `@NamedQuery(name = "Category.findAll", ...)`).
- **Tầng Cấu hình JPA (`vn.iotstar.config`):**
  - `JpaConfig.java`: Quản lý `EntityManagerFactory` theo mẫu **Singleton Pattern** tránh rò rỉ kết nối (Connection Leak) và tối ưu hóa hiệu năng.
  - `TestJPA.java`: Lớp kiểm thử toàn diện CRUD Category và nghiệp vụ User/Login bằng JPA.
- **Tầng Cấu hình Persistence (`src/main/resources/META-INF`):**
  - `persistence.xml`: Cấu hình 2 Persistence Unit:
    - `jpa-hibernate-mysql`: Kết nối MySQL (`ShoppingServiceMVC` cổng 3306)
    - `jpa-hibernate-sqlserver`: Kết nối Microsoft SQL Server (`ShoppingServiceMVC` / `webst2` cổng 1433)
- **Tầng Data Access (`vn.iotstar.dao.impl`):**
  - `CategoryDaoImpl.java`: Chuyển đổi toàn bộ các phương thức `insert`, `edit`, `delete`, `get`, `getAll`, `search` sang sử dụng `EntityManager`, `EntityTransaction` và `TypedQuery (JPQL)`.
  - `UserDaoImpl.java`: Chuyển đổi `get(username)`, `insert(user)`, `checkExistEmail`, `checkExistUsername`, `checkExistPhone` sang JPA.
- **Tầng Service & Controller & View:**
  - `UserServiceImpl`, `CategoryServiceImpl`, `LoginController`, `RegisterController`, `CategoryController`, `views/...` giữ nguyên 100% logic, đảm bảo tính đóng gói và độc lập giữa các tầng.

---

## 3. Hướng dẫn chạy kiểm thử (Test)

### Cách 1: Chạy trực tiếp kiểm thử JPA bằng Maven Exec Plugin
Mở terminal tại thư mục dự án và chạy:
```bash
mvn compile exec:java
```
Hoặc:
```bash
mvn exec:java -Dexec.mainClass="vn.iotstar.config.TestJPA"
```

### Cách 2: Đóng gói file WAR để triển khai trên Apache Tomcat 10.1 / 11
```bash
mvn clean package
```
File WAR xuất ra tại: `target/24110032_TruongGiaKiet_BT12.11.2026_Bai1.war`.  
Copy file này vào thư mục `webapps` của Apache Tomcat để chạy trên trình duyệt web.
