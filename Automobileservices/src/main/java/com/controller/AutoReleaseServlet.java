package com.controller;

import java.sql.Connection;
import java.sql.PreparedStatement;

import com.db.Dbconnection;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/autoRelease")
public class AutoReleaseServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) {

        HttpSession session = request.getSession(false);
        if (session == null) return;

        String username = (String) session.getAttribute("username");
        if (username == null) return;

        try (Connection con = new Dbconnection().getConnection()) {

            // VERIFY auto release
            String vSql =
                "UPDATE invoice_images SET assigned_to_user=NULL, status='pending' " +
                "WHERE assigned_to_user=? AND status='in_progress'";
            try (PreparedStatement ps = con.prepareStatement(vSql)) {
                ps.setString(1, username);
                ps.executeUpdate();
            }

            // QC auto release
            String qSql =
                "UPDATE invoice_images SET assigned_to_qc=NULL, status='completed' " +
                "WHERE assigned_to_qc=? AND status='qc_in_progress'";
            try (PreparedStatement ps = con.prepareStatement(qSql)) {
                ps.setString(1, username);
                ps.executeUpdate();
            }

        } catch (Exception ignored) {}
    }
}
