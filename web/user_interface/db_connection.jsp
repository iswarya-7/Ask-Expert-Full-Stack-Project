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
                // Use the updated driver class name
                Class.forName("com.mysql.jdbc.Driver");

                // Establish the connection
                conn = DriverManager.getConnection(url, dbUser, dbPass);
                
                // Store the connection in the application scope
                application.setAttribute("conn", conn);
                
                // Optionally, you can check if the connection is successful
//                out.println("Database connection successful");
            } catch (Exception e) {
                out.println("DB Error: " + e.getMessage());
            }
        %>
    </body>
</html>
