package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.db.Dbconnection;
import com.model.InvoiceImageModel;

public class InvoiceImageDAO {

    public boolean saveImage(InvoiceImageModel image) {

        String sql =
            "INSERT INTO invoice_images (image_path, status) VALUES (?, ?)";

        try (Connection con = Dbconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, image.getImagePath());
            ps.setString(2, image.getStatus() != null ? image.getStatus() : "pending");

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}




















