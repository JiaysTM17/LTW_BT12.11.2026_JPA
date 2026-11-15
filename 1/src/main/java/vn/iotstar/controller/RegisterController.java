package vn.iotstar.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import vn.iotstar.service.UserService;
import vn.iotstar.service.impl.UserServiceImpl;
import vn.iotstar.util.Constant;

/**
 * RegisterController - Điều khiển chức năng đăng ký tài khoản người dùng
 * 
 * Dự án: Bài Tập Lập Trình Web (HCMUTE - WEBPR330479)
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

    private final UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        if (session != null && session.getAttribute(Constant.SESSION_ACCOUNT) != null) {
            resp.sendRedirect(req.getContextPath() + "/waiting");
            return;
        }
        req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html");
        resp.setCharacterEncoding("UTF-8");
        req.setCharacterEncoding("UTF-8");

        String username = req.getParameter("username");
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String fullname = req.getParameter("fullname");
        String phone = req.getParameter("phone");

        // Kiểm tra dữ liệu rỗng cơ bản
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            req.setAttribute("alert", "Vui lòng nhập đầy đủ tài khoản và mật khẩu!");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        username = username.trim();
        if (email != null) email = email.trim();
        if (fullname != null) fullname = fullname.trim();
        if (phone != null) phone = phone.trim();

        // 1. Kiểm tra trùng email
        if (email != null && !email.isEmpty() && userService.checkExistEmail(email)) {
            req.setAttribute("alert", "Email đã tồn tại!");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        // 2. Kiểm tra trùng tài khoản
        if (userService.checkExistUsername(username)) {
            req.setAttribute("alert", "Tài khoản đã tồn tại!");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
            return;
        }

        // 3. Tiến hành đăng ký
        boolean isSuccess = userService.register(username, password, email, fullname, phone);
        if (isSuccess) {
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            req.setAttribute("alert", "System error!");
            req.getRequestDispatcher(Constant.Path.REGISTER).forward(req, resp);
        }
    }
}
