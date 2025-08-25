<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    int specialistId = (Integer) session.getAttribute("specialistId");
    int unreadCount = 0;

    try {
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
        PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM notifications WHERE recipient_id = ? AND status = 'unread'");
        ps.setInt(1, specialistId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            unreadCount = rs.getInt(1);
        }
        conn.close();
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!-- In your HTML -->

<html>
    <head>
        <title>Header</title>
        <link rel="stylesheet" href="style.css">
        <!--<link rel="stylesheet" href="styles.css">-->

        <style>
            header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                /*padding: 10px 30px;*/
                background-color: #6a59d1;
                color: white;
                position: sticky;
                top: 0;
                z-index: 1000;
            }

            .header-title {
                font-size: 24px;
                font-weight: bold;
                position: relative;
                left: -150px;
            }

            .header-actions {
                display: flex;
                align-items: center;
                gap: 20px;
                position: relative;
                left: 150px;
            }

            .action-btn {
                background: none;
                border: none;
                color: white;
                font-size: 20px;
                cursor: pointer;
                position: relative;
            }
            /*search icon*/
            /*            .search-container {
                            flex: 1;
                            max-width: 600px;
                            margin: 0 20px;
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
                        }*/


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
                height: 42px;
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
            <!--            <div class="search-container">
                            <input type="text" class="search-input" placeholder="search question...">
                        </div>-->
            <div class="header-actions" >
                <a href="SpecialistaskQuestion.jsp">
                    <!--<button class="action-btn plus" onclick="addquestion()" >-->
                    <button class="action-btn plus" >
                        <i class="fas fa-plus"  ></i>
                    </button></a>


                <!--                <div class="notification-container">
                                    <button class="action-btn notification-btn" id="notificationBtn" style="position:relative;top: 25px;">
                                        <i class="fas fa-bell"></i>
                                        <span class="notification-badge"><%= unreadCount%></span>
                                    </button>-->
                <!--                    <div class="notification-dropdown" id="notificationDropdown">
                                        <div class="notification-header">
                                            <h3>Notifications</h3>
                                            <form action="<%= request.getContextPath()%>/MarkAllReadSpecServlet" method="post">
                                                <input type="hidden" name="user_id" value="<%= session.getAttribute("specialistId")%>">
                                                <button type="submit" class="mark-all-btn">Mark all as read</button>
                                            </form>
                
                                        </div>
                                    </div>-->
                <!--<div class="notification-list">-->


                <%--    <%
                        try {
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
                            PreparedStatement ps = conn.prepareStatement("SELECT message, created_at FROM notifications WHERE recipient_id = ? ORDER BY created_at DESC LIMIT 3");
                            ps.setInt(1, specialistId);
                            ResultSet rs = ps.executeQuery();
                            while (rs.next()) {
                                String message = rs.getString("message");
                                Timestamp time = rs.getTimestamp("created_at");
                    %>
                    <div class="notification-item unread">
                        <div class="notification-icon answer-icon">
                            <i class="fas fa-check-circle"></i>
                        </div>

                                <div class="notification-content">
                                    <p class="notification-title"><%=message%></p>
                                    <p class="notification-time"><%=time%></p>
                                </div>
                            </div>

                        </div>
                        <%
                                }

                                conn.close();
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        %>
                        <!--                        <div class="notification-footer">
                                                    <a href="notifications.jsp" class="view-all-btn">View all notifications</a>
                                                </div>-->
                    </div>
                </div>--%>

                <button class=" profile-btn"  id="user_icon">
                    <div class="dropdown"  >
                        <img src="<%= request.getContextPath()%>/profileimages/<%= session.getAttribute("profileimage")%>" alt="Profile Picture"  class="userprofile" />
                    </div>
                </button>
                <!--</div>-->
        </header>

    </body>
    <script src="notify.js"></script>

</html>