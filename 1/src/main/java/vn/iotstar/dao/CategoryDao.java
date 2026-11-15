package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.model.Category;

/**
 * Interface CategoryDao - Định nghĩa các thao tác dữ liệu với bảng [Category]
 * Môn học: Lập Trình Web (HCMUTE - WEBPR330479)
 * Giảng viên: ThS. Nguyễn Hữu Trung
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
public interface CategoryDao {

    /**
     * Thêm một danh mục mới vào cơ sở dữ liệu
     * @param category đối tượng Category cần thêm
     */
    void insert(Category category);

    /**
     * Cập nhật thông tin danh mục theo ID
     * @param category đối tượng Category chứa thông tin mới
     */
    void edit(Category category);

    /**
     * Xóa danh mục khỏi cơ sở dữ liệu theo ID
     * @param id mã danh mục cần xóa
     */
    void delete(int id);

    /**
     * Lấy thông tin chi tiết một danh mục theo mã danh mục (ID)
     * @param id mã danh mục
     * @return đối tượng Category nếu tìm thấy, null nếu không tồn tại
     */
    Category get(int id);

    /**
     * Lấy thông tin danh mục theo tên danh mục
     * @param name tên danh mục
     * @return đối tượng Category nếu tìm thấy, null nếu không tồn tại
     */
    Category get(String name);

    /**
     * Lấy toàn bộ danh sách danh mục trong hệ thống (sắp xếp giảm dần theo cate_id)
     * @return danh sách các đối tượng Category
     */
    List<Category> getAll();

    /**
     * Tìm kiếm danh mục theo từ khóa tên danh mục
     * @param keyword từ khóa tìm kiếm
     * @return danh sách các danh mục phù hợp
     */
    List<Category> search(String keyword);
}
