<%-- 
    Document   : specialist_details
    Created on : 18 Apr, 2025, 4:52:21 PM
    Author     : rohini
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, java.util.Map, java.sql.*, java.util.ArrayList, java.util.HashMap"%>

<%
    // Auto-load data when JSP is accessed directly
    List<Map<String, String>> specialistsList = (List<Map<String, String>>) request.getAttribute("specialistsList");

    // If specialistsList is null (direct JSP access), load the data here
    if (specialistsList == null) {
        specialistsList = new ArrayList<>();

        try {
            // Load the JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Get database connection
            String dbUrl = "jdbc:mysql://localhost:3306/askexpert";
            String dbUser = "root";
            String dbPassword = "";

            Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);

            // Query specialists
            String query = "SELECT * FROM specialist_regdetails";
            PreparedStatement pstmt = conn.prepareStatement(query);
            ResultSet rs = pstmt.executeQuery();

            // Process results
            while (rs.next()) {
                Map<String, String> specialist = new HashMap<>();
                specialist.put("name", rs.getString("full_name"));
                specialist.put("email", rs.getString("email"));
                specialist.put("gender", rs.getString("gender"));
                specialist.put("expertise_category", rs.getString("expertise_category"));
                specialist.put("expertise_domain", rs.getString("expertise_domain"));
                specialist.put("status", rs.getString("status"));

                specialistsList.add(specialist);
            }

            // Close resources
            rs.close();
            pstmt.close();
            conn.close();

        } catch (Exception e) {
            // Set error attribute
            request.setAttribute("error", "Error loading specialists: " + e.getMessage());
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Specialist Management</title>

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

        <style>
            td.d-flex {
                display: flex;
                justify-content: space-around;
                align-items: center;
                gap: 10px;
            }
        </style>
    </head>
    <body>
        <div class="main">
            <%@ include file="sidebar.jsp" %>
            <div class="main_right">
                <%--<%@ include file="nav.jsp"%>--%>

                <div id="content_area">
                    <h3 style="margin: 20px;margin-bottom: 50px; font-size: 25px; font-weight: bold;">Specialist Details</h3>

                    <!-- Display any error messages -->
                    <% if (request.getAttribute("error") != null) {%>
                    <div class="alert alert-danger">
                        <%= request.getAttribute("error")%>
                    </div>
                    <% } %>

                    <!--Specialist Details-->
                    <table class="details table table-striped">
                        <thead>
                            <tr class="title">
                                <th><input type="checkbox" onclick="selectAll(this)" /></th> <!-- Master checkbox -->
                                <th>Specialist Name</th>
                                <th>Email</th>
                                <th>Gender</th>
                                <th>Expertise</th>
                                <th>Category</th>
                                <th>Status</th>
                                <th style="text-align: center;">Actions</th>
                                <th style="text-align: center;">Review Request</th> <!-- Approve/Reject -->
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if (specialistsList.isEmpty()) {
                                    // Message for empty list
                            %>
                            <tr>
                                <td colspan="9" class="text-center">No specialists found in the database.</td>
                            </tr>
                            <%
                            } else {
                                // Display specialists data
                                for (Map<String, String> specialist : specialistsList) {
                            %>



                            <tr>
                                <td><input type="checkbox" class="select-row" /></td>
                                <td><%= specialist.get("name")%></td>
                                <td><%= specialist.get("email")%></td>
                                <td><%= specialist.get("gender")%></td>
                                <td><%= specialist.get("expertise_category")%></td>
                                <td><%= specialist.get("expertise_domain")%></td>
                                <td>
                                    <%
                                        String status = specialist.get("status");
                                        if ("Pending".equals(status)) {
                                    %>
                                    <span class="text-danger"><%= status%></span>
                                    <%
                                    } else if ("Approved".equals(status)) {
                                    %>
                                    <span class="text-success"><%= status%></span>
                                    <%
                                    } else if ("Rejected".equals(status)) {
                                    %>
                                    <span class="text-secondary"><%= status%></span>
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
                                        <button class="btn btn-info btn-sm" onclick="viewProfile('<%= specialist.get("email")%>')">
                                            <i class="fa fa-eye"></i>
                                        </button>
                                        <!-- Edit -->
                                        <!--                                        <button class="btn btn-warning btn-sm" onclick="editSpecialist('<= specialist.get("email")%>')">
                                                                                <i class="fa fa-pen"></i>
                                                                            </button>-->
                                        <!-- Delete -->
                                        <button class="btn btn-danger btn-sm" onclick="deleteSpecialist('<%= specialist.get("email")%>')">
                                            <i class="fa fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                                <!-- Approve & Reject Buttons -->
                                <td class="vertical-align: middle; text-align: center;">
                                    <div class="d-flex justify-content-center gap-2">
                                        <form method="post" action="ApproveSpecialistServlet" style="display:inline; margin-bottom: 10px;">
                                            <!--getting the input name and email-->
                                            <input type="hidden" name="sname"  value="<%= specialist.get("name")%>" />
                                            <input type="hidden" name="email" value="<%= specialist.get("email")%>" />
                                            <button type="submit" class="btn btn-success btn-sm">Approve</button>
                                        </form>
                                        <form method="post" action="RejectSpecialistServlet" style="display:inline;">
                                            <!--getting the input name and email-->
                                            <input type="hidden" name="sname"  value="<%= specialist.get("name")%>" />
                                            <input type="hidden" name="email" value="<%= specialist.get("email")%>" />
                                            <button type="submit" class="btn btn-danger btn-sm">Reject</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- JavaScript for table functionality -->
        <script>
            // Function to select/deselect all checkboxes
            function selectAll(source) {
                var checkboxes = document.getElementsByClassName('select-row');
                for (var i = 0; i < checkboxes.length; i++) {
                    checkboxes[i].checked = source.checked;
                }
            }

            // Function to view specialist profile
            function viewProfile(email) {
                // Redirect to profile page with email parameter
                window.location.href = "specialist_profile.jsp?email=" + email;
            }

            // Function to edit specialist
            function editSpecialist(email) {
                // Redirect to edit page with email parameter
                window.location.href = "edit_specialist.jsp?email=" + email;
            }

            // Function to delete specialist
            function deleteSpecialist(email) {
                if (confirm("Are you sure you want to delete this specialist?")) {
                    // Create a form and submit it
                    var form = document.createElement("form");
                    form.method = "POST";
                    form.action = "DeleteSpecialistServlet";

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
