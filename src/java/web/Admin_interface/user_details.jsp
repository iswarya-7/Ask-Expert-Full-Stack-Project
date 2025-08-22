<%-- 
    Document   : user_details
    Created on : 18 Apr, 2025, 4:56:45 PM
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

        String query = "SELECT * FROM user_registerdetails";
        ps = con.prepareStatement(query);
        rs = ps.executeQuery();

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Details</title>

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
        <!-- Bootstrap cdn -->
        <!-- Latest compiled and minified CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <div class="main">
            <%@ include file="sidebar.jsp" %>
            <div class="main_right">
                <%--<%@ include file="nav.jsp"%>--%>
                <!-- specialist details -->
                <h3 style="margin: 25px;margin-bottom: 50px; font-size: 25px; font-weight: 600;">User Details</h3>

                <table class="details table table-striped">
                    <thead>
                        <tr class="title">
                            <th><input type="checkbox" onclick="selectAll(this)" /></th> <!-- Master checkbox -->
                            <th>User Name</th>
                            <th>Email</th>
                            <th>Gender</th>
                            <th>Question Asked</th>
                            <th>Answer Received</th>

                            <th style="text-align: center;">Actions</th>

                        </tr>
                    </thead>
                    <%                    while (rs.next()) {
                            String uname = rs.getString("full_name");
                            String gender = rs.getString("gender");
                            String email = rs.getString("email");
                            String mobile = rs.getString("mobile");
                            int uid = rs.getInt("id");

                            session.setAttribute("userId", uid);
                            session.setAttribute("uname", uname);
                            session.setAttribute("uemail", email);

                    %>

                    <tbody>
                        <tr>
                            <td><input type="checkbox" class="select-row" /></td>
                            <td><%= uname%></td>
                            <td><%= email%></td>
                            <td><%=gender%></td>


                            <%
//                        count for question asked and asnwered question
                                int totalAsked = 0;
                                int totalAnswered = 0;

                                // Query for question count
                                String q1 = "SELECT COUNT(*) FROM questions WHERE user_id = ?";
                                PreparedStatement ps1 = con.prepareStatement(q1);
                                ps1.setInt(1, uid);
                                ResultSet rs1 = ps1.executeQuery();
                                if (rs1.next()) {
                                    totalAsked = rs1.getInt(1);
                                }

                                // Query for answered count
                                String q2 = "SELECT COUNT(*) FROM questions WHERE user_id = ? AND status = 'Answered'";
                                PreparedStatement ps2 = con.prepareStatement(q2);
                                ps2.setInt(1, uid);
                                ResultSet rs2 = ps2.executeQuery();
                                if (rs2.next()) {
                                    totalAnswered = rs2.getInt(1);
                                }
                            %>

                            <td><%=totalAsked%></td>
                            <td><%=totalAnswered%></td>
                            <td class="vertical-align: middle; text-align: center;">
                                <div class="d-flex justify-content-center gap-2">
                                    <!-- View Profile -->
                                    <button class="btn btn-info btn-sm" onclick="viewProfile('<%=email%>')">
                                        <i class="fa fa-eye"></i>
                                    </button>
                                    <!-- Edit -->
                                    <!--                                        <button class="btn btn-warning btn-sm" onclick="editSpecialist('<= specialist.get("email")%>')">
                                                                            <i class="fa fa-pen"></i>
                                                                        </button>-->
                                    <!-- Delete -->
                                    <button class="btn btn-danger btn-sm" onclick="deleteSpecialist('<%= email%>')">
                                        <i class="fa fa-trash"></i>
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>


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
                </table>
            </div>
        </div>


        <script>
            // Function to select/deselect all checkboxes
            function selectAll(source) {
                var checkboxes = document.getElementsByClassName('select-row');
                for (var i = 0; i < checkboxes.length; i++) {
                    checkboxes[i].checked = source.checked;
                }
            }









            // Function to delete specialist
            function deleteSpecialist(email) {
                if (confirm("Are you sure you want to delete this specialist?")) {
                    // Create a form and submit it
                    var form = document.createElement("form");
                    form.method = "POST";
                    form.action = "${pageContext.request.contextPath}/DeleteUserServlet";

                    var input = document.createElement("input");
                    input.type = "hidden";
                    input.name = "email";
                    input.value = email;

                    form.appendChild(input);
                    document.body.appendChild(form);
                    form.submit();
                }
            }
        </script>

        <!-- Bootstrap cdn -->
        <!-- Latest compiled JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
