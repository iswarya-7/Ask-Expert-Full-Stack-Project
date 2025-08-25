<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*" %>
<%
    String token = request.getParameter("token");
    if (token == null || token.trim().isEmpty()) {
        out.println("Invalid token.");
        return;
    }

    boolean isValid = false;
    int userId = -1;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

        PreparedStatement ps = con.prepareStatement("SELECT id, token_expiry FROM user_registerdetails WHERE reset_token=?");
        ps.setString(1, token);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            Timestamp expiry = rs.getTimestamp("token_expiry");
            if (expiry != null && expiry.after(new java.util.Date())) {
                isValid = true;
                userId = rs.getInt("id");
                session.setAttribute("resetUserId", userId);
            }
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    if (!isValid) {
        out.println("Link expired or invalid.");
        return;
    }
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Reset Password</title>
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
            <jsp:include page="user_nav.jsp" />

            <div class="main-wrapper">
                <!-- Include Sidebar -->
                <jsp:include page="user_sidebar.jsp" />

                <!-- Main Content -->
                <main class="main-content" id="main-content">
                    <!-- Modal Background -->
                    <div class="modal-content" id="passwordModal">
                        <form method="post"  action="UpdatePasswordServlet">
                            <div class="form_data">
                                <!-- Close Icon -->
                                <span class="close-btn" onclick="closeModal()">×</span>

                                <h3 style="color:#fd7e14; margin-bottom: 30px;">New Password</h3>
                                <input type="hidden" name="email"  readonly >

                                <div class="input">
                                    <input type="password" name="newpass" id="pass" placeholder="Enter New Password" required>
                                </div>
                                <div class="input">
                                    <input type="password" name="confirmpass" id="cpass" placeholder="Confirm Password" required>
                                </div>
                                <div class="login_btn">
                                    <button type="submit" name="reset_pass" value="true">Reset Password</button>

                                </div>
                               
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
           

        </script>
    </body>
</html>