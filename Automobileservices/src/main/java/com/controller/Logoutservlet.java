package com.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

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

        if (session != null) {
            String username = (String) session.getAttribute("username");

            if (username != null) {
                try (Connection conn = new Dbconnection().getConnection()) {
                    // Reset all images assigned to this user back to pending
                    // This handles cases where user logs out while holding an image or just has one open
                    String sql =
                        "UPDATE invoice_images SET " +
                        " assigned_to_user = NULL, " +
                        " status = 'pending', " +
                        " verify_start_time = NULL " +
                        " WHERE assigned_to_user = ? " +
                        " AND status IN ('in_progress', 'hold')";

                    try (PreparedStatement ps = conn.prepareStatement(sql)) {
                        ps.setString(1, username);
                        ps.executeUpdate();
                    }

                } catch (Exception e) {
                    e.printStackTrace();
                }
            }

            session.invalidate();
        }

        response.sendRedirect("login.jsp");
    }
}