<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%

    Integer sId = (Integer) session.getAttribute("specialistId");
    out.print("<script>console.log('User ID: " + sId + "')</script>");
    String sId = "";
    if (sId != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM questions WHERE user_id = ?");
            ps.setInt(1, sId);
            ResultSet rs = ps.executeQuery();

//            uid = String.valueOf(userId);
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    sId = (sId != null) ? String.valueOf(sId) : "";

    List<Map<String, String>> questions = (List<Map<String, String>>) session.getAttribute("questions");
    String filter = (String) session.getAttribute("filter");
    if (filter == null) {
        filter = "all";
    }
    out.print("<script>console.log('Filter: " + filter + "')</script>");
    if (questions != null) {
        out.print("<script>console.log('Questions count: " + questions.size() + "')</script>");
    } else {
        out.print("<script>console.log('Questions is null')</script>");
    }

%>




<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ask Expert - Home</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- google fonts -->
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
            rel="stylesheet">
        <!--External style sheet-->
        <!--<link rel="stylesheet" href="<= request.getContextPath()%>/style.css">-->
        <style>
            /*Reset and Base Styles*/ 
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'poppins',sans-serif;
            }

            body {
                background-color: #f5f5f5;
                color: #333;
                line-height: 1.6;
            }

            a {
                text-decoration: none;
                color: inherit;
            }

            ul {
                list-style: none;
            }

            button {
                cursor: pointer;
                background: none;
                border: none;
                outline: none;
            }

            /* Layout */
            .app-container {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                font-family: 'poppins',sans-serif;
            }

            .main-wrapper {
                display: flex;
                flex: 1;
            }

            /* Header */
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
            }

            .header-title {
                font-size: 28px;
                font-weight: 760;
                width: 200px;
            }

            .search-container {
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
            }

            .header-actions {
                display: flex;
                gap: 15px;

            }

            .action-btn {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: white;
                color: #FF7F00;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 18px;
                transition: all 0.2s ease;
            }

            .action-btn:hover {
                transform: scale(1.05);
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            }

            /*user dropdown*/
            .dropdown {
                position: relative;
                display: inline-block;
            }

            #user_drop{
                margin-left: -100px;
                margin-top: 0px;
            }


            .dropdown_content {
                /* display: none; */
                position: absolute;
                /* Fixes right-side extra space issue */
                top: 45px;
                /*    left: -30px;*/
                background-color: white;
                min-width: 200px;
                /* Increased width to fit content properly */
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
                border-radius: 8px;
                overflow: hidden;
                z-index: 1;
                opacity: 0;
                transition: max-height 0.6s ease-in-out, opacity 0.5s ease-in-out;

            }

            .dropdown_content.show {
                /* min-height: 150px; */
                opacity: 1;
                visibility: visible;
            }

            .dropdown_content a {
                display: flex;
                align-items: center;
                /* Ensures icons & text align properly */
                gap: 12px;
                /* Space between icon and text */
                padding: 15px 36px;
                font-size: 16px;
                text-decoration: none;
                color: black;
                transition: 0.3s;
            }

            /* Icon styling (if using FontAwesome or similar) */
            .dropdown_content a i {
                font-size: 18px;
                color: #fd7e14;

            }

            .dropdown:hover .dropdown_content {
                display: block;
            }

            .dropdown .dropdown_content a:hover {
                background-color: rgba(102, 99, 99, 0.123);
            }

            .dropdown:hover .dropdown_btn {
                background-color: #b64900;
            }
            /*
                         Sidebar 
                        .sidebar {
                            width: 270px;
                            background:#ff8000bd;
                            box-shadow:  0px 8px 16px rgba(0, 0, 0, 0.2);
                            color: white;
                            position: fixed;
                            top: 50px;
                            left: 0;
                            bottom: 0;
                            z-index: 900;
                            overflow-y: auto;
                        }
            
                        .sidebar-nav {
                            padding: 20px 0;
                            width: 100%;    
                        }
            
                        .nav-item {
                            margin-bottom: 5px;
                        }
            
                        .nav-link {
                            display: flex;
                            align-items: center;
                            padding: 12px 25px;
                            transition: background-color 0.2s ease;
                        }
            
                        .nav-link:hover, .nav-link.active {
                            background-color: rgba(255, 255, 255, 0.2);
                            font-weight: bold;
                            width: 100%;
                        }
            
                        .nav-link i {
                            margin-right: 15px;
                            font-size: 18px;
                        }
                        .nav-link span{
                            font-size: 18px;
                        }*/

            /* Main Content */
            .main-content {
                flex: 1;
                margin-top: 60px;
                padding: 20px;
                overflow-y: auto;
            }

            .content-wrapper {
                max-width: 1200px;
                margin: 0 auto;
                margin-left: 200px;

            }

            h1 {
                margin-bottom: 20px;
                color: #333;
            }

            /* Question Filters */
            .question-filters {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
            }

            .filter-btn {
                padding: 8px 15px;
                border-radius: 20px;
                background-color: #f0f0f0;
                color: #666;
                font-weight: 500;
                transition: all 0.2s ease;
            }

            .filter-btn:hover, .filter-btn.active {
                background-color: #FF7F00;
                color: white;
            }

            /* Question List */
            .question-list {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            .question-card {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .question-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 15px;
                background-color: #f9f9f9;
                border-bottom: 1px solid #eee;
            }

            .question-category {
                padding: 5px 10px;
                border-radius: 15px;
                background-color: #e6f7ff;
                color: #0066cc;
                font-size: 12px;
                font-weight: 500;
            }

            .question-status {
                font-size: 12px;
                font-weight: 500;
                padding: 5px 10px;
                border-radius: 15px;
            }

            .question-status.pending {
                background-color: #fff3e0;
                color: #ff9800;
            }

            .question-status.answered {
                background-color: #e8f5e9;
                color: #4caf50;
            }

            .question-body {
                padding: 10px;
            }

            .question-body h3 {
                margin-bottom: 10px;
                color: #333;
                display: flex;
                justify-content: left;
                padding-left: 10px;
            }

            .question-body p {
                color: #666;
            }

            .question-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 15px;
                border-top: 1px solid #eee;
                background-color: #f9f9f9;
            }

            .question-date {
                font-size: 12px;
                color: #888;
            }

            .question-action-btn {
                color: #666;
                font-size: 16px;
            }

            </style>
    </head>
    <body>

        <div class="app-container ">
            <!-- Include Header -->
            <jsp:include page="nav.jsp" />

            <div class="main-wrapper">
                <!-- Include Sidebar -->
                <jsp:include page="sidebar.jsp" />

                <!-- Main Content -->
                <main class="main-content" id="main-content" style="margin-left:70px; margin-top: 40px;" >
                    <!-- Content will be loaded here -->

                    <div class="content-wrapper">
                        <h1>My Questions</h1>
                        <!--getting userid using hiddent input field-->
                        <input type="hidden" value="<%=sId%>" name="userid"/>
                        <div class="question-filters">
                            <a href="${pageContext.request.contextPath}/SpecialistGetQuestion?filter=all&userId=<%= sId%>">    <button class="filter-btn <%= ("all".equals(filter) || filter == null) ? "active" : ""%>" data-filter="all">All Questions</button></a>
                            <a href="${pageContext.request.contextPath}/SpecialistGetQuestion?filter=Pending&userId=<%= sId%>">  <button class="filter-btn <%= "Pending".equals(filter) ? "active" : ""%>" data-filter="Pending">Pending</button></a>
                            <a href="${pageContext.request.contextPath}/SpecialistGetQuestion?filter=Answered&userId=<%= sId%>">     <button class="filter-btn <%= "Answered".equals(filter) ? "active" : ""%>" data-filter="answered">Answered</button></a>
                        </div>

                        <div class="question-list">


                            <% if (questions != null && !questions.isEmpty()) {
                                    for (Map<String, String> q : questions) {%>

                            <div class="question-card" data-status="<%= q.get("status")%>">

                                <div class="question-header">
                                    <span class="question-category"><%= q.get("category")%></span>
                                    <span class="question-status <%= q.get("status")%>">
                                        <%= q.get("status").toLowerCase()%>
                                    </span>

                                    <!--                                    <span class="question-category">Health</span>
                                                                        <span class="question-status pending">Pending</span>-->
                                </div>
                                <div class="question-body">
                                    <h3><%= q.get("question")%></h3>

                                    <!--<h3>What are the best exercises for lower back pain?</h3>-->
                                    <!--<p>I've been experiencing lower back pain for the past few weeks. What exercises would you recommend to alleviate the pain?</p>-->
                                </div>
                                <div class="question-footer">
                                    <span class="question-date">Posted: <%= q.get("date")%></span>
                                    <!--<span class="question-date">Posted: April 20, 2023</span>-->
                                    <button class="question-action-btn">
                                        <i class="fas fa-ellipsis-v"></i>
                                    </button>
                                </div>
                            </div>
                            <%   }
                            } else { %>
                            <p>No questions found.</p>
                            <% }%>


                          </div>
                    </div>
                </main>
            </div>

        </div>

    </body>

    <!--<script src="script.js"></script>-->
</html>
