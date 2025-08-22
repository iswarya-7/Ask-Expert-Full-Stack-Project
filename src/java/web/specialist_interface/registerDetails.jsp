<%-- 
    Document   : registerDetails
    Created on : 17 Apr, 2025, 4:10:44 PM
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
        <%
            String fname = request.getParameter("full_name");
            String gen = request.getParameter("gender");
            String db = request.getParameter("dob");
            String mail = request.getParameter("email");
            String phone = request.getParameter("phone_no");
            String profile = request.getParameter("profile_photo");
            String expertixeCategory = request.getParameter("category");
            String expertiseDomain = request.getParameter("sub-category");
            String experience_year = request.getParameter("experience");
            String current_Workplace = request.getParameter("workplace");
            String about = request.getParameter("bio");
            String portfolio = request.getParameter("personal_website");
            String linkedinUrl = request.getParameter("linkedin");

// Dob [convert 'yyyy-mm-dd' to 'dd-mm-yyyy']
            String formattedDob = "";
            try {
//    convert it to 'dd-mm-yyyy'
                SimpleDateFormat fromFormat = new SimpleDateFormat("yyyy-mm-dd");
                SimpleDateFormat toFormat = new SimpleDateFormat("dd-mm-yyyy");

//     change string into date obj           
                Date date = fromFormat.parse(db);
                formattedDob = toFormat.format(date);

            } catch (Exception e) {
                out.println("Error: " + e);
            }

            //  String submitbtn = request.getParameter("submit");
            Connection con = null;
            PreparedStatement pst = null;

            // Step 2: Load JDBC driver and connect to DB
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

            try {

                // Step 3: Insert query
                String query = "INSERT INTO specialist_regdetails(full_name, gender, dob, email, mobile,Profile_pic,expertise_category,specialization,experience,current_workplace,bio,portfolio,linkedin_link ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                pst = con.prepareStatement(query);
                pst.setString(1, fname);
                pst.setString(2, gen);
                pst.setString(3, formattedDob);
                pst.setString(4, mail);
                pst.setString(5, phone);
                pst.setString(6, profile);
                pst.setString(7, expertixeCategory);
                pst.setString(8, expertiseDomain);
                pst.setString(9, experience_year);
                pst.setString(10, current_Workplace);
                pst.setString(11, about);
                pst.setString(12, portfolio);
                pst.setString(13, linkedinUrl);

                int result = pst.executeUpdate();

                if (result > 0) {
                    out.println("Registered Successfully! <a href='../login.jsp'>Login</a>");
//                    out.println("<script type='text/javascript'>");
//                    out.println("window.location.href = '../login.jsp'");
//                    out.println("</script>");
                } else {
                    out.println("<script> alert('Registration Failed!')</script>");
                }

            } catch (Exception e) {
                out.println("<h3>Error: " + e.getMessage() + "</h3>");
            } finally {
                try {
                    if (pst != null) {
                        pst.close();
                    }
                } catch (Exception e) {
                }
                try {
                    if (con != null) {
                        con.close();
                    }
                } catch (Exception e) {
                }
            }


        %> 
    </body>
</html>
