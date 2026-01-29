package com.db;

import java.sql.Connection;
import java.sql.DriverManager;

public class Dbconnection {

    private static final String URL =
        "jdbc:mysql://localhost:3306/automobileservices"
      + "?useSSL=false"
      + "&allowPublicKeyRetrieval=true"
      + "&serverTimezone=UTC";

    private static final String USER = "root";
    private static final String PASS = "Akshaya216e@";

    public static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
