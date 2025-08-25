<%-- 
    Document   : user_details
    Created on : 18 Apr, 2025, 4:56:45 PM
    Author     : rohini
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Integer userId = (Integer) session.getAttribute("userId");
    int uid = 0;
    String blocked = null, gender = null;
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

        String query = "SELECT * FROM user_registerdetails where status='accepted' ";
        ps = con.prepareStatement(query);
        rs = ps.executeQuery();

%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin - User Details</title>

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
            .uprofile{
                width: 45px;
                height: 45px;
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
                <!-- specialist details -->
                <h3 style="margin: 25px;margin-bottom: 50px; font-size: 25px; font-weight: 600;">User Details</h3>

                <table class="details table table-striped">
                    <thead>
                        <tr class="title">
                            <th><input type="checkbox" onclick="selectAll(this)" /></th> <!-- Master checkbox -->
                            <th>S No</th>
                            <th>Profile</th>
                            <th>User Name</th>
                            <th>DOB</th>
                            <th>Gender</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Status</th>

                            <!--<th>Question Asked</th>-->
                            <!--<th>Answer Received</th>-->

                            <th style="text-align: center;">Actions</th>
                            <th>Block Access</th>


                        </tr>
                    </thead>
                    <%                        int i = 0;
                        while (rs.next()) {
                            String uname = rs.getString("full_name");
                            String uprofile = rs.getString("profile_photo");
                            gender = rs.getString("gender");
                            String email = rs.getString("email");
                            String mobile = rs.getString("mobile");
                            String dob = rs.getString("dob");
                            Timestamp ts = rs.getTimestamp("created_at");
                            String bio = rs.getString("bio");
                            String password = rs.getString("password");
                            String cpassword = rs.getString("cpassword");
                            blocked = rs.getString("blocked");
                            String status = rs.getString("blockstatus");
                            SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy");
                            String formattedTime = sdf.format(ts);
                            uid = rs.getInt("id");

                            session.setAttribute("userId", uid);
                            session.setAttribute("uname", uname);
                            session.setAttribute("uemail", email);
                            i++;


                    %>

                    <tbody>
                        <tr>
                            <td><input type="checkbox" class="select-row" /></td>
                            <td><%=i%></td>
                            <td><img src="<%= request.getContextPath()%>/profileimages/<%=uprofile%>" alt="admin_profile" class="uprofile"></td>
                            <td><%= uname%></td>
                            <td><%= dob%></td>
                            <td><%=gender%></td>
                            <td><%= email%></td>
                            <td><%= mobile%></td>

                            <td>
                                <%
                                    if ("Pending".equals(status)) {
                                %>
                                <span class="text-danger"><%= status%></span>
                                <%
                                 }else if ("active".equals(status)) {
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

                            <!--<td><%=totalAsked%></td>-->
                            <!--<td><%=totalAnswered%></td>-->
                            <td class="vertical-align: middle; text-align: center;">
                                <div class="d-flex justify-content-center gap-2">
                                    <!-- View Profile -->
        <!--                                    <button class="btn btn-info btn-sm" onclick="viewProfile('<%=email%>')">
                                        <i class="fa fa-eye"></i>
                                    </button>-->
                                    <!-- Edit -->
                                    <!--                                        <button class="btn btn-warning btn-sm" onclick="editSpecialist('<= specialist.get("email")%>')">
                                                                            <i class="fa fa-pen"></i>
                                                                        </button>-->
                                    <!-- Delete -->

                                    <div class="d-flex justify-content-center gap-2">
                                        <!-- View Profile -->
                                        <button class="btn btn-info btn-sm" 
                                                onclick="viewProfile(this)"
                                                data-name="<%= uname%>"
                                                data-name1="<%= uname%>"
                                                data-email="<%= email%>"
                                                data-gender="<%= gender%>"
                                                data-mobile="<%= mobile%>"
                                                data-dob="<%= dob%>"
                                                data-qnaskedcount="<%= totalAsked%>"
                                                data-answercount="<%= totalAnswered%>"


                                                data-profile="<%= uprofile%>"
                                                data-joined="<%= formattedTime%>">
                                            <i class="fa fa-eye"></i>
                                        </button>
                                        <button   type="button" class="btn btn-warning btn-sm" 
                                                  onclick="editProfile('<%=uid%>', '<%= uname%>', '<%= email%>', '<%= gender%>', '<%= mobile%>', '<%= dob%>', '<%= uprofile%>', '<%=bio%>', '<%= password%>')" >
                                            <i class="fa fa-pen"></i>

                                        </button>

                                        <button class="btn btn-danger btn-sm" onclick="deleteSpecialist('<%= email%>')">
                                            <i class="fa fa-trash"></i>
                                        </button>
                                    </div>
                                </div>
                            </td>

                            <td>
                                <% if ("yes".equalsIgnoreCase(blocked)) {%>
                                <form id="reasonForm" method="post" action="${pageContext.request.contextPath}/UnblockUserServlet" onsubmit="return unblockValidate()">
                                    <input type="hidden" name="id" id="userId" value="<%=uid%>">
                                    <input type="hidden" name="action" id="actionType" value="unblock">
                                    <button class="btn " style="background:white;color:black;" onclick="unblock('<%= uid%>', 'unblock')">Unblock</button>
                                </form>


                                <% } else {%>
                                <button class="btn block-btn btn-danger" onclick="openReasonModal('<%= uid%>', 'block')">Block</button>
                                <% } %>
                            </td>
                        </tr>
                    </tbody>


                    <%
                        }

                    %>
                </table>
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
                            <p><strong>DOB:</strong> <span id="modalDOB"></span></p>
                            <p><strong>Gender:</strong> <span id="modalGender"></span></p>
                            <p><strong>Joined On:</strong> <span id="modalJoined"></span></p>
                            <p><strong>User Asked Question Count:</strong> <span id="modalQuestionc"></span></p>
                            <p><strong>User ANswer Received Count:</strong> <span id="modalAnswerc"></span></p>

                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>









        <!-- Edit Specialist Modal - Updated to match the design -->
        <div class="modal fade" id="editUserModal" tabindex="-1" aria-labelledby="editSpecialistModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered modal-xl">
                <div class="modal-content">
                    <div class="modal-header text-white" style="background:#fd7e14;">
                        <h5 class="modal-title" id="editSpecialistModalLabel">Profile Update</h5>
                        <button type="button" class="btn-close btn-white" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <form id="editSpecialistForm" action="${pageContext.request.contextPath}/EditUserFormA" method="POST" enctype="multipart/form-data"  onsubmit="return validateEditForm()">
                        <div class="modal-body">
                            <input type="text" id="editId" name="uid" >


                            <!-- Hidden fields to store original values -->
                            <input type="hidden" id="originalName" name="full_name">
                            <input type="hidden" id="originalEmail" name="email">
                            <input type="hidden" id="originalMobile" name="phone">
                            <input type="hidden" id="originalGender" name="gender">
                            <input type="hidden" id="originalDOB" name="dob">
                            <input type="hidden" id="originalBio" name="bio">



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
                                            <input type="email" class="form-control" id="editEmail" name="email"  readonly>
                                        </div>

                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="mobile1" class="form-label">Phone</label>
                                            <input type="text" class="form-control" id="editMobile" name="mobile1" >
                                        </div>
                                        <div class="col-md-6">
                                            <label for="dob1" class="form-label">Date of Birth</label>
                                            <input type="date" class="form-control" id="editDOB" name="dob1" >
                                        </div>
                                    </div>

                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="gender1" class="form-label">Gender</label>
                                            <select class="form-select" name="gender1"  >
                                                <option >Select Gender</option>
                                                <option value="Male" <%=gender.equals("male") ? "selected" : ""%>>Male</option>
                                                <option value="Female"    <%=gender.equals("female") ? "selected" : ""%>>Female</option>
                                            </select>
                                        </div>

                                    </div>


                                    <div class="mb-3">
                                        <label for="bio1" class="form-label">Bio</label>
                                        <textarea class="form-control" id="editBio" name="bio1" rows="4"></textarea>
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











        <!-- Reason modal for block--> 
        <div id="reasonModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%;
             background: rgba(0, 0, 0, 0.6); z-index:9999; align-items:center; justify-content:center;">
            <div style="background:#fff; padding:20px; border-radius:8px; width:500px; position:relative;">
                <h3 style="margin-top:0;">Enter Reason</h3>
                <form id="reasonForm" method="post" action="${pageContext.request.contextPath}/BlockUserServlet" onsubmit="return blockValidate()">
                    <input type="hidden" name="id" id="userId" value="<%=uid%>">
                    <input type="hidden" name="action" id="actionType">
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

        <script>
            // Function to select/deselect all checkboxes
            function selectAll(source) {
                var checkboxes = document.getElementsByClassName('select-row');
                for (var i = 0; i < checkboxes.length; i++) {
                    checkboxes[i].checked = source.checked;
                }
            }


            function viewProfile(button) {
                const name = button.getAttribute("data-name");
                const name1 = button.getAttribute("data-name");
                const email = button.getAttribute("data-email");
                const gender = button.getAttribute("data-gender");
                const mobile = button.getAttribute("data-mobile");
                const dob = button.getAttribute("data-dob");
                const qnaskedcount = button.getAttribute("data-qnaskedcount");
                const answercount = button.getAttribute("data-answercount");
                const profile = button.getAttribute("data-profile");
                const joined = button.getAttribute("data-joined");


                document.getElementById("modalName").innerText = name;
                document.getElementById("modalName1").innerText = name;
                document.getElementById("modalEmail").innerText = email;
                document.getElementById("modalMobile").innerText = mobile;
                document.getElementById("modalDOB").innerText = dob;
                document.getElementById("modalGender").innerText = gender;
                document.getElementById("modalQuestionc").innerText = qnaskedcount;
                document.getElementById("modalAnswerc").innerText = answercount;
                document.getElementById("modalProfile").src = "<%= request.getContextPath()%>/profileimages/" + profile;
                document.getElementById("modalJoined").innerText = joined;


                const modal = new bootstrap.Modal(document.getElementById('specialistModal'));
                modal.show();
            }




            function editProfile(id, name, email, gender, mobile, dob, profile, bio, password) {
                // Set form values
                document.getElementById("editId").value = id;

                document.getElementById("editName").value = name;
                document.getElementById("previewName").textContent = name;
                document.getElementById("editEmail").value = email;
                document.getElementById("editMobile").value = mobile;
                document.getElementById("editDOB").value = dob;
                // For select elements, we need to set the selected option
                // For gender dropdown



                document.getElementById("editBio").value = bio;
                // For profile image
                document.getElementById("editProfilePreview").src = "<%= request.getContextPath()%>/profileimages/" + profile;
                // Store original values in hidden fields for comparison
                document.getElementById("originalName").value = name;
                document.getElementById("originalEmail").value = email;
                document.getElementById("originalMobile").value = mobile;
                document.getElementById("originalGender").value = gender;
                document.getElementById("originalDOB").value = dob;
                document.getElementById("originalBio").value = bio;
                // Set form action
//                document.getElementById("editSpecialistForm").action = "UpdateSpecialistServlet";
                // Show the modal
                const editModal = new bootstrap.Modal(document.getElementById('editUserModal'));
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

//            validation for this form
            function validateEditForm() {
                // Get current values
                let name = document.getElementById("editName").value.trim();
                let email = document.getElementById("editEmail").value.trim();
                let mobile = document.getElementById("editMobile").value.trim();
                let gender = document.getElementById("editGender").value.trim();
                let dob = document.getElementById("editDOB").value.trim();
                let bio = document.getElementById("editBio").value.trim();
                // Get original values
                let originalName = document.getElementById("originalName").value.trim();
                let originalEmail = document.getElementById("originalEmail").value.trim();
                let originalMobile = document.getElementById("originalMobile").value.trim();
                let originalGender = document.getElementById("originalGender").value.trim();
                let originalDOB = document.getElementById("originalDOB").value.trim();
                let originalBio = document.getElementById("originalBio").value.trim();
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
                        bio !== originalBio;
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
                alert("Are you sure you want to unblock this user?");
            }

            function openReasonModal(userId, actionType) {
                document.getElementById('userId').value = userId;
                document.getElementById('actionType').value = actionType;
                document.getElementById('reasonText').value = "";
                document.getElementById('reasonModal').style.display = 'flex';
            }

            function closeModal() {
                document.getElementById('reasonModal').style.display = 'none';
            }

            // Function to delete specialist
            function deleteSpecialist(email) {
                if (confirm("Are you sure you want to delete this specialist?")) {
                    // Create a form and submit it
                    var form = document.createElement("form");
                    form.method = "POST";
                    form.action = "DeleteUserServlet";

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
