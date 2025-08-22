<%-- 
    Document   : login
    Created on : 17 Apr, 2025, 4:39:04 PM
    Author     : rohini
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date, java.sql.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <!-- Google font link -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
            rel="stylesheet"> 
        <style>
            .form {
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                font-family: 'poppins', sans-serif
            }

            .form_data {
                background:#fff;
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.1);
                padding: 10px 60px;
                border-radius: 8px;
            }

            .form_data h5 {
                font-size: 20px;
                color: #fd7e14;
                font-weight: 600;
                text-align: center;
            }

            .form_data .input input {
                padding: 15px 0px 15px 10px;
                width: 270px;
                margin-bottom: 15px;
                border: 1px solid #5555554d;
                border-radius: 4px;
                font-size: 14px;
            }

            .form_data .input label {
                font-size: 13px;
                font-weight: 500;
                display: block;
                padding: 4px 0px 4px 3px;
            }

            .form_data .input label::after {
                content: " * ";
                color: red;
                position: relative;
                top: -3px;
            }

            input::placeholder {
                font-size: 14px;
            }

            .input input:focus {
                outline: none;
                border-color: #fd7e14;
                color: #212529;
                box-shadow: 0 0 5px rgba(253, 126, 20, 0.5);
                /* Add a glowing effect */
            }
            .input a {
                text-decoration: none;
                color: #212529;
                cursor: pointer;
            }

            .input a .forgot {
                margin-top: -10px;
                font-size: 14px;
                padding-left: 155px;
            }

            .login_btn button {
                margin-top: 10px;
                width: 280px;
                padding: 12px 0px;
                border: none;
                border-radius: 4px;
                background: #fd7e14;
                color:#fff;
                font-size: 15px;
                font-weight: bold;
                text-align: center;
            }
            .sign_up {
                margin: 10px;
                text-align: center;
                margin-bottom: 30px;
            }

            .sign_up p {
                font-size: 14px;
                line-height: 10px;
            }

            .sign_up p a {
                text-decoration: none;
                cursor: pointer;
                color: #fd7e14;
                font-weight: bold;
            }
        </style>
    </head>
    <body style="background:#F8F9FA;">

        <%@ include file="db_connection.jsp" %>
        <%            if (request.getParameter("user_login") != null) {
                String email = request.getParameter("email");
                String password = request.getParameter("pass");

                Connection con = (Connection) application.getAttribute("conn");
                PreparedStatement ps = con.prepareStatement(
                        "SELECT * FROM user_registerdetails WHERE email=? AND password=?"
                );
                ps.setString(1, email);
                ps.setString(2, password);
                ResultSet rs = ps.executeQuery();

                if (rs.next()) {

                    String locked = rs.getString("locked");
                    String blocked = rs.getString("blocked");

                    if ("yes".equalsIgnoreCase(locked)) {
                        out.println("<script>alert('Your account is Locked. Please contact support.')</script>");
                    } else if ("yes".equalsIgnoreCase(blocked)) {
                        out.println("<script>alert('Your account is blocked. Please contact support.')</script>");
                    } else {
                        session.setAttribute("userId", rs.getInt("id"));
                        session.setAttribute("fullname", rs.getString("full_name"));
                        session.setAttribute("email", rs.getString("email"));
                        session.setAttribute("phone", rs.getString("mobile"));
                        session.setAttribute("gender", rs.getString("gender"));
                        session.setAttribute("dob", rs.getString("dob"));
                        session.setAttribute("bio", rs.getString("bio"));

                        session.setAttribute("profileimage", rs.getString("profile_photo"));

                        //                    session.setAttribute("bio", rs.getString("Bio"));
                        response.sendRedirect("user_home.jsp");

                    }
                } else {

                    out.println("<script>alert('Invalid User name or Password');</script>");

                }
            }
        %>




        <form method="post" class="form" onsubmit="login(event)">
            <div class="form_data">
                <h5>Log in your account</h5>

                <div class="input">
                    <label>Email</label>
                    <input type="email" name="email" id="mail" placeholder="Email ">
                </div>
                <div class="input">
                    <label>Password</label>
                    <input type="password" name="pass" id="pass" placeholder="Your Password">
                    <!-- forgot password -->
                    <a href="<%=request.getContextPath()%>/user_interface/forgotPassword.jsp">
                        <p class="forgot">Forgot Password ?</p>
                    </a>
                </div>

                <!-- login button -->
                <div class="login_btn">
                    <button type="submit" style="cursor: pointer;" name="user_login">Login</button>
                </div>
                <div class="sign_up">
                    <p>Have not account yet?</p>
                    <p>Sign up <a href="<%=request.getContextPath()%>/specialist_interface/specialist_register.jsp">Specialist</a> | <a
                            href="<%=request.getContextPath()%>/user_interface/user_register.jsp">User</a> </p>
                </div>
            </div>
        </form>


        <script>

            // login for admin
            function  login(event) {
                event.preventDefault();

                // selecting ip elements
                var Email = document.getElementById('mail').value.trim();
                var Pass = document.getElementById('pass').value.trim();
                // pattern
                var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                // email validation
                if (Email === '') {
                    alert("Enter a Email Address");
                    document.getElementById('mail').focus();
                    return false;
                } else if (!emailPattern.test(Email)) {
                    alert("Enter a valid Email Address");
                    document.getElementById('mail').focus();
                    return false;
                } else if (Pass === '') {
                    alert("Enter a Password");
                    document.getElementById('pass').focus();
                    return false;
                }
                return true;
                // If all validations pass, the form will submit normally
                document.forms[0].submit(); // Submit the form manually
        </script>
    </body>
</html>
