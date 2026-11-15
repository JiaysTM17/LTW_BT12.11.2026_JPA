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
 * LoginController - Điều khiển chức năng đăng nhập và ghi nhớ tài khoản (Remember Me)
 * 
 * Dự án: Bài Tập Lập Trình Web (HCMUTE - WEBPR330479)
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/login"})
public class LoginController extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute(Constant.SESSION_ACCOUNT) != null) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }

        // Kiểm tra xem trình duyệt có lưu Cookie Remember Me không
        Cookie[] cookies = req.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (Constant.COOKIE_REMEMBER.equals(cookie.getName()) && cookie.getValue() != null && !cookie.getValue().isEmpty()) {
                    String username = cookie.getValue();
                    User user = userService.get(username);
                    if (user != null) {
                        session = req.getSession(true);
                        session.setAttribute(Constant.SESSION_ACCOUNT, user);
                        session.setAttribute(Constant.SESSION_USERNAME, user.getUserName());
                        resp.sendRedirect(req.getContextPath() + "/waiting");
                        return;
                    }
                }
            }
        }

        req.getRequestDispatcher(Constant.Path.LOGIN).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String remember = req.getParameter("remember");
        boolean isRememberMe = (remember != null && ("on".equalsIgnoreCase(remember) || "true".equalsIgnoreCase(remember)));

        // Kiểm tra validation rỗng
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("alert", "Tài khoản hoặc mật khẩu không được rỗng");
            req.getRequestDispatcher(Constant.Path.LOGIN).forward(req, resp);
            return;
        }

        username = username.trim();
        User user = userService.login(username, password);

        if (user != null) {
            HttpSession session = req.getSession(true);
            session.setAttribute(Constant.SESSION_ACCOUNT, user);
            session.setAttribute(Constant.SESSION_USERNAME, user.getUserName());

            // Xử lý Remember Me (Cookie 30 phút, path = "/")
            if (isRememberMe) {
                Cookie cookie = new Cookie(Constant.COOKIE_REMEMBER, username);
                cookie.setMaxAge(Constant.COOKIE_MAX_AGE);
                cookie.setPath("/");
                resp.addCookie(cookie);
            }

            resp.sendRedirect(req.getContextPath() + "/waiting");
        } else {
            req.setAttribute("alert", "Tài khoản hoặc mật khẩu không đúng");
            req.getRequestDispatcher(Constant.Path.LOGIN).forward(req, resp);
        }
    }
}
