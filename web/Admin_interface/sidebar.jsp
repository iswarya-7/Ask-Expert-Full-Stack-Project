<%-- 
    Document   : sidebar
    Created on : 18 Apr, 2025, 10:37:38 AM
    Author     : rohini
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Side Bar</title>
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

        <style> 
            .dropdown-btn {
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: start;
                /*gap: 10px;*/
                margin-top: -15px;
                padding-top: 5px;
            }
            #dd{
                flex-direction: column;
            }   


            .dropdown-container {
                display: none;
                flex-direction: column;
                margin-left: 30px;
                transition: max-height 0.5s ease;
                overflow: hidden;
            }

            .dropdown-container.show {
                display: flex;
            }

            .dropdown-container a {
                font-size: 14px;
                color: #444;
                padding: 5px 0;
                text-decoration: none;
                margin-top: 5px;

            }
            .dropdown-container a:hover {
                color: #6a59d1;
            }
        </style>
    </head>
    <body>

        <div class="main_left">
            <h3>Ask Expert</h3>
            <!-- dashboard -->
            <div class="part">
                <i class="fa-solid fa-house"></i>
                <a href="<%=request.getContextPath()%>/Admin_interface/admin_home.jsp">
                    <h5>Home</h5>
                </a>
            </div>
            <div class="part">
                <i class="fa-solid fa-gauge-high "></i>
                <a href="<%=request.getContextPath()%>/Admin_interface/dashboard.jsp">
                    <h5>Dashboard</h5>
                </a>
            </div>
            <!--Specialist  -->
            <div class="part" id="dd">
                <div class="dropdown-btn" onclick="toggleDropdown()">
                    <i class="fa-solid fa-user-tie"></i>
                    <h5 style="position:relative; top: 7px;">Manage Specialist <i class="fa-solid fa-caret-down" style="position:relative;top: 0px; left: 10px;"></i></h5>
                </div>
                <div id="specialistDropdown" class="dropdown-container">
                    <a href="specialist_requests.jsp" style="padding-top:10px;">Specialist Requests</a>
                    <a href="specialist_details.jsp" >Specialist Details</a>
                </div>
            </div>  



            <!-- User -->
            <div class="part">
                <i class="fa-solid fa-users"></i>
                <a href="<%=request.getContextPath()%>/Admin_interface/user_details.jsp">
                    <h5>Manage Users </h5>
                </a>
            </div>
            <!-- Questions & Responses  -->
            <div class="part">
                <i class="fa-solid fa-comments"></i>
                <a href=" <%=request.getContextPath()%>/Admin_interface/questions_response.jsp">
                    <h5>Questions & Responses </h5>
                </a>
            </div>

            <!-- Logout -->
            <div class="part">
                <i class="fa-solid fa-right-from-bracket"></i>
                <a href="<%=request.getContextPath()%>/home.jsp">
                    <h5>Logout</h5>
                </a>
            </div>
        </div>   

    </body>

    <script>
        function toggleDropdown() {
            const dropdown = document.getElementById("specialistDropdown");
            dropdown.classList.toggle("show");
        }
    </script>
</html>
