package vn.iotstar.config;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import vn.iotstar.entity.Category;
import vn.iotstar.entity.Video;

/**
 * Lớp kiểm thử độc lập khởi tạo EntityManager và lưu thực thể Category, Video
 * 
 * Bài tập 2 (12/11/2026) - HCMUTE
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
public class Test {
    public static void main(String[] args) {
        System.out.println("========== BẮT ĐẦU KIỂM THỬ JPA BÀI 2 ==========");
        EntityManager enma = JPAConfig.getEntityManager();
        EntityTransaction trans = enma.getTransaction();

        Category cate = new Category();
        cate.setCategoryname("Iphone 16");
        cate.setImages("iphone16.jpg");
        cate.setStatus(1);

        Video video = new Video();
        video.setVideoId("v101");
        video.setTitle("Trên tay Iphone 16 chính hãng");
        video.setDescription("Đánh giá camera và hiệu năng chip Apple A18.");
        video.setPoster("poster_v101.jpg");
        video.setActive(1);
        video.setViews(500);
        video.setCategory(cate);

        try {
            trans.begin();
            // Xóa video cũ nếu đã tồn tại để bài test luôn chạy thành công
            Video oldVideo = enma.find(Video.class, "v101");
            if (oldVideo != null) {
                enma.remove(oldVideo);
            }
            enma.persist(cate);
            enma.persist(video);
            trans.commit();

            System.out.println(">> THÊM MỚI DỮ LIỆU THÀNH CÔNG VÀO CSDL!");
            System.out.println(">> Category ID vừa sinh: " + cate.getCategoryid());
            System.out.println(">> Video ID vừa thêm: " + video.getVideoId());

            Category found = enma.find(Category.class, cate.getCategoryid());
            System.out.println(">> Tìm thấy Category từ DB: " + found.getCategoryname());
        } catch (Exception e) {
            System.err.println(">> GẶP LỖI: " + e.getMessage());
            e.printStackTrace();
            if (trans.isActive()) {
                trans.rollback();
            }
        } finally {
            enma.close();
            JPAConfig.close();
            System.out.println("========== KẾT THÚC KIỂM THỬ THÀNH CÔNG ==========");
            System.exit(0);
        }
    }
}
