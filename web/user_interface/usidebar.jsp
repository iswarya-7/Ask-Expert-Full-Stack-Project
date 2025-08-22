<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ask Expert - New Sidebar</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- Google Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
        <style>
            /* Reset and Base Styles */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'Poppins', sans-serif;
            }

            html, body {
                margin: 0;
                padding: 0;
                width: 100%;
                overflow-x: hidden;
            }

            body {
                background-color: #f5f5f5;
                color: #333;
                line-height: 1.6;
            }

            /* Layout */
            .app-container {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                width: 100%;
            }

            .main-wrapper {
                display: flex;
                flex: 1;
                width: 100%;
            }

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
                color: black;
                margin: 0px 5px 10px 5px;
            }

            .nav-link {
                display: flex;
                align-items: center;
                padding: 12px 25px;
                transition: background-color 0.2s ease;
            }

            .nav-link:hover {
                background-color: rgba(255, 255, 255, 0.2);
            }

            .nav-link.active {
                background-color: rgba(255, 255, 255, 0.2);
            }

            .nav-item:hover {
                background-color: white;
                border-radius: 4px;
            }

            .nav-item:hover i,
            .nav-item:hover span {
                color: black;
            }

            .nav-link i {
                margin-right: 15px;
                font-size: 17px;
                color: black;
            }

            .nav-link span {
                font-size: 17px;
            }

            /* Header */
            .header {
                display: flex;
                align-items: center;
                justify-content: space-around;
                padding: 0 20px;
                height: 60px;
                background: linear-gradient(to right, #FF7F00, #FF4500);
                color: white;
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1000;
                width: 100%;
                box-sizing: border-box;
            }

            .header-title {
                font-size: 28px;
                font-weight: 760;
                width: 200px;
            }

            /* Main Content */
            .main-content {
                flex: 1;
                margin-top: 60px;
                margin-left: 270px;
                width: calc(100% - 270px);
                padding: 20px;
                box-sizing: border-box;
            }

            .content-wrapper {
                width: 100%;
                max-width: none;
                margin: 0;
            }

            h1 {
                margin-bottom: 20px;
                color: #333;
            }
        </style>
    </head>
    <body>
        <div class="app-container">
            <!-- Header -->
            <header class="header">
                <div class="header-title">Ask Expert</div>
            </header>

            <div class="main-wrapper">
                <!-- Sidebar -->
                <div class="sidebar">
                    <nav class="sidebar-nav">
                        <ul>
                            <li class="nav-item" id="profile">
                                <a href="<%= request.getContextPath()%>/user_interface/uhome.jsp" class="nav-link" id="user_icon">
                                    <i class="fas fa-home"></i>
                                    <span>Home</span>
                                </a>
                            </li>
                            <li class="nav-item" id="profile">
                                <a href="#" class="nav-link" id="user_icon">
                                    <i class="fas fa-user"></i>
                                    <span>My Profile</span>
                                </a>
                            </li>
                            <li class="nav-item" id="profile">
                                <a href="#" class="nav-link" id="user_icon">
                                    <i class="fas fa-key"></i>
                                    <span>Change Password</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="fa-solid fa-users"></i>
                                    <span>Experts Profile</span>
                                </a>
                            </li>       
                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="fas fa-comment-dots"></i>
                                    <span>Questions I Asked</span>
                                </a>
                            </li>
                            <li class="nav-item">
                                <a href="#" class="nav-link">
                                    <i class="fas fa-inbox"></i>
                                    <span>Responses Received</span>
                                </a>
                            </li>
                            <li class="nav-item" id="logout-btn">
                                <a href="#" class="nav-link">
                                    <i class="fa-solid fa-right-from-bracket"></i>
                                    <span>Logout</span>
                                </a>
                            </li>
                        </ul>
                    </nav>
                </div>
<!--
                 Main Content 
                <main class="main-content">
                    <div class="content-wrapper">
                        
                    </div>
                </main>-->
            </div>
        </div>

        <script>
            // Profile modal functions (same as user_sidebar.jsp)
            function openProfileModal() {
                var modal = document.getElementById("profileModal");
                if (modal) {
                    modal.style.display = "flex";
                    modal.style.alignItems = "center";
                    modal.style.justifyContent = "center";
                }
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