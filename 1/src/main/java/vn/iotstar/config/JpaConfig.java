package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

/**
 * Lớp cấu hình JPA - Quản lý EntityManagerFactory theo mẫu thiết kế Singleton
 * 
 * Dự án: Bài Tập Lập Trình Web (HCMUTE - WEBPR330479)
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
public class JpaConfig {

    private static EntityManagerFactory factory;

    static {
        try {
            // Mặc định kết nối MySQL (ShoppingServiceMVC cổng 3306)
            factory = Persistence.createEntityManagerFactory("jpa-hibernate-mysql");
        } catch (Throwable ex) {
            System.err.println(">> Cảnh báo: Không thể kết nối MySQL, thử chuyển sang cấu hình SQL Server: " + ex.getMessage());
            try {
                factory = Persistence.createEntityManagerFactory("jpa-hibernate-sqlserver");
            } catch (Throwable e2) {
                System.err.println(">> Lỗi khởi tạo EntityManagerFactory: " + e2.getMessage());
                e2.printStackTrace();
            }
        }
    }

    /**
     * Lấy EntityManager từ EntityManagerFactory dùng chung
     */
    public static EntityManager getEntityManager() {
        if (factory == null || !factory.isOpen()) {
            try {
                factory = Persistence.createEntityManagerFactory("jpa-hibernate-mysql");
            } catch (Throwable ex) {
                factory = Persistence.createEntityManagerFactory("jpa-hibernate-sqlserver");
            }
        }
        return factory.createEntityManager();
    }

    /**
     * Đóng EntityManagerFactory khi tắt ứng dụng
     */
    public static void close() {
        if (factory != null && factory.isOpen()) {
            factory.close();
        }
    }
}
