<%-- 
    Document   : SpecialistUpdateAnswer
    Created on : 4 May, 2025, 7:14:41 PM
    Author     : rohini
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date, java.sql.*" %>
<%
    Integer specialistId = (Integer) session.getAttribute("specialistId");
    String message = "";
    if (specialistId != null) {
        String answer = request.getParameter("updateans");
        int answerId = Integer.parseInt(request.getParameter("answerid"));
        try {

            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
            PreparedStatement ps = conn.prepareStatement("UPDATE answers SET answer_text=? where answer_id=?");
            ps.setString(1, answer);
            ps.setInt(2, answerId);

            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                message = "true";
                session.setAttribute("answer", answer);
                response.sendRedirect("viewUrAnswers.jsp?sucess=true");
            } else {
                out.println("Error updating answer.");
                response.sendRedirect("viewUrAnswers.jsp?sucess=error");
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        response.sendRedirect("specialist_login.jsp?Success=error");
    }
%>
