package com.controller;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

import com.dao.Userdao;
import com.model.Usermodel;

@WebServlet("/Registerservlet")
public class Registerservlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String username = req.getParameter("username");
        String password = req.getParameter("password");

        Usermodel lm = new Usermodel();
        lm.setusername(username);
        lm.setpassword(password);

        Userdao ld = new Userdao();

        if (ld.register(lm)) {
            res.sendRedirect("register.jsp?success=1");
        } else {
            res.sendRedirect("register.jsp?error=1");
        }
    }
}
