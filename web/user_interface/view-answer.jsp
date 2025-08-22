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
    <title>View Answer - AskExpert</title>
    <link rel="stylesheet" href="styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .answer-container {
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
        
        .answer-details {
            background-color: #f9f9f9;
            padding: 20px;
            border-radius: 5px;
            margin-top: 20px;
        }
        
        .answer-meta {
            display: flex;
            justify-content: space-between;
            color: #666;
            font-size: 14px;
            margin-bottom: 15px;
        }
        
        .answer-content {
            font-size: 16px;
            line-height: 1.6;
            color: #333;
        }
        
        .specialist-info {
            display: flex;
            align-items: center;
            margin-top: 20px;
        }
        
        .specialist-avatar {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 15px;
        }
        
        .specialist-name {
            font-weight: bold;
            color: #333;
        }
        
        .back-btn {
            display: inline-block;
            margin-top: 20px;
            background-color: #ff7b00;
            color: white;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            text-decoration: none;
            font-size: 16px;
            transition: background-color 0.2s;
        }
        
        .back-btn:hover {
            background-color: #e66f00;
        }
    </style>
</head>
<body>
    <%
        // Get notification ID and question ID from request parameters
        int notificationId = Integer.parseInt(request.getParameter("notificationId"));
        int questionId = Integer.parseInt(request.getParameter("questionId"));
        
        // Question and answer details
        String question = "";
        String userName = "";
        String category = "";
        String postedAt = "";
        String answerText = "";
        String specialistName = "";
        String answeredTime = "";
        
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
            
            // Mark notification as read
            PreparedStatement psMarkRead = conn.prepareStatement(
                "UPDATE notifications SET is_read = 1 WHERE id = ?"
            );
            psMarkRead.setInt(1, notificationId);
            psMarkRead.executeUpdate();
            
            // Get question details
            PreparedStatement psQuestion = conn.prepareStatement(
                "SELECT q.question, q.user_name, q.category, q.posted_at " +
                "FROM questions q WHERE q.question_id = ?"
            );
            psQuestion.setInt(1, questionId);
            ResultSet rsQuestion = psQuestion.executeQuery();
            
            if (rsQuestion.next()) {
                question = rsQuestion.getString("question");
                userName = rsQuestion.getString("user_name");
                category = rsQuestion.getString("category");
                postedAt = rsQuestion.getString("posted_at");
            }
            
            // Get answer details
            PreparedStatement psAnswer = conn.prepareStatement(
                "SELECT a.answer_text, a.answered_time, s.specialist_name " +
                "FROM answers a " +
                "JOIN specialist_regdetails s ON a.specialist_id = s.id " +
                "WHERE a.question_id = ?"
            );
            psAnswer.setInt(1, questionId);
            ResultSet rsAnswer = psAnswer.executeQuery();
            
            if (rsAnswer.next()) {
                answerText = rsAnswer.getString("answer_text");
                specialistName = rsAnswer.getString("specialist_name");
                answeredTime = rsAnswer.getString("answered_time");
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

    <div class="answer-container">
        <div class="question-details">
            <h1 class="question-title">Your Question</h1>
            <div class="question-meta">
                <span>Asked by: <%= userName %></span>
                <span>Category: <%= category %></span>
                <span>Posted: <%= postedAt %></span>
            </div>
            <p class="question-content"><%= question %></p>
        </div>
        
        <h2>Expert Answer</h2>
        <div class="answer-details">
            <div class="answer-meta">
                <span>Answered by: <%= specialistName %></span>
                <span>Answered: <%= answeredTime %></span>
            </div>
            <p class="answer-content"><%= answerText %></p>
            
            <div class="specialist-info">
                <img src="/placeholder.svg?height=50&width=50" alt="Specialist" class="specialist-avatar">
                <div>
                    <div class="specialist-name"><%= specialistName %></div>
                    <div>Expert in <%= category %></div>
                </div>
            </div>
        </div>
        
        <a href="user_home.jsp" class="back-btn">Back to Home</a>
    </div>
</body>
</html>
