package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.Map;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.db.Dbconnection;

@WebServlet("/logout")
public class Logoutservlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        String username = null;

        if (session != null) {
            username = (String) session.getAttribute("username");
            
            ServletContext context = getServletContext();
            Map<String, String> activeUsers =
                (Map<String, String>) context.getAttribute("activeUsers");

            if (username != null && activeUsers != null) {
                activeUsers.remove(username);
            }

            session.invalidate();
        }

        try (Connection conn = new Dbconnection().getConnection()) {

            if (username != null) {

                // VERIFY release
                String verifySql =
                    "UPDATE invoice_images SET assigned_to_user=NULL, status='pending', verify_start_time=NULL " +
                    "WHERE assigned_to_user=? AND status ='in_progress' ";

                try (PreparedStatement ps = conn.prepareStatement(verifySql)) {
                    ps.setString(1, username);
                    ps.executeUpdate();
                }

                // QC release
                String qcSql =
                    "UPDATE invoice_images SET assigned_to_qc=NULL,status='completed' WHERE assigned_to_qc=? AND status ='qc_in_progress' ";

                try (PreparedStatement ps = conn.prepareStatement(qcSql)) {
                    ps.setString(1, username);
                    ps.executeUpdate();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }


        response.sendRedirect("login.jsp");
    }
}
