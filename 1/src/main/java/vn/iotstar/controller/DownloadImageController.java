package vn.iotstar.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import org.apache.commons.io.IOUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import vn.iotstar.util.Constant;

/**
 * Controller DownloadImageController - Đọc và truyền luồng byte dữ liệu hình ảnh trực tiếp ra trình duyệt
 * URL Pattern: /image (Ví dụ: /image?fname=ao-nam.jpg)
 * Môn học: Lập Trình Web (HCMUTE - WEBPR330479)
 * Giảng viên: ThS. Nguyễn Hữu Trung
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
@SuppressWarnings("serial")
@WebServlet(urlPatterns = {"/image"})
public class DownloadImageController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fname = req.getParameter("fname");
        // 1. Kiểm tra tham số rỗng hoặc null, xử lý an toàn tránh NullPointerException
        if (fname == null || fname.trim().isEmpty()) {
            return;
        }

        // 2. Phòng chống tấn công Path Traversal: chỉ trích xuất tên tập tin đơn thuần
        String fileName = new File(fname).getName();
        if (fileName.contains("..") || fileName.contains("/") || fileName.contains("\\")) {
            resp.sendError(HttpServletResponse.SC_FORBIDDEN, "Invalid file name");
            return;
        }

        File file = new File(Constant.DIR + File.separator + fileName);
        if (!file.exists() || !file.isFile()) {
            // Nếu không tìm thấy tập tin yêu cầu, kiểm tra fallback sang tập tin ảnh mặc định
            File defaultFile = new File(Constant.DIR + File.separator + Constant.DEFAULT_FILENAME);
            if (defaultFile.exists() && defaultFile.isFile()) {
                file = defaultFile;
            } else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Image not found");
                return;
            }
        }

        // 3. Xác định MIME type phù hợp để trình duyệt hiển thị đúng định dạng ảnh
        String mimeType = getServletContext().getMimeType(file.getName());
        if (mimeType == null) {
            String lower = file.getName().toLowerCase();
            if (lower.endsWith(".png")) {
                mimeType = "image/png";
            } else if (lower.endsWith(".jpg") || lower.endsWith(".jpeg")) {
                mimeType = "image/jpeg";
            } else if (lower.endsWith(".gif")) {
                mimeType = "image/gif";
            } else if (lower.endsWith(".webp")) {
                mimeType = "image/webp";
            } else {
                mimeType = "application/octet-stream";
            }
        }

        resp.setContentType(mimeType);
        resp.setContentLengthLong(file.length());

        // 4. Sao chép luồng byte từ tệp tin ra response OutputStream
        try (FileInputStream in = new FileInputStream(file);
             OutputStream out = resp.getOutputStream()) {
            IOUtils.copy(in, out);
            out.flush();
        } catch (Exception e) {
            // Không làm gián đoạn ứng dụng khi client ngắt kết nối giữa chừng
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doGet(req, resp);
    }
}
