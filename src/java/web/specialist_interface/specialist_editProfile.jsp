<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%

    String success = request.getParameter("success");
    Integer specialistId = (Integer) session.getAttribute("specialistId");
    String fname = "", gender = "", mobile = "", email = "", dob = "", profilePhoto = "", category = "", expertise_domain = "", years = "", bio = "", portfolio = "", workplace = "", id = "";
    if (specialistId != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM specialist_regdetails WHERE id = ?");
            ps.setInt(1, specialistId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                fname = rs.getString("full_name");
                gender = rs.getString("gender");
                email = rs.getString("email");
                mobile = rs.getString("mobile");
                dob = rs.getString("dob");
                profilePhoto = rs.getString("profile_photo");
                category = rs.getString("expertise_category");
                expertise_domain = rs.getString("expertise_domain");
                years = rs.getString("years_experience");
                workplace = rs.getString("workplace");
                portfolio = rs.getString("portfolio");
                bio = rs.getString("bio");
                id = rs.getString("id");
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        out.println("<script>alert('session is null');</script>");
    }
%>

<!DOCTYPE html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User - Edit Profile Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">


    <!-- google fonts -->
    <link
        href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
        rel="stylesheet">
    <script src="https://unpkg.com/feather-icons"></script>
    <!--External style sheet-->
    <!--<link rel="stylesheet" href="style.css">-->
    <style>
        body {
            font-family: 'poppins', sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
        }
      
        /* Close Button */
 .close {
            color: black;
            position: relative;
            /*left: 100%;*/
            top: -30px;
            font-size: 24px;
            cursor: pointer;
        }

       

        .buttons {
            grid-column: span 2;
            display: flex;
            justify-content: flex-end;
            gap: 10px;
            margin-top: 20px;
        }

        .buttons button {
            padding: 10px 20px;
            font-size: 15px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
        }

        .save-btn {
            background: #fd7e14;
            color: white;
        }
        .save-btn:hover{
            background:  linear-gradient(to right, #FF7F00, #FF4500);
        }

        .discard-btn {
            background-color: #f0f0f0;
            color: #333;
        }
        .profile-pic-wrapper{
            position: relative;
            display: inline-block;
        }
        .profile-pic-wrapper img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
        }
        .edit_icon {
            position: absolute;
            top: 90px;
            right: 5px;
            background-color: #fd7e14;
            color: white;
            width: 28px;
            height: 28px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            border: 2px solid white;
            box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
            font-size: 14px;
        }




        /*new design*/
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f5f7fb;
            margin: 0;
            padding: 20px;
        }

        .profile-card {
            max-width: 900px;
            margin: auto;
            background: white;
            display: flex;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-top: 40px;
            margin-left: 250px;
        }

        .left-panel {
            background:  #fff;
            color: white;
            padding: 15px 20px;
            width: 30%;
            text-align: center;
        }

        .left-panel img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid white;
            margin-bottom: 15px;
        }

        .left-panel h2 {
            margin: 10px 0 5px;
            font-size: 22px;
            color: #000;
        }

        .status {
            font-weight: bold;
            padding: 5px 10px;
            border-radius: 20px;
            display: inline-block;
            font-size: 12px;
            margin-top: 10px;
            background-color: #ffc107;
            color: black;
        }

        .status.approved {
            background-color: #28a745;
            color: white;
        }
        .right-panel {
            padding: 30px;
            width: 70%;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }

        .info-group label {
            font-weight: bold;
            color: #666;
            font-size: 14px;
        }

        .info-group span, .info-group a {
            display: block;

            color: #333;
            font-size: 16px;
            text-decoration: none;
        }
        .info-group input,
        .info-group textarea,
        .info-group select{
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
        }
        .info-group select{
            color: #333; 
        }
        .info-group option{
            color: #444; 
        }
        .info-group select:focus {
            outline: none;
            border-color: #fd7e14;
            color: #212529;
            box-shadow: 0 0 5px rgba(253, 126, 20, 0.5);
            /* Add a glowing effect */
        }
        .info-group input:focus {
            outline: none;
            border-color: #fd7e14;
            color: #212529;
            box-shadow: 0 0 5px rgba(253, 126, 20, 0.5);
            /* Add a glowing effect */
        }
        .info-group textarea:focus{
            outline: none;
            border-color: #fd7e14;
            color: #212529;
            box-shadow: 0 0 5px rgba(253, 126, 20, 0.5);
        }
        .info-group a.button {
            background: #6a59d1;
            color: white;
            padding: 8px 12px;
            border-radius: 8px;
            display: inline-block;
            text-align: center;
        }

        .info-group.full-width {
            grid-column: span 2;
        }

        .edit-btn {
            grid-column: span 2;
            text-align: right;
        }

        .edit-btn a {
            background: #ff7b00;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
        }

        @media (max-width: 768px) {
            .profile-card {
                flex-direction: column;
            }

            .left-panel, .right-panel {
                width: 100%;
            }

            .right-panel {
                grid-template-columns: 1fr;
            }

            .edit-btn {
                text-align: center;

            </style>
        </head>


        <body>

            <div class="app-container">
                <!-- Include Header -->
                <jsp:include page="nav.jsp" />

                <div class="main-wrapper">
                    <!-- Include Sidebar -->
                    <jsp:include page="sidebar.jsp" />

                    <!-- Main Content -->
                    <main class="main-content" id="main-content">
                        <!-- Content will be loaded here -->
                        <div class="profile-card">
                            <span class="close" onclick="closeProfileModal()">&times;</span>
                            <div class="left-panel">
                                <h2 style="margin-bottom:30px;">Profile Update</h2>
                                <form  method="post" enctype="multipart/form-data" id="imageUploadForm" action="${pageContext.request.contextPath}/SpecialistUpdateProfile"  >
                                    <div class="profile-pic-wrapper">
                                        <img src="<%= request.getContextPath()%>/Specialist_profile/<%= profilePhoto%>" alt="Profile Picture"  />
                                        <!-- Pencil icon -->    
                                        <label for="profileImage" class="edit_icon">
                                            <i class="fa-regular fa-pen-to-square" ></i>
                                            <!-- Hidden file input -->

                                            <input type="file" id="profileImage" name="profilefile" style="display: none;" onchange="document.getElementById('imageUploadForm').submit();" />
                                        </label>
                                        <!--</form>-->
                                    </div>
                                    <h2><%= fname%></h2>
                            </div>


                            <div class="right-panel">
                                <div class="info-group">
                                    <label>Full name</label>
                                    <input type="text" id="name"  name="full_name" value ="<%=  fname%>" >

                                    <!--<span>Rohini</span>-->
                                </div>
                                <!--get the input id via hidden-->
                                <input type="hidden" name="spid" value="<%=id%>">

                                <div class="info-group">
                                    <label>Email</label>
                                    <input type="email" id="email" name="email"   value ="<%= email%>"   readonly>
                                </div>

                                <div class="info-group">
                                    <label>Phone</label>
                                    <input type="tel" id="phone"  name ="phone" placeholder="(91) 456-7890"   value ="<%= mobile%>" >
                                </div>

                                <!--                            <div class="info-group">
                                                                <label>Gender</label>
                                                                <span>Female</span>
                                                            </div>-->

                                <div class="info-group">
                                    <label>Date of Birth</label>
                                    <input type="text" id="category" value="<%= dob%>"  name="category">
                                </div>

                                <div class="info-group">
                                    <label>Category</label>
                                    <select name="category" id="category_area" placeholder="Select your category"
                                            style="color: #555555d8;" value="<%=category%>">
                                        <option disabled <%= (category == null || category.equals("")) ? "selected" : ""%>>Select your category</option>
                                        <option value="technology">Technology</option>
                                        <option value="Medicine">Medicine</option>
                                        <option value="business">Business</option>
                                        <option value="education">Education</option>
                                        <option value="laws">Laws </option>
                                        <option value="finance">Finance</option>
                                        <option value="arts">Arts</option>
                                        <option value="science">Science</option>
                                        <option value="engineering">Engineering</option>
                                    </select>
                                    <!--<input type="text" id="category" value="<= category%>"  name="category">-->
                                </div>

                                <div class="info-group">
                                    <label>Domain</label>
                                    <input type="text" id="category" value="<%= expertise_domain%>"  name="category">
                                </div>

                                <div class="info-group">
                                    <label>Experience</label>
                                    <input type="text" id="years"   value="<%= years%>" name="experience"  >
                                </div>

                                <div class="info-group">
                                    <label>Workplace</label>
                                    <input type="text" id="workplace"   value= "<%= workplace%>" name="workplace"  >
                                </div>

                                <div class="info-group" style="display: flex">
                                        <label>Portfolio</label>
                                        <input type="text" id="portfolio"   value="<%= portfolio%>" name="portfolio"  >

                                    </div>

                                    <!--                                <div class="info-group">
                                                                        <label>LinkedIn</label>
                                                                        <a href="https://linkedin.com/in/rohini" target="_blank"  style=" color: #6a59d1;
                                                                           text-decoration: none;">LinkedIn</a>
                                                                    </div>-->

                                    <div class="info-group full-width">
                                        <label>Bio</label>
                                        <textarea id="bio" rows="3" name="bio" ><%= bio%></textarea>
                                    </div>


                                    <div class="buttons">
                                        <button class="discard-btn" type="reset">Discard Changes</button>
                                        <button class="save-btn" type="submit"  >Save Changes</button>  
                                    </div>
                                    <!--<div class="edit-btn">-->
                                    <!--<a href="Specialist_editProfile.jsp">Edit Profile</a>-->
                                    <!--</div>-->
                                </div>
                            </div>
                            </form>

                        </main>
                    </div>
                </div>
                <script>
                    //            user form validation
                    function saveForm() {
                        //                const genderEl = document.querySelector('input[name="gender"]:checked');
                        const data = {
                            name: document.getElementById('name').value.trim(),
                            email: document.getElementById('email').value.trim(),
                            phone: document.getElementById('phone').value.trim(),
                            password: document.getElementById('password').value,
                            specialization: document.getElementById('bio').value.trim(),
                            //                    gender: genderEl ? genderEl.value : ''
                        };
                        if (!data.name || !data.phone) {
                            alert('Please fill out the fields.');
                            return;
                        }

                        console.log('Saved Data:', data);
                        //                alert('User Profile Updated successfully!');
                    }


                    function closeProfileModal() {
                        const container = document.getElementById("cl");
                        if (container) {
                            container.style.display = "none";
                            window.location.href = "user_home.jsp";

                        }
                    }

                    // Or optionally redirect
                    //                     window.location.href = "user_home.jsp"; // example


                    document.addEventListener('DOMContentLoaded', function () {
                        // Get the file input element
                        const profileImageInput = document.getElementById('profileImage');
                        if (profileImageInput) {
                            // Get the image element
                            const profileImgTag = document.querySelector('#imageUploadForm img');
                            // Remove the onchange attribute from the HTML that submits the form
                            profileImageInput.removeAttribute('onchange');
                            // Add a new event listener
                            profileImageInput.addEventListener('change', function (event) {
                                const file = event.target.files[0];
                                if (file && profileImgTag) {
                                    const reader = new FileReader();
                                    reader.onload = function (e) {
                                        profileImgTag.src = e.target.result;
                                    };
                                    reader.readAsDataURL(file);
                                    // No automatic submission
                                    // The form will only submit when the user explicitly does so
                                }
                            });
                        }
                    });


//for specialist profile alert
                    <% if ("true".equals(success)) { %>
                    alert("Specialist profile updated successfully!");
                    <% }%>
                </script>



                <script src="<%=request.getContextPath()%>/Js/specialist.js"></script>
                <script src="<%=request.getContextPath()%>/Js/user.js"></script>
            </body>

