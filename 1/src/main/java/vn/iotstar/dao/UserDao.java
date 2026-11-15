package vn.iotstar.dao;

import vn.iotstar.model.User;

/**
 * Interface UserDao - Định nghĩa các thao tác dữ liệu với bảng [User]
 * 
 * Dự án: Bài Tập Lập Trình Web (HCMUTE - WEBPR330479)
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
public interface UserDao {

    /**
     * Tìm và trả về thông tin người dùng theo tên đăng nhập
     * @param username tên tài khoản
     * @return Đối tượng User nếu tồn tại, ngược lại trả về null
     */
    User get(String username);

    /**
     * Chèn một bản ghi người dùng mới vào cơ sở dữ liệu
     * @param user đối tượng người dùng cần thêm
     */
    void insert(User user);

    /**
     * Kiểm tra sự tồn tại của email trong hệ thống
     * @param email địa chỉ email cần kiểm tra
     * @return true nếu đã tồn tại, false nếu chưa
     */
    boolean checkExistEmail(String email);

    /**
     * Kiểm tra sự tồn tại của tên tài khoản trong hệ thống
     * @param username tên tài khoản cần kiểm tra
     * @return true nếu đã tồn tại, false nếu chưa
     */
    boolean checkExistUsername(String username);

    /**
     * Kiểm tra sự tồn tại của số điện thoại trong hệ thống
     * @param phone số điện thoại cần kiểm tra
     * @return true nếu đã tồn tại, false nếu chưa
     */
    boolean checkExistPhone(String phone);
}
