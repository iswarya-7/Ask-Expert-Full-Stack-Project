<%-- 
    Document   : specialist_details
    Created on : 18 Apr, 2025, 4:52:21 PM
    Author     : rohini
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    Integer sid = 0;
    String blocked = null, sgender = null;
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

        String query = "SELECT * FROM specialist_regdetails where status='Approved' ";
        ps = con.prepareStatement(query);
        rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin - Specialist Details</title>

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

            .uprofile{
                width: 45px;
                height: 45px;
                border-radius: 50%;
                object-fit: cover;
            }
            .profile-container {
                max-width: 700px;
                margin: 30px auto;
                padding: 25px;
                box-shadow: 0 0 15px rgba(0,0,0,0.2);
                border-radius: 15px;
            }

            .profile-img {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
            }

            .label {
                font-weight: bold;
            }

            .detail-row {
                margin-bottom: 15px;
            }
            input:focus {
                outline: none;
                border-color: #fd7e14;
                color: #212529;
                box-shadow: 0 0 5px rgba(253, 126, 20, 0.5);
                /* Add a glowing effect */
            }
            textarea:focus{
                outline: none;
                border-color: #fd7e14;
                color: #212529;
                box-shadow: 0 0 5px rgba(253, 126, 20, 0.5);
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
                                <th>SNo</th>
                                <th>Specialist Profile</th>
                                <th>Specialist Name</th>
                                <th>Email</th>
                                <th>Password</th>
                                <!--<th>Expertise</th>-->
                                <!--<th>Category</th>-->
                                <th>Status</th>
                                <th style="text-align: center;">Actions</th>
                                <th>Block Access</th>
                                <!--<th style="text-align: center;">Review Request</th>  Approve/Reject -->
                            </tr>
                        </thead>


                        <tbody>
                            <%     int i = 0;
                                boolean hasData = false; // STEP 1

                                while (rs.next()) {
                                    hasData = true; // STEP 2
                                    sid = rs.getInt("id");
                                    String sname = rs.getString("full_name");
                                    String sprofile = rs.getString("profile_photo");
                                    sgender = rs.getString("gender");
                                    String password = rs.getString("password");
                                    String email = rs.getString("email");
                                    String mobile = rs.getString("mobile");
                                    String city = rs.getString("city");
                                    String expertise_category = rs.getString("expertise_category");
                                    String expertise_domain = rs.getString("expertise_domain");
                                    String years = rs.getString("years_experience");
//                                    String status = rs.getString("status");
                                    String status = rs.getString("blockstatus");
                                    String bio = rs.getString("bio");
                                    String dob = rs.getString("dob");
                                    String workplace = rs.getString("workplace");
                                    String portfolio = rs.getString("portfolio");
                                    String linkedin = rs.getString("linkedin");
                                    blocked = rs.getString("blocked");

                                    session.setAttribute("speId", sid);
                                    session.setAttribute("sname", sname);
                                    session.setAttribute("semail", email);

                                    Timestamp ts = rs.getTimestamp("created_at");
                                    SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
                                    String formattedTime = sdf.format(ts);

                                    i++;

                            %>


                            <tr>
                                <td><input type="checkbox" class="select-row" /></td>
                                <td><%= i%></td>
                                <td><img src="<%= request.getContextPath()%>/profileimages/<%=sprofile%>" alt="admin_profile" class="uprofile"></td>
                                <td><%= sname%></td>
                                <td><%= email%></td>
                                <td><%= password%></td>
                                <!--<td><%= expertise_category%></td>-->
                                <!--<td><%= expertise_domain%></td>-->
                                <td>
                                    <%
                                        if ("Pending".equals(status)) {
                                    %>
                                    <span class="text-danger"><%= status%></span>
                                    <%
                                    } else if ("active".equals(status)) {
                                    %>
                                    <span class="text-white bg-success p-1 " style="border-radius:4px;"><%= status%></span>
                                    <%
                                    } else if ("blocked".equals(status)) {
                                    %>
                                    <span class="text-white  bg-danger p-1"    style="border-radius:4px;"><%= status%></span>
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
                                        <!--                                        <button class="btn btn-info btn-sm" 
                                                                                        onclick="viewProfile(this)"
                                                                                        data-name="<%= sname%>"
                                                                                        data-name1="<%= sname%>"
                                                                                        data-email="<%= email%>"
                                                                                        data-city="<%= city%>"
                                                                                        data-gender="<%= sgender%>"
                                                                                        data-mobile="<%= mobile%>"
                                                                                        data-dob="<%= dob%>"
                                                                                        data-category="<%= expertise_category%>"
                                                                                        data-domain="<%= expertise_domain%>"
                                                                                        data-profile="<%= sprofile%>"
                                                                                        data-joined="<%= formattedTime%>">
                                                                                    <i class="fa fa-eye"></i>
                                                                                </button>-->
                                        <button class="btn btn-info btn-sm" 
                                                onclick="viewProfile('<%= sname%>', '<%= email%>', '<%= sgender%>', '<%= mobile%>', '<%= dob%>', '<%=city%> ', '<%= expertise_category%> ', '<%= expertise_domain%>', '<%= sprofile%>', '<%=formattedTime%>')"
                                                type="button">
                                            <i class="fa fa-eye"></i>
                                        </button>

<!--                                        <button class="btn btn-warning btn-sm" onclick="editProfile('<%= email%>')">
                                            <i class="fa fa-pen"></i>
                                        </button>-->
                                        <!--Edit--> 

                                        <!-- Edit Profile - Updated with all data attributes -->

                                        <button class="btn btn-warning btn-sm" 
                                                onclick="editProfile('<%= sid%>', '<%= sname%>', '<%= email%>', '<%= sgender%>', '<%= mobile%>',
                                                                '<%= dob%>', '<%= expertise_category%>', '<%= expertise_domain%>', '<%= password%>',
                                                                '<%= sprofile%>', '<%= city%>', '<%= years%>', '<%=workplace%>', '<%=bio%>',
                                                                '<%= portfolio%>', '<%= linkedin%>')"
                                                type="button">
                                            <i class="fa fa-pen"></i>
                                        </button>





                                        <!--Delete--> 
                                        <button class="btn btn-danger btn-sm" onclick="deleteSpecialist('<%= email%>')">
                                            <i class="fa fa-trash"></i>
                                        </button>
                                    </div>
                                </td>
                                <td>
                                    <% if ("yes".equalsIgnoreCase(blocked)) {%>
                                    <form id="reasonForm" method="post" action="${pageContext.request.contextPath}/UnblockSpecialistServlet" onsubmit="return unblockValidate()">
                                        <input type="hidden" name="uid" id="ubuserId" value="<%=sid%>">
                                        <input type="hidden" name="uaction" id="ubactionType" value="unblock">
                                        <button class="btn " style="background:white;color:black;" onclick="unblock('<%= sid%>', 'unblock')">Unblock</button>
                                    </form>


                                    <% } else {%>
                                    <button class="btn block-btn btn-danger" onclick="openReasonModal('<%= sid%>', 'block')">Block</button>
                                    <% } %>

                                    <%--                                    <% if (rs.getString("blocked").equals("yes")) {%>
                                                                        <!-- show unblock button -->
                                                                        <button type="button" class="btn block-btn btn-danger" id="block" onclick="openReasonModal('<%= sid%>', 'unblock')">Block</button>

                                    <% } else {%>
                                    <!-- show block button -->
                                    <button type="button" class="btn block-btn btn-danger" id="block" onclick="openReasonModal('<%= sid%>', 'block')">Block</button>

                                    <% }%>

                                    <!--<button type="button" class="btn block-btn btn-danger" id="block" onclick="openReasonModal('<%= sid%>', 'block')">Block</button>-->
                                    --%>
                                </td>
                            </tr>
                        </tbody>
                        <% if (!hasData) { %>
                        <tbody>
                            <tr>
                                <td colspan="10" class="text-center text-danger fw-bold">No specialist found</td>
                            </tr>
                        </tbody>
                        <% }
                            }

                        %>
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
                            <p style="width:80%;display: flex;justify-content: center;margin-top: 20px;"><strong> <span id="modalName"></span></strong></p>
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
                            <p><strong>Joined On:</strong> <span id="modalJoined"></span></p>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>


        <!-- Edit Specialist Modal - Updated to match the design -->
        <div class="modal fade" id="editSpecialistModal" tabindex="-1" aria-labelledby="editSpecialistModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl">
                <div class="modal-content">
                    <div class="modal-header text-white" style="background:#fd7e14;">
                        <h5 class="modal-title" id="editSpecialistModalLabel">Profile Update</h5>
                        <button type="button" class="btn-close btn-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="editSpecialistForm" action="${pageContext.request.contextPath}/EditSpecialistFormA" method="POST" enctype="multipart/form-data"  onsubmit="return validateEditForm()">
                        <div class="modal-body">
                            <input type="hidden" id="editId" name="id">


                            <!-- Hidden fields to store original values -->
                            <input type="hidden" id="originalName" name="full_name">
                            <input type="hidden" id="originalEmail" name="email">
                            <input type="hidden" id="originalMobile" name="phone">
                            <input type="hidden" id="originalGender" name="gender">
                            <input type="hidden" id="originalDOB" name="dob">
                            <input type="hidden" id="originalCity" name="city">
                            <input type="hidden" id="originalCategory" name="category">
                            <input type="hidden" id="originalDomain" name="domain">
                            <input type="hidden" id="originalExperience" name="experience">
                            <input type="hidden" id="originalWorkplace" name="workplace">
                            <input type="hidden" id="originalBio" name="bio">
                            <input type="hidden" id="originalPortfolio" name="portfolio">
                            <input type="hidden" id="originalLinkedin" name="linkedin">



                            <div class="row">
                                <div class="col-md-3 text-center mb-4">
                                    <div class="position-relative d-inline-block">
                                        <img id="editProfilePreview" src="" class="rounded-circle" 
                                             style="width: 150px; height: 150px; object-fit: cover;" alt="Profile Photo">
                                        <label for="profilePhoto" class="position-absolute bottom-0 end-0 bg-warning rounded-circle p-2 cursor-pointer" style="cursor: pointer;">
                                            <i class="fa-regular fa-pen-to-square" ></i>
                                            <input type="file" class="d-none" id="profilePhoto" name="profilePhoto">
                                        </label>
                                    </div>
                                    <h4 class="mt-3" id="previewName">Specialist Name</h4>
                                    <input type="hidden" id="currentProfile" name="currentProfile">
                                </div>

                                <div class="col-md-9">
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="fullName" class="form-label">Full name</label>
                                            <input type="text" class="form-control" id="editName" name="fullName" >
                                        </div>
                                        <div class="col-md-6">
                                            <label for="email" class="form-label">Email</label>
                                            <input type="email" class="form-control" id="editEmail" name="email" readonly>
                                        </div>

                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="mobile" class="form-label">Phone</label>
                                            <input type="text" class="form-control" id="editMobile" name="mobile" >
                                        </div>
                                        <div class="col-md-6">
                                            <label for="dob" class="form-label">Date of Birth</label>
                                            <input type="text" class="form-control" id="editDOB" name="dob" >
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="gender" class="form-label">Gender</label>
                                            <select class="form-select" name="gender"  >
                                                <option  >Select Gender</option>
                                                <option value="male" <%=sgender.equals("male") ? "selected" : ""%>>Male</option>
                                                <option value="female"    <%=sgender.equals("female") ? "selected" : ""%>>Female</option>
                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="city" class="form-label">City</label>
                                            <input type="text" class="form-control" id="editCity" name="city">
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="expertiseCategory" class="form-label">Category</label>
                                            <select class="form-select" name="expertiseCategory" required>
                                                <option id="editCategory"  disabled >Select Category</option>
                                                <option value="Technology">Technology</option>
                                                <option value="Medicine">Medicine</option>
                                                <option value="Education">Education</option>
                                                <option value="Sports">Sports</option>

                                            </select>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="expertiseDomain" class="form-label">Domain</label>
                                            <input type="text" class="form-control" id="editDomain" name="expertiseDomain" required>
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="yearsExperience" class="form-label">Experience</label>
                                            <input type="number" class="form-control" id="editExperience" name="yearsExperience" >
                                        </div>
                                        <div class="col-md-6">
                                            <label for="workplace" class="form-label">Workplace</label>
                                            <input type="text" class="form-control" id="editWorkplace" name="workplace">
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="portfolio" class="form-label">Portfolio</label>
                                            <input type="url" class="form-control" id="editPortfolio" name="portfolio" >
                                        </div>
                                        <div class="col-md-6">
                                            <label for="linkedin" class="form-label">LinkedIn</label>
                                            <input type="url" class="form-control" id="editLinkedin" name="linkedin" >
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label for="bio" class="form-label">Bio</label>
                                        <textarea class="form-control" id="editBio" name="bio" rows="4"></textarea>
                                    </div>


                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="password" class="form-label">Password</label>
                                            <input type="password" class="form-control" id="editPassword" name="password">
                                            <small class="text-muted">Leave blank to keep current password</small>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="cpassword" class="form-label">Confirm Password</label>
                                            <input type="password" class="form-control" id="editcPassword" name="cpassword">
                                            <small class="text-muted">Leave blank to keep current password</small>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Discard Changes</button>
                            <button type="submit" class="btn btn-warning" >Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>





        <%-- <% //                            String blocked = rs.getString("blocked");
            if ("yes".equalsIgnoreCase(blocked)) {
        %>
        <form action="" method="post">
            <input type="hidden" name="id" value="<%= rs.getString("id")%>">
            <button type="submit" style="background-color: white; color: black; border: 1px solid grey;">
                Unblock
            </button>
        </form>
        <%
        } else {
        %>

        --%>


        <!-- Reason modal for block--> 
        <div id="reasonModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%;
             background: rgba(0, 0, 0, 0.6); z-index:9999; align-items:center; justify-content:center;">
            <div style="background:#fff; padding:20px; border-radius:8px; width:500px; position:relative;">
                <h3 style="margin-top:0;">Enter Reason</h3>
                <form id="reasonForm" method="post" action="${pageContext.request.contextPath}/BlockSpecialistServlet" onsubmit="return blockValidate()">
                    <!-- Fixed: Use hidden inputs with unique IDs -->
                    <input type="hidden" name="id" id="modalUserId">
                    <input type="hidden" name="action" id="modalActionType">
                    <textarea name="reason" id="reasonText" placeholder="Enter reason here..." required style="width:100%; height:90px; border-radius: 4px; padding: 10px;"></textarea><br><br>
                    <button type="submit" class="btn" style="background:#ff7b00; color:white; float: right;">Submit</button>
                    <button type="button" onclick="closeModal()" class="btn" style="background:#ccc;float:right;margin-right: 10px;">Cancel</button>
                </form>
            </div>
        </div>




        <%            } catch (Exception e) {
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

        <!-- JavaScript for table functionality -->
        <script>
            // Function to select/deselect all checkboxes
            function selectAll(source) {
                var checkboxes = document.getElementsByClassName('select-row');
                for (var i = 0; i < checkboxes.length; i++) {
                    checkboxes[i].checked = source.checked;
                }
            }



            // Function to view specialist profile in modal
            function viewProfile(name, email, gender, mobile, dob, city, category, domain, profile, joined) {
                // Make sure Bootstrap is loaded before trying to show modal
                if (typeof bootstrap === 'undefined') {
                    console.error('Bootstrap is not loaded');
                    return;
                }

                // Set the modal content
                document.getElementById("modalName").innerText = name;
                document.getElementById("modalName1").innerText = name;
                document.getElementById("modalEmail").innerText = email;
                document.getElementById("modalMobile").innerText = mobile;
                document.getElementById("modalDOB").innerText = dob;
                document.getElementById("modalCity").innerText = city;
                document.getElementById("modalJoined").innerText = joined;
                document.getElementById("modalGender").innerText = gender; // This should now display the gender
                document.getElementById("modalCategory").innerText = category;
                document.getElementById("modalDomain").innerText = domain;
                document.getElementById("modalProfile").src = "<%= request.getContextPath()%>/profileimages/" + profile;
                // Show the modal
                var specialistModal = new bootstrap.Modal(document.getElementById('specialistModal'));
                specialistModal.show();
            }


            // Function to edit specialist profile - Added as requested
            // Function to edit specialist profile - Updated to include all fields
            function editProfile(id, name, email, gender, mobile, dob, category, domain, password,
                    profile, city, experience, workplace, bio, portfolio, linkedin) {
                // Set form values
                document.getElementById("editId").value = id;
                document.getElementById("editName").value = name;
                document.getElementById("previewName").textContent = name;
                document.getElementById("editEmail").value = email;
                document.getElementById("editMobile").value = mobile;
                document.getElementById("editDOB").value = dob;
                // For select elements, we need to set the selected option
                // For gender dropdown
                const genderSelect = document.querySelector('select[name="gender"]');
                for (let i = 0; i < genderSelect.options.length; i++) {
                    if (genderSelect.options[i].value === gender) {
                        genderSelect.selectedIndex = i;
                        break;
                    }
                }

                document.getElementById("editCity").value = city;
                // For category dropdown
                const categorySelect = document.querySelector('select[name="expertiseCategory"]');
                for (let i = 0; i < categorySelect.options.length; i++) {
                    if (categorySelect.options[i].value === category.trim()) {
                        categorySelect.selectedIndex = i;
                        break;
                    }
                }

                document.getElementById("editDomain").value = domain;
                document.getElementById("editExperience").value = experience;
                document.getElementById("editWorkplace").value = workplace;
                document.getElementById("editBio").value = bio;
                document.getElementById("editPortfolio").value = portfolio;
                document.getElementById("editLinkedin").value = linkedin;
                // For profile image
                document.getElementById("editProfilePreview").src = "<%= request.getContextPath()%>/profileimages/" + profile;
                // Store original values in hidden fields for comparison
                document.getElementById("originalName").value = name;
                document.getElementById("originalEmail").value = email;
                document.getElementById("originalMobile").value = mobile;
                document.getElementById("originalGender").value = gender;
                document.getElementById("originalDOB").value = dob;
                document.getElementById("originalCity").value = city;
                document.getElementById("originalCategory").value = category;
                document.getElementById("originalDomain").value = domain;
                document.getElementById("originalExperience").value = experience;
                document.getElementById("originalWorkplace").value = workplace;
                document.getElementById("originalBio").value = bio;
                document.getElementById("originalPortfolio").value = portfolio;
                document.getElementById("originalLinkedin").value = linkedin;
                // Set form action
//                document.getElementById("editSpecialistForm").action = "UpdateSpecialistServlet";
                // Show the modal
                const editModal = new bootstrap.Modal(document.getElementById('editSpecialistModal'));
                editModal.show();
            }




            // Preview uploaded image before submitting
            document.getElementById('profilePhoto').addEventListener('change', function (e) {
                const file = e.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    reader.onload = function (event) {
                        document.getElementById('editProfilePreview').src = event.target.result;
                    };
                    reader.readAsDataURL(file);
                }
            });
//validation for this form
            function validateEditForm() {
                // Get current values
                let name = document.getElementById("editName").value.trim();
                let email = document.getElementById("editEmail").value.trim();
                let mobile = document.getElementById("editMobile").value.trim();
                let gender = document.getElementById("editGender").value.trim();
                let dob = document.getElementById("editDOB").value.trim();
                let city = document.getElementById("editCity").value.trim();
                let category = document.getElementById("editCategory").value.trim();
                let domain = document.getElementById("editDomain").value.trim();
                let experience = document.getElementById("editExperience").value.trim();
                let workplace = document.getElementById("editWorkplace").value.trim();
                let bio = document.getElementById("editBio").value.trim();
                let portfolio = document.getElementById("editPortfolio").value.trim();
                let linkedin = document.getElementById("editLinkedin").value.trim();
                // Get original values
                let originalName = document.getElementById("originalName").value.trim();
                let originalEmail = document.getElementById("originalEmail").value.trim();
                let originalMobile = document.getElementById("originalMobile").value.trim();
                let originalGender = document.getElementById("originalGender").value.trim();
                let originalDOB = document.getElementById("originalDOB").value.trim();
                let originalCity = document.getElementById("originalCity").value.trim();
                let originalCategory = document.getElementById("originalCategory").value.trim();
                let originalDomain = document.getElementById("originalDomain").value.trim();
                let originalExperience = document.getElementById("originalExperience").value.trim();
                let originalWorkplace = document.getElementById("originalWorkplace").value.trim();
                let originalBio = document.getElementById("originalBio").value.trim();
                let originalPortfolio = document.getElementById("originalPortfolio").value.trim();
                let originalLinkedin = document.getElementById("originalLinkedin").value.trim();
                // Get passwords
                let password = document.getElementById("editPassword").value.trim();
                let cPassword = document.getElementById("editcPassword").value.trim();
                // Check if any field is changed
                let isChanged =
                        name !== originalName ||
                        email !== originalEmail ||
                        mobile !== originalMobile ||
                        gender !== originalGender ||
                        dob !== originalDOB ||
                        city !== originalCity ||
                        category !== originalCategory ||
                        domain !== originalDomain ||
                        experience !== originalExperience ||
                        workplace !== originalWorkplace ||
                        bio !== originalBio ||
                        portfolio !== originalPortfolio ||
                        linkedin !== originalLinkedin;

                if (!isChanged) {
                    alert("No changes detected. Please update at least one field before submitting.");
                }
                // Final check: either something changed or password entered
                // If password is provided, confirm password must also be provided and match
                if (password !== "") {
                    if (cPassword === "") {
                        alert("Please enter confirm password");
                        return false;
                    }

                    if (password !== cPassword) {
                        alert("Password and Confirm Password do not match.");
                        return false;
                    }

                    if (password.length < 6) {
                        alert("Password must be at least 6 characters.");
                        return false;
                    }
                }

                // If confirm password is provided, password must also be provided
                if (cPassword !== "" && password === "") {
                    alert("Please enter password");
                    return false;
                }

                return true; // allow submit
            }


            function blockValidate() {
                let reason = document.getElementById('reasonText');
                if (reason === "") {
                    alert("Enter the reason for blocked");
                    return false;
                }
                return true;
                document.getElementById('block').textContent = 'Unblock';
            }

            function unblockValidate() {
                alert("Are you sure you want to unblock this specialist?");
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


            function openReasonModal(userId, actionType) {
                console.log("Opening modal with userId:", userId, "actionType:", actionType); // Debug log

                // Set values using the correct IDs
                document.getElementById('modalUserId').value = userId;
                document.getElementById('modalActionType').value = actionType;
                document.getElementById('reasonText').value = "";

                // Show the modal
                document.getElementById('reasonModal').style.display = 'flex';

                // Debug: Check if values are set correctly
                console.log("Set userId:", document.getElementById('modalUserId').value);
                console.log("Set actionType:", document.getElementById('modalActionType').value);
            }

            function closeModal() {
                document.getElementById('reasonModal').style.display = 'none';
            }

        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
