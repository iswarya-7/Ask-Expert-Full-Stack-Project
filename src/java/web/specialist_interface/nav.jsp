<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
    <head>
        <title>Header</title>
        <link rel="stylesheet" href="style.css">

        <style>


            /* Close Button */
            .container .close {
                color: black;
                position: relative;
                left: 100%;
                top: -30px;
                font-size: 24px;
                cursor: pointer;
            }

            Profile Styling .profile-container {
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
                position: relative;
                left: -40px;
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
            .dropdown .userprofile{
                height: 42px;
                width: 40px;
                border-radius: 50%;
                position: relative;
                /*top: 3px;*/
            }

        </style>
    </head>
    <body>
        <header class="header">
            <div class="header-title">Ask Expert</div>
            <div class="search-container">
                <input type="text" class="search-input" placeholder="search question...">
            </div>
            <div class="header-actions">
                <a href="askQuestion.jsp">
                    <!--<button class="action-btn plus" onclick="addquestion()" >-->
                    <button class="action-btn plus" >
                        <i class="fas fa-plus"  ></i>
                    </button></a>
                <button class="action-btn notification-btn">
                    <i class="fas fa-bell"></i>
                </button>
                <button class=" profile-btn"  id="user_icon">
                    <div class="dropdown"  >
                        <img src="<%= request.getContextPath()%>/Specialist_profile/<%= session.getAttribute("profileimage")%>" alt="Profile Picture"  class="userprofile" />

                  
                    </div>
                </button>
            </div>
        </header>

    </body>

</html>