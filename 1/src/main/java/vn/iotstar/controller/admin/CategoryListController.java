package vn.iotstar.controller.admin;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.Category;
import vn.iotstar.model.User;
import vn.iotstar.service.CategoryService;
import vn.iotstar.service.impl.CategoryServiceImpl;
import vn.iotstar.util.Constant;

/**
 * Controller CategoryListController - Hiển thị danh sách danh mục và tìm kiếm
 * URL Pattern: /admin/category/list
 * Môn học: Lập Trình Web (HCMUTE - WEBPR330479)
 * Giảng viên: ThS. Nguyễn Hữu Trung
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/admin/category/list"})
public class CategoryListController extends HttpServlet {

    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Kiểm tra xác thực phiên đăng nhập và phân quyền Quản trị viên (roleid == 1)
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

        // 2. Nhận từ khóa tìm kiếm (nếu có)
        String keyword = req.getParameter("keyword");
        List<Category> list;
        if (keyword != null && !keyword.trim().isEmpty()) {
            list = categoryService.search(keyword.trim());
        } else {
            list = categoryService.getAll();
        }

        // 3. Đưa danh sách vào request attribute (hỗ trợ cả cateList và categoryList)
        req.setAttribute("cateList", list);
        req.setAttribute("categoryList", list);

        // 4. Chuyển tiếp tới giao diện hiển thị
        req.getRequestDispatcher(Constant.Path.CATEGORY_LIST).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
