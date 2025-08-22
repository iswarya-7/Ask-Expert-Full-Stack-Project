<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Answer Question - AskExpert</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .answer-form-container {
            max-width: 800px;
            margin: 30px auto;
            background-color: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 30px;
        }
        
        .question-details {
            margin-bottom: 20px;
            padding-bottom: 20px;
            border-bottom: 1px solid #eee;
        }
        
        .question-title {
            font-size: 24px;
            color: #333;
            margin-bottom: 10px;
        }
        
        .question-meta {
            display: flex;
            justify-content: space-between;
            color: #666;
            font-size: 14px;
            margin-bottom: 15px;
        }
        
        .question-content {
            font-size: 16px;
            line-height: 1.6;
            color: #333;
        }
        
        .answer-form textarea {
            width: 100%;
            min-height: 200px;
            padding: 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
            margin-bottom: 20px;
            resize: vertical;
        }
        
        .submit-btn {
            background-color: #ff7b00;
            color: white;
            border: none;
            padding: 12px 25px;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
            transition: background-color 0.2s;
        }
        
        .submit-btn:hover {
            background-color: #e66f00;
        }
    </style>
</head>
<body>
    <%
        // Get specialist ID from session
        Integer specialistId = (Integer) session.getAttribute("specialistId");
        
        // Get question ID from request parameter
        int questionId = Integer.parseInt(request.getParameter("questionId"));
        
        // Question details
        String question = "";
        String userName = "";
        String category = "";
        String postedAt = "";
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
            
            // Get question details
            PreparedStatement ps = conn.prepareStatement(
                "SELECT q.question, q.user_name, q.category, q.posted_at " +
                "FROM questions q WHERE q.question_id = ?"
            );
            ps.setInt(1, questionId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                question = rs.getString("question");
                userName = rs.getString("user_name");
                category = rs.getString("category");
                postedAt = rs.getString("posted_at");
            }
            
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    %>

    <header class="header">
        <div class="header-title">Ask Expert</div>
        <div class="search-container">
            <input type="text" class="search-input" placeholder="Search question...">
        </div>
        <div class="header-actions">
            <button class="action-btn notification-btn">
                <i class="fas fa-bell"></i>
            </button>
            <button class="profile-btn">
                <img src="/placeholder.svg?height=40&width=40" alt="Profile" class="userprofile">
            </button>
        </div>
    </header>

    <div class="answer-form-container">
        <div class="question-details">
            <h1 class="question-title">Question Details</h1>
            <div class="question-meta">
                <span>Asked by: <%= userName %></span>
                <span>Category: <%= category %></span>
                <span>Posted: <%= postedAt %></span>
            </div>
            <p class="question-content"><%= question %></p>
        </div>
        
        <form class="answer-form" action="createAnswerNotification" method="post">
            <input type="hidden" name="questionId" value="<%= questionId %>">
            <input type="hidden" name="specialistId" value="<%= specialistId %>">
            
            <h2>Your Answer</h2>
            <textarea name="answerText" placeholder="Write your answer here..." required></textarea>
            
            <button type="submit" class="submit-btn">Submit Answer</button>
        </form>
    </div>

    <script>
        // You can add any JavaScript functionality here if needed
    </script>
</body>
</html>
