<%-- 
    Document   : answer1
    Created on : 30 Apr, 2025, 5:49:14 PM
    Author     : rohini
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    if (userId == null) {
        out.println("Error: User not logged in or session expired.");
        return;
    }   
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

        String query = "SELECT a.answer_id, a.answer_text, a.answer_date, q.category,q.specialist_name,q.question, q.user_name, q.posted_at "
                + "FROM answers a "
                + "JOIN questions q ON a.question_id = q.question_id "
                + "WHERE q.user_id = ? ORDER BY q.question_id DESC";
        ps = con.prepareStatement(query);
        ps.setInt(1, userId);
        rs = ps.executeQuery();

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Answers</title>

        <style>
            .main-content {
                flex: 1;
                margin-top: 60px;
                padding: 20px;
                overflow-y: auto;
            }

            .content-wrapper {
                max-width: 1200px;
                margin: 0 auto;
                margin-left: 260px;
                /*margin-left: 200px;*/
            }


            .accordion-container {
                width: 100%;
                margin: 20px auto;
            }

            .accordion-item {
                border-left: 5px solid #fd7e14;
                margin-bottom: 10px;
                background: #fff;
                border-radius: 6px;
                box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            }

            .accordion-header {
                padding: 15px 20px;
                cursor: pointer;
                background: #f5f5f5;
                font-weight: bold;
                display: flex;
                justify-content: space-between;
                align-items: center;
            }

            .accordion-body {
                padding: 15px 20px;
                display: none;
                background: #fff;
                border-top: 1px solid #eee;
            }

            .arrow {
                font-size: 20px;
            }
            .question-category {
                padding: 5px 10px;
                border-radius: 15px;
                /* background-color: #e6f7ff;*/
                background-color: #fff3e0;
                color: #0066cc;
                font-size: 12px;
                font-weight: 500;
            }

            .edit-icon {
                float: right;
                color: #FF6600;
                cursor: pointer;
                margin-top: -20px;
                margin-right: 10px;
                font-size: 16px;
            }

            .edit-icon:hover {
                color: #e65100;
            }

            .save-btn, .cancel-btn {
                background-color: #ff6600;
                color: white;
                border: none;
                padding: 6px 12px;
                margin-right: 5px;
                border-radius: 4px;
                cursor: pointer;
            }

            .cancel-btn {
                background-color: #ccc;
                color: #333;
            }

            .answer-input {
                width: 100%;
                min-height: 130px;
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
                    <h2 style="margin-left:190px; margin-top: 10px;  font-size:26px; font-weight: 700;">Review Your Answers</h2>
                    <%                        while (rs.next()) {
                            int answerId = rs.getInt("answer_id");
                            String question = rs.getString("question");
                            String answer = rs.getString("answer_text");
                            String category = rs.getString("category");
                            String expert = rs.getString("specialist_name");
                            Timestamp ts = rs.getTimestamp("answer_date");

                            SimpleDateFormat sdf = new SimpleDateFormat("MMMM dd, yyyy – hh:mm a");
                            String formattedDate = sdf.format(ts);
                    %>
                    <div class="content-wrapper">
                        <div class="accordion-container">
                            <div class="accordion-item">
                                <div class="accordion-header" onclick="toggleAccordion(this)">
                                    <span style="width:100%;">💡<%=question%></span>
                                    <div style="display:flex; align-items:center; gap:10px;">
                                        <small style="color: #888;"> <span class="question-category"><%=category%></span></small>
                                        <span class="arrow">+</span>
                                    </div>
                                </div>
                                <div class="accordion-body">
                                    <p ><strong>Answer : </strong><span class="answer-text"> <%=answer%></span></p>

                                    <!--To edit option-->   
                                    <form action="<%=request.getContextPath()%>/specialist_interface/SpecialistUpdateAnswer.jsp" method="post">
                                        <div class="edit-area" style="display: none;">
                                            <!--get the answerid through hidden-->
                                            <input type="hidden" name="answerid" value="<%=answerId%>" />

                                            <textarea rows="3" style="width: 100%;" class="answer-input" name="updateans"><%=answer%></textarea>
                                            <div style="margin-top: 10px;">
                                                <button class="save-btn">Save</button>
                                                <button class="cancel-btn">Cancel</button>
                                            </div>
                                        </div>
                                    </form>
                                    <%--   <p><strong>Expert :  </strong><%= expert%></p> --%>
                                    <p><strong>Answered on :  </strong> <%=formattedDate%></p>

                                    <!-- Pencil Icon -->
                                    <i class="fas fa-pencil-alt edit-icon" title="Edit Answer"></i>
                                </div>

                            </div>

                        </div>
                    </div>
                    <%
                            }
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
                </main>
            </div>
        </div>



        <script>
            function toggleAccordion(header) {
                const body = header.nextElementSibling;
                const arrow = header.querySelector(".arrow");
                const isOpen = body.style.display === "block";

                document.querySelectorAll('.accordion-body').forEach(b => b.style.display = "none");
                document.querySelectorAll('.arrow').forEach(a => a.innerText = "+");

                if (!isOpen) {
                    body.style.display = "block";
                    arrow.innerText = "−";
                }
            }



//            to edit option
            document.addEventListener("DOMContentLoaded", () => {
                document.querySelectorAll(".edit-icon").forEach(icon => {
                    icon.addEventListener("click", () => {
                        const body = icon.closest(".accordion-body");
                        const answerText = body.querySelector(".answer-text");
                        const editArea = body.querySelector(".edit-area");
                        const textarea = editArea.querySelector("textarea");

                        editArea.style.display = "block";
                        textarea.value = answerText.innerText;
                    });
                });

                document.querySelectorAll(".cancel-btn").forEach(btn => {
                    btn.addEventListener("click", () => {
                        const editArea = btn.closest(".edit-area");
                        editArea.style.display = "none";
                    });
                });

                document.querySelectorAll(".save-btn").forEach(btn => {
                    btn.addEventListener("click", () => {
                        const editArea = btn.closest(".edit-area");
                        const newAnswer = editArea.querySelector("textarea").value;
                        const answerText = editArea.closest(".accordion-body").querySelector(".answer-text");

                        // You'd do an AJAX call or form submission here
                        answerText.innerText = newAnswer;
                        editArea.style.display = "none";

                        // Optionally show a toast or alert
                        alert("Answer updated (UI only - not saved to DB)!");
                    });
                });
            });


        </script>
    </body>
</html>
