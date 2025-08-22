<%-- 
    Document   : SpecialistUpdateAnswer
    Created on : 4 May, 2025, 7:14:41 PM
    Author     : rohini
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date, java.sql.*" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    String message = "";
    if (userId != null) {
        String question = request.getParameter("question");
        int questionId = Integer.parseInt(request.getParameter("questionId"));
        try {

            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
            PreparedStatement ps = conn.prepareStatement("UPDATE questions SET question=? where question_id=?");
            ps.setString(1, question);
            ps.setInt(2, questionId);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                message = "true";
                session.setAttribute("question", question);
                response.sendRedirect("questions.jsp?sucess=true");
            } else {
                out.println("Error updating answer.");
                response.sendRedirect("questions.jsp?sucess=error");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("user_login.jsp?Success=error");
    }
%>
