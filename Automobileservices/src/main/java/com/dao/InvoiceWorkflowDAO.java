package com.dao;

import com.model.InvoiceImageModel;
import com.db.Dbconnection;
import java.sql.*;

public class InvoiceWorkflowDAO {

    // ================= VERIFY USER =================
    public InvoiceImageModel getNextImageForUser(String username) {

        String sql =
            "SELECT * FROM invoice_images " +
            "WHERE status = 'pending' " +
            "ORDER BY uploaded_date LIMIT 1";

        try (Connection con = Dbconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {

                InvoiceImageModel img = new InvoiceImageModel();
                img.setImageId(rs.getInt("image_id"));
                img.setImagePath(rs.getString("image_path"));
                img.setStatus(rs.getString("status"));

                assignImageToUser(img.getImageId(), username);
                return img;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private void assignImageToUser(int imageId, String username) {

        String sql =
            "UPDATE invoice_images SET " +
            "assigned_to_user = ?, status = 'in_progress', verify_start_time = NOW() " +
            "WHERE image_id = ?";

        try (Connection con = Dbconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setInt(2, imageId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ================= QC USER =================
    public InvoiceImageModel getNextImageForQC(String qcUser) {

        String sql =
            "SELECT * FROM invoice_images " +
            "WHERE status = 'completed' " +
            "AND (assigned_to_qc IS NULL OR assigned_to_qc = ?) " +
            "ORDER BY verify_end_time LIMIT 1";

        try (Connection con = Dbconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, qcUser);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                InvoiceImageModel img = new InvoiceImageModel();
                img.setImageId(rs.getInt("image_id"));
                img.setImagePath(rs.getString("image_path"));
                img.setVerifiedBy(rs.getString("verified_by"));

                assignImageToQC(img.getImageId(), qcUser);
                return img;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private void assignImageToQC(int imageId, String qcUser) {

        String sql =
            "UPDATE invoice_images SET assigned_to_qc = ? WHERE image_id = ?";

        try (Connection con = Dbconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, qcUser);
            ps.setInt(2, imageId);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // ================= QC SAVE =================
    public boolean saveQCData(int imageId, String qcUser, String errors) {

        String sql =
            "UPDATE invoice_images SET " +
            "qc_checked_by = ?, errors = ? " +
            "WHERE image_id = ?";

        try (Connection con = Dbconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, qcUser);
            ps.setString(2, errors);
            ps.setInt(3, imageId);

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}


















