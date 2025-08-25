<%-- 
    Document   : uhome
    Created on : 16 May, 2025, 8:09:29 PM
    Author     : rohini
--%>

<%@page import="java.sql.*"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Integer userId = (Integer) session.getAttribute("userId");
    String uProfile = (String) session.getAttribute("uprofile");
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String search = request.getParameter("search");

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

//            for display all the question at random order
//        String query = "SELECT q.question_id, q.user_id, q.user_name, q.category, q.posted_at, q.userProfile, q.question, a.answer_text"
//                + " FROM questions q "
//                + "LEFT JOIN answers a ON q.question_id = a.question_id WHERE q.status ='Answered' "
//                + "ORDER BY RAND(), a.answer_id";
        if (search != null && !search.trim().isEmpty()) {
            String query = "SELECT q.question_id, q.user_id, q.user_name, q.category, q.posted_at, q.userProfile, q.question, a.answer_text "
                    + "FROM questions q "
                    + "LEFT JOIN answers a ON q.question_id = a.question_id "
                    + "WHERE q.status ='Answered' AND (q.question LIKE ? OR q.category LIKE ? OR q.user_name LIKE ?) "
                    + "ORDER BY RAND(), a.answer_id";
            ps = con.prepareStatement(query);
            String keyword = "%" + search.trim() + "%";
            ps.setString(1, keyword);
            ps.setString(2, keyword);
            ps.setString(3, keyword);
        } else {
            String query = "SELECT q.question_id, q.user_id, q.user_name, q.category, q.posted_at, q.userProfile, q.question, a.answer_text "
                    + "FROM questions q "
                    + "LEFT JOIN answers a ON q.question_id = a.question_id "
                    + "WHERE q.status ='Answered' "
                    + "ORDER BY RAND(), a.answer_id";
            ps = con.prepareStatement(query);
        }
        rs = ps.executeQuery();

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            /*            :root {
                            --primary: #fd7e14;
                            --primary-light: #fff7ed;
                            --primary-medium: #ffedd5;
                            --secondary: #fb923c;
                            --text-dark: #1e293b;
                            --text-light: #64748b;
                            --bg-light: #f8fafc;
                            --bg-white: #ffffff;
                            --shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
                            --border: #e2e8f0;
                            --border-radius: 12px;
                        }*/

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
            }

            body {
                background-color:#f8fafc;
                color:#1e293b;
                line-height: 1.5;
                font-size: 15px;
                width: 100%;    
            }

            .app-container{
                display: flex;
            }

            .container {
                max-width: none; /* Remove the max-width constraint */
                margin: 0;
                padding: 20px;
                width: 100%; /* Ensure it takes full width */
            }

            header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 15px 5px;
                margin-bottom: 25px;
                position: sticky;
                top: 0;
                background-color: #f8fafc;
                z-index: 10;
                box-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
            }

            .header-left {
                display: flex;
                align-items: center;
            }

            .logo {
                font-size: 22px;
                font-weight: 700;
                color: #fd7e14;
                display: flex;
                align-items: center;
                gap: 10px;
            }

            .logo i {
                background-color: #fd7e14;
                color: white;
                width: 32px;
                height: 32px;
                border-radius: 8px;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .search-container {
                margin-left: 30px;
                width: 300px;
                position: relative;
            }

            /*            .search-container input {
                            width: 100%;
                            padding: 10px 16px 10px 40px;
                            border: 1px solid #e2e8f0;
                            border-radius: 8px;
                            background-color: #ffffff;
                            outline: none;
                            font-size: 14px;
                            transition: all 0.2s;
                        }*/

            .search-container input:focus {
                border-color:#fd7e14;
                box-shadow: 0 0 0 3px rgba(253, 126, 20, 0.1);
            }

            /*            .search-container i {
                            position: absolute;
                            left: 15px;
                            top: 50%;
                            transform: translateY(-50%);
                            color: #64748b;
                        }*/

            .header-right {
                display: flex;
                align-items: center;
            }

            .categories {
                display: flex;
                gap: 8px;
            }

            .category {
                padding: 8px 16px;
                background-color:#ffffff;
                border-radius:  12px;
                font-size: 14px;
                font-weight: 500;
                color: #64748b;
                cursor: pointer;
                transition: all 0.2s;
                border: 1px solid transparent;
            }

            .category:hover {
                color: #fd7e14;
                border-color: #fd7e14;
            }

            .category.active {
                background-color:#fff7ed;
                color: #fd7e14;
                border-color: #fff7ed;
            }

            .main-content {
                flex: 1; /* Take remaining space */
                margin-left: 270px; /* Account for sidebar */
                width: calc(100% - 270px); /* Dynamically calculate width */
                box-sizing: border-box;
            }

            .feed {
                flex-grow: 1;
                max-width: none;
                width: 100%; /* Ensure it takes full width */
            }

            .question-card {
                background-color: #ffffff;
                border-radius: 12px;
                box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
                padding: 20px;
                margin-bottom: 16px;
                transition: all 0.3s ease;
                border: 1px solid #e2e8f0;
                width: 100%; /* Ensure each card takes full width */
                box-sizing: border-box;
            }

            .question-card:hover {
                transform: translateY(-2px);
                box-shadow: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
            }

            .question-header {
                display: flex;
                align-items: center;
                margin-bottom: 16px;
            }

            .avatar {
                width: 42px;
                height: 42px;
                border-radius: 50%;
                background-color: #ffedd5;
                display: flex;
                justify-content: center;
                align-items: center;
                margin-right: 12px;
                color:#fd7e14;
                font-size: 18px;
                font-weight: 600;
            }

            .question-meta {
                flex-grow: 1;
            }

            .username {
                font-weight: 600;
                font-size: 15px;
                display: flex;
                align-items: center;
            }

            .username small {
                background-color: #fff7ed;
                color: #fd7e14;
                padding: 1px 8px;
                border-radius: 10px;
                font-size: 11px;
                margin-left: 8px;
            }

            .date {
                font-size: 13px;
                color: #64748b;
                margin-top: 2px;
            }

            .question {
                color: #1e293b;
                font-weight: 600;
                font-size: 16px;
                margin-bottom: 12px;
                padding-left: 24px;
                position: relative;
            }

            .question i {
                position: absolute;
                left: 0;
                top: 3px;
                color: #fd7e14;
            }

            .answer-preview {
                color: #64748b;
                cursor: pointer;
                padding-left: 24px;
                position: relative;
                margin-bottom: 12px;
            }

            .answer-preview i {
                position: absolute;
                left: 0;
                top: 3px;
                color: #16a34a; /* green color for check icon */
            }

            .answer-preview span {
                color:#fd7e14;
                font-weight: 500;
                margin-left: 5px;
            }

            .answer-preview:hover span {
                text-decoration: underline;
            }

            .answer-full {
                background-color:#ffedd5;
                padding: 16px;
                border-radius:  12px;
                margin-top: 12px;
                margin-bottom: 12px;
                position: relative;
                padding-left: 40px;
                display: none;
            }

            .answer-full.show {
                display: block;
            }

            .answer-full i {
                position: absolute;
                left: 16px;
                top: 16px;
                color: #16a34a;
            }

            .answer-content {
                white-space: pre-line;
                line-height: 1.6;
            }

            .see-less {
                text-align: right;
                color:#fd7e14;
                cursor: pointer;
                font-weight: 500;
                margin-top: 10px;
                font-size: 14px;
            }

            .see-less:hover {
                text-decoration: underline;
            }

            .question-footer {
                display: flex;
                justify-content: space-between;
                margin-top: 16px;
                padding-top: 12px;
                border-top: 1px solid #e2e8f0;
                color:#64748b;
            }

            .action-buttons {
                display: flex;
                gap: 20px;
            }

            .action-button {
                display: flex;
                align-items: center;
                gap: 6px;
                cursor: pointer;
                transition: color 0.2s;
            }

            .action-button:hover {
                color:#fd7e14;
            }

            .new-question-btn {
                position: fixed;
                bottom: 30px;
                right: 30px;
                background-color: #fd7e14;
                color: white;
                width: 60px;
                height: 60px;
                border-radius: 50%;
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 24px;
                box-shadow: 0 4px 15px rgba(253, 126, 20, 0.3);
                cursor: pointer;
                transition: transform 0.2s ease;
            }

            .new-question-btn:hover {
                transform: scale(1.1);
            }

            /* Mobile responsive */
            @media (max-width: 900px) {
                .search-container {
                    width: 200px;
                }
            }

            @media (max-width: 800px) {
                header {
                    flex-direction: column;
                    align-items: flex-start;
                    gap: 15px;
                    padding-bottom: 12px;
                }

                .header-right {
                    width: 100%;
                    overflow-x: auto;
                    padding-bottom: 5px;
                }

                .categories {
                    flex-wrap: nowrap;
                    white-space: nowrap;
                }

                .search-container {
                    width: 100%;
                    margin-left: 0;
                }
            }

            @media (max-width: 600px) {
                .container {
                    padding: 15px 10px;
                }

                .question-card {
                    padding: 15px;
                }

                .header-left {
                    width: 100%;
                    justify-content: space-between;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="uhome.jsp" />

        <main class="main-content">
            <div class="content-wrapper">
                <!-- Content will be included here -->


                <div class="feed" id="question-feed">
                    <!-- Question cards will be inserted here by JavaScript -->

                    <%                                while (rs.next()) {
                            String uname = rs.getString("user_name");
                            String category = rs.getString("category");
                            //                                    String postedDate = rs.getString("posted_at");
                            String question = rs.getString("question");
                            String answer = rs.getString("answer_text");
                            String userProfile = rs.getString("userProfile");
                            Timestamp postedDate = rs.getTimestamp("posted_at");
                            //                                    for date format
                            SimpleDateFormat sdf = new SimpleDateFormat("MMMM dd, yyyy – hh:mm a");
                            String formattedDate = sdf.format(postedDate);

                            String preview = answer.split("\n")[0];  // get first line
                            if (preview.length() > 80) {
                                preview = preview.substring(0, 80) + "...";
                            }
                    %>





                    <!-- Question Card 5 -->
                    <div class="question-card" data-category="<%=category%>">
                        <div class="question-header">
                            <!--<img src="<= request.getContextPath()%>/profileimages/<=userProfile%>" alt="Profile Picture"  class="avatar" />-->
                            <div class="avatar">V</div>
                            <div class="question-meta">
                                <div class="username">  <%=uname%>
                                    <small><%=category%></small>
                                </div>
                                <div class="date"><%=formattedDate%></div>
                            </div>
                        </div>
                        <div class="question">
                            <i class="fas fa-question-circle"></i>
                            <%=question%>
                        </div>
                        <div class="answer-preview">
                            <i class="fas fa-check-circle"></i>
                            <%=preview%>
                            <span class="see-more">See More <i class="fas fa-plus"></i></span>
                        </div>
                        <div class="answer-full">
                            <i class="fas fa-check-circle"></i>
                            <div class="answer-content">
                                <%=answer%>

                                <!--                                        Advantages of serverless architecture:
                                
                                                                        1. Cost efficiency - pay only for actual computation used
                                                                        2. Automatic scaling - handles traffic spikes without manual intervention
                                                                        3. Reduced operational complexity - no server management required
                                                                        4. Faster time to market - focus on code, not infrastructure
                                                                        5. Built-in high availability and fault tolerance
                                                                        6. Reduced latency through edge deployment
                                                                        7. Easier updates and deployments with function versioning
                                                                        8. Event-driven execution model
                                                                        9. Simplified backend integration with managed services
                                                                        10. Reduced environmental impact through shared resources-->

                            </div>
                            <div class="see-less">See Less <i class="fas fa-minus"></i></div>
                        </div>

                    </div>

                    <!-- Content will be loaded here -->
                    <%        }
                        } catch (Exception e) {
                            out.println("Error: " + e.getMessage());
                        } finally {
                            if (rs != null) {
                                rs.close();
                            }
                            if (ps != null) {
                                ps.close();
                            }
                            if (con != null) {
                                con.close();
                            }
                        }
                    %>
                </div>
            </div>

            <div class="new-question-btn" title="Ask a new question">
                <a href="askQuestion.jsp" style="text-decoration:none;">    <i class="fas fa-plus"></i></a>
            </div>
        </main>
    </body>


    <script>
        // Wait for the DOM to be fully loaded
        document.addEventListener('DOMContentLoaded', function () {
            // Add click event listeners to all "See More" buttons
            const seeMoreButtons = document.querySelectorAll('.see-more');
            seeMoreButtons.forEach(function (button) {
                button.addEventListener('click', function () {
                    // Find the parent question card
                    const card = this.closest('.question-card');
                    // Find the answer preview and full answer elements
                    const preview = card.querySelector('.answer-preview');
                    const fullAnswer = card.querySelector('.answer-full');
                    // Hide the preview and show the full answer
                    preview.style.display = 'none';
                    fullAnswer.classList.add('show');
                });
            });
            // Add click event listeners to all "See Less" buttons
            const seeLessButtons = document.querySelectorAll('.see-less');
            seeLessButtons.forEach(function (button) {
                button.addEventListener('click', function () {
                    // Find the parent question card
                    const card = this.closest('.question-card');
                    // Find the answer preview and full answer elements
                    const preview = card.querySelector('.answer-preview');
                    const fullAnswer = card.querySelector('.answer-full');
                    // Show the preview and hide the full answer
                    preview.style.display = 'block';
                    fullAnswer.classList.remove('show');
                });
            });

            // Add click event listeners to category filters
            const categories = document.querySelectorAll('.category');
            categories.forEach(function (category) {
                category.addEventListener('click', function () {
                    // Remove active class from all categories
                    categories.forEach(function (cat) {
                        cat.classList.remove('active');
                    });

                    // Add active class to clicked category
                    this.classList.add('active');

                    // Get the category name
                    const categoryName = this.textContent.trim();

                    // Filter the question cards
                    const cards = document.querySelectorAll('.question-card');
                    cards.forEach(function (card) {
                        if (categoryName === 'All') {
                            card.style.display = 'block';
                        } else if (card.dataset.category === categoryName) {
                            card.style.display = 'block';
                        } else {
                            card.style.display = 'none';
                        }
                    });
                });
            });
        });




//for search 
        document.querySelector('.search-input').addEventListener('keypress', function (e) {
            if (e.key === 'Enter') {
                this.form.submit();
            }
        });




        // Function to filter questions by category
//            function filterQuestions(category) {
//                const cards = document.querySelectorAll('.question-card');
//                if (category === 'All') {
//                    cards.forEach(card => {
//                        card.style.display = 'block';
//                    });
//                } else {
//                    cards.forEach(card => {
//                        if (card.dataset.category === category) {
//                            card.style.display = 'block';
//                        } else {
//                            card.style.display = 'none';
//                        }
//                    });
//                }
//            }
//
//            // Initialize the feed and add event listeners
//            document.addEventListener('DOMContentLoaded', () => {
//                createQuestionCards();
//                // Add event listeners for category filtering
//                const categories = document.querySelectorAll('.category');
//                categories.forEach(category => {
//                    category.addEventListener('click', () => {
//                        // Update active class
//                        categories.forEach(c => c.classList.remove('active'));
//                        category.classList.add('active');
//                        // Filter questions
//                        const categoryName = category.textContent;
//                        filterQuestions(categoryName);
//                    });
//                });
//            });
    </script>
</html>
