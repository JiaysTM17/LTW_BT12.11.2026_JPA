package vn.iotstar.service;

import vn.iotstar.model.User;

/**
 * Interface UserService - Định nghĩa các phương thức xử lý nghiệp vụ người dùng
 * 
 * Dự án: Bài Tập Lập Trình Web (HCMUTE - WEBPR330479)
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
public interface UserService {

    /**
     * Xác thực đăng nhập người dùng bằng tên tài khoản và mật khẩu
     * @param username tên tài khoản
     * @param password mật khẩu
     * @return Đối tượng User nếu đúng thông tin xác thực, ngược lại trả về null
     */
    User login(String username, String password);

    /**
     * Lấy thông tin người dùng theo tên tài khoản
     * @param username tên tài khoản
     * @return Đối tượng User nếu tìm thấy, ngược lại trả về null
     */
    User get(String username);

    /**
     * Thêm mới trực tiếp đối tượng người dùng vào hệ thống
     * @param user đối tượng người dùng
     */
    void insert(User user);

    /**
     * Nghiệp vụ đăng ký tài khoản người dùng mới
     * @param username tên tài khoản
     * @param password mật khẩu
     * @param email địa chỉ email
     * @param fullname họ và tên
     * @param phone số điện thoại
     * @return true nếu đăng ký thành công, false nếu tên tài khoản đã tồn tại
     */
    boolean register(String username, String password, String email, String fullname, String phone);

    /**
     * Kiểm tra sự tồn tại của email
     * @param email địa chỉ email
     * @return true nếu đã có, false nếu chưa
     */
    boolean checkExistEmail(String email);

    /**
     * Kiểm tra sự tồn tại của tên tài khoản
     * @param username tên tài khoản
     * @return true nếu đã có, false nếu chưa
     */
    boolean checkExistUsername(String username);

    /**
     * Kiểm tra sự tồn tại của số điện thoại
     * @param phone số điện thoại
     * @return true nếu đã có, false nếu chưa
     */
    boolean checkExistPhone(String phone);
}
