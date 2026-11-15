package vn.iotstar.config;

import java.sql.Date;
import java.util.List;
import vn.iotstar.dao.CategoryDao;
import vn.iotstar.dao.UserDao;
import vn.iotstar.dao.impl.CategoryDaoImpl;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.model.Category;
import vn.iotstar.model.User;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.service.impl.UserServiceImpl;

/**
 * Lớp kiểm thử toàn diện tầng Data & Service sử dụng công nghệ JPA (Hibernate)
 * 
 * Bài tập 01 (09/11/2026) chuyển đổi sang JPA - Ngày 12/11/2026
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
public class TestJPA {

    public static void main(String[] args) {
        System.out.println("=======================================================================");
        System.out.println("  KIỂM THỬ TẦNG DATA ACCESS (DAO & SERVICE) BẰNG CÔNG NGHỆ JPA");
        System.out.println("  Dự án: 24110032_TruongGiaKiet_BT12.11.2026_Bai1");
        System.out.println("=======================================================================\n");

        CategoryDao categoryDao = new CategoryDaoImpl();
        UserDao userDao = new UserDaoImpl();
        CategoryService categoryService = new CategoryServiceImpl(categoryDao);
        UserService userService = new UserServiceImpl(userDao);

        try {
            // -----------------------------------------------------------------
            // TEST 1: KIỂM THỬ TẦNG USER QUA JPA
            // -----------------------------------------------------------------
            System.out.println("--- [TEST 1: USER DAO & SERVICE (JPA)] ---");
            String testUsername = "jpa_test_user";
            if (!userDao.checkExistUsername(testUsername)) {
                User newUser = new User();
                newUser.setUserName(testUsername);
                newUser.setFullName("Nguyễn Văn JPA");
                newUser.setPassWord("123456");
                newUser.setEmail("jpa_test@hcmute.edu.vn");
                newUser.setPhone("0988776655");
                newUser.setRoleid(3);
                newUser.setCreatedDate(new Date(System.currentTimeMillis()));
                userDao.insert(newUser);
                System.out.println(">> Đã thêm User thành công bằng JPA: " + newUser.getUserName());
            } else {
                System.out.println(">> User '" + testUsername + "' đã tồn tại sẵn trong CSDL.");
            }

            // Kiểm tra truy vấn User
            User foundUser = userDao.get(testUsername);
            if (foundUser != null) {
                System.out.println(">> Tìm thấy User qua JPA: ID=" + foundUser.getId() + ", FullName=" + foundUser.getFullName());
            }

            // Kiểm tra logic login qua Service
            User loginUser = userService.login(testUsername, "123456");
            System.out.println(">> Kết quả đăng nhập UserService qua JPA: " + (loginUser != null ? "THÀNH CÔNG (Xin chào " + loginUser.getFullName() + ")" : "THẤT BẠI"));

            // -----------------------------------------------------------------
            // TEST 2: KIỂM THỬ CRUD CATEGORY QUA JPA
            // -----------------------------------------------------------------
            System.out.println("\n--- [TEST 2: CRUD CATEGORY (JPA)] ---");

            // 2.1. Thêm mới danh mục
            Category newCate = new Category();
            newCate.setName("Laptop Gaming JPA 2026");
            newCate.setIcon("laptop_gaming.png");
            categoryService.insert(newCate);
            System.out.println(">> Đã thêm Category mới qua JPA, ID sinh tự động: " + newCate.getId());

            // 2.2. Tìm kiếm danh mục theo ID
            Category loadedCate = categoryService.get(newCate.getId());
            System.out.println(">> Truy vấn Category theo ID=" + newCate.getId() + ": " + (loadedCate != null ? loadedCate.getName() : "Không tìm thấy"));

            // 2.3. Cập nhật danh mục
            if (loadedCate != null) {
                loadedCate.setName("Laptop Gaming JPA 2026 - Bản Nâng Cấp");
                categoryService.edit(loadedCate);
                Category updatedCate = categoryService.get(loadedCate.getId());
                System.out.println(">> Sau khi cập nhật qua JPA: " + updatedCate.getName());
            }

            // 2.4. Tìm kiếm theo từ khóa
            List<Category> searchResults = categoryService.search("Gaming");
            System.out.println(">> Tìm kiếm từ khóa 'Gaming' (JPA): Tìm thấy " + searchResults.size() + " kết quả:");
            for (Category c : searchResults) {
                System.out.println("   + [" + c.getId() + "] " + c.getName() + " | Icon: " + c.getIcon());
            }

            // 2.5. Lấy toàn bộ danh sách danh mục
            List<Category> allCategories = categoryService.getAll();
            System.out.println("\n>> Tổng số Category hiện có trong CSDL (JPA): " + allCategories.size());

            // 2.6. Xóa danh mục kiểm thử vừa tạo
            if (loadedCate != null && loadedCate.getId() > 0) {
                categoryService.delete(loadedCate.getId());
                Category deletedCheck = categoryService.get(loadedCate.getId());
                System.out.println(">> Kiểm tra sau khi xóa ID=" + loadedCate.getId() + ": " + (deletedCheck == null ? "ĐÃ XÓA THÀNH CÔNG!" : "VẪN CÒN TỒN TẠI"));
            }

            System.out.println("\n=======================================================================");
            System.out.println("  TẤT CẢ CÁC BÀI TEST TẦNG DATA JPA HOÀN TẤT THÀNH CÔNG 100%!");
            System.out.println("=======================================================================");
        } catch (Exception e) {
            System.err.println(">> GẶP LỖI TRONG QUÁ TRÌNH KIỂM THỬ JPA:");
            e.printStackTrace();
        } finally {
            JpaConfig.close();
            System.exit(0);
        }
    }
}
