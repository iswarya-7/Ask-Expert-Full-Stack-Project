<%-- 
    Document   : changePassword
    Created on : 2 May, 2025, 3:52:55 PM
    Author     : rohini
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%@ include file="db_connection.jsp" %>--%>
<%    String message = "";
    String email = (String) session.getAttribute("email");

    if (request.getParameter("change_password") != null) {
        String pass = request.getParameter("pass");
        String cpass = request.getParameter("cpass");

        out.print("Pass :" + pass);
        if (pass == null || pass.trim().isEmpty()) {
            message = "Password field is empty!";
        } else if (!pass.equals(cpass)) {
            message = "Passwords do not match!";
        } else {
            try {
                Connection con = (Connection) application.getAttribute("conn");
                PreparedStatement ps = con.prepareStatement("UPDATE specialist_regdetails SET password = ? WHERE email = ?");
                ps.setString(1, pass);
                ps.setString(2, email);
                int updated = ps.executeUpdate();

                if (updated > 0) {
                    out.print("<script>confirm('Password changed successfully!')</script>");
                    message = "Password changed successfully!";
                    response.sendRedirect("specialist_home.jsp?message=" + message);
                    return;
                } else {
                    message = "Password change failed. Please try again.";
                }
            } catch (Exception e) {
                e.printStackTrace();
                message = "Database error: " + e.getMessage();
            }
        }
    }
%>


<!DOCTYPE html>
<html>
    <head>
        <title>Change Password</title>
        <link href="https://fonts.googleapis.com/css2?family=Poppins&display=swap" rel="stylesheet">
        <style>
            .modal-content {
                background-color: #fefefe;
                margin: 8% auto;
                padding: 40px 20px;
                border: 1px solid #ccc;
                width: 400px;
                border-radius: 10px;
                font-family: 'Poppins', sans-serif;
            }

            .form_data {
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            .form_data .input {
                width: 90%;
                margin-bottom: 15px;
            }

            .form_data .input input {
                width: 100%;
                padding: 12px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 6px;
                box-sizing: border-box;
            }
            .form_data .input input:focus{
                outline: none;
                border-color: #fd7e14;
                color: #212529;
                box-shadow: 0 0 5px rgba(253, 126, 20, 0.4);
            }

            .login_btn {
                width: 100%;
                text-align: center;
            }

            .login_btn button {
                width: 90%;
                padding: 12px;
                font-size: 16px;
                background-color: #fd7e14;
                color: #fff;
                border: none;
                border-radius: 6px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            .login_btn button:hover {
                background-color: #e36408;
            }
            .close{
                position: relative;
                left: 170px;
                top: -10px;
                font-size: 22px;
                margin-top: -20px;
                cursor: pointer;
                height: 20px;
                width: 20px;
                border-radius: 50%;
                background: #f5f5f5;
            }
            .close:hover{
                background: #f5f5f5;
            }
            /* CSS Styling */
            .close-btn {
                margin-left: 310px;
                margin-top: -15px;
                margin-bottom: 10px;
                display: inline-block;
                font-size: 22px;
                font-weight: 500;
                color: #fff;
                background-color: #f5f5f5; /* Your theme color */
                color: black;
                width: 30px;
                height:30px;
                text-align: center;
                align-items: center;

                border-radius: 50%;
                cursor: pointer;
                transition: background-color 0.3s ease, transform 0.2s;
            }

            .close-btn:hover {
                background-color: #b5b4b4;
                color: black;
                /*transform: rotate(90deg);*/
            }

            .error-message { color: red; text-align: center; margin-top: 10px; }
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
                    <!-- Modal Background -->
                    <div class="modal-content" id="passwordModal">
                        <form method="post">
                            <div class="form_data">
                                <!-- Close Icon -->
                                <span class="close-btn" onclick="closeModal()">×</span>

                                <h3 style="color:#fd7e14; margin-bottom: 30px;">Change Your Password</h3>
                                <input type="hidden" name="email" value="<%=email%>" readonly >

                                <div class="input">
                                    <input type="password" name="pass" id="pass" placeholder="Enter New Password" required>
                                </div>
                                <div class="input">
                                    <input type="password" name="cpass" id="cpass" placeholder="Confirm Password" required>
                                </div>
                                <div class="login_btn">
                                    <button type="submit" name="change_password" value="true">Update Password</button>

                                </div>
                                <!--< if (!message.isEmpty()) {-->
                                <!--<div class="error-message"><= message%></div>-->
                                <!--%-->
                            </div>
                        </form>
                    </div>

                </main>
            </div>
        </div>
        <script>


            function change() {
                // prevents submission
                //                event.preventDefault();

                // select all the values
                //                var currentpass = document.getElementById('currentpass').value.trim();
                var Password = document.getElementById('pass').value.trim();
                var Cpasword = document.getElementById('cpass').value.trim();

                // patterns
                var passwordPattern = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{6,}$/;

                if (Password === '') {
                    alert("Enter a New  Password");
                    document.getElementById('pass').focus();
                    return false;
                } else if (!passwordPattern.test(Password)) {
                    alert("Password must be at least 6 characters long, include one uppercase and one lower case letter and one number.");
                    document.getElementById('pass').focus();
                    return false;
                } else if (Cpasword === '') {
                    alert("Enter a Confirm Password");
                    document.getElementById('pass').focus();
                    return false;
                } else if (Password !== Cpasword) {
                    alert("Password do not match");
                    document.getElementById('cpass').focus();
                    return false;
                } else {
                    //  alert("Password Changed successfully !!");
                    // after success submit it will erase all the data
                    document.getElementById('pass').value = '';
                    document.getElementById('cpass').value = '';
                    return true;

                }
            }




            //            password open modal
            function openModal() {
                document.getElementById("passwordModal").style.display = "block";
            }

            function closeModal() {
                document.getElementById("passwordModal").style.display = "none";
                window.location.href = "specialist_home.jsp";
            }

            // Optional: Close on outside click
            window.onclick = function (event) {
                const modal = document.getElementById("passwordModal");
                if (event.target == modal) {
                    modal.style.display = "none";
                }
            }



        </script>
    </body>
</html>
