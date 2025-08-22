<%-- 
    Document   : specialist_details
    Created on : 18 Apr, 2025, 4:52:21 PM
    Author     : rohini
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List, java.util.Map, java.sql.*, java.util.ArrayList, java.util.HashMap"%>

<%
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

        String query = "SELECT * FROM specialist_regdetails where status='pending' ";
        ps = con.prepareStatement(query);
        rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin - Specialist Request</title>

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
            .uprofile {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                object-fit: cover;
            }

        </style>
    </head>
    <body>
        <div class="main">
            <%@ include file="sidebar.jsp" %>
            <div class="main_right">
                <%--<%@ include file="nav.jsp"%>--%>

                <div id="content_area">
                    <h3 style="margin: 20px;margin-bottom: 50px; font-size: 25px; font-weight: bold;">Specialist Requests</h3>

                    <!-- Display any error messages -->
                    <% if (request.getAttribute("error") != null) {%>
                    <div class="alert alert-danger">
                        <%= request.getAttribute("error")%>
                    </div>
                    <% }%>

                    <!--Specialist Details-->
                    <table class="details table table-striped">
                        <thead>
                            <tr class="title" >
                                <th><input type="checkbox" onclick="selectAll(this)" /></th> <!-- Master checkbox -->
                                <th>S No</th>
                                <th>Specialist Profile</th>
                                <th>Specialist Name</th>
                                <th>Email</th>
                                <!--<th>Gender</th>-->
                                <th>Expertise</th>
                                <th>Category</th>
                                <th>Status</th>
                                <th style="text-align: center;">Actions</th>
                                <th style="text-align: center;">Review Request</th> <!-- Approve/Reject -->
                            </tr>
                        </thead>
                        <tbody>
                            <%     int i = 0;
                                boolean hasData = false; // STEP 1

                                while (rs.next()) {
                                    hasData = true; // STEP 2
                                    Integer sid = rs.getInt("id");
                                    String sname = rs.getString("full_name");
                                    String sprofile = rs.getString("profile_photo");
                                    String gender = rs.getString("gender");
                                    String email = rs.getString("email");
                                    String mobile = rs.getString("mobile");
                                    String city = rs.getString("city");
                                    String expertise_category = rs.getString("expertise_category");
                                    String expertise_domain = rs.getString("expertise_domain");
                                    String status = rs.getString("status");

                                    String dob = rs.getString("dob");

                                    int uid = rs.getInt("id");

                                    session.setAttribute("speId", sid);
                                    session.setAttribute("sname", sname);
                                    session.setAttribute("semail", email);
                                    i++;

                            %>


                            <tr><td > <input  type = "checkbox" class="select-row" /></td> 
                                <td> <%= i%></td>
                                <td><img src="${pageContext.request.contextPath}/profileimages/<%=sprofile%>" alt="admin_profile" class="uprofile"></td>
                                <td><%= sname%></td>
                                <td><%= email%></td>
                                <!--<td><%= gender%></td>-->
                                <td><%= expertise_category%></td>
                                <td><%= expertise_domain%></td>
                                <td>
                                    <%
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
                                        <button class="btn btn-info btn-sm" 
                                                onclick="viewProfile(this)"
                                                data-name="<%= sname%>"
                                                data-name1="<%= sname%>"
                                                data-email="<%= email%>"
                                                data-city="<%= city%>"
                                                data-gender="<%= gender%>"
                                                data-mobile="<%= mobile%>"
                                                data-dob="<%= dob%>"
                                                data-category="<%= expertise_category%>"
                                                data-domain="<%= expertise_domain%>"
                                                data-profile="<%= sprofile%>">
                                            <i class="fa fa-eye"></i>
                                        </button>
                                        <!-- Edit -->
                                        <!--                                        <button class="btn btn-warning btn-sm" onclick="editSpecialist('<= specialist.get("email")%>')">
                                                                                <i class="fa fa-pen"></i>
                                                                            </button>-->
                                        <!-- Delete -->
                                        <button class="btn btn-danger btn-sm" onclick="deleteSpecialist('<%=email%>')">
                                            <i class="fa fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                                <!-- Approve & Reject Buttons -->
                                <td class="vertical-align: middle; text-align: center;">
                                    <div class="d-flex justify-content-center gap-2">
                                        <form method="post" action="ApproveSpecialistServlet" style="display:inline; margin-bottom: 10px;">
                                            <!--getting the input name and email-->
                                            <input type="hidden" name="sname"  value="<%= sname%>" />
                                            <input type="hidden" name="email" value="<%= email%>" />
                                            <button type="submit" class="btn btn-success btn-sm"  onclick="approveSpecialist(<%=sid%>)">Approve</button>
                                        </form>
                                        <form method="post" action="RejectSpecialistServlet" style="display:inline;">
                                            <!--getting the input name and email-->
                                            <input type="hidden" name="sname"  value="<%= sname%>" />
                                            <input type="hidden" name="email" value="<%= email%>" />
                                            <button type="submit" class="btn btn-danger btn-sm">Reject</button>
                                        </form>
                                    </div>
                                </td>
                            </tr>
                            <% }
                                if (!hasData) {%>
                            <tr>
                                <td colspan="11" class="text-center text-danger fw-bold">No specialist found</td>
                            </tr>
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
                        </tbody>
                    </table>
                </div>
            </div>
        </div>


        <!-- Specialist Details Modal -->
        <div class="modal fade" id="specialistModal" tabindex="-1" aria-labelledby="specialistModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-lg">
                <div class="modal-content">
                    <div class="modal-header text-white ps-5" style="background:#fd7e14;">
                        <h5 class="modal-title" id="specialistModalLabel">Specialist Details</h5>
                        <button type="button" class="btn-close btn-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body d-flex gap-4">
                        <div>
                            <p style="margin-left:50px;"><strong>Profile Image</strong> </p>
                            <img id="modalProfile" src="" class="rounded-circle" style="width: 100px; height: 100px; object-fit: cover;margin-right: 100px;margin-left: 50px;" alt="Profile Photo">
                            <p style="margin-left:60px;margin-top: 20px;"><strong> <span id="modalName"></span></strong></p>
                        </div>
                        <div>
                            <p><strong>Name:</strong> <span id="modalName1"></span></p>
                            <p><strong>Email:</strong> <span id="modalEmail"></span></p>
                            <p><strong>Mobile:</strong> <span id="modalMobile"></span></p>
                            <p><strong>City</strong> <span id="modalCity"></span></p>
                            <p><strong>DOB:</strong> <span id="modalDOB"></span></p>
                            <p><strong>Gender:</strong> <span id="modalGender"></span></p>
                            <p><strong>Expertise Category:</strong> <span id="modalCategory"></span></p>
                            <p><strong>Expertise Domain:</strong> <span id="modalDomain"></span></p>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                    </div>
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
            function viewProfile(button) {
                const name = button.getAttribute("data-name");
                const name1 = button.getAttribute("data-name");
                const email = button.getAttribute("data-email");
                const city = button.getAttribute("data-city");
                const gender = button.getAttribute("data-gender");
                const mobile = button.getAttribute("data-mobile");
                const dob = button.getAttribute("data-dob");
                const category = button.getAttribute("data-category");
                const domain = button.getAttribute("data-domain");
                const profile = button.getAttribute("data-profile");

                document.getElementById("modalName").innerText = name;
                document.getElementById("modalName1").innerText = name;
                document.getElementById("modalEmail").innerText = email;
                document.getElementById("modalCity").innerText = city;
                document.getElementById("modalMobile").innerText = mobile;
                document.getElementById("modalDOB").innerText = dob;
                document.getElementById("modalGender").innerText = gender;
                document.getElementById("modalCategory").innerText = category;
                document.getElementById("modalDomain").innerText = domain;
                document.getElementById("modalProfile").src = "<%= request.getContextPath()%>/profileimages/" + profile;

                const modal = new bootstrap.Modal(document.getElementById('specialistModal'));
                modal.show();
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


//            to hide the specialist details it click approve button
            function approveSpecialist(id) {
                fetch('ApproveSpecialistServlet?id=' + id)
                        .then(response => response.text())
                        .then(data => {
                            if (data === "Approved") {
                                const row = document.getElementById("row-" + id);
                                row.style.transition = "opacity 0.5s";
                                row.style.opacity = 0;
                                setTimeout(() => row.remove(), 500);
                            }
                        });
            }
        </script>

        <!-- Bootstrap cdn -->
        <!-- Latest compiled JavaScript -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
