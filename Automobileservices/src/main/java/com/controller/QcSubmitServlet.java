package com.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.db.Dbconnection;

@WebServlet("/QcSubmitServlet")
public class QcSubmitServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("actionType");
        String imageId = request.getParameter("imageId");
        String qcUser = (String) request.getSession().getAttribute("username");

        if (qcUser == null || imageId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            Connection conn = new Dbconnection().getConnection();
            int imgId = Integer.parseInt(imageId);

            if ("submit".equals(action)) {

                /* ===== HEADER DETAILS ===== */
                String vendorName    = request.getParameter("vendorName");
                String invoiceNumber = request.getParameter("invoiceNumber");
                String invoiceDate   = request.getParameter("invoiceDate");
                String poNumber      = request.getParameter("poNumber");
                double invoiceTotal  = Double.parseDouble(request.getParameter("invoiceTotal"));
                double subTotal      = Double.parseDouble(request.getParameter("subTotal"));

                /* ===== ITEM ARRAYS ===== */
                String[] itemNos    = request.getParameterValues("itemNo[]");
                String[] itemNames  = request.getParameterValues("itemName[]");
                String[] prices     = request.getParameterValues("itemPrice[]");
                String[] quantities = request.getParameterValues("quantity[]");
                String[] cgsts      = request.getParameterValues("itemCGST[]");
                String[] sgsts      = request.getParameterValues("itemSGST[]");
                String[] totals     = request.getParameterValues("itemTotal[]");

                /* ===== CSV BUILDERS ===== */
                StringBuilder itemNoSb   = new StringBuilder();
                StringBuilder itemNameSb = new StringBuilder();
                StringBuilder priceSb    = new StringBuilder();
                StringBuilder qtySb      = new StringBuilder();
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

                /* ===== INSERT QC DATA ===== */
                String insertSql =
                    "INSERT INTO qc_invoice_details (" +
                    "image_id, vendor_name, invoice_number, invoice_date, po_number, invoice_total, " +
                    "item_no, item_name, price, quantity, cgst, sgst, item_total, sub_total, " +
                    "qc_verified_by, qc_verified_time" +
                    ") VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,NOW())";

                try (PreparedStatement ps = conn.prepareStatement(insertSql)) {

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
                    ps.setDouble(14, subTotal);

                    ps.setString(15, qcUser);

                    ps.executeUpdate();
                }

                /* ===== UPDATE IMAGE STATUS ===== */
                String updateImageSql =
                    "UPDATE invoice_images SET " +
                    "status='qc_completed', " +
                    "qc_checked_by=?, " +
                    "qc_end_time=NOW(), " +
                    "assigned_to_qc=NULL " +
                    "WHERE image_id=?";

                try (PreparedStatement ps = conn.prepareStatement(updateImageSql)) {
                    ps.setString(1, qcUser);
                    ps.setInt(2, imgId);
                    ps.executeUpdate();
                }


                response.sendRedirect("qc_invoice_ui.jsp?success=QC+Completed+Successfully");

            }

            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("qc_invoice_ui.jsp?error=" + e.getMessage());
        }
    }

    /* ===== HELPER ===== */
    private void append(StringBuilder sb, String value) {
        if (sb.length() > 0) sb.append(",");
        sb.append(value == null ? "" : value.trim());
    }
}
