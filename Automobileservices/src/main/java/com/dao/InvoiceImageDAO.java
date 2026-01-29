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























//package com.dao;
//
//import java.sql.*;
//import com.db.Dbconnection;
//import com.model.InvoiceImageModel;
//
//public class InvoiceImageDAO 
//{
//
//    // =============================
//    // 1️⃣ SAVE IMAGE (FOR PDF UPLOAD)
//	public boolean saveImage(InvoiceImageModel image)
//	{
//	    boolean status = false;
//	    
//	    System.out.println("DAO: Saving image with status: " + image.getImagePath());
//
//	    // Updated SQL to include workflow fields
//	    String sql = "INSERT INTO invoice_images (image_path, status, assigned_to_user, assigned_to_qc, " +
//	                "verified_by, qc_checked_by, errors) " +
//	                "VALUES (?, ?, ?, ?, ?, ?, ?)";
//	    
//	    Dbconnection db;
//		try (Connection con = Dbconnection.getConnection())
//		{
//	        System.out.println("DAO: Database connection successful");
//	        
//	        try (PreparedStatement ps = con.prepareStatement(sql)) 
//	        {
//	            ps.setString(1, image.getImagePath());
//	            ps.setString(2, image.getStatus() != null ? image.getStatus() : "pending");
//	            ps.setString(3, image.getAssignedToUser());
//	            ps.setString(4, image.getAssignedToQc());
//	            ps.setString(5, image.getVerifiedBy());
//	            ps.setString(6, image.getQcCheckedBy());
//	            ps.setString(7, image.getErrors());
//	            
//	            int rowsAffected = ps.executeUpdate();
//	            System.out.println("DAO: Rows affected: " + rowsAffected);
//	            
//	            status = rowsAffected > 0;
//	        }
//	    } 
//		catch (Exception e)
//		{
//	        System.out.println("DAO: Error - " + e.getMessage());
//	        e.printStackTrace();
//	    }
//	    
//	    return status;
//	}
//}
