package vn.iotstar.service;

import java.util.List;
import vn.iotstar.model.Category;

/**
 * Interface CategoryService - Định nghĩa các nghiệp vụ quản lý danh mục sản phẩm
 * Môn học: Lập Trình Web (HCMUTE - WEBPR330479)
 * Giảng viên: ThS. Nguyễn Hữu Trung
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
public interface CategoryService {

    /**
     * Thêm danh mục mới vào hệ thống
     * @param category đối tượng danh mục
     */
    void insert(Category category);

    /**
     * Cập nhật thông tin danh mục, tự động xóa tệp ảnh cũ trên ổ đĩa nếu thay ảnh mới
     * @param category đối tượng danh mục mới
     */
    void edit(Category category);

    /**
     * Phương thức bí danh (alias) tương thích với Slide 24
     * @param category đối tượng danh mục
     */
    void update(Category category);

    /**
     * Xóa danh mục và dọn dẹp tệp ảnh đại diện tương ứng trên ổ đĩa
     * @param id mã danh mục cần xóa
     */
    void delete(int id);

    /**
     * Lấy thông tin danh mục theo ID
     * @param id mã danh mục
     * @return đối tượng Category hoặc null nếu không tồn tại
     */
    Category get(int id);

    /**
     * Phương thức bí danh (alias) tương thích với Slide 23
     * @param id mã danh mục
     * @return đối tượng Category hoặc null nếu không tồn tại
     */
    Category findById(int id);

    /**
     * Lấy thông tin danh mục theo tên
     * @param name tên danh mục
     * @return đối tượng Category hoặc null nếu không tồn tại
     */
    Category get(String name);

    /**
     * Lấy toàn bộ danh sách danh mục
     * @return danh sách Category
     */
    List<Category> getAll();

    /**
     * Tìm kiếm danh mục theo từ khóa
     * @param keyword từ khóa tìm kiếm
     * @return danh sách Category phù hợp
     */
    List<Category> search(String keyword);
}
