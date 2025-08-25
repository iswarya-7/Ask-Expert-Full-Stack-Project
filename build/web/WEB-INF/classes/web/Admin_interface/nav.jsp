<%-- 
    Document   : nav
    Created on : 18 Apr, 2025, 10:37:27 AM
    Author     : rohini
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Header</title>

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


        <!-- Internal css file -->
        <style>

            .modal{
                display:none;
                font-family: 'poppins', sans-serif;
            }

            /* Close Button */
            .container .close {
                color: black;
                position: relative;
                left: 100%;
                top: -30px;
                font-size: 24px;
                cursor: pointer;
            }

            Profile Styling 
            .profile-container {
                text-align: center;
            }


            .container {
                max-width: 800px;
                margin: 50px auto;
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
                padding: 40px;
                display: flex;
                gap: 30px;
            }


            .profile-pic {
                flex: 1;
                text-align: center;
            }

            .profile-pic img {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
            }

            .profile-info {
                flex: 2;
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
            }

            .profile-info h2 {
                grid-column: span 2;
                margin: 0;
                font-size: 24px;
            }

            .info-group {
                display: flex;
                flex-direction: column;
            }

            .info-group label {
                font-weight: bold;
                color: #888;
                margin-bottom: 5px;
            }

            .info-group span {
                font-size: 16px;
            }

            .bio {
                grid-column: span 2;
            }

            .buttons {
                margin-top: 30px;
                text-align: right;
                grid-column: span 2;
            }

            .buttons a {
                text-decoration: none;
                background-color: #ff7b00;
                color: white;
                padding: 10px 20px;
                border-radius: 8px;
                font-weight: 500;
            }
        </style>

    </head>
    <body>

        <header >
            <div class="top_right">
                <i class="fa-regular fa-bell"></i>
                <div class="profile">
                    <div class="dropdown">
                        <img src="<%=request.getContextPath()%>/assets/ad_profile.jpg" alt="admin_profile">
            
                        <div class="dropdown_content ">
                            <a href="" onclick="event.preventDefault(); openProfileModal()"><i
                                    class="fa-solid fa-user"></i> Profile</a>
                            <a href="<%=request.getContextPath()%>/home.jsp"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
                        </div>
                    </div>
                </div>
            </div>
        </header>

        <div class="center">
            <div id="profileModal" class="modal">
                <div class="modal-content">
                    <div class="profile-container">
                        <div class="container ">
                            <span class="close" onclick="closeProfileModal()">&times;</span>

                            <div class="profile-pic">
                                <img src="<%=request.getContextPath()%>/assets/sp.jpg"  alt="Profile Picture" />
                                <p style="margin-top: 10px; font-weight: bold;">John Doe</p>
                            </div>

                            <div class="profile-info">
                                <h2>Profile Preview</h2>

                                <div class="info-group">
                                    <label>Email</label>
                                    <span>john.doe@example.com</span>
                                </div>

                                <div class="info-group">
                                    <label>Phone</label>
                                    <span>(123) 456-7890</span>
                                </div>

                                <div class="info-group">
                                    <label>Specialization</label>
                                    <span>Full Stack Development</span>
                                </div>

                                <div class="info-group">
                                    <label>Experience</label>
                                    <span>5 Years</span>
                                </div>

                                <div class="info-group">
                                    <label>Expertise</label>
                                    <span>Web & Cloud Platforms</span>
                                </div>

                                <div class="info-group">
                                    <label>Gender</label>
                                    <span>Male</span>
                                </div>

                                <div class="info-group bio">
                                    <label>Bio</label>
                                    <span>A passionate developer with expertise in JavaScript and cloud-native technologies. Always learning and building.</span>
                                </div>

                                <div class="buttons">
                                    <a href="<%=request.getContextPath()%>/Admin_interface/editProfile.jsp">Edit Profile</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--
                <div class="container " id="profile">
                    <span class="close" onclick="closeProfileModal()">&times;</span>
        
                    <div class="profile-pic">
                        <img src="<%=request.getContextPath()%>/assets/ad_profile.jpg"  alt="Profile Picture" />
                        <p style="margin-top: 10px; font-weight: bold;">John Doe</p>
                    </div>
        
                    <div class="profile-info">
                        <h2>Profile Preview</h2>
        
                        <div class="info-group">
                            <label>Email</label>
                            <span>john.doe@example.com</span>
                        </div>
        
                        <div class="info-group">
                            <label>Phone</label>
                            <span>(123) 456-7890</span>
                        </div>
        
                        <div class="info-group">
                            <label>Specialization</label>
                            <span>Full Stack Development</span>
                        </div>
        
                        <div class="info-group">
                            <label>Experience</label>
                            <span>5 Years</span>
                        </div>
        
                        <div class="info-group">
                            <label>Expertise</label>
                            <span>Web & Cloud Platforms</span>
                        </div>
        
                        <div class="info-group">
                            <label>Gender</label>
                            <span>Male</span>
                        </div>
        
                        <div class="info-group bio">
                            <label>Bio</label>
                            <span>A passionate developer with expertise in JavaScript and cloud-native technologies. Always learning and building.</span>
                        </div>
        
                        <div class="buttons">
                            <a href="edit-profile.html">Edit Profile</a>
                        </div>
                    </div>-->
    <!--</div>-->   
</body>



<script src="<%=request.getContextPath()%>/Js/specialist.js"></script>
<script src="<%=request.getContextPath()%>/Js/user.js"></script>
</html>
