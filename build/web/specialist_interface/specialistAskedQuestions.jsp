<%-- 
    Document   : SpecialistGetAllQuestion
    Created on : 14 May, 2025, 11:01:17 PM
    Author     : rohini
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%!
    // Method to escape JavaScript string literals
    public String escapeJS(String text) {
        if (text == null) {
            return "";
        }
        return text.replace("\\", "\\\\")
                .replace("\n", "\\n")
                .replace("\r", "\\r")
                .replace("\t", "\\t")
                .replace("'", "\\'")
                .replace("\"", "\\\"");
    }
%>
<%

    Integer sId = (Integer) session.getAttribute("specialistId");
    String sname = "";
    out.print("<script>console.log('User ID: " + sId + "')</script>");
    if (sId != null) {
        Integer questionId = 0, sid = 0;
        String question = "";
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM questions WHERE qnaskspecialist_id = ?");
            ps.setInt(1, sId);
            ResultSet rs = ps.executeQuery();

//            uid = String.valueOf(userId);

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Specialist Asked Questions</title>
        <link rel="stylesheet" href="styles.css">

        <!--External style sheet-->
        <style>

            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: 'poppins',sans-serif;
            }

            body {
                background-color: #f5f5f5;
                color: #333;
                line-height: 1.6;
            }

            a {
                text-decoration: none;
                color: inherit;
            }

            ul {
                list-style: none;
            }

            button {
                cursor: pointer;
                background: none;
                border: none;
                outline: none;
            }

            /* Layout */
            .app-container {
                display: flex;
                flex-direction: column;
                min-height: 100vh;
                font-family: 'poppins',sans-serif;
            }

            .main-wrapper {
                display: flex;
                flex: 1;
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
            }

            .header-title {
                font-size: 28px;
                font-weight: 760;
                width: 200px;
            }

            .search-container {
                flex: 1;
                max-width: 600px;
                margin: 0 20px;
            }

            .search-input {
                width: 100%;
                padding: 10px 20px;
                border: none;
                border-radius: 20px;
                background-color: rgba(255, 255, 255, 0.3);
                color: white;
                font-size: 16px;
            }

            .search-input::placeholder {
                color: rgba(255, 255, 255, 0.8);
            }

            .header-actions {
                display: flex;
                gap: 15px;

            }

            .action-btn {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: white;
                color: #FF7F00;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 18px;
                transition: all 0.2s ease;
            }

            .action-btn:hover {
                transform: scale(1.05);
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            }

            /*user dropdown*/
            .dropdown {
                position: relative;
                display: inline-block;
            }

            #user_drop{
                margin-left: -100px;
                margin-top: 0px;
            }


            .dropdown_content {
                /* display: none; */
                position: absolute;
                /* Fixes right-side extra space issue */
                top: 45px;
                /*    left: -30px;*/
                background-color: white;
                min-width: 200px;
                /* Increased width to fit content properly */
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
                border-radius: 8px;
                overflow: hidden;
                z-index: 1;
                opacity: 0;
                transition: max-height 0.6s ease-in-out, opacity 0.5s ease-in-out;

            }

            .dropdown_content.show {
                /* min-height: 150px; */
                opacity: 1;
                visibility: visible;
            }

            .dropdown_content a {
                display: flex;
                align-items: center;
                /* Ensures icons & text align properly */
                gap: 12px;
                /* Space between icon and text */
                padding: 15px 36px;
                font-size: 16px;
                text-decoration: none;
                color: black;
                transition: 0.3s;
            }

            /* Icon styling (if using FontAwesome or similar) */
            .dropdown_content a i {
                font-size: 18px;
                color: #fd7e14;

            }

            .dropdown:hover .dropdown_content {
                display: block;
            }

            .dropdown .dropdown_content a:hover {
                background-color: rgba(102, 99, 99, 0.123);
            }

            .dropdown:hover .dropdown_btn {
                background-color: #b64900;
            }
            /*
                         Sidebar 
                        .sidebar {
                            width: 270px;
                            background:#ff8000bd;
                            box-shadow:  0px 8px 16px rgba(0, 0, 0, 0.2);
                            color: white;
                            position: fixed;
                            top: 50px;
                            left: 0;
                            bottom: 0;
                            z-index: 900;
                            overflow-y: auto;
                        }
            
                        .sidebar-nav {
                            padding: 20px 0;
                            width: 100%;    
                        }
            
                        .nav-item {
                            margin-bottom: 5px;
                        }
            
                        .nav-link {
                            display: flex;
                            align-items: center;
                            padding: 12px 25px;
                            transition: background-color 0.2s ease;
                        }
            
                        .nav-link:hover, .nav-link.active {
                            background-color: rgba(255, 255, 255, 0.2);
                            font-weight: bold;
                            width: 100%;
                        }
            
                        .nav-link i {
                            margin-right: 15px;
                            font-size: 18px;
                        }
                        .nav-link span{
                            font-size: 18px;
                        }*/

            /* Main Content */
            .main-content {
                flex: 1;
                margin-top: 60px;
                padding: 20px;
                overflow-y: auto;
            }

            .content-wrapper {
                max-width: 1200px;
                margin: 0 auto;
                margin-left: 200px;

            }

            h1 {
                margin-bottom: 20px;
                color: #333;
            }

            /* Question Filters */
            .question-filters {
                display: flex;
                gap: 10px;
                margin-bottom: 20px;
            }

            .filter-btn {
                padding: 8px 15px;
                border-radius: 20px;
                background-color: #f0f0f0;
                color: #666;
                font-weight: 500;
                transition: all 0.2s ease;
            }

            .filter-btn:hover, .filter-btn.active {
                background-color: #FF7F00;
                color: white;
            }

            /* Question List */
            .question-list {
                display: flex;
                flex-direction: column;
                gap: 15px;
            }

            .question-card {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                overflow: hidden;
            }

            .question-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 15px;
                background-color: #f9f9f9;
                border-bottom: 1px solid #eee;
            }

            .question-category {
                padding: 5px 10px;
                border-radius: 15px;
                background-color: #e6f7ff;
                color: #0066cc;
                font-size: 12px;
                font-weight: 500;
            }

            .question-status {
                font-size: 12px;
                font-weight: 500;
                padding: 5px 10px;
                border-radius: 15px;
            }

            .question-status.pending {
                background-color: #fff3e0;
                color: #ff9800;
            }

            .question-status.answered {
                background-color: #e8f5e9;
                color: #4caf50;
            }

            .question-body {
                padding: 10px;
            }

            .question-body h3 {
                margin-bottom: 10px;
                color: #333;
                display: flex;
                justify-content: left;
                padding-left: 10px;
            }

            .question-body p {
                color: #666;
            }

            .question-footer {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 12px 15px;
                border-top: 1px solid #eee;
                background-color: #f9f9f9;
            }

            .question-date {
                font-size: 12px;
                color: #888;
            }

            .question-action-btn {
                color: #666;
                font-size: 16px;
            }






            /*action for edit and delete question*/
            .actions {
                display: flex;
                gap: 10px; /* space between buttons */
                align-items: center;
            }

            .actions button {
                border: none;
                cursor: pointer;
                padding: 7px 10px;
                border-radius: 4px;
                color: white;
                font-size: 16px;
                background-color: #4a90e2; /* default blue */
                transition: background-color 0.3s ease;
            }

            .actions button:hover {
                background-color: #357abd;
            }

            /* Delete button styles */
            .actions button.delete-btn {
                background-color: #e94e4e; /* red */
            }

            .actions button.delete-btn:hover {
                background-color: #c03939;
            }







            /* Modal Styles */
            .modal {
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0,0,0,0.5);
            }

            .modal-content {
                background-color: white;
                margin: 10% auto;
                padding: 20px;
                border-radius: 8px;
                width: 50%;
                max-width: 500px;
            }

            .modal-header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 15px;
            }

            .modal-header h2 {
                margin: 0;
                color: #333;
            }

            .close-modal {
                font-size: 24px;
                font-weight: bold;
                cursor: pointer;
            }

            .modal-body {
                margin-bottom: 20px;
            }

            .modal-body textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                min-height: 100px;
                font-family: inherit;
                font-size: 14px;
            }

            .modal-body select {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                margin-bottom: 15px;
                font-family: inherit;
            }

            .modal-footer {
                display: flex;
                justify-content: flex-end;
                gap: 10px;
            }

            .modal-btn {
                padding: 8px 15px;
                border-radius: 4px;
                font-weight: 500;
                cursor: pointer;
                transition: background-color 0.2s;
            }

            .cancel-btn {
                background-color: #f0f0f0;
                color: #333;
                border: 1px solid #ddd;
            }

            .save-btn {
                background-color: #FF7F00;
                color: white;
                border: none;
            }

            .delete-btn1 {
                background-color: #e94e4e;
                color: #fff;
                border: none;
            }


        </style>
    </head>
    <body>
        <div class="app-container ">
            <!-- Include Header -->
            <jsp:include page="nav.jsp" />

            <div class="main-wrapper">
                <!-- Include Sidebar -->
                <jsp:include page="sidebar.jsp" />

                <!-- Main Content -->
                <main class="main-content" id="main-content" style="margin-left:290px; margin-top: 40px;" >
                    <!-- Content will be loaded here -->

                    <!--<div class="content-wrapper">-->
                    <h1 style="margin-top:20px;">My Questions</h1>
                    <!--getting userid using hiddent input field-->
                    <input type="hidden" value="<%=sId%>" name="spid"/>
                    <div class="question-filters">
                        <a href="<%= request.getContextPath()%>/specialist_interface/SpecialistGetAllQuestion.jsp">    <button class="filter-btn " data-filter="all">All Questions</button></a>
                        <a href="<%= request.getContextPath()%>/specialist_interface/SpecialistGetPendingQuestion.jsp">  <button class="filter-btn " data-filter="Pending">Pending</button></a>
                    </div>

                    <%
                        boolean isquestion = false;
                        while (rs.next()) {
                            isquestion = true;
                            questionId = rs.getInt("question_id");
                            Integer uid = rs.getInt("user_id");
                            sid = rs.getInt("specialist_id");
                            Integer qnaskspecid = rs.getInt("qnaskspecialist_id");

                            String uname = rs.getString("user_name");
                            String uprofile = rs.getString("userProfile");
                            String category = rs.getString("category");
                            question = rs.getString("question");
                            String status = rs.getString("status");
                            sname = rs.getString("specialist_name");
                            Timestamp ts = rs.getTimestamp("posted_at");
                            SimpleDateFormat sdf = new SimpleDateFormat("dd MMM yyyy, hh:mm a");
                            String formattedTime = sdf.format(ts);

                    %>

                    <div class="question-list" >
                        <div class="question-card" data-status="<%= status%>">
                            <div class="question-header">
                                <span class="question-category"><%=category%></span>
                                <span class="question-category">Expert name : <%=sname%></span>
                                <span class="question-status <%= status%>">
                                    <%= status.toLowerCase()%>
                                </span>

                                <!--                                    <span class="question-category">Health</span>
                                                                    <span class="question-status pending">Pending</span>-->
                            </div>
                            <div class="question-body">
                                <h3><%= question%></h3>

                                <!--<h3>What are the best exercises for lower back pain?</h3>-->
                                <!--<p>I've been experiencing lower back pain for the past few weeks. What exercises would you recommend to alleviate the pain?</p>-->
                            </div>
                            <div class="question-footer">
                                <div>
                                    <span class="question-date">Posted: <%= formattedTime%></span>
                                </div>

                                <!--first check if the question is already deleted or not ..if deleted it disable the deleted option-->
                                <div class="actions">
                                    <%  if (status.equals("Answered")) {%>

                                    <button onclick="confirmDelete('<%= questionId%>')" class="delete-btn">
                                        <i class="fas fa-trash"></i>
                                    </button>

                                    <% }else if(!status.equals("Deleted")) {%>
                                    <button onclick="openEditModal('<%= questionId%>', '<%= category%>', '<%= escapeJS(question)%>')" class="edit-btn">
                                        <i class="fas fa-pencil-alt"></i>
                                    </button>
                                    <button onclick="confirmDelete('<%= questionId%>')" class="delete-btn">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                    <% }else { %>
                                    <!-- Optional: show a label or nothing -->
                                    <span style="color: gray; font-size: 12px;">Deleted</span>
                                    <% }
                                    %>

                                </div>
                            </div>

                        </div>
                        <% }
                            if (!isquestion) {%>
                        <p style="color:red;margin-left: 10px;">No question available</p>
                        <%}%>
                    </div>
                    <!--</div>-->

                </main>

            </div>
        </div>

        <!-- Edit Question Modal -->
        <div id="editModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2>Edit Question</h2>
                    <span class="close-modal" onclick="closeEditModal()">&times;</span>
                </div>
                <form id="editQuestionForm" action="<%= request.getContextPath()%>/specialist_interface/EditSpecialistAskedQuestion.jsp" method="post">
                    <input type="hidden" id="editQuestionId" name="questionId" value="<%= questionId%>" />
                    <div class="modal-body">
                        <!--                                            <label for="editCategory">Category:</label>
                                                                    <select id="editCategory" name="category">
                                                                        <option value="Engineering">Engineering</option>
                                                                        <option value="Health">Health</option>
                                                                        <option value="Education">Education</option>
                                                                        <option value="Technology">Technology</option>
                                                                        <option value="Finance">Finance</option>
                                                                        <option value="Other">Other</option>
                                                                    </select>-->

                        <label for="editQuestionText">Question:</label>
                        <textarea id="editQuestionText" name="updatequestion" required></textarea>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="modal-btn cancel-btn" onclick="closeEditModal()">Cancel</button>
                        <button type="submit" class="modal-btn save-btn">Save Changes</button>
                    </div>
                </form>
            </div>
        </div>

        <!-- Delete Confirmation Modal -->
        <div id="deleteModal" class="modal">
            <div class="modal-content">
                <div class="modal-header">
                    <h2>Delete Question</h2>
                    <span class="close-modal" onclick="closeDeleteModal()">&times;</span>
                </div>
                <div class="modal-body">
                    <p>Are you sure you want to delete this question? This action cannot be undone.</p>
                </div>
                <div class="modal-footer">
                    <button class="modal-btn cancel-btn" onclick="closeDeleteModal()">Cancel</button>
                    <form id="deleteQuestionForm" action="<%= request.getContextPath()%>/specialist_interface/DeleteSpecialistAskedQuestion.jsp" method="post">
                        <input type="hidden" id="deleteQuestionId" name="questionId">
                        <button type="submit" class="modal-btn delete-btn1">Delete</button>
                    </form>
                </div>
            </div>
        </div>  
        <%

            } catch (Exception e) {
                e.printStackTrace();
            }
        } else {
        %>
        <p>No questions found.</p >
        <%    }
        %>
    </body>
    <script>
        // Toggle action menu
        function toggleActionMenu(btn) {
            // Close any other open menu
            document.querySelectorAll('.action-menu').forEach(menu => {
                if (!menu.contains(btn.nextElementSibling)) {
                    menu.style.display = 'none';
                }
            });

            const menu = btn.nextElementSibling;
            if (menu.style.display === 'block') {
                menu.style.display = 'none';
            } else {
                menu.style.display = 'block';
            }
        }

