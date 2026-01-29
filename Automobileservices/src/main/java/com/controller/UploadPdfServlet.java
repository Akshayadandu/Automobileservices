package com.controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.imageio.ImageIO;

import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.rendering.PDFRenderer;

import com.dao.InvoiceImageDAO;
import com.db.Dbconnection;
import com.model.InvoiceImageModel;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet("/UploadPdfServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,    // 1MB
    maxFileSize = 1024 * 1024 * 10,     // 10MB
    maxRequestSize = 1024 * 1024 * 50   // 50MB
)
public class UploadPdfServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        try {
            // 1. Get uploaded PDF
            Part pdfPart = request.getPart("pdfFile");
            String originalFileName = pdfPart.getSubmittedFileName();
            
            // Validate file type
            if (originalFileName == null || !originalFileName.toLowerCase().endsWith(".pdf")) {
                out.println("<h3 style='color:red;'>Error: Only PDF files are allowed!</h3>");
                out.println("<a href='image.jsp'>Go Back</a>");
                return;
            }

            // 2. Create directories inside webapp
            String webappPath = getServletContext().getRealPath("/");
            
            // PDF temp directory
            String pdfDir = webappPath + "temp_pdfs/";
            File pdfDirFile = new File(pdfDir);
            if (!pdfDirFile.exists()) {
                pdfDirFile.mkdirs();
            }
            
            // Images directory - INSIDE WEBAPP for easy access
            String imageDir = webappPath + "invoice_images/";
            File imageDirFile = new File(imageDir);
            if (!imageDirFile.exists()) {
                imageDirFile.mkdirs();
            }
            
            out.println("<div style='font-family: Arial; padding: 20px; background: #f5f5f5; min-height: 100vh;'>");
            out.println("<div style='max-width: 800px; margin: 0 auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.1);'>");
            
            out.println("<h2 style='color:green; border-bottom: 2px solid #4e73df; padding-bottom: 10px;'>PDF Processing Report</h2>");
            out.println("<p><strong>Original File:</strong> " + originalFileName + "</p>");
            out.println("<p><strong>WebApp Path:</strong> " + webappPath + "</p>");
            out.println("<p><strong>Images will be saved to:</strong> " + imageDir + "</p>");

            // 3. Save PDF temporarily with unique timestamp
            long timestamp = System.currentTimeMillis();
            String pdfPath = pdfDir + timestamp + "_" + originalFileName.replace(" ", "_");
            pdfPart.write(pdfPath);

            int totalImages = 0;
            int totalPages = 0;
            
            try (PDDocument document = PDDocument.load(new File(pdfPath))) {
                PDFRenderer renderer = new PDFRenderer(document);
                InvoiceImageDAO dao = new InvoiceImageDAO();
                totalPages = document.getNumberOfPages();
                
                out.println("<p><strong>Total Pages:</strong> " + totalPages + "</p>");
                out.println("<hr style='margin: 20px 0;'>");

                // 4. Convert each page to image
                for (int page = 0; page < totalPages; page++) {
                    out.println("<div style='background: #f8f9fc; padding: 10px; margin: 10px 0; border-radius: 5px;'>");
                    out.println("<p>📄 <strong>Processing Page " + (page + 1) + ":</strong></p>");
                    
                    try {
                        // Render image at 150 DPI (good quality)
                        BufferedImage image = renderer.renderImageWithDPI(page, 150);
                        
                        // Create image name
                        String imageName = "invoice_" + timestamp + "_page_" + (page + 1) + ".jpg";
                        String imagePath = imageDir + imageName;
                        
                        // Save image as JPG
                        boolean savedToDisk = ImageIO.write(image, "jpg", new File(imagePath));
                        
                        if (savedToDisk) {
                            out.println("<p style='color:green; margin-left: 20px;'>✓ Image saved: " + imageName + "</p>");
                            
                            // Save to database with workflow status
                            InvoiceImageModel model = new InvoiceImageModel();
                            model.setImagePath(imageName);
                            model.setStatus("pending");
                            
                            boolean savedToDB = dao.saveImage(model);
                            
                            if (savedToDB) {
                                out.println("<p style='color:green; margin-left: 20px;'>✓ Saved to database with 'pending' status</p>");
                                totalImages++;
                            } else {
                                out.println("<p style='color:red; margin-left: 20px;'>✗ Failed to save to database</p>");
                            }
                        } else {
                            out.println("<p style='color:red; margin-left: 20px;'>✗ Failed to save image file</p>");
                        }
                    } catch (Exception e) {
                        out.println("<p style='color:red; margin-left: 20px;'>✗ Error on page " + (page + 1) + ": " + e.getMessage() + "</p>");
                    }
                    out.println("</div>");
                }
                
                out.println("<hr style='margin: 20px 0;'>");
                out.println("<h3 style='color:blue;'>✅ Processing Complete!</h3>");
                out.println("<p><strong>Successfully processed:</strong> " + totalImages + " out of " + totalPages + " pages</p>");
                
                // 5. Clean up temp PDF
                try {
                    new File(pdfPath).delete();
                    out.println("<p style='color:gray;'>✓ Temporary PDF removed</p>");
                } catch (Exception e) {
                    out.println("<p style='color:orange;'>⚠ Could not delete temp file</p>");
                }
                
                // 6. Show database status
                out.println("<div style='margin-top: 20px; padding: 15px; background: #e6f2ff; border-radius: 5px;'>");
                out.println("<h4>📊 Database Status:</h4>");
                showDatabaseStatus(out);
                out.println("</div>");
                
                // 7. Show how to access images
                out.println("<div style='margin-top: 20px; padding: 15px; background: #e6ffe6; border-radius: 5px;'>");
                out.println("<h4>🔗 How to Access Images:</h4>");
                out.println("<p>Images are now accessible via:</p>");
                out.println("<code>http://" + request.getServerName() + ":" + request.getServerPort() + 
                           request.getContextPath() + "/invoice_images/FILENAME.jpg</code><br>");
                out.println("<p><strong>Example:</strong></p>");
                if (totalImages > 0) {
                    out.println("<code>http://" + request.getServerName() + ":" + request.getServerPort() + 
                               request.getContextPath() + "/invoice_images/invoice_" + timestamp + "_page_1.jpg</code>");
                }
                out.println("</div>");
                
            } catch (Exception e) {
                out.println("<div style='color:red; padding: 15px; background: #ffe6e6; border-radius: 5px;'>");
                out.println("<h3>❌ PDF Processing Error:</h3>");
                out.println("<p>" + e.getMessage() + "</p>");
                out.println("</div>");
                e.printStackTrace(out);
            }
            
