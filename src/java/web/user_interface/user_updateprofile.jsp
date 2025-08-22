<%-- 
    Document   : user_updateprofile
    Created on : 22 Apr, 2025, 9:38:57 AM
    Author     : rohini
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date, java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%@ include file="db_connection.jsp" %>
        <%    if (session.getAttribute("id") == null) {
                response.sendRedirect("login.jsp");
            }

            String fullname = request.getParameter("full_name");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String bio = request.getParameter("bio");

            int id = (Integer) session.getAttribute("id");

            Connection con = (Connection) application.getAttribute("conn");
            PreparedStatement ps = con.prepareStatement(
                    "UPDATE user_regdetails1 SET full_name=?, email=?, mobile=?,Bio=?  WHERE id=?"
            );
            ps.setString(1, fullname);
            ps.setString(2, email);
            ps.setString(3, phone);
            ps.setString(4, bio);

            ps.setInt(5, id);

            int i = ps.executeUpdate();
            if (i > 0) {
                // Update session too
                session.setAttribute("fullname", fullname);
                session.setAttribute("email", email);
                session.setAttribute("phone", phone);
                session.setAttribute("bio", bio);

                out.println("<script>alert('Profile Update Successfully !!');</script>");
                response.sendRedirect("../user_interface/user_home.jsp");

            } else {
                out.println("Update failed");
            }
        %>
    </body>
</html>
