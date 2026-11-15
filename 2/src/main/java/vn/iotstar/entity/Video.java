package vn.iotstar.entity;

import java.io.Serializable;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.NamedQuery;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * Entity Video - Quản lý video thuộc Category (JPA 3.0 & Jakarta 6.0)
 * 
 * Bài tập 2 (12/11/2026) - HCMUTE
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
@Entity
@Table(name = "Videos")
@NamedQuery(name = "Video.findAll", query = "SELECT v FROM Video v")
public class Video implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @Column(name = "VideoId", length = 50)
    private String videoId;

    @Column(name = "Active")
    private int active;

    @Column(name = "Description", columnDefinition = "nvarchar(500) null")
    private String description;

    @Column(name = "Poster", columnDefinition = "nvarchar(500) null")
    private String poster;

    @Column(name = "Title", columnDefinition = "nvarchar(500) null")
    private String title;

    @Column(name = "Views")
    private int views;

    // bi-directional many-to-one association to Category
    @ManyToOne
    @JoinColumn(name = "CategoryId")
    private Category category;
}
