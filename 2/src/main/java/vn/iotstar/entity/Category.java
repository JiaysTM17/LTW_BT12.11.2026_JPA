package vn.iotstar.entity;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotEmpty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Entity Category - Quản lý danh mục sản phẩm (JPA 3.0 & Jakarta 6.0)
 * 
 * Bài tập 2 (12/11/2026) - HCMUTE
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
@Table(name = "categories")
@NamedQuery(name = "Category.findAll", query = "SELECT c FROM Category c")
public class Category implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "CategoryId")
    private int categoryid;

    @Column(name = "CategoryName", columnDefinition = "nvarchar(50) not null")
    @NotEmpty(message = "Không được phép rỗng")
    private String categoryname;

    @Column(name = "Images", columnDefinition = "nvarchar(500) null")
    private String images;

    @Column(name = "Status")
    private int status;

    // bi-directional many-to-one association to Video
    @OneToMany(mappedBy = "category", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Video> videos = new ArrayList<>();

    public Video addVideo(Video video) {
        if (videos == null) {
            videos = new ArrayList<>();
        }
        getVideos().add(video);
        video.setCategory(this);
        return video;
    }

    public Video removeVideo(Video video) {
        if (videos != null) {
            getVideos().remove(video);
        }
        video.setCategory(null);
        return video;
    }
}
