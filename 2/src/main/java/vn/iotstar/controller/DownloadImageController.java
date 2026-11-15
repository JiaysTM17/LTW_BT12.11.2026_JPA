package vn.iotstar.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.commons.io.IOUtils;
import vn.iotstar.util.constants;

/**
 * Servlet hiển thị hình ảnh từ thư mục upload
 * 
 * Bài tập 2 (12/11/2026) - HCMUTE
 * Sinh viên: Trương Gia Kiệt - MSSV: 24110032
 */
@WebServlet(urlPatterns = "/image")
public class DownloadImageController extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fileName = req.getParameter("fname");
        if (fileName == null || fileName.trim().isEmpty()) {
            return;
        }

        File file = new File(constants.DIR + File.separator + fileName);
        if (file.exists() && file.isFile()) {
            // Xác định định dạng ảnh
            String mimeType = getServletContext().getMimeType(file.getName());
            if (mimeType == null) {
                mimeType = "image/jpeg";
            }
            resp.setContentType(mimeType);
            resp.setContentLengthLong(file.length());

            try (FileInputStream inStream = new FileInputStream(file)) {
                IOUtils.copy(inStream, resp.getOutputStream());
            }
        }
    }
}
