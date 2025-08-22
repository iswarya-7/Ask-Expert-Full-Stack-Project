<%-- 
    Document   : questions_response
    Created on : 18 Apr, 2025, 5:00:09 PM
    Author     : rohini
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Integer userId = (Integer) session.getAttribute("userId");

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
        out.println("Connection Successful");
        String query = "SELECT q.question_id, q.user_name, q.category, q.question, q.attachment, q.status, q.posted_at, a.answer_text, a.answer_date, q.specialist_name FROM questions q LEFT JOIN answers a ON q.question_id = a.question_id ORDER BY q.posted_at DESC";

        ps = con.prepareStatement(query);
        rs = ps.executeQuery();

%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>


        <!--External css link-->
        <link rel="stylesheet" href="admin.css"/>

        <!-- google fonts -->
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
            rel="stylesheet">
        <!-- FOnt awesome cdn -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
              integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />

        <!-- bootstrap -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">

        <style>
            .view_ans {
                cursor: pointer;
            }

            .view_ans {
                background-color: #fd7e14;
                color: black;
                border: none;
            }

            .view_ans i {
                color: white;
                padding-right: 5px;
            }

            .view_ans:hover i {
                color: #fd7e14;
            }

            .view_ans:hover {
                background: #fd7d1438;
            }

            .modal-content {
                border-radius: 12px;
                padding: 20px;

            }


            .modal-dialog {
                max-width: 600px;
                width: 90%;
                margin: auto;

                display: flex !important;
                align-items: center;
                min-height: 100vh;
            }

            .modal-body {
                max-height: 400px;
                overflow-y: auto;
            }

            .modal-header,
            .modal-footer {
                border: none;
            }
        </style>
    </head>
    <body>
        <div class="main">
            <%@ include file="sidebar.jsp" %>
            <div class="main_right">
                <%--<%@ include file="nav.jsp"%>--%>
                <!-- overview -->
                <div class="dashboard">
                    <h3 style="margin: 25px;margin-bottom: 50px; font-size: 25px; font-weight: 600;">Questions & Responses
                    </h3>

                    <%//count the total answered ,pending and total questions
                        int totalAsked = 0;
                        int totalPending = 0;
                        int totalAnswered = 0;

                        // Query for question count
                        String q1 = "SELECT COUNT(*) FROM questions";
                        PreparedStatement ps1 = con.prepareStatement(q1);

                        ResultSet rs1 = ps1.executeQuery();
                        if (rs1.next()) {
                            totalAsked = rs1.getInt(1);
                        }

                        // Query for answered count
                        String q2 = "SELECT COUNT(*) FROM questions  WHERE  status = 'Answered' ";
                        PreparedStatement ps2 = con.prepareStatement(q2);
                        ResultSet rs2 = ps2.executeQuery();
                        if (rs2.next()) {
                            totalAnswered = rs2.getInt(1);
                        }

                        // Query for pending count
                        String q3 = "SELECT COUNT(*) FROM questions WHERE  status = 'pending' ";
                        PreparedStatement ps3 = con.prepareStatement(q3);

                        ResultSet rs3 = ps3.executeQuery();
                        if (rs3.next()) {
                            totalPending = rs3.getInt(1);
                        }
                    %>
                    <!-- dashboard options -->
                    <div class="overview flex">
                        <div class="cards">
                            <h3>Total Asked Questions </h3>
                            <p><%=totalAsked%></p>
                        </div>
                        <div class="cards">
                            <h3>Total Answered Questions</h3>
                            <p><%=totalAnswered%></p>
                        </div>
                        <div class="cards">
                            <h3>Answer Pending Questions</h3>
                            <p><%=totalPending%></p>
                        </div>
                    </div>

                    <!-- question and answer -->
                    <table class="details qaa">
                        <tr class="title">
                            <th><input type="checkbox" onclick="selectAll(this)" /></th> <!-- Master checkbox -->
                            <th>Questions</th>
                            <th>Asked By</th>
                            <th>Specialist Assigned</th>
                            <th>Status</th>
                            <th>Action (Answers) </th>
                        </tr>
                        <%                        while (rs.next()) {

                                int questionId = rs.getInt("question_id");
                                String uname = rs.getString("user_name");
                                String sname = rs.getString("specialist_name");
                                String qcategory = rs.getString("category");
                                String uquestion = rs.getString("question");
                                String qanswer = rs.getString("answer_text");
                                String status = rs.getString("status");
                        %>
                        <tr>
                        <input type="hidden" name="question" value="<%=uquestion%>" />
                        <input type="hidden" name="questionId" value="<%=questionId%>" />
                        <td><input type="checkbox" class="select-row" /></td>
                        <td style="text-align:left; width:40%;"><%=uquestion%></td>
                        <td name="question1"><%=uname%></td>
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

                        <td class="vertical-align: middle; text-align: center;">
                            <div class="d-flex justify-content-center gap-2">
                                <!-- View Profile -->
                                <button type="button" class="btn view_ans"
                                        onclick="openModal('<%=uquestion%>', '<%= (qanswer != null) ? qanswer : "Not answered yet"%>')">
                                    <i  class="fa-solid fa-magnifying-glass"></i>View
                                </button>
                                <!--trash button-->
                                <button class="btn btn-danger btn-sm" onclick="deleteQuestion('<%= questionId%>')">
                                    <i class="fa fa-trash"></i>
                                </button>

                            </div>
                        </td>                             
                        </tr>


                        <%}
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
                    </table>
                    <!-- Bootstrap Modal for qn and answer -->
                    <div class="modal fade" id="qaModal" tabindex="-1" aria-labelledby="qaModalLabel" aria-hidden="true">
                        <div class="modal-dialog  modal-dialog-centered">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="qaModalLabel">Question & Answer</h5>
                                    <!-- <button type="button" class="btn-close" data-bs-dismiss="modal"
                                        aria-label="Close"></button> -->
                                </div>
                                <div class="modal-body">
                                    <h6 id="modalQuestion"></h6>
                                    <p id="modalAnswer"></p>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- script tag -->

        <script>
            function openModal(question, answer) {
                document.getElementById("modalQuestion").innerText = "Question : "  + question;
                document.getElementById("modalAnswer").innerText = "Answer : "+ answer;
                var modal = new bootstrap.Modal(document.getElementById("qaModal"), {
//                    backdrop: false,
                    keyboard: false
                });
                modal.show();
            }




//         to create a form externally for   delete question 

            // Function to delete question
            function deleteQuestion(questionId) {
                if (confirm("Are you sure you want to delete this question?")) {
                    // Create a form and submit it
                    var form = document.createElement("form");
                    form.method = "POST";
                    form.action = "${pageContext.request.contextPath}/DeleteQuestionServlet";
                    form.style.display = "none";

                    var input1 = document.createElement("input");
                    input1.type = "hidden";
                    input1.name = "questionId";
                    input1.value = questionId;

                    form.appendChild(input1);
                    document.body.appendChild(form);
                    form.submit();
                }
            }
        </script>


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>

    </body>

</html>
