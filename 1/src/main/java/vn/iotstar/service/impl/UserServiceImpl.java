package vn.iotstar.service.impl;

import vn.iotstar.dao.UserDao;
import vn.iotstar.dao.impl.UserDaoImpl;
import vn.iotstar.model.User;
import vn.iotstar.service.UserService;

/**
 * Lớp triển khai UserServiceImpl - Xử lý nghiệp vụ logic tầng Service
 * 
 * Dự án: Bài Tập Lập Trình Web (HCMUTE - WEBPR330479)
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
public class UserServiceImpl implements UserService {

    private final UserDao userDao;

    public UserServiceImpl() {
        this.userDao = new UserDaoImpl();
    }

    public UserServiceImpl(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public User login(String username, String password) {
        if (username == null || password == null) {
            return null;
        }
        User user = this.get(username);
        if (user != null && password.equals(user.getPassWord())) {
            return user;
        }
        return null;
    }

    @Override
    public User get(String username) {
        if (username == null) {
            return null;
        }
        return userDao.get(username);
    }

    @Override
    public void insert(User user) {
        userDao.insert(user);
    }

    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        if (username == null || userDao.checkExistUsername(username)) {
            return false;
        }
        long millis = System.currentTimeMillis();
        java.sql.Date date = new java.sql.Date(millis);
        // Mặc định roleid = 3 (Người dùng thông thường), avatar = null
        User newUser = new User(email, username, fullname, password, null, 3, phone, date);
        userDao.insert(newUser);
        return true;
    }

    @Override
    public boolean checkExistEmail(String email) {
        if (email == null) {
            return false;
        }
        return userDao.checkExistEmail(email);
    }

    @Override
    public boolean checkExistUsername(String username) {
        if (username == null) {
            return false;
        }
        return userDao.checkExistUsername(username);
    }

    @Override
    public boolean checkExistPhone(String phone) {
        if (phone == null) {
            return false;
        }
        return userDao.checkExistPhone(phone);
    }
}
