package com.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import com.db.Dbconnection;
import com.model.InvoiceDetailsModel;

public class InvoiceDetailsDAO {

    public void insertInvoiceDetails(InvoiceDetailsModel m) {

        String sql =
            "INSERT INTO invoice_details (" +
            "image_id, vendor_name, invoice_number, invoice_date, po_number, invoice_total, " +
            "item_no, item_name, price, quantity, cgst, sgst, item_total, sub_total, " +
            "verified_by, verified_time" +
            ") VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,NOW())";

        try (Connection con = Dbconnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, m.getImageId());
            ps.setString(2, m.getVendorName());
            ps.setString(3, m.getInvoiceNumber());
            ps.setString(4, m.getInvoiceDate());
            ps.setString(5, m.getPoNumber());
            ps.setDouble(6, m.getInvoiceTotal());

            ps.setString(7, m.getItemNo());
            ps.setString(8, m.getItemName());
            ps.setString(9, m.getPrice());
            ps.setString(10, m.getQuantity());
            ps.setString(11, m.getCgst());
            ps.setString(12, m.getSgst());
            ps.setString(13, m.getItemTotal());
            ps.setDouble(14, m.getSubTotal());

            ps.setString(15, m.getVerifiedBy());

            ps.executeUpdate();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
