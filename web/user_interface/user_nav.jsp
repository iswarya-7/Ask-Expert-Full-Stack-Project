<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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

                session.setAttribute("uprofile", profilePhoto);

            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<html>
    <head>
        <title>Header</title>
         <!--<link rel="stylesheet" href="<%= request.getContextPath() %>/style.css">--> 
        <!--<link rel="stylesheet" href="styles.css">-->

        <style>

            /*search icon*/
            .header {
                display: flex;
                align-items: center;
                justify-content: space-around;
                padding: 0 20px;
                height: 60px;
                background: linear-gradient(to right, #FF7F00, #FF4500);
                color: white;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1000;
                width: 100%; /* Ensure full width */
                box-sizing: border-box;
            }

            .search-container {
                flex: 1;
                max-width: 600px;
                margin: 0 20px;
                width: 100%; /* Ensure it stretches properly */
            }
            .search-input {
                width: 100%;
                padding: 10px 20px;
                border: none;
                border-radius: 20px;
                background-color: rgba(255, 255, 255, 0.3);
                color: white;
                font-size: 16px;
            }

            .search-input::placeholder {
                color: rgba(255, 255, 255, 0.8);
            }


            /* Close Button */
            .container .close {
                color: black;
                position: relative;
                left: 100%;
                top: -30px;
                font-size: 24px;
                cursor: pointer;
            }

            Profile Styling .profile-container {
                text-align: center;
            }


            .container {
                max-width: 800px;
                margin: 50px auto;
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
                padding: 40px;
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
            .dropdown .userprofile{
                height: 40px;
                width: 40px;
                border-radius: 50%;
                position: relative;
                top: 4px;
            }


        </style>
    </head>
    <body>
        <header class="header">
            <div class="header-title">Ask Expert</div>
            <div class="search-container">
                <form action="user_home.jsp" method="get">
                    <input type="text" name="search"  id="searchInput" class="search-input" placeholder="Search question..."  value="<%= request.getParameter("search") != null ? request.getParameter("search") : ""%>" />
                </form>
            </div>
            <div class="header-actions">
                <a href="askQuestion.jsp">
                    <button class="action-btn plus" >
                        <i class="fas fa-plus"  ></i>
                    </button></a>


                <!--                <div class="notification-container">
                                    <button class="action-btn notification-btn" id="notificationBtn">
                                        <i class="fas fa-bell"></i>
                                        <span class="notification-badge">3</span>
                                    </button>
                                    <div class="notification-dropdown" id="notificationDropdown">
                                        <div class="notification-header">
                                            <h3>Notifications</h3>
                                            <button class="mark-all-btn">Mark all as read</button>
                                        </div>
                                        <div class="notification-list">
                                            <div class="notification-item unread">
                                                <div class="notification-icon answer-icon">
                                                    <i class="fas fa-check-circle"></i>
                                                </div>
                                                <div class="notification-content">
                                                    <p class="notification-title">Your question about JavaScript has been answered</p>
                                                    <p class="notification-time">5 minutes ago</p>
                                                </div>
                                            </div>
                                            <div class="notification-item unread">
                                                <div class="notification-icon expert-icon">
                                                    <i class="fas fa-user-tie"></i>
                                                </div>
                                                <div class="notification-content">
                                                    <p class="notification-title">Dr. Smith is now available to answer your questions</p>
                                                    <p class="notification-time">1 hour ago</p>
                                                </div>
                                            </div>
                                            <div class="notification-item">
                                                <div class="notification-icon system-icon">
                                                    <i class="fas fa-info-circle"></i>
                                                </div>
                                                <div class="notification-content">
                                                    <p class="notification-title">Welcome to AskExpert! Connect with worldwide experts</p>
                                                    <p class="notification-time">2 days ago</p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="notification-footer">
                                            <a href="notifications.jsp" class="view-all-btn">View all notifications</a>
                                        </div>
                                    </div>
                                </div>-->


                <button class=" profile-btn"  id="user_icon">
                    <div class="dropdown"  >
                        <img src="<%= request.getContextPath()%>/profileimages/<%=profilePhoto%>" alt="Profile Picture"  class="userprofile" />
                    </div>
                </button>
            </div>
        </header>

        <!--        <div class="center">
                    <div id="profileModal" class="modal">
                        <div class="modal-content">
                            <div class="profile-container">
                                <div class="container ">
                                    <span class="close" onclick="closeProfileModal()">&times;</span>
        
                                    <div class="profile-pic">
                                        <img src="uploads/{sessionScope.profileimage}" alt="Profile Image">
        <%--        <img src="<%= request.getContextPath()%>/profileimages/<%= session.getAttribute("profileimage")%>" alt="Profile Picture" /> --%>
                <p style="margin-top: 10px; font-weight: bold;"><%= session.getAttribute("fullname")%></p>
            </div>

            <div class="profile-info">
                <h2>Profile Preview</h2>

                <div class="info-group">
                    <label>User name </label>
        <%--  <span><%= session.getAttribute("fullname")%></span> --%>
     </div>

     <div class="info-group">
         <label>Email</label>
        <%--       <span><%= session.getAttribute("email")%></span>  --%>
           </div>

           <div class="info-group">
               <label>Phone</label>
        <%--    <span><%= session.getAttribute("phone")%></span>  --%>
        </div>
        <div class="info-group">
            <label>Gender</label>
        <%--           <span><%= session.getAttribute("gender")%></span>   --%>
               </div>


               <div class="info-group bio">
                   <label>Bio</label>
                   <span>= session.getAttribute("bio")</span>
        <%--                               <span><%=session.getAttribute("bio") != null ? session.getAttribute("bio") : "Add Your Bio...."%></span>--%>
                                   </div>
   
                                   <div class="buttons">
        <%--        <a href="<%=request.getContextPath()%>/user_interface/user_editProfile.jsp">Edit Profile</a>  --%>
            </div>
        </div>
    </div>
</div>
</div>
</div>
</div>-->
    </body>
    <script src="notify.js"></script>

</html>