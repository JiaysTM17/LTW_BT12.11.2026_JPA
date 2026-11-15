package vn.iotstar.model;

import java.io.Serializable;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;

/**
 * Entity Model Category - Thực thể biểu diễn danh mục sản phẩm (JPA)
 * Môn học: Lập Trình Web (HCMUTE - WEBPR330479)
 * Giảng viên: ThS. Nguyễn Hữu Trung
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
@Entity
@Table(name = "category")
@NamedQuery(name = "Category.findAll", query = "SELECT c FROM Category c ORDER BY c.cateid DESC")
public class Category implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "cate_id")
    private int cateid;

    @Column(name = "cate_name", length = 255, nullable = false)
    private String catename;

    @Column(name = "icons", length = 255)
    private String icon;

    // 1. Constructors
    public Category() {
        super();
    }

    public Category(int cateid, String catename, String icon) {
        super();
        this.cateid = cateid;
        this.catename = catename;
        this.icon = icon;
    }

    public Category(String catename, String icon) {
        super();
        this.catename = catename;
        this.icon = icon;
    }

    // 2. Getters & Setters cho cateid & id (Tương thích EL: ${cate.id} và ${cate.cateid})
    public int getCateid() {
        return cateid;
    }

    public void setCateid(int cateid) {
        this.cateid = cateid;
    }

    public int getCateId() {
        return cateid;
    }

    public void setCateId(int cateid) {
        this.cateid = cateid;
    }

    public int getId() {
        return cateid;
    }

    public void setId(int id) {
        this.cateid = id;
    }

    // 3. Getters & Setters cho catename & name (Tương thích EL: ${cate.name} và ${cate.catename})
    public String getCatename() {
        return catename;
    }

    public void setCatename(String catename) {
        this.catename = catename;
    }

    public String getCateName() {
        return catename;
    }

    public void setCateName(String catename) {
        this.catename = catename;
    }

    public String getName() {
        return catename;
    }

    public void setName(String name) {
        this.catename = name;
    }

    // 4. Getters & Setters cho icon & icons (Tương thích EL: ${cate.icon} và ${cate.icons})
    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getIcons() {
        return icon;
    }

    public void setIcons(String icons) {
        this.icon = icons;
    }

    @Override
    public String toString() {
        return "Category [cateid=" + cateid + ", catename=" + catename + ", icon=" + icon + "]";
    }
}
