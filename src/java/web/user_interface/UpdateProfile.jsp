<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%
    Integer userId = (Integer) session.getAttribute("userId");
    String fname = "", gender = "", mobile = "", email = "", profilePhoto = "", bio = "", id = "";
    if (userId != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM user_registerdetails WHERE id = ?");
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                fname = rs.getString("full_name");
                gender = rs.getString("gender");
                email = rs.getString("email");
                mobile = rs.getString("mobile");
                profilePhoto = rs.getString("profile_photo");
                bio = rs.getString("bio");
                id = rs.getString("id");
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    // Check for success message
    String successMsg = "";
    if (request.getParameter("success") != null && request.getParameter("success").equals("true")) {
        successMsg = "Profile updated successfully!";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User - Edit Profile Page</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    <script src="https://unpkg.com/feather-icons"></script>
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            font-family: 'poppins', sans-serif;
            background-color: #f0f2f5;
            margin: 0;
            padding: 0;
        }

        .container {
            /*min-width: 400px;*/
            max-width: 800px;
            margin: 40px auto;
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
            padding: 40px;
            display: flex;
            gap: 30px;
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

        .sidebar1 {
            flex: 1;
            text-align: center;
            margin-left: -25px;
            margin-right: 10px;
            width:30%;
        }

        .sidebar1 img {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            object-fit: cover;
        }

        .sidebar1 h2 {
            font-size: 18px;
            margin: 5px 0 5px;
        }

        .sidebar1 p {
            color: gray;
        }

        .form-section {
            flex: 3;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-group {
            display: flex;
            flex-direction: column;
        }

        .form-group.full-width {
            grid-column: span 2;
        }

        .form-group label {
            font-weight: 600;
            margin-bottom: 6px;
        }

        .form-group input,
        .form-group select,
        .form-group textarea {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            font-size: 15px;
        }

        .form-group input:focus {
            outline: none;
            border-color: #fd7e14;
            color: #212529;
            box-shadow: 0 0 5px rgba(253, 126, 20, 0.5);
        }
        .form-group textarea:focus{
            outline: none;
            border-color: #fd7e14;
            color: #212529;
            box-shadow: 0 0 5px rgba(253, 126, 20, 0.5);
        }
        .gender-options {
            display: flex;
            gap: 20px;
            align-items: center;
            margin-top: 8px;
        }
        .gender-options input:focus{
            box-shadow: none;
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
        
        .success-message {
            background-color: #d4edda;
            color: #155724;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 15px;
            text-align: center;
            width: 100%;
            position: absolute;
            top: 10px;
            left: 0;
        }
    </style>
</head>

<body>
    <div class="app-container">
        <!-- Include Header -->
        <jsp:include page="user_nav.jsp" />

        <div class="main-wrapper">
            <!-- Include Sidebar -->
            <jsp:include page="user_sidebar.jsp" />

            <!-- Main Content -->
            <main class="main-content" id="main-content">
                <!-- Content will be loaded here -->
                <div class="container" id="cl">
                    <span class="close" onclick="closeProfileModal()">&times;</span>
                    
                    <% if (!successMsg.isEmpty()) { %>
                    <div class="success-message">
                        <%= successMsg %>
                    </div>
                    <% } %>
                    
                    <!-- COMBINED FORM STARTS HERE -->
                    <form method="post" action="${pageContext.request.contextPath}/CombinedProfileServlet" onsubmit="return validateForm();" enctype="multipart/form-data">
                        <div class="sidebar1">
                            <div class="profile-pic-wrapper">
                                <img id="profileImageDisplay" src="<%= request.getContextPath() %>/profileimages/<%= profilePhoto %>" alt="Profile Picture" />
                                <!-- Pencil icon -->    
                                <label for="profileImage" class="edit_icon">
                                    <i class="fa-regular fa-pen-to-square"></i>
                                    <!-- Hidden file input -->
                                    <input type="file" id="profileImage" name="profilefile" style="display: none;" accept="image/*" />
                                </label>
                            </div>
                            <h2><%= fname %></h2>
                        </div>

                        <div class="form-section">
                            <div class="form-group">
                                <label for="name">Full name</label>
                                <input type="text" id="name" name="full_name" value="<%= fname %>" required>
                            </div>

                            <div class="form-group">
                                <label for="userId">User Id</label>
                                <input type="text" id="userId" name="userid" value="<%= id %>" readonly>
                            </div>

                            <div class="form-group">
                                <label for="email">Email</label>
                                <input type="email" id="email" name="email" value="<%= email %>">
                            </div>

                            <div class="form-group">
                                <label for="phone">Phone</label>
                                <input type="tel" id="phone" name="phone" placeholder="(91) 456-7890" value="<%= mobile %>" required>
                            </div>

                            <div class="form-group" style="display:none;">
                                <label for="password">Password</label>
                                <input type="password" id="password" name="password" minlength="6" value="<%= session.getAttribute("pass") %>" readonly>
                            </div>
                            
                            <div class="form-group full-width">
                                <label for="bio">Bio</label>
                                <textarea id="bio" rows="3" name="bio"><%= bio %></textarea>
                            </div>

                            <div class="buttons">
                                <button class="discard-btn" type="reset" onclick="resetForm()">Discard Changes</button>
                                <button class="save-btn" type="submit">Save Changes</button>  
                            </div>
                        </div>
                    </form>
                    <!-- COMBINED FORM ENDS HERE -->
                </div>
            </main>
        </div>
    </div>
    
    <script>
        // Form validation
        function validateForm() {
            const name = document.getElementById('name').value.trim();
            const phone = document.getElementById('phone').value.trim();
            
            if (!name) {
                alert('Please enter your full name.');
                return false;
            }
            
            if (!phone) {
                alert('Please enter your phone number.');
                return false;
            }
            
            return true;
        }

        // Close modal function
        function closeProfileModal() {
            const container = document.getElementById("cl");
            if (container) {
                container.style.display = "none";
                window.location.href = "user_home.jsp";
            }
        }
        
        // Reset form including image preview
        function resetForm() {
            const profileImageDisplay = document.getElementById('profileImageDisplay');
            profileImageDisplay.src = "<%= request.getContextPath() %>/profileimages/<%= profilePhoto %>";
        }

        // Image preview handling
        document.addEventListener('DOMContentLoaded', function() {
            const profileImageInput = document.getElementById('profileImage');
            const profileImageDisplay = document.getElementById('profileImageDisplay');
            
            if (profileImageInput) {
                profileImageInput.addEventListener('change', function(event) {
                    const file = event.target.files[0];
                    if (file) {
                        const reader = new FileReader();
                        reader.onload = function(e) {
                            profileImageDisplay.src = e.target.result;
                        };
                        reader.readAsDataURL(file);
                    }
                });
            }
        });
    </script>

    <script src="<%=request.getContextPath()%>/Js/specialist.js"></script>
    <script src="<%=request.getContextPath()%>/Js/user.js"></script>
</body>
</html>