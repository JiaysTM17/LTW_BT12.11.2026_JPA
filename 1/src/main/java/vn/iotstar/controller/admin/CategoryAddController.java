package vn.iotstar.controller.admin;

import java.io.File;
import java.io.IOException;
import java.nio.file.Paths;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import vn.iotstar.model.Category;
import vn.iotstar.model.User;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.util.Constant;

/**
 * Controller CategoryAddController - Thêm mới danh mục với tải lên tệp tin hình ảnh
 * URL Pattern: /admin/category/add
 * Môn học: Lập Trình Web (HCMUTE - WEBPR330479)
 * Giảng viên: ThS. Nguyễn Hữu Trung
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/admin/category/add"})
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB
    maxFileSize = 1024 * 1024 * 10,       // 10MB
    maxRequestSize = 1024 * 1024 * 50     // 50MB
)
public class CategoryAddController extends HttpServlet {

    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra xác thực phiên đăng nhập và phân quyền Quản trị viên
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute(Constant.SESSION_ACCOUNT) == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (user.getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        req.getRequestDispatcher(Constant.Path.CATEGORY_ADD).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra quyền Quản trị viên
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute(Constant.SESSION_ACCOUNT) == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (user.getRoleid() != 1) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        String catename = req.getParameter("catename");
        if (catename == null || catename.trim().isEmpty()) {
            req.setAttribute("alert", "Tên danh mục không được để trống!");
            req.getRequestDispatcher(Constant.Path.CATEGORY_ADD).forward(req, resp);
            return;
        }

        Constant.ensureUploadDirExists();

        // Đọc phần tệp tin upload (ưu tiên 'icon', hỗ trợ dự phòng 'images')
        Part part = req.getPart("icon");
        if (part == null || part.getSize() == 0) {
            part = req.getPart("images");
        }

        String fileName = Constant.DEFAULT_FILENAME;
        if (part != null && part.getSize() > 0 && part.getSubmittedFileName() != null && !part.getSubmittedFileName().trim().isEmpty()) {
            String originalFilename = Paths.get(part.getSubmittedFileName()).getFileName().toString();
            int dotIndex = originalFilename.lastIndexOf('.');
            String ext = (dotIndex >= 0) ? originalFilename.substring(dotIndex + 1) : "png";
            fileName = System.currentTimeMillis() + "." + ext;
            part.write(Constant.DIR + File.separator + fileName);
        }

        Category category = new Category();
        category.setName(catename.trim());
        category.setIcon(fileName);

        categoryService.insert(category);
        resp.sendRedirect(req.getContextPath() + "/admin/category/list");
    }
}
