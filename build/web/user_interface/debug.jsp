<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Database Debug</title>
</head>
<body>
    <h1>Database Connection Test</h1>
    
    <%
    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
        out.println("<p style='color:green'>Database connection successful!</p>");
        
        // Test query to get all questions
        PreparedStatement ps = conn.prepareStatement("SELECT * FROM questions");
        ResultSet rs = ps.executeQuery();
        
        out.println("<h2>Questions in Database:</h2>");
        out.println("<table border='1'>");
        out.println("<tr><th>ID</th><th>User ID</th><th>Title/Question</th><th>Category</th><th>Status</th><th>Date</th></tr>");
        
        boolean hasRows = false;
        while(rs.next()) {
            hasRows = true;
            out.println("<tr>");
            
            // Try different column names that might exist
            try {
                out.println("<td>" + rs.getInt("question_id") + "</td>");
            } catch (Exception e) {
                try {
                    out.println("<td>" + rs.getInt("id") + "</td>");
                } catch (Exception ex) {
                    out.println("<td>Unknown</td>");
                }
            }
            
            try {
                out.println("<td>" + rs.getInt("user_id") + "</td>");
            } catch (Exception e) {
                out.println("<td>Unknown</td>");
            }
            
            try {
                out.println("<td>" + rs.getString("title") + "</td>");
            } catch (Exception e) {
                try {
                    out.println("<td>" + rs.getString("question") + "</td>");
                } catch (Exception ex) {
                    out.println("<td>Unknown</td>");
                }
            }
            
            try {
                out.println("<td>" + rs.getString("category") + "</td>");
            } catch (Exception e) {
                out.println("<td>Unknown</td>");
            }
            
            try {
                out.println("<td>" + rs.getString("status") + "</td>");
            } catch (Exception e) {
                out.println("<td>Unknown</td>");
            }
            
            try {
                out.println("<td>" + rs.getDate("posted_at") + "</td>");
            } catch (Exception e) {
                try {
                    out.println("<td>" + rs.getDate("created_date") + "</td>");
                } catch (Exception ex) {
                    out.println("<td>Unknown</td>");
                }
            }
            
            out.println("</tr>");
        }
        
        out.println("</table>");
        
        if (!hasRows) {
            out.println("<p>No questions found in the database.</p>");
        }
        
        // Show all column names for the questions table
        out.println("<h2>Column Names in Questions Table:</h2>");
        java.sql.DatabaseMetaData meta = conn.getMetaData();
        ResultSet columns = meta.getColumns(null, null, "questions", null);
        
        out.println("<ul>");
        while (columns.next()) {
            String columnName = columns.getString("COLUMN_NAME");
            String columnType = columns.getString("TYPE_NAME");
            out.println("<li>" + columnName + " (" + columnType + ")</li>");
        }
        out.println("</ul>");
        
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
        e.printStackTrace(new java.io.PrintWriter(out));
    }
    %>
    
    <h2>Session Information</h2>
    <p>User ID in session: <%= session.getAttribute("userId") %></p>
    
    <h2>Test Links</h2>
    <p><a href="${pageContext.request.contextPath}/GetQuestionServlet?filter=all&userId=1">Get All Questions (User ID 1)</a></p>
    <p><a href="${pageContext.request.contextPath}/GetQuestionServlet?filter=Pending&userId=1">Get Pending Questions (User ID 1)</a></p>
</body>
</html>