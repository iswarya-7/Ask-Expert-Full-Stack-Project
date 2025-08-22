<%-- 
    Document   : profile
    Created on : 1 May, 2025, 11:27:43 AM
    Author     : rohini
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    String fname = "", gender = "", mobile = "", email = "", profilePhoto = "", bio = "", id = "";
    if (userId != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM user_registerdetails WHERE id = ?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                fname = rs.getString("full_name");
                gender = rs.getString("gender");
                email = rs.getString("email");
                mobile = rs.getString("mobile");
                profilePhoto = rs.getString("profile_photo");
                bio = rs.getString("bio");
                id = rs.getString("id");

            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!--<link rel="stylesheet" href="style.css">-->
        <style>
            .modal {
                display: block; /* For testing */
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                overflow: auto;
                background-color: rgba(0,0,0,0.4);
                z-index: 1000;
            }

            .modal-content {
                background-color: #fefefe;
                margin: 10% auto;
                padding: 20px;
                border-radius: 10px;
                width: 70%;
                position: relative;
            }
            .close {
                position: absolute;
                top: 10px;
                right: 25px;
                font-size: 30px;
                color: #aaa;
                cursor: pointer;
            }
            .center{
                margin-top: 100px;
                margin-left: 200px;
            }

            .container {
                width: 600px;
                margin: 50px auto;
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
                display: flex;
                gap: 30px;
            }


            .profile-pic {
                flex: 1;
                text-align: center;
                position: relative;
                left: -40px;
            }

            .profile-pic img {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
            }

            .profile-info {
                flex: 2;
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
            }

            .profile-info h2 {
                grid-column: span 2;
                margin: 0;
                font-size: 24px;
            }


            .info-group {
                display: flex;
                flex-direction: column;
            }

            .info-group label {
                font-weight: bold;
                color: #888;
                margin-bottom: 5px;
            }

            .info-group span {
                font-size: 16px;
            }

            .bio {
                grid-column: span 2;
            }

            .buttons {
                margin-top: 30px;
                text-align: right;
                grid-column: span 2;
            }

            .buttons a {
                text-decoration: none;
                background-color: #ff7b00;
                color: white;
                padding: 10px 20px;
                border-radius: 8px;
                font-weight: 500;
            }


        </style>
    </head>
    <body>
        <div class="app-container">
            <!-- Include Header -->
            <jsp:include page="user_nav.jsp" />

            <div class="main-wrapper">
                <!-- Include Sidebar -->
                <jsp:include page="user_sidebar.jsp" />

                <!-- Main Content -->
                <main class="main-content" id="main-content">


                    <div class="center">
                        <!--<div id="profileModal" class="modal">-->
                        <!--<div class="modal-content">-->
                        <div class="profile-container">
                            <div class="container ">
                                <span class="close" onclick="closeProfileModal()">&times;</span>

                                <div class="profile-pic">
                                    <!--<img src="uploads/{sessionScope.profileimage}" alt="Profile Image">-->
                                    <img src="<%= request.getContextPath()%>/profileimages/<%=profilePhoto%>" alt="Profile Picture" />
                                    <p style="margin-top: 10px; font-weight: bold;"><%= fname%></p>
                                </div>

                                <div class="profile-info">
                                    <h2>Profile Preview</h2>

                                    <div class="info-group">
                                        <label>User name </label>
                                        <span><%=fname%></span>
                                    </div>

                                    <div class="info-group">
                                        <label>Email</label>
                                        <span><%= email%></span>
                                    </div>

                                    <div class="info-group">
                                        <label>Phone</label>
                                        <span><%= mobile%></span>
                                    </div>
<!--                                    <div class="info-group">
                                        <label>Gender</label>
                                        <span><%= gender%></span>
                                    </div>-->


                                    <div class="info-group bio">
                                        <label>Bio</label>
                                        <!--<span>= session.getAttribute("bio")</span>-->
                                        <span><%=bio != null ? bio: "Add Your Bio...."%></span>
                                    </div>

                                    <div class="buttons">
                                        <a href="<%=request.getContextPath()%>/user_interface/user_editProfile.jsp">Edit Profile</a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--</div>-->
                    <!--</div>-->
                </main>
            </div>
        </div>



        <script>
            function closeProfileModal() {
                const modal = document.querySelector(".center");
                if (modal) {
                    modal.style.display = "none";
                    window.location.href = "user_home.jsp";

                }
            }

        </script>
    </body>
</html>
