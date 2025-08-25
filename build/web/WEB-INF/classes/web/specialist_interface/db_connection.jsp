<%-- 
    Document   : db
    Created on : 17 Apr, 2025, 12:15:06 PM
    Author     : rohini
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ask Expert / Home Page</title>
    </head>
    <body>
        <%
            Connection conn = null;
            String url = "jdbc:mysql://localhost:3306/askexpert";
            String dbUser = "root";
            String dbPass = "";

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection(url, dbUser, dbPass);
                application.setAttribute("conn", conn);
            } catch (Exception e) {
                out.println("DB Error: " + e);
            }
        %>

    </body>
</html>