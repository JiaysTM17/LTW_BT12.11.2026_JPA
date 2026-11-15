package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.util.Constant;

/**
 * LogoutController - Xử lý đăng xuất, hủy phiên làm việc (Session) và xóa Cookie Remember Me
 * 
 * Dự án: Bài Tập Lập Trình Web (HCMUTE - WEBPR330479)
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/logout"})
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Hủy phiên làm việc (Session)
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.removeAttribute(Constant.SESSION_ACCOUNT);
            session.removeAttribute(Constant.SESSION_USERNAME);
            session.invalidate();
        }

        // 2. Xóa Cookie Remember Me trên trình duyệt client
        Cookie cookie = new Cookie(Constant.COOKIE_REMEMBER, "");
        cookie.setMaxAge(0);
        cookie.setPath("/");
        resp.addCookie(cookie);

        // 3. Chuyển hướng người dùng về trang đăng nhập
        resp.sendRedirect(req.getContextPath() + "/login");
    }
}
