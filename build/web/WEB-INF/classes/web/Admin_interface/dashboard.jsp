<%-- 
    Document   : dashboard
    Created on : 18 Apr, 2025, 4:45:40 PM
    Author     : rohini
--%>

<%@page import="java.sql.*"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    // Initialize variables to store counts
    int totalQuestions = 0;
    int answeredQuestions = 0;
    int totalUsers = 0;
    int totalSpecialists = 0;

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

        // Get total questions count
        String totalQuestionsQuery = "SELECT COUNT(*) FROM questions";
        try (PreparedStatement pstmt = con.prepareStatement(totalQuestionsQuery)) {
            rs = pstmt.executeQuery();
            if (rs.next()) {
                totalQuestions = rs.getInt(1);
            }
        }

        // Get total answers count
        String answeredQuestionsQuery = "SELECT COUNT(*) FROM questions WHERE status='Answered' ";
        try (PreparedStatement pstmt = con.prepareStatement(answeredQuestionsQuery)) {
            rs = pstmt.executeQuery();
            if (rs.next()) {
                answeredQuestions = rs.getInt(1);
            }
        }

        // Get total answers count
        String totalUsersQuery = "SELECT COUNT(*)  FROM  user_registerdetails";
        try (PreparedStatement pstmt = con.prepareStatement(totalUsersQuery)) {
            rs = pstmt.executeQuery();
            if (rs.next()) {
                totalUsers = rs.getInt(1);
            }
        }

        // Get total answers count
        String totalSpecialistQuery = "SELECT COUNT(*) FROM specialist_regdetails";
        try (PreparedStatement pstmt = con.prepareStatement(totalSpecialistQuery)) {
            rs = pstmt.executeQuery();
            if (rs.next()) {
                totalSpecialists = rs.getInt(1);
            }
        }

        // Set attributes to pass to JSP
//        request.setAttribute("totalQuestions", totalQuestions);
//        request.setAttribute("answeredQuestions", answeredQuestions);
//        request.setAttribute("totalUsers", totalUsers);
//        request.setAttribute("totalSpecialists", totalSpecialists);
//get the recent question
        String query = "SELECT * FROM questions ORDER BY question_id DESC";
        ps = con.prepareStatement(query);
        rs = ps.executeQuery();
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard</title>
        <!--External css-->
        <link rel="stylesheet" href="admin.css"/>

        <!-- Google font link -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
            rel="stylesheet">
        <!-- bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    </head>
    <body>
        <div class="main">
            <%@ include file="sidebar.jsp" %>
            <div class="main_right">
                <%--<%@ include file="nav.jsp"%>--%>

                <div class="dashboard">
                    <!-- dashboard options -->
                    <h3 style="margin: 25px;margin-bottom: 50px; font-size: 25px; font-weight: 600;">Overview of Ask Expert
                    </h3>
                    <div class="overview">
                        <div class="cards">
                            <h3>Total Questions</h3>
                            <p><%=totalQuestions%></p>
                        </div>
                        <div class="cards">
                            <h3>Total Answered</h3>
                            <p><%=answeredQuestions%></p>
                        </div>
                        <div class="cards">
                            <h3>Total Users</h3>
                            <p><%=totalUsers%></p>
                        </div>
                        <div class="cards">
                            <h3>Total Specialist</h3>
                            <p><%=totalSpecialists%></p>
                        </div>
                    </div>
                </div>

                <div class="analytics">
                    <h3>Analytics</h3>
                    <div class="analy">
                        <div class="one">
                            <h3 style="font-size: 24px;">Expert Responses Rate</h3>
                            <canvas id="responsesChart"></canvas>
                        </div>
                    </div>
                </div>

                <div class="qnandans">
                    <div class="qn">
                        <h3 style="padding-top: 20px;">Recent Questions List </h3>
                        <table class="details">
                            <tr>
                                <th>Questions</th>
                                <th>User name</th>
                                <th>Specialist name</th>
                                <th>Action</th>
                            </tr>

                            <%
                                while (rs.next()) {
                                    String uname = rs.getString("user_name");
                                    String sname = rs.getString("specialist_name");
                                    String uquestion = rs.getString("question");
                                    String status = rs.getString("status");
                            %>
                            <tr>
                                <td style="width:50%; text-align: left;padding-left: 20px;"><%=uquestion%></td>
                                <td><%=uname%></td>
                                <td><%=sname%></td>
                                <td>
                                    <%

                                        if ("pending".equals(status)) {
                                    %>
                                    <span class="text-danger"><%= status%></span>
                                    <%
                                    } else if ("Answered".equals(status)) {
                                    %>
                                    <span class="text-success"><%= status%></span>
                                    <%
                                    } else {
                                    %>
                                    <span><%= status%></span>
                                    <%
                                        }
                                    %>
                                </td>
                            </tr>
                          
                            <%
                                    }
                                } catch (Exception e) {
                                    out.println("Error: " + e.getMessage());
                                } finally {
                                    // Close resources to avoid memory leaks
                                    try {
                                        if (rs != null) {
                                            rs.close();
                                        }

                                        if (con != null) {
                                            con.close();
                                        }
                                    } catch (SQLException e) {
                                        e.printStackTrace();
                                    }
                                }
                            %>
                        </table>

                    </div>

                </div>
            </div>

        </div>


        <script>
            // for expert answer rate bar chart
            document.addEventListener("DOMContentLoaded", function () {
                const ctx1 = document.getElementById("responsesChart").getContext("2d");

                new Chart(ctx1, {
                    type: "bar",
                    data: {
                        labels: ["Jan", "Feb", "Mar", "Apr", "May"],
                        datasets: [
                            {
                                label: "Total Questions",
                                data: [50, 70, 90, 110, 130],
                                backgroundColor: "red",
                            },
                            {
                                label: "Answered Questions",
                                data: [30, 50, 80, 100, 120],
                                backgroundColor: "green",
                            },
                        ],
                    },
                    options: {
                        responsive: true,
                        scales: {
                            y: {
                                beginAtZero: true,
                            },
                        },
                    },
                });
            });

        </script>


        <!-- for chart -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <!--for bootstrap-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

    </body>
</html>
