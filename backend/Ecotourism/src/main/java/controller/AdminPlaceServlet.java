package controller;

import dao.PlaceDAO;
import model.Place;
import util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Timestamp;
import java.util.UUID;

@WebServlet("/admin/places")
@MultipartConfig(
        fileSizeThreshold = 2 * 1024 * 1024,   // 2MB
        maxFileSize = 10 * 1024 * 1024,        // 10MB
        maxRequestSize = 50 * 1024 * 1024      // 50MB
)
public class AdminPlaceServlet extends AdminBaseServlet {

    private static final String UPLOAD_DIR = "assets/img/uploads";

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        // Optional: redirect to a specific dashboard section
        String redirectSection = req.getParameter("redirectSection");
        if (redirectSection == null) redirectSection = "";
        else redirectSection = "#" + redirectSection;

        try (Connection conn = DBConnection.getConnection()) {
            PlaceDAO placeDAO = new PlaceDAO(conn);

            Place place;
            String placeIdStr = req.getParameter("placeId");

            if (placeIdStr == null || placeIdStr.isEmpty()) {
                // ADD new place
                place = new Place();
                place.setCreatedAt(new Timestamp(System.currentTimeMillis()));
            } else {
                // UPDATE existing place
                int placeId = parseInt(placeIdStr, 0);
                place = placeDAO.getPlaceById(placeId);
                if (place == null) {
                    resp.sendRedirect(req.getContextPath() + "/admin/dashboard" + redirectSection);
                    return;
                }
            }

            // ===== Set values from form =====
            place.setPlaceCode(trim(req.getParameter("placeCode")));
            place.setPlaceName(trim(req.getParameter("placeName")));
            place.setDescription(trim(req.getParameter("description")));
            place.setPricePerPerson(parseDouble(req.getParameter("pricePerPerson"), 0));
            place.setStatus(trim(req.getParameter("status")));

            // ===== Handle file upload =====
            String uploadedImage = handleUpload(req);
            if (uploadedImage != null) {
                place.setImageUrl(uploadedImage);
            }

            // ===== Save to DB =====
            if (placeIdStr == null || placeIdStr.isEmpty()) {
                placeDAO.addPlace(place);
            } else {
                placeDAO.updatePlace(place);
            }

            // ===== Redirect to dashboard with optional section =====
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard" + redirectSection);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    }

    // ===== Helper Methods =====
    private String handleUpload(HttpServletRequest req) throws IOException, ServletException {
        Part filePart = req.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) uploadDir.mkdirs(); // safer

            String fileName = UUID.randomUUID() + "_" + new File(filePart.getSubmittedFileName()).getName();
            filePart.write(uploadPath + File.separator + fileName);

            return UPLOAD_DIR + "/" + fileName;
        }
        return null;
    }

    private int parseInt(String str, int defaultVal) {
        try { return Integer.parseInt(str.trim()); } catch (Exception e) { return defaultVal; }
    }

    private double parseDouble(String str, double defaultVal) {
        try { return Double.parseDouble(str.trim()); } catch (Exception e) { return defaultVal; }
    }

    private String trim(String str) {
        return (str == null) ? "" : str.trim();
    }
}