// Optional: Close when clicking outside
        document.addEventListener('click', function (event) {
            const isMenuButton = event.target.closest('.question-action-btn');
            const isMenu = event.target.closest('.action-menu');
            if (!isMenu && !isMenuButton) {
                document.querySelectorAll('.action-menu').forEach(menu => {
                    menu.style.display = 'none';
                });
            }
        });

        // Edit Question Functions
        function openEditModal(questionId, category, questionText) {
            document.getElementById('editQuestionId').value = questionId;
//                document.getElementById('editCategory').value = category;
            document.getElementById('editQuestionText').value = questionText;
            document.getElementById('editModal').style.display = 'block';
        }

        function closeEditModal() {
            document.getElementById('editModal').style.display = 'none';
        }

        // Delete Question Functions
        function confirmDelete(questionId) {
            document.getElementById('deleteQuestionId').value = questionId;
            document.getElementById('deleteModal').style.display = 'block';
        }

        function closeDeleteModal() {
            document.getElementById('deleteModal').style.display = 'none';
        }

        // Close modals when clicking outside
        window.onclick = function (event) {
            const editModal = document.getElementById('editModal');
            const deleteModal = document.getElementById('deleteModal');

            if (event.target === editModal) {
                editModal.style.display = 'none';
            }

            if (event.target === deleteModal) {
                deleteModal.style.display = 'none';
            }
        }
    </script>
</html>
