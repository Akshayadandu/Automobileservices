package com.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.db.Dbconnection;

@WebServlet("/QCServlet")
public class QCServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("text/plain");
        
        HttpSession session = request.getSession();
        String qcUser = (String) session.getAttribute("username");
        
        if (qcUser == null) {
            response.getWriter().write("QC user not logged in");
            return;
        }
        
        String action = request.getParameter("action");
        String imageIdStr = request.getParameter("imageId");
        
        if (imageIdStr == null) {
            response.getWriter().write("No image ID");
            return;
        }
        
        int imageId = Integer.parseInt(imageIdStr);
        
        try {
            Connection conn = new Dbconnection().getConnection();
            String comments = request.getParameter("comments");
            
            switch (action) {
                case "approve":
                    String approveSql = "UPDATE invoice_images SET " +
                                      "qc_checked_by = ?, " +
                                      "qc_data = ?, " +
                                      "qc_end_time = NOW(), " +
                                      "status = 'qc_approved' " +
                                      "WHERE image_id = ?";
                    PreparedStatement approvePs = conn.prepareStatement(approveSql);
                    approvePs.setString(1, qcUser);
                    approvePs.setString(2, "Approved: " + (comments != null ? comments : "No comments"));
                    approvePs.setInt(3, imageId);
                    approvePs.executeUpdate();
                    approvePs.close();
                    response.getWriter().write("success");
                    break;
                    
                case "reject":
                    String rejectSql = "UPDATE invoice_images SET " +
                                     "qc_checked_by = ?, " +
                                     "qc_data = ?, " +
                                     "qc_end_time = NOW(), " +
                                     "status = 'qc_rejected', " +
                                     "assigned_to_user = NULL " +
                                     "WHERE image_id = ?";
                    PreparedStatement rejectPs = conn.prepareStatement(rejectSql);
                    rejectPs.setString(1, qcUser);
                    rejectPs.setString(2, "Rejected: " + (comments != null ? comments : "No reason"));
                    rejectPs.setInt(3, imageId);
                    rejectPs.executeUpdate();
                    rejectPs.close();
                    response.getWriter().write("success");
                    break;
                    
                case "correction":
                    String correctionSql = "UPDATE invoice_images SET " +
                                         "qc_checked_by = ?, " +
                                         "qc_data = ?, " +
                                         "qc_end_time = NOW(), " +
                                         "status = 'needs_correction', " +
                                         "errors = CONCAT(IFNULL(errors, ''), 'QC Correction: ', ?) " +
                                         "WHERE image_id = ?";
                    PreparedStatement correctionPs = conn.prepareStatement(correctionSql);
                    correctionPs.setString(1, qcUser);
                    correctionPs.setString(2, "Correction requested: " + comments);
                    correctionPs.setString(3, comments);
                    correctionPs.setInt(4, imageId);
                    correctionPs.executeUpdate();
                    correctionPs.close();
                    response.getWriter().write("success");
                    break;
                    
                default:
                    response.getWriter().write("Invalid action");
            }
            
            conn.close();
            
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error: " + e.getMessage());
        }
    }
}