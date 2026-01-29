package com.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.db.Dbconnection;

@WebServlet("/SimpleVerifyServlet")
public class SimpleVerifyServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String action = request.getParameter("actionStatus");
        String imageId = request.getParameter("imageId");
        String username = (String) request.getSession().getAttribute("username");

        if (username == null || imageId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Connection conn = new Dbconnection().getConnection();
            int imgId = Integer.parseInt(imageId);
            
            if ("submit".equals(action)) {

                /* -------- Invoice header -------- */
                String vendorName    = request.getParameter("vendorName");
                String invoiceNumber = request.getParameter("invoiceNumber");
                String invoiceDate   = request.getParameter("invoiceDate");
                String poNumber      = request.getParameter("poNumber");
                double invoiceTotal  = Double.parseDouble(request.getParameter("invoiceTotal"));

                /* -------- Item arrays -------- */
                String[] itemNos    = request.getParameterValues("itemNo[]");
                String[] itemNames  = request.getParameterValues("itemName[]");
                String[] prices     = request.getParameterValues("itemPrice[]");
                String[] quantities = request.getParameterValues("quantity[]");
                String[] cgsts      = request.getParameterValues("itemCGST[]");
                String[] sgsts      = request.getParameterValues("itemSGST[]");
                String[] totals     = request.getParameterValues("itemTotal[]");

                /* -------- Comma builders -------- */
                StringBuilder itemNoSb   = new StringBuilder();
                StringBuilder itemNameSb = new StringBuilder();
                StringBuilder qtySb      = new StringBuilder();
                StringBuilder priceSb    = new StringBuilder();
                StringBuilder cgstSb     = new StringBuilder();
                StringBuilder sgstSb     = new StringBuilder();
                StringBuilder totalSb    = new StringBuilder();

                for (int i = 0; i < itemNos.length; i++) {

                    boolean emptyRow =
                        (itemNos[i] == null || itemNos[i].trim().isEmpty()) &&
                        (itemNames[i] == null || itemNames[i].trim().isEmpty());

                    if (emptyRow) continue;

                    append(itemNoSb, itemNos[i]);
                    append(itemNameSb, itemNames[i]);
                    append(priceSb, prices[i]);
                    append(qtySb, quantities[i]);
                    append(cgstSb, cgsts[i]);
                    append(sgstSb, sgsts[i]);
                    append(totalSb, totals[i]);
                }

                String sql =
                    "INSERT INTO invoice_details (" +
                    " image_id, vendor_name, invoice_number, invoice_date, po_number, invoice_total," +
                    " item_no, item_name, price, quantity, cgst, sgst, item_total, sub_total," +
                    " verified_by, verified_time" +
                    ") VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,NOW())";

                try (PreparedStatement ps = conn.prepareStatement(sql)) {

                    ps.setInt(1, imgId);
                    ps.setString(2, vendorName);
                    ps.setString(3, invoiceNumber);
                    ps.setString(4, invoiceDate);
                    ps.setString(5, poNumber);
                    ps.setDouble(6, invoiceTotal);

                    ps.setString(7, itemNoSb.toString());
                    ps.setString(8, itemNameSb.toString());
                    ps.setString(9, priceSb.toString());
                    ps.setString(10, qtySb.toString());
                    ps.setString(11, cgstSb.toString());
                    ps.setString(12, sgstSb.toString());
                    ps.setString(13, totalSb.toString());
                    ps.setDouble(14, Double.parseDouble(request.getParameter("subTotal")));

                    ps.setString(15, username);

                    ps.executeUpdate();
                }

                String updateImageSql =
                    "UPDATE invoice_images SET " +
                    " status = 'completed', " +
                    " verified_by = ?, " +
                    " verify_end_time = NOW(), " +
                    " verify_duration_mmss = CONCAT(" +
                    "   FLOOR(TIMESTAMPDIFF(SECOND, verify_start_time, NOW()) / 60), '.', " +
                    "   LPAD(MOD(TIMESTAMPDIFF(SECOND, verify_start_time, NOW()), 60), 2, '0')" +
                    " ), " +
                    " assigned_to_user = NULL " +
                    " WHERE image_id = ?";

                try (PreparedStatement ps = conn.prepareStatement(updateImageSql)) {
                    ps.setString(1, username);
                    ps.setInt(2, imgId);
                    ps.executeUpdate();
                }

                response.sendRedirect("verify_invoice_ui.jsp?success=Invoice+submitted+successfully");

            } else if ("skip".equals(action)) {

                String reason = request.getParameter("reason");
                String sql =
                    "UPDATE invoice_images SET " +
                    "status = 'skipped', " +
                    "errors = ?, " +
                    "verify_end_time = NOW(), " +
                    "verify_duration_mmss = CONCAT(" +
                    "FLOOR(TIMESTAMPDIFF(SECOND, verify_start_time, NOW()) / 60), '.', " +
                    "LPAD(MOD(TIMESTAMPDIFF(SECOND, verify_start_time, NOW()), 60), 2, '0')" +
                    "), " +
                    "assigned_to_user = ? " +
                    "WHERE image_id = ?";

                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, "Skipped: " + (reason != null ? reason : "No reason"));
                ps.setString(2, username);
                ps.setInt(3, imgId);
                ps.executeUpdate();
                ps.close();

                response.sendRedirect("verify_invoice_ui.jsp");

            } else if ("hold".equals(action)) {

                String reason = request.getParameter("reason");
                String sql =
                    "UPDATE invoice_images SET " +
                    "status = 'hold', " +
                    "errors = ?, " +
                    "verify_end_time = NOW(), " +
                    "verify_duration_mmss = CONCAT(" +
                    "FLOOR(TIMESTAMPDIFF(SECOND, verify_start_time, NOW()) / 60), '.', " +
                    "LPAD(MOD(TIMESTAMPDIFF(SECOND, verify_start_time, NOW()), 60), 2, '0')" +
                    ") " +
                    "WHERE image_id = ?";

                PreparedStatement ps = conn.prepareStatement(sql);
                ps.setString(1, "Hold: " + (reason != null ? reason : "No reason"));
                ps.setInt(2, imgId);
                ps.executeUpdate();
                ps.close();

                response.sendRedirect("verify_invoice_ui.jsp");
            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("verify_invoice_ui.jsp?error=" + e.getMessage());
        }
    }

    /* ================= HELPER ================= */
    private void append(StringBuilder sb, String value) {
        if (sb.length() > 0) sb.append(",");
        sb.append(value == null ? "" : value.trim());
    }
}