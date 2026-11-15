package vn.iotstar.util;

import java.io.File;

/**
 * Lớp định nghĩa các hằng số hệ thống và tiện ích đường dẫn
 * Môn: Lập Trình Web - HCMUTE
 */
public class Constant {

    // Thư mục lưu trữ hình ảnh tải lên (ổ D tránh đầy bộ nhớ ổ C)
    public static final String DIR = "D:/upload";
    
    // Alias hỗ trợ tham chiếu tương thích
    public static final String UPLOAD_DIRECTORY = DIR;

    // Tên tệp tin hình ảnh mặc định khi không có hình tải lên
    public static final String DEFAULT_FILENAME = "avata.png";
    public static final String DEFAULT_AVATAR = "avata.png";

    // Hằng số quản lý phiên làm việc (Session) và Cookie Remember Me
    public static final String SESSION_USERNAME = "username";
    public static final String SESSION_ACCOUNT = "account";
    public static final String COOKIE_REMEMBER = "username";
    public static final int COOKIE_MAX_AGE = 30 * 60; // 30 phút (1800 giây)

    public static class Path {
        public static final String LOGIN = "/views/login.jsp";
        public static final String REGISTER = "/views/register.jsp";
        public static final String ADMIN_HOME = "/views/admin/home.jsp";
        public static final String MANAGER_HOME = "/views/manager/home.jsp";
        public static final String HOME = "/views/home.jsp";
        public static final String CATEGORY_LIST = "/views/admin/list-category.jsp";
        public static final String CATEGORY_ADD = "/views/admin/add-category.jsp";
        public static final String CATEGORY_EDIT = "/views/admin/edit-category.jsp";
    }

    // Khối khởi tạo tĩnh đảm bảo thư mục upload luôn sẵn sàng khi chạy ứng dụng
    static {
        ensureUploadDirExists();
    }

    /**
     * Phương thức kiểm tra và tự động khởi tạo thư mục upload nếu chưa tồn tại
     */
    public static void ensureUploadDirExists() {
        File uploadDir = new File(DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs();
        }
        createDefaultImageIfNotExists("avata.png");
        createDefaultImageIfNotExists("default.png");
    }

    private static void createDefaultImageIfNotExists(String filename) {
        File file = new File(DIR + File.separator + filename);
        if (!file.exists()) {
            try {
                byte[] png1x1 = new byte[] {
                    (byte)0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A,
                    0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52,
                    0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
                    0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, (byte)0xC4, (byte)0x89,
                    0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, 0x54,
                    0x78, (byte)0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01,
                    0x0D, 0x0A, 0x2D, (byte)0xB4,
                    0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44,
                    (byte)0xAE, 0x42, 0x60, (byte)0x82
                };
                java.nio.file.Files.write(file.toPath(), png1x1);
            } catch (Exception ignored) {
            }
        }
    }

    /**
     * Phương thức bí danh (alias) tương thích với đặc tả hệ thống
     */
    public static void ensureDirExists() {
        ensureUploadDirExists();
    }

    /**
     * Hàm main hỗ trợ kiểm tra tiện ích đường dẫn upload
     */
    public static void main(String[] args) {
        ensureUploadDirExists();
        System.out.println("Thư mục upload: " + DIR + " | Tồn tại: " + new File(DIR).exists());
    }
}
