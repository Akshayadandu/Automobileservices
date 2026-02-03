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
@WebServlet("/homeloginservlet")
public class Homeloginservlet extends HttpServlet {

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
        HttpSession oldSession = request.getSession(false);
        if (oldSession != null && oldSession.getAttribute("username") == null) {
            oldSession.invalidate();
        }

        HttpSession currentSession = request.getSession();
        String oldSessionId = activeUsers.get(username);

        if (oldSessionId != null && !oldSessionId.equals(currentSession.getId())) {
            // Old session is dead (tab closed / browser crashed)
            activeUsers.remove(username);
        }

        // ❌ already logged in
        if (activeUsers.containsKey(username)) {
            response.sendRedirect("login.jsp?error=User+already+logged+in");
            return;
        }

        Usermodel user = new Usermodel();
        user.setusername(username);
        user.setpassword(password);

        Userdao dao = new Userdao();
        Usermodel validUser = dao.valid(user);

        if (validUser != null) {

            HttpSession session = currentSession;
            session.setAttribute("username", username);
            session.setAttribute("qcEligible", true);

            activeUsers.put(username, session.getId());

            response.sendRedirect("home.jsp");
        } else {
            response.sendRedirect("login.jsp?error=1");
        }
    }
}
