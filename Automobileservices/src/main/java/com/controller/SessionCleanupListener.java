package com.controller;

import jakarta.servlet.ServletContext;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

import java.util.Map;
@WebListener
public class SessionCleanupListener implements HttpSessionListener {

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {

        ServletContext context = se.getSession().getServletContext();
        Map<String, String> activeUsers =
            (Map<String, String>) context.getAttribute("activeUsers");

        if (activeUsers == null) return;

        String username = (String) se.getSession().getAttribute("username");

        System.out.println("Session destroyed for user = " + username);

        if (username != null) {
            activeUsers.remove(username);
            System.out.println("Removed from activeUsers: " + username);
        }
    }
}
