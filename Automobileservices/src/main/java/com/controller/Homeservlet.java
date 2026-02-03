package com.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
@WebServlet("/home")
public class Homeservlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        String currentMode = (String) session.getAttribute("mode");

        Boolean qcEligible = (Boolean) session.getAttribute("qcEligible");

        if (qcEligible == null || !qcEligible) {
            response.sendRedirect("home.jsp?error=No+QC+access");
            return;
        }

        /* ===== VERIFY CLICK ===== */
        if ("verify".equals(action)) {

            if ("qc".equals(currentMode)) {
                response.sendRedirect("home.jsp?error=Finish+QC+first");
                return;
            }

            session.setAttribute("mode", "verify");
            response.sendRedirect("verify_invoice_ui.jsp");
            return;
        }

        /* ===== QC CLICK ===== */
        if ("qc".equals(action)) {

            if ("verify".equals(currentMode)) {
                response.sendRedirect("home.jsp?error=Finish+Verify+first");
                return;
            }

            session.setAttribute("mode", "qc");
            response.sendRedirect("qc_invoice_ui.jsp");
            return;
        }

        /* ===== DEFAULT ===== */
        response.sendRedirect("home.jsp");
    }
}
