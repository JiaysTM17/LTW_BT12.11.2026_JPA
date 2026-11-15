package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.model.User;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

/**
 * WaitingController - Điều phối và phân quyền người dùng sau đăng nhập
 * - roleid == 1 -> /admin/home
 * - roleid == 2 -> /manager/home
 * - roleid khác -> /home
 * - Chưa đăng nhập -> /login
 * 
 * Dự án: Bài Tập Lập Trình Web (HCMUTE - WEBPR330479)
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/waiting"})
public class WaitingController extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User user = null;

        if (session != null) {
            user = (User) session.getAttribute(Constant.SESSION_ACCOUNT);

            // Nếu chưa có account trong session nhưng có username
            if (user == null && session.getAttribute(Constant.SESSION_USERNAME) != null) {
                String username = (String) session.getAttribute(Constant.SESSION_USERNAME);
                user = userService.get(username);
                if (user != null) {
                    session.setAttribute(Constant.SESSION_ACCOUNT, user);
                }
            }
        }

        // Nếu session không có, kiểm tra thêm Cookie Remember Me
        if (user == null) {
            Cookie[] cookies = req.getCookies();
            if (cookies != null) {
                for (Cookie cookie : cookies) {
                    if (Constant.COOKIE_REMEMBER.equals(cookie.getName()) && cookie.getValue() != null && !cookie.getValue().isEmpty()) {
                        user = userService.get(cookie.getValue());
                        if (user != null) {
                            if (session == null) {
                                session = req.getSession(true);
                            }
                            session.setAttribute(Constant.SESSION_ACCOUNT, user);
                            session.setAttribute(Constant.SESSION_USERNAME, user.getUserName());
                            break;
                        }
                    }
                }
            }
        }

        // Kiểm tra sau khi nạp: nếu vẫn chưa có thì redirect về /login
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // Điều hướng theo vai trò (roleid)
        if (user.getRoleid() == 1) {
            resp.sendRedirect(req.getContextPath() + "/admin/home");
        } else if (user.getRoleid() == 2) {
            resp.sendRedirect(req.getContextPath() + "/manager/home");
        } else {
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}
