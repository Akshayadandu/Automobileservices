package com.controller;

import java.io.IOException;

import com.dao.Userdao;
import com.model.Usermodel;

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

        Usermodel user = new Usermodel();
        user.setusername(username);
        user.setpassword(password);

        Userdao dao = new Userdao();
        Usermodel validUser = dao.valid(user);

        if (validUser != null) {
            HttpSession session = request.getSession();
            session.setAttribute("username", validUser.getusername());

            response.sendRedirect("home.jsp");
        } else {
            // ❗ redirect back to login
            response.sendRedirect("login.jsp?error=1");
        }
    }
}
