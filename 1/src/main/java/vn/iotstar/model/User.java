package vn.iotstar.model;

import java.io.Serializable;
import java.sql.Date;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

/**
 * Entity Model User - Đại diện cho thực thể người dùng trong hệ thống (JPA)
 * Ánh xạ với bảng [user] trong cơ sở dữ liệu
 * 
 * Dự án: Bài Tập Lập Trình Web (HCMUTE - WEBPR330479)
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
@SuppressWarnings("serial")
@Entity
@Table(name = "user")
public class User implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private int id;

    @Column(name = "email", length = 255)
    private String email;

    @Column(name = "username", length = 50, nullable = false, unique = true)
    private String userName;

    @Column(name = "fullname", length = 255)
    private String fullName;

    @Column(name = "password", length = 255, nullable = false)
    private String passWord;

    @Column(name = "avatar", length = 255)
    private String avatar;

    @Column(name = "roleid")
    private int roleid;

    @Column(name = "phone", length = 20)
    private String phone;

    @Column(name = "createddate")
    private Date createdDate;

    // Constructor mặc định (no-argument)
    public User() {
        super();
    }

    // Constructor đầy đủ 9 tham số
    public User(int id, String email, String userName, String fullName, String passWord, 
                String avatar, int roleid, String phone, Date createdDate) {
        super();
        this.id = id;
        this.email = email;
        this.userName = userName;
        this.fullName = fullName;
        this.passWord = passWord;
        this.avatar = avatar;
        this.roleid = roleid;
        this.phone = phone;
        this.createdDate = createdDate;
    }

    // Constructor 8 tham số dùng khi đăng ký / tạo mới (id tự tăng)
    public User(String email, String userName, String fullName, String passWord, 
                String avatar, int roleid, String phone, Date createdDate) {
        super();
        this.email = email;
        this.userName = userName;
        this.fullName = fullName;
        this.passWord = passWord;
        this.avatar = avatar;
        this.roleid = roleid;
        this.phone = phone;
        this.createdDate = createdDate;
    }

    // Getters and Setters chuẩn theo slide và JavaBeans
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    // Getter/setter tương thích EL ${account.username}
    public String getUsername() {
        return userName;
    }

    public void setUsername(String username) {
        this.userName = username;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    // Getter/setter tương thích EL ${account.fullname}
    public String getFullname() {
        return fullName;
    }

    public void setFullname(String fullname) {
        this.fullName = fullname;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    // Getter/setter tương thích EL ${account.password}
    public String getPassword() {
        return passWord;
    }

    public void setPassword(String password) {
        this.passWord = password;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public int getRoleid() {
        return roleid;
    }

    public void setRoleid(int roleid) {
        this.roleid = roleid;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    @Override
    public String toString() {
        return "User [id=" + id + ", email=" + email + ", userName=" + userName 
                + ", fullName=" + fullName + ", roleid=" + roleid + ", phone=" + phone 
                + ", createdDate=" + createdDate + "]";
    }
}
