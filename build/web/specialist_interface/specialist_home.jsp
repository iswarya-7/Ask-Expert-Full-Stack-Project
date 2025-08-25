<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Spcialist Home</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- google fonts -->
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
            rel="stylesheet">
        <!--External style sheet-->
        <link rel="stylesheet" href="style.css">
        <style>
            .main-content {
                margin-left: 270px; /* Match the width of your sidebar */
                padding: 20px;
                min-height: calc(100vh - 50px); /* Adjust based on your header height */
            }
            
            .content-container {
                background: white;
                border-radius: 8px;
                padding: 20px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            }
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
              
                </main>
            </div>
        </div>








        <script src="<%=request.getContextPath()%>/script.js"></script>
        <script src="<%=request.getContextPath()%>/Js/specialist.js"></script>
        <script src="<%=request.getContextPath()%>/Js/user.js"></script>
    </body>
</html>
