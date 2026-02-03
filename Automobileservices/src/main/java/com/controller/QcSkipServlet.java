package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.db.Dbconnection;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/QcSkipServlet")
public class QcSkipServlet extends HttpServlet {

    // 🔒 STATIC TL CREDENTIALS (TESTING)
    private static final String TL_USER = "dreams";
    private static final String TL_PASS = "dreams";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("username") == null) {
            response.sendRedirect("qc_invoice_ui.jsp?error=Session+expired");
            return;
        }

        String qcUser = (String) session.getAttribute("username");
        String imageIdStr = request.getParameter("imageId");
        String action = request.getParameter("actionType");
        String user = request.getParameter("tlUsername");
        String pass = request.getParameter("tlPassword");
        String reason = request.getParameter("skipReasonHidden");

        if (!"qcSkip".equals(action)) {
            response.sendRedirect("qc_invoice_ui.jsp?error=Invalid+action");
            return;
        }

        // ❌ TL AUTH CHECK
        if (!TL_USER.equals(user) || !TL_PASS.equals(pass)) {
            response.sendRedirect("qc_invoice_ui.jsp?error=Invalid+TL+credentials");
            return;
        }

        try (Connection con = new Dbconnection().getConnection()) {

            PreparedStatement ps = con.prepareStatement(
                "UPDATE invoice_images SET " +
                "status='qc_skipped', " +
                "qc_skip_reason=?, " +
                "assigned_to_qc=NULL, " +
                "qc_checked_by=?, " +
                "qc_end_time=NOW() " +
                "WHERE image_id=? " +
                "AND status='qc_in_progress'"
            );

            ps.setString(1, reason);
            ps.setString(2, qcUser);
            ps.setInt(3, Integer.parseInt(imageIdStr));

            int rows = ps.executeUpdate();
            System.out.println("QC SKIP rows updated = " + rows);

            // 🧹 CLEAR SESSION
            session.removeAttribute("imageId");
            session.removeAttribute("imagePath");
            session.removeAttribute("qcItems");

            if (rows == 0) {
                response.sendRedirect("qc_invoice_ui.jsp?error=QC+Skip+Failed+(Row+Mismatch)");
                return;
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("qc_invoice_ui.jsp?error=QC+skip+exception");
            return;
        }

        // ✅ LOAD NEXT FIFO IMAGE
        response.sendRedirect("qc_invoice_ui.jsp?success=Invoice+Skipped");
    }
}
