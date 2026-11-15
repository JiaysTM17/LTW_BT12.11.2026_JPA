package vn.iotstar.connection;

import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 * DBConnection - Lớp quản lý kết nối cơ sở dữ liệu (Hỗ trợ cả MySQL và SQL Server)
 * 
 * Dự án: Bài Tập Lập Trình Web (HCMUTE - WEBPR330479)
 * Giảng viên: ThS. Nguyễn Hữu Trung
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
public class DBConnection {

    // Cấu hình thông số kết nối CSDL
    private static final String SERVER_NAME = "localhost";
    private static final String DB_NAME = "ShoppingServiceMVC";

    /**
     * Phương thức tĩnh lấy kết nối tới cơ sở dữ liệu.
     * Tự động nhận diện và kết nối MySQL (cổng 3306) hoặc SQL Server (cổng 1433).
     * 
     * @return Connection đối tượng kết nối đang mở
     * @throws Exception khi kết nối CSDL thất bại
     */
    public static Connection getConnection() throws Exception {
        // 1. Kết nối MySQL (cổng 3306)
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String mysqlUrl = "jdbc:mysql://" + SERVER_NAME + ":3306/" + DB_NAME 
                    + "?useSSL=false&allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Ho_Chi_Minh";
            for (String pass : new String[]{"123456", "root", "123", ""}) {
                try {
                    return DriverManager.getConnection(mysqlUrl, "root", pass);
                } catch (SQLException ignored) {}
            }
        } catch (Exception ignored) {}

        // 2. Kết nối Microsoft SQL Server (cổng 1433)
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            String sqlServerUrl = "jdbc:sqlserver://" + SERVER_NAME + ":1433"
                    + ";databaseName=" + DB_NAME
                    + ";encrypt=true;trustServerCertificate=true;characterEncoding=UTF-8";
            for (String pass : new String[]{"123", "123456", "1234@a$"}) {
                try {
                    return DriverManager.getConnection(sqlServerUrl, "sa", pass);
                } catch (SQLException ignored) {}
            }
        } catch (Exception ignored) {}

        throw new SQLException("Không thể kết nối cơ sở dữ liệu MySQL (3306) hoặc SQL Server (1433).");
    }

    /**
     * Phương thức chuẩn hóa câu lệnh SQL tương thích giữa MySQL và SQL Server
     */
    public static PreparedStatement prepareStatement(Connection conn, String sql) throws SQLException {
        if (conn != null && sql != null) {
            String dbProduct = conn.getMetaData().getDatabaseProductName().toLowerCase();
            if (dbProduct.contains("mysql")) {
                sql = sql.replace("[User]", "User").replace("[user]", "User")
                         .replace("[Category]", "Category").replace("[category]", "Category");
            }
        }
        return conn.prepareStatement(sql);
    }

    /**
     * Phương thức instance lấy kết nối CSDL, ủy quyền gọi sang getConnection().
     */
    public Connection getDatabaseConnection() {
        try {
            return getConnection();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Phương thức kiểm tra độc lập kết nối JDBC
     */
    public static void main(String[] args) {
        System.out.println("Kiểm tra kết nối CSDL...");
        try (Connection conn = getConnection()) {
            if (conn != null && !conn.isClosed()) {
                DatabaseMetaData meta = conn.getMetaData();
                System.out.println(">> KẾT NỐI THÀNH CÔNG!");
                System.out.println("- Hệ quản trị:    " + meta.getDatabaseProductName());
                System.out.println("- Phiên bản:      " + meta.getDatabaseProductVersion());
                System.out.println("- Database:       " + conn.getCatalog());
            }
        } catch (Exception e) {
            System.err.println(">> LỖI KẾT NỐI:");
            e.printStackTrace();
        }
    }
}
