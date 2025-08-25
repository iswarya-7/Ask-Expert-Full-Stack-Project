<%-- 
    Document   : useraskqncard
    Created on : 17 May, 2025, 12:00:14 AM
    Author     : rohini
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Integer userId = (Integer) session.getAttribute("userId");

    String speId = request.getParameter("expertId");
    if (speId != null) {
        out.println("Error: Specialist ID not found in session.");
    }
    String fname = "", uprofile = "", sname = "", sprofile = "", category = "";
    Integer uid = 0, sid = 0;
    PreparedStatement ps = null;
    ResultSet rs = null;

    PreparedStatement ps1 = null;
    ResultSet rs1 = null;

    if (userId != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
            ps = conn.prepareStatement("SELECT * FROM user_registerdetails WHERE id = ?");
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            if (rs.next()) {
                fname = rs.getString("full_name");
                uid = rs.getInt("id");
                uprofile = rs.getString("profile_photo");
            }

            ps1 = conn.prepareStatement("SELECT * FROM specialist_regdetails WHERE id = ?");
            ps1.setString(1, speId);
            rs1 = ps1.executeQuery();

            if (rs1.next()) {
                sname = rs1.getString("full_name");
                sid = rs1.getInt("id");
                sprofile = rs1.getString("profile_photo");
                category = rs1.getString("expertise_category");
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
        <title>Ask Question</title>
        <style>
            * {
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }

            body {
                background-color: #f2f2f2;
                margin: 0;
                padding: 0;
            }

            .main-container {
                margin-left: 260px; /* assuming your sidebar is fixed and 260px wide */
                padding: 30px;
            }

            .question-card {
                max-width: 700px;
                margin: 40px auto;
                background-color: #fff;
                border-radius: 16px;
                box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
                padding: 40px;
            }

            .question-card h2 {
                text-align: center;
                color: #333;
                margin-bottom: 30px;
            }

            textarea {
                width: 100%;
                height: 140px;
                padding: 14px;
                border: 1px solid #ccc;
                border-radius: 12px;
                font-size: 16px;
                resize: none;
                outline: none;
            }
            textarea:hover {
                outline: none;
                border-color: #fd7e14;
                color:#212529;
                box-shadow:0 0 5px rgba(253, 126, 20, 0.5);     
            }
            .submit-btn {
                margin-top: 25px;
                width: 100%;
                padding: 14px;
                background-color: #ff6600;
                border: none;
                color: white;
                font-size: 16px;
                border-radius: 12px;
                cursor: pointer;
                transition: background 0.3s ease;
            }
            .submit-btn:hover{
                background: linear-gradient(to right, #ff7f00, #ff4500);
            }

            .back-link {
                text-align: right;
                margin-top: 20px;
            }

            .back-link a {
                color: #ff6600;
                text-decoration: none;
                font-weight: 500;
            }

            .back-link a:hover {
                text-decoration: underline;
            }

            @media (max-width: 768px) {
                .main-container {
                    margin-left: 0;
                    padding: 20px;
                }

                .question-card {
                    padding: 25px;
                    margin: 20px 10px;
                }
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
                    <div class="maincontent">
                        <div class="main-container">
                            <div class="question-card">
                                <h2>Ask Your Question</h2>
                                <form action="${pageContext.request.contextPath}/QuestionStoreServlet"  onsubmit="return validateQuestionForm()" method="post">

                                    <input type="hidden" id="uname" name="uname" value="<%= fname%>"  required>
                                    <input type="hidden" id="uid" name="uid" value="<%= uid%>"  required>
                                    <input type="hidden" id="uname" name="uprofile" value="<%= uprofile%>"  required>
                                    <input type="hidden" id="uid" name="category" value="<%= category%>"  required>            
                                    <input type="hidden" id="uname" name="specialist" value="<%= sname%>"  required>
                                    <input type="hidden" id="uid" name="speId" value="<%= sid%>"  required>

                                    <textarea name="question" id="question" placeholder="Type your question here..." required></textarea>
                                    <button type="submit" class="submit-btn">Submit Question</button>
                                </form>

                                <div class="back-link">
                                    <a href="expertprofile.jsp">← Back to Expert Profiles</a>
                                </div>
                            </div>
                        </div>




                    </div>
                </main>
            </div>
        </div>
    </body>
    <script>
        function validateQuestionForm() {
            var question = document.getElementById("question").value.trim();

            if (question === "") {
                alert("Please enter your question.");
                return false; // prevent form submission
            }
            return true;
        }

    </script>
</html>
