package com.dao;

import com.model.InvoiceImageModel;
import com.db.Dbconnection;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class InvoiceWorkflowDAO {
    Dbconnection db = new Dbconnection();
    
    // Get next pending image for a verify user
    public InvoiceImageModel getNextImageForUser(String username) {
        String sql = "SELECT * FROM invoice_images WHERE (assigned_to_user IS NULL OR assigned_to_user = ?) " +
                    "AND status = 'pending' ORDER BY uploaded_date LIMIT 1";
        
        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                InvoiceImageModel image = new InvoiceImageModel();
                image.setImageId(rs.getInt("image_id"));
                image.setImagePath(rs.getString("image_path"));
                image.setStatus(rs.getString("status"));
                
                // Assign this image to user
                assignImageToUser(rs.getInt("image_id"), username);
                
                return image;
            }
            return null;
            
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    // Assign image to verify user
    private void assignImageToUser(int imageId, String username) {
        String sql = "UPDATE invoice_images SET assigned_to_user = ?, status = 'in_progress', " +
                    "assigned_date = NOW() WHERE image_id = ?";
        
        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setInt(2, imageId);
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // Get image for QC user
    public InvoiceImageModel getNextImageForQC(String qcUsername) {
        String sql = "SELECT * FROM invoice_images WHERE status = 'completed' " +
                    "AND (assigned_to_qc IS NULL OR assigned_to_qc = ?) " +
                    "ORDER BY completed_date LIMIT 1";
        
        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, qcUsername);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                InvoiceImageModel image = new InvoiceImageModel();
                image.setImageId(rs.getInt("image_id"));
                image.setImagePath(rs.getString("image_path"));
                image.setStatus(rs.getString("status"));
                image.setVerifiedBy(rs.getString("assigned_to_user"));
                image.setVerificationData(rs.getString("verification_data"));
                
                // Assign to QC
                assignImageToQC(rs.getInt("image_id"), qcUsername);
                
                return image;
            }
            return null;
            
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    // Assign image to QC user
    private void assignImageToQC(int imageId, String qcUsername) {
        String sql = "UPDATE invoice_images SET assigned_to_qc = ?, qc_start_time = NOW() WHERE image_id = ?";
        
        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, qcUsername);
            ps.setInt(2, imageId);
            ps.executeUpdate();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // Save verification data from verify user
    public boolean saveVerificationData(int imageId, String username, String verificationData) {
        String sql = "UPDATE invoice_images SET status = 'completed', verified_by = ?, " +
                    "verification_data = ?, completed_date = NOW() WHERE image_id = ?";
        
        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, username);
            ps.setString(2, verificationData);
            ps.setInt(3, imageId);
            
            return ps.executeUpdate() > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Save QC check data
    public boolean saveQCData(int imageId, String qcUsername, String qcData, String errors) {
        String sql = "UPDATE invoice_images SET qc_checked_by = ?, qc_data = ?, errors = ?, " +
                    "qc_end_time = NOW() WHERE image_id = ?";
        
        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, qcUsername);
            ps.setString(2, qcData);
            ps.setString(3, errors);
            ps.setInt(4, imageId);
            
            return ps.executeUpdate() > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Handle Hold/Skip operations
    public boolean updateImageStatus(int imageId, String status, String reason) {
        String sql = "UPDATE invoice_images SET status = ?, errors = CONCAT(IFNULL(errors, ''), ?) " +
                    "WHERE image_id = ?";
        
        try (Connection con = db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, status);
            ps.setString(2, "Status changed to " + status + ": " + reason + "\n");
            ps.setInt(3, imageId);
            
            return ps.executeUpdate() > 0;
            
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}