package com.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/home")
public class Homeservlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("verify".equals(action)) {
            response.sendRedirect("verify_invoice_ui.jsp");

        } else if ("qc".equals(action)) {
            response.sendRedirect("qc_invoice_ui.jsp");

        } else {
            response.sendRedirect("home.jsp");
        }
    }
}
