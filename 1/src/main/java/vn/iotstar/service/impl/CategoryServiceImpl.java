package vn.iotstar.service.impl;

import java.io.File;
import java.util.List;
import vn.iotstar.dao.CategoryDao;
import vn.iotstar.dao.impl.CategoryDaoImpl;
import vn.iotstar.model.Category;
import vn.iotstar.service.CategoryService;
import vn.iotstar.util.Constant;

/**
 * Lớp triển khai CategoryServiceImpl - Quản lý nghiệp vụ danh mục và dọn dẹp tập tin hình ảnh
 * Môn học: Lập Trình Web (HCMUTE - WEBPR330479)
 * Giảng viên: ThS. Nguyễn Hữu Trung
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
public class CategoryServiceImpl implements CategoryService {

    private CategoryDao categoryDao;

    public CategoryServiceImpl() {
        this.categoryDao = new CategoryDaoImpl();
    }

    public CategoryServiceImpl(CategoryDao categoryDao) {
        this.categoryDao = categoryDao;
    }

    @Override
    public void insert(Category category) {
        categoryDao.insert(category);
    }

    @Override
    public void edit(Category newCategory) {
        Category oldCategory = categoryDao.get(newCategory.getId());
        if (oldCategory == null) {
            return;
        }

        // Xử lý tệp tin ảnh khi cập nhật
        if (newCategory.getIcon() != null && !newCategory.getIcon().trim().isEmpty()) {
            String oldIcon = oldCategory.getIcon();
            // Nếu người dùng upload ảnh mới khác ảnh cũ thì xóa tệp ảnh cũ trên đĩa
            if (oldIcon != null && !oldIcon.trim().isEmpty() && !oldIcon.equals(newCategory.getIcon())) {
                deletePhysicalImage(oldIcon);
            }
        } else {
            // Người dùng không upload ảnh mới -> giữ lại ảnh cũ
            newCategory.setIcon(oldCategory.getIcon());
        }

        categoryDao.edit(newCategory);
    }

    @Override
    public void update(Category category) {
        edit(category);
    }

    @Override
    public void delete(int id) {
        Category oldCategory = categoryDao.get(id);
        if (oldCategory != null) {
            String oldIcon = oldCategory.getIcon();
            if (oldIcon != null && !oldIcon.trim().isEmpty()) {
                deletePhysicalImage(oldIcon);
            }
        }
        categoryDao.delete(id);
    }

    @Override
    public Category get(int id) {
        return categoryDao.get(id);
    }

    @Override
    public Category findById(int id) {
        return get(id);
    }

    @Override
    public Category get(String name) {
        return categoryDao.get(name);
    }

    @Override
    public List<Category> getAll() {
        return categoryDao.getAll();
    }

    @Override
    public List<Category> search(String keyword) {
        return categoryDao.search(keyword);
    }

    /**
     * Tiện ích xóa tệp hình ảnh vật lý trên ổ đĩa.
     * BẢO VỆ: Tuyệt đối không xóa các hình ảnh mặc định hệ thống như avata.png hoặc default.png.
     * 
     * @param fileName tên tệp hình ảnh cần xóa
     */
    private void deletePhysicalImage(String fileName) {
        if (fileName == null || fileName.trim().isEmpty()) {
            return;
        }
        // Không xóa ảnh mặc định của hệ thống
        if (fileName.equalsIgnoreCase("avata.png") 
                || fileName.equalsIgnoreCase("default.png") 
                || fileName.equalsIgnoreCase(Constant.DEFAULT_FILENAME)
                || fileName.equalsIgnoreCase(Constant.DEFAULT_AVATAR)) {
            return;
        }

        try {
            File file = new File(Constant.DIR + File.separator + fileName);
            if (file.exists() && file.isFile()) {
                file.delete();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