            // 8. Navigation
            out.println("<div style='margin-top: 30px; text-align: center;'>");
            out.println("<a href='image.jsp' style='padding: 10px 20px; background: #4e73df; color: white; text-decoration: none; border-radius: 5px; margin: 5px; display: inline-block;'>📤 Upload Another PDF</a>");
            out.println("<a href='register.jsp' style='padding: 10px 20px; background: #1cc88a; color: white; text-decoration: none; border-radius: 5px; margin: 5px; display: inline-block;'>📝 Back to Registration</a>");
            out.println("<a href='testimage.jsp' style='padding: 10px 20px; background: #6c757d; color: white; text-decoration: none; border-radius: 5px; margin: 5px; display: inline-block;'>🖼️ Test Image Loading</a>");
            out.println("<a href='verify_invoice_ui.jsp' style='padding: 10px 20px; background: #ffc107; color: black; text-decoration: none; border-radius: 5px; margin: 5px; display: inline-block;'>📋 Go to Verify Page</a>");
            out.println("</div>");
            
            out.println("</div>");
            out.println("</div>");

        } catch (Exception e) {
            out.println("<div style='padding: 20px; color: red;'>");
            out.println("<h3>Upload Error:</h3>");
            out.println("<p>" + e.getMessage() + "</p>");
            out.println("</div>");
            out.println("<a href='image.jsp'>← Go Back</a>");
            e.printStackTrace(out);
        }
    }
    
    // Helper method to show database status
    private void showDatabaseStatus(PrintWriter out) {
        String sql = "SELECT " +
                    "COUNT(*) as total, " +
                    "SUM(CASE WHEN status = 'pending' THEN 1 ELSE 0 END) as pending, " +
                    "SUM(CASE WHEN status = 'in_progress' THEN 1 ELSE 0 END) as in_progress, " +
                    "SUM(CASE WHEN status = 'completed' THEN 1 ELSE 0 END) as completed, " +
                    "SUM(CASE WHEN status = 'hold' THEN 1 ELSE 0 END) as hold, " +
                    "SUM(CASE WHEN status = 'skipped' THEN 1 ELSE 0 END) as skipped " +
                    "FROM invoice_images";
        
        try (Connection con = new Dbconnection().getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            if (rs.next()) {
                int total = rs.getInt("total");
                int pending = rs.getInt("pending");
                int inProgress = rs.getInt("in_progress");
                int completed = rs.getInt("completed");
                int hold = rs.getInt("hold");
                int skipped = rs.getInt("skipped");
                
                out.println("<table style='width:100%; border-collapse: collapse; font-size: 14px;'>");
                out.println("<tr style='background: #4e73df; color: white;'>");
                out.println("<th style='padding: 8px; text-align: left;'>Status</th>");
                out.println("<th style='padding: 8px; text-align: center;'>Count</th>");
                out.println("</tr>");
                
                String[] statuses = {"Total", "Pending", "In Progress", "Completed", "Hold", "Skipped"};
                int[] counts = {total, pending, inProgress, completed, hold, skipped};
                String[] colors = {"#343a40", "#ffc107", "#17a2b8", "#28a745", "#dc3545", "#6c757d"};
                
                for (int i = 0; i < statuses.length; i++) {
                    out.println("<tr style='border-bottom: 1px solid #ddd;'>");
                    out.println("<td style='padding: 8px;'><span style='display: inline-block; width: 12px; height: 12px; background: " + colors[i] + "; border-radius: 50%; margin-right: 8px;'></span>" + statuses[i] + "</td>");
                    out.println("<td style='padding: 8px; text-align: center; font-weight: bold;'>" + counts[i] + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            }
            
        } catch (Exception e) {
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    }
}