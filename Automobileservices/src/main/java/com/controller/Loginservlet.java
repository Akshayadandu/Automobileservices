package com.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import com.dao.Userdao;
import com.model.Usermodel;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class Loginservlet extends HttpServlet {

    private static final String ADMIN_USERNAME = "dreams";
    private static final String ADMIN_PASSWORD = "dreams";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        ServletContext context = getServletContext();
        Map<String, String> activeUsers =
            (Map<String, String>) context.getAttribute("activeUsers");

        if (activeUsers == null) {
            activeUsers = new HashMap<>();
            context.setAttribute("activeUsers", activeUsers);
        }
        /* ===== ADMIN LOGIN ===== */
        if (ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password)) {

            HttpSession session = request.getSession();
            session.setAttribute("admin", "dreams");

            response.sendRedirect("homelogin.jsp?success=1");
            return;
        }

       

        /* ===== NORMAL USER LOGIN ===== */
        Usermodel user = new Usermodel();
        user.setusername(username);
        user.setpassword(password);

        Userdao dao = new Userdao();
        Usermodel validUser = dao.valid(user);
        
        if (validUser != null) {
        	HttpSession oldSession = request.getSession(false);
        	if (oldSession != null && oldSession.getAttribute("username") == null) {
        	    oldSession.invalidate();
        	}

        	HttpSession currentSession = request.getSession();
        	String oldSessionId = activeUsers.get(username);

        	if (oldSessionId != null && !oldSessionId.equals(currentSession.getId())) {
        	    activeUsers.remove(username);
        	}

        	if (activeUsers.containsKey(username)) {
        	    response.sendRedirect("login.jsp?error=User+already+logged+in");
        	    return;
        	}

        	HttpSession session = currentSession;
        	session.setAttribute("username", validUser.getusername());
        	session.setAttribute("mode", "verify");

        	activeUsers.put(username, session.getId());
        	response.sendRedirect("verify_invoice_ui.jsp?success=1");

        } else {
        	response.sendRedirect("login.jsp?error=Invalid+username+or+password");
        }
    }
}

