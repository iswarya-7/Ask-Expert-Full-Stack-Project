<%-- 
    Document   : admin_home
    Created on : 18 Apr, 2025, 11:10:17 AM
    Author     : rohini
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Home</title>
        <!-- Google font link -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
            rel="stylesheet">
        <!--External css link-->
        <link rel="stylesheet" href="admin.css"/>

        <style>
            body{
                font-family: poppins,'sans-serif';
            }
            .main-content{
                display:flex;
                justify-content: center;
                align-items: center;
                height:100vh;
            }
            #content_area{
                margin-left: 120px;
            }

            #content-area h2{
                font-weight: 600;
                font-size: 30px;
                line-height: 40px;
            }
            /*
                        .main {
                            width: 100%;
                            display: flex;
                            justify-content: space-between;
                        }
            
            
                        .modal{
                            display:none;
                            font-family: 'poppins', sans-serif;
                        }
            
                         Close Button 
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
            
                        
                        #search{
                            position: relative;
                            left: -250px;
                            padding:18px 20px;
                        }
                        .top_right .icon{
                            position: relative;
                            left:-150px;
                        }*/


        </style>
    </head>
    <body>
        <div class="main">

            <%@ include file="sidebar.jsp" %>
            <div class="main_right">
                <!--Main content-->
                <div class="main-content" >
                    <div id="content-area" >
                        <h2>Welcome to Admin Dashboard !</h2>
                        <p style="margin-left: 100px;">Select an option from the sidebar.</p>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
