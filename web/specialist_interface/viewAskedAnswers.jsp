<%-- 
    Document   : answer1
    Created on : 30 Apr, 2025, 5:49:14 PM
    Author     : rohini
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>
<%
    Integer aspId = (Integer) session.getAttribute("specialistId");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

        String query = "SELECT a.answer_id, a.answer_text, a.answer_date, q.category,q.specialist_name,q.question, q.user_name, q.posted_at "
                + "FROM answers a "
                + "JOIN questions q ON a.question_id = q.question_id "
                + "WHERE q.qnaskspecialist_id = ? ORDER BY q.question_id DESC";
        ps = con.prepareStatement(query);
        ps.setInt(1, aspId);
        rs = ps.executeQuery();

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

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

        </style>
    </head>
    <body>

        <div class="app-container ">
            <!-- Include Header -->
            <jsp:include page="user_nav.jsp" />

            <div class="main-wrapper">
                <!-- Include Sidebar -->
                <jsp:include page="user_sidebar.jsp" />
                <!-- Main Content -->
                <main class="main-content" id="main-content" style="margin-left:70px; margin-top: 40px;" >
                    <!-- Content will be loaded here -->
                    <h2 style="margin-left:190px; margin-top: 10px;  font-size:26px; font-weight: 700;">Explore Answers from Experts</h2>
                    <%                        while (rs.next()) {
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
                                    <p><strong>Answer : </strong> <%=answer%></p>
                                    <p><strong>Expert :  </strong><%=expert%></p>
                                    <p><strong>Answered on :  </strong> <%=formattedDate%></p>
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

        </script>
    </body>
</html>
