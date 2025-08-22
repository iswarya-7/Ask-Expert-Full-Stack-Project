<%-- 
    Document   : pendingQuestions
    Created on : 2 May, 2025, 10:53:03 PM
    Author     : rohini
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.sql.Timestamp" %>


<%!
    // Method to escape JavaScript string literals
    public String escapeJS(String text) {
        if (text == null) {
            return "";
        }
        return text.replace("\\", "\\\\")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t")
                .replace("'", "\\'")
                .replace("\"", "\\\"");
    }
%>

<%@ include file="db_connection.jsp" %>
<%    String message = "";
    String semail = (String) session.getAttribute("email");
    Integer sId = (Integer) session.getAttribute("specialistId");
    String sName = (String) session.getAttribute("fullname");
    String uname = "", category = "", question = "", status = "", formattedDate = "", uProfile = "";
    int questionId = 0, userId, spId;  // Initialize questionId properly

    // Create a map to store user profile photos
//    Map<Integer, String> userProfiles = new HashMap<>();
    try {
        // Make sure the session contains specialistId
        if (sId == null) {
            message = "Specialist ID is not available in session.";
            response.sendRedirect("specialist_login.jsp"); // or show message
        }

        Connection con = (Connection) application.getAttribute("conn");
//        String sql = "SELECT q.*, u.profile_photo FROM questions q "
//                + "LEFT JOIN user_registerdetails u ON q.user_id = u.user_id "
//                + "WHERE q.specialist_id = ? AND q.specialist_name = ? AND q.status = 'Pending' "
//                + "ORDER BY q.question_id DESC";

        String sql = "SELECT * FROM questions WHERE specialist_id =? AND specialist_name =? AND status = 'pending' ORDER BY question_id DESC";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, sId);  // Set the value for specialist_id parameter
        ps.setString(2, sName);

        ResultSet rs = ps.executeQuery();  // Execute the query and get the result set
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pending Questions</title>
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <style>
            /* Layout */
            .app-container {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                font-family: 'Poppins', sans-serif;
            }

            .main-wrapper {
                display: flex;
                flex: 1;
                position: relative;
            }

            /* Main Content */
            .main-content {
                flex: 1;
                padding: 20px;
                overflow-y: auto;
                position: relative;
            }

            .content-wrapper {
                max-width: 1000px;
                margin: 0 auto;
                padding: 0 20px;
            }

            .page-title {
                font-size: 29px;
                font-weight: 600;
                margin: 30px 0 10px -80px;;
                color: #333;
            }

            /* Question Cards */
            .question-list {
                display: flex;
                flex-direction: column;
                gap: 20px;
                margin-bottom: 40px;
                margin-left: -80px;

            }

            .question-card {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
                overflow: hidden;
                width: 100%;
                transition: transform 0.2s, box-shadow 0.2s;
            }

            .question-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            }

            .question-header {
                display: flex;
                /*justify-content: space-between;*/
                align-items: center;
                padding: 12px 20px;
                background-color: #f9f9f9;
            }
            .uname{
                padding: 5px 15px;
                border-radius: 20px;
                background-color: #e6f7ff;
                color: #0066cc;
                font-size: 14px;
                font-weight: 500;
            }
            .question-category {
                padding: 5px 15px;
                border-radius: 20px;
                background-color: #e6f7ff;
                color: #0066cc;
                font-size: 14px;
                font-weight: 500;
            }

            .question-status {
                font-size: 14px;
                font-weight: 500;
                padding: 5px 15px;
                border-radius: 20px;
            }

            .question-status.pending {
                background-color: #fff3e0;
                color: #ff9800;
            }

            .question-body {
                padding: 20px;
            }

            .question-title {
                font-size: 18px;
                font-weight: 600;
                color: #333;
                margin-bottom: 10px;
            }

            .question-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 20px;
                background-color: #f9f9f9;
            }

            .question-date {
                font-size: 14px;
                color: #666;
            }

            .answer-btn {
                background: linear-gradient(to right, #FF7F00, #FF4500);
                color: white;
                border: none;
                border-radius: 4px;
                padding: 8px 20px;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                transition: background 0.3s;
            }

            .answer-btn:hover {
                background: linear-gradient(to left, #FF7F00, #FF4500);
            }

            .options-btn {
                background: none;
                border: none;
                color: #666;
                cursor: pointer;
                font-size: 18px;
            }

            /* Answer Form Overlay */
            .answer-overlay {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                /*background-color: rgba(255, 255, 255, 0.95);*/
                background-color: rgba(0, 0, 0, 0.3); /* light black fade */
                backdrop-filter: blur(2px);  /*optional soft blur effect */
                z-index: 1000;
                display: flex;
                flex-direction: column;
                padding: 20px;
                padding-top: 80px; /* Space for the header */
                overflow-y: auto;
                display: none;
            }

            .answer-form-container {
                max-width: 1000px;
                margin: 0 auto;
                width: 100%;
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 15px rgba(0, 0, 0, 0.2);
                overflow: hidden;
                margin-left: 330px;
                margin-top: 40px;
            }

            .answer-form-header {
                display: flex;
                align-items: center;
                padding: 20px;
                border-bottom: 1px solid #f0f0f0;
                position: relative;
            }

            .user-avatar {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                object-fit: cover;
                margin-right: 15px;
            }

            .user-info-container {
                flex: 1;
            }

            .user-name-display {
                font-weight: 600;
                font-size: 16px;
                color: #333;
                margin-bottom: 5px;
            }

            .post-timestamp {
                font-size: 14px;
                color: #666;
            }

            .close-form-btn {
                position: absolute;
                top: 15px;
                right: 15px;
                background: none;
                border: none;
                color: #ff4d4d;
                font-size: 22px;
                cursor: pointer;
                padding: 0;
                line-height: 1;
            }

            .close-form-btn:hover {
                color: #ff0000;
            }

            .question-display {
                padding: 20px;
                border-bottom: 1px solid #f0f0f0;
            }

            .question-label-text {
                font-weight: 600;
                margin-right: 5px;
                font-size: 16px;
            }

            .question-display-text {
                font-size: 16px;
                line-height: 1.5;
                color: #333;
            }

            .answer-form-body {
                padding: 20px;
            }

            .answer-input {
                width: 100%;
                min-height: 200px;
                border: 1px solid #e0e0e0;
                border-radius: 8px;
                padding: 15px;
                font-size: 16px;
                font-family: 'Poppins', sans-serif;
                resize: vertical;
                margin-bottom: 20px;
            }

            .answer-input:focus {
                outline: none;
                border-color: #FF7F00;
                box-shadow: 0 0 5px rgba(255, 127, 0, 0.3);
            }

            .answer-form-footer {
                display: flex;
                justify-content: flex-end;
                padding: 0 20px 20px 20px;
            }

            .submit-answer-button {
                background: linear-gradient(to right, #FF7F00, #FF4500);
                color: white;
                border: none;
                border-radius: 4px;
                padding: 10px 25px;
                font-size: 15px;
                font-weight: 500;
                cursor: pointer;
                transition: background 0.3s;
            }

            .submit-answer-button:hover {
                background: linear-gradient(to left, #FF7F00, #FF4500);
            }

            .hidden {
                display: none;
            }

            .visible {
                display: flex;
            }
        </style>
    </head>
    <body>
        <div class="app-container">
            <!-- Include Header -->
            <jsp:include page="nav.jsp" />

            <div class="main-wrapper">
                <!-- Include Sidebar -->
                <jsp:include page="sidebar.jsp" />

                <!-- Main Content -->
                <main class="main-content">
                    <div class="content-wrapper">
                        <h1 class="page-title">Pending Questions</h1>



                        <div class="question-list">

                            <%
                                boolean hasResults = false;
                                while (rs.next()) {
                                    hasResults = true;

                                    questionId = rs.getInt("question_id");
                                    uname = rs.getString("user_name");
                                    category = rs.getString("category");
                                    question = rs.getString("question");
                                    status = rs.getString("status");
                                    uProfile = rs.getString("userProfile");
                                    Timestamp timestamp = rs.getTimestamp("posted_at");

                                    // user id and  spec id
                                    userId = rs.getInt("user_id");
                                    spId = rs.getInt("specialist_id");

                                    // Save to session
                                    session.setAttribute("userId", userId);
                                    session.setAttribute("questionId", questionId);
                                    session.setAttribute("question", question);
                                    //                                    session.setAttribute("specialistId", spId);
                                    //                                    String userProfile = rs.getString("profile_photo");
                                    // Store user profile in the map
                                    //                                    userProfiles.put(questionId, userProfile);
                                    // Date formatting
                                    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d, yyyy, hh:mm a");
                                    formattedDate = dateFormat.format(timestamp);
                            %>
                            <div class="question-card" data-question-id="<%= questionId%>">
                                <div class="question-header">
                                    <span class="uname"><%=uname%></span>
                                    <span class="question-category"><%= category%></span>
                                    <span class="question-status pending"><%= status.toLowerCase()%></span>
                                </div>
                                <div class="question-body">
                                    <h3 class="question-title" ><%= question%></h3>
                                </div>
                                <div class="question-footer">
                                    <span class="question-date">Posted on: <%= formattedDate%></span>
                                    <button class="answer-btn" onclick="showAnswerForm('<%= questionId%>', '<%= uname%>', '<%= escapeJS(question)%>', '<%= formattedDate%>')">Answer</button>


                                    <!--<button class="answer-btn" onclick="showAnswerForm('<%= questionId%>', '<%= uname%>', '<%= question%>', '<%= formattedDate%>')">Answer</button>-->
                                </div>
                            </div>
                            <% }
                                if (!hasResults) {
                            %>
                            <p style="color:red">No questions found !</p>
                            <%}%>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <!-- Answer Form Overlay -->
        <div id="answer-overlay" class="answer-overlay">
            <div class="answer-form-container">
                <div class="answer-form-header">
                    <!--<img id="user-avatar" class="user-avatar" src="/placeholder.svg" alt="User Profile" onerror="handleImageError(this)">-->
                    <img id="user-avatar" class="user-avatar" src="<%= request.getContextPath()%>/profileimages/<%=uProfile%>" alt="User Profile"> 
                    <div class="user-info-container">
                        <div id="user-name-display" class="user-name-display" ></div>
                        <div id="post-timestamp" class="post-timestamp"></div>  
                    </div>
                    <button class="close-form-btn" onclick="closeAnswerForm()">×</button>
                </div>

                <div class="question-display">
                    <div class="question-display-text">
                        <span class="question-label-text">Question:</span>
                        <span id="question-display-text"></span>
                    </div>
                </div>
                <%
                    Integer userId1 = (Integer) session.getAttribute("userId");
                    Integer questionId1 = (Integer) session.getAttribute("questionId");
                    String question1 = (String) session.getAttribute("question");
                %>
                <form action="${pageContext.request.contextPath}/AnswerQuestionServlet" method="post">
                    <!--getting the user and specialist id through hidden-->
                    <input type="hidden" id="userid-input" name="userid" value="<%= userId1%>" />
                    <input type="hidden" id="questionid-input" name="questionid" value="" />
                    <input type="hidden" name="spid" value="<%=sId%>" />
                    <input type="hidden" id="question-input" name="question" value="" />
                    <div class="answer-form-body">
                        <textarea id="answer-input" class="answer-input" name="answer" placeholder="Write your answer..."></textarea>
                        <div class="answer-form-footer">
                            <button type="submit" id="submit-answer-button" class="submit-answer-button">Submit Answer</button>
                        </div>
                    </div>
                </form>

            </div>

            <script>


                // Show answer form
                function showAnswerForm(questionId, userName, questionText, postedDate) {
                    // Store the question ID for submission
                    document.getElementById('answer-overlay').setAttribute('data-question-id', questionId);
                    // Fill in the question details
                    document.getElementById('user-name-display').textContent = userName;
                    document.getElementById('post-timestamp').textContent = postedDate;
                    document.getElementById('question-display-text').textContent = questionText;

                    // Set the form input values directly
//                    document.getElementById('userid-input').value = userid;
                    document.getElementById('questionid-input').value = questionId;
                    document.getElementById('question-input').value = questionText;

                    // Show the answer form overlay
                    document.getElementById('answer-overlay').style.display = 'flex';
                    // Focus on the answer input
                    document.getElementById('answer-input').focus();
                    // Disable scrolling on the body
                    document.body.style.overflow = 'hidden';
                }

                // Close answer form
                function closeAnswerForm() {
                    // Hide the answer form overlay
                    document.getElementById('answer-overlay').style.display = 'none';
                    // Enable scrolling on the body
                    document.body.style.overflow = 'auto';
                    // Clear the answer text
                    document.getElementById('answer-input').value = '';
                }

                // Submit answer - No longer needed as we're using the form's native submit
                /*
                 function submitAnswer() {
                 // This function is no longer needed
                 }
                 */

                // Close the answer form when pressing Escape key
                document.addEventListener('keydown', function (event) {
                    if (event.key === 'Escape') {
                        closeAnswerForm();
                    }
                });
            </script>

            <%
                } catch (Exception e) {
                    e.printStackTrace();
                    message = "Database error: " + e.getMessage();
                }
            %>
    </body>
</html>
