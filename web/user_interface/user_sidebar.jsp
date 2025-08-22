<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ask Expert - Sidebar</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- google fonts -->
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
            rel="stylesheet">
        <!--External style sheet-->
        <link rel="stylesheet" href="style.css">
        <style>
            /* Sidebar */
            .sidebar {
                width: 270px;
                background: #ff8000bd;
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
                color: white;
                position: fixed;
                top: 60px; /* Match header height */
                left: 0;
                bottom: 0;
                overflow-y: auto;
                margin: 0; /* Ensure no extra margins */
            }

            .sidebar-nav {
                padding: 20px 0;
                width: 100%; /* Ensure it takes full sidebar width */
            }

            .nav-item {
                color:black;
                margin: 0px 5px 10px 5px;

                /*margin: 10px;*/
            }

            .nav-link {
                display: flex;
                align-items: center;
                padding: 12px 25px;
                transition: background-color 0.2s ease;

            }

            .nav-link:hover{
                background-color: rgba(255, 255, 255, 0.2);
                /*                font-weight: bold;*/
            }
            .nav-link.active {
                background-color: rgba(255, 255, 255, 0.2);

            }
            .nav-item:hover{
                background-color: white;
                border-radius: 4px;
                /*margin: 10px;*/
            }
            .nav-item:hover i,span{
                color: black;
                /*                font-weight: bold;*/
            }
            .nav-link i {
                margin-right: 15px;
                font-size: 17px;
                color:black;
            }
            .nav-link span{
                font-size: 17px;
            }
            /*            #logout-btn{
                            display:flex; 
                            align-items: bottom; 
                            margin:280px 5px 0px 5px;
                            padding-left: 20px;
                            color:#ffffff;
                        }*/


            /*            .modal {
                            display: none;
                            font-family: 'poppins', sans-serif;
                            margin-left: 20%;
                            height: 100vh;
                        }
                        .center{
                            margin-left: 500px;
                        }*/

        </style>
    </head>
    <body>
        <div class="sidebar">
            <nav class="sidebar-nav">
                <ul>
                    <li class="nav-item" id="profile">
                        <a href="<%= request.getContextPath()%>/user_interface/user_home.jsp" class="nav-link" id="user_icon">
                            <i class="fas fa-home"></i>
                            <span>Home</span>
                        </a>
                    </li>
                    <li class="nav-item" id="profile">
                        <a href="<%= request.getContextPath()%>/user_interface/profile.jsp" class="nav-link" id="user_icon">
                            <i class="fas fa-user"></i>
                            <span>My Profile</span>
                        </a>
                    </li>
                    <li class="nav-item" id="profile">
                        <a href="<%= request.getContextPath()%>/user_interface/changePassword.jsp" onclick="openModal(); return false;"    class="nav-link" id="user_icon">
                            <i class="fas fa-key"></i>
                            <!--<i class="fas fa-lock"></i>--> 
                            <span>Change Password</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="<%= request.getContextPath()%>/user_interface/expertprofile.jsp" class="nav-link"  >
                            <i class="fa-solid fa-users"></i>
                            <span>Experts Profile</span>
                        </a>
                    </li>       
                    <li class="nav-item">
                        <a href="<%= request.getContextPath()%>/user_interface/questions.jsp" class="nav-link"  >
                            <i class="fas fa-comment-dots"></i>
                            <span>Questions I Asked</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a href="<%= request.getContextPath()%>/user_interface/view_answer.jsp" class="nav-link" >
                            <i class="fas fa-inbox"></i>
                            <span>Responses Received</span>
                        </a>
                    </li>

                    <li class="nav-item" id="logout-btn">
                        <a href="<%= request.getContextPath()%>/home.jsp" class="nav-link" >
                            <i class="fa-solid fa-right-from-bracket"></i>
                            <span>Logout</span>
                        </a>
                    </li>
                </ul>
            </nav>
        </div>





        <script>
//            // Add this at the beginning of your script
//            document.addEventListener("DOMContentLoaded", function () {
//                // Make sure modal is hidden on page load
//                document.getElementById("profileModal").style.display = "none";
//
//            });
//
//
//// user drop down
//            const User = document.getElementById('user_icon');
//            const Drop = document.getElementById('profile');
//            User.addEventListener("click", function (event) {
//                event.stopPropagation(); // Prevents immediate closing
//                Drop.classList.toggle("show");
//            });

// profile page
            function openProfileModal() {
                var modal = document.getElementById("profileModal");

                modal.style.display = "flex";
                // Set alignment properties when showing
                modal.style.alignItems = "center";
                modal.style.justifyContent = "center";

                // To prevent scrolling of the main page while the modal is open
//    document.body.style.overflow = "hidden";
            }

            function closeProfileModal() {
                const modal = document.querySelector(".modal");
                if (modal) {
                    modal.style.display = "none";
                }
            }

        </script>



    </body>
</html>
