package vn.iotstar.controller.manager;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;
import vn.iotstar.util.Constant;

/**
 * ManagerHomeController - Điều khiển trang quản lý (/manager/home)
 * Yêu cầu quyền Quản lý (roleid == 2)
 * 
 * Dự án: Bài Tập Lập Trình Web (HCMUTE - WEBPR330479)
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/manager/home"})
public class ManagerHomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute(Constant.SESSION_ACCOUNT) == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);
        if (user.getRoleid() != 2) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        req.getRequestDispatcher(Constant.Path.MANAGER_HOME).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
