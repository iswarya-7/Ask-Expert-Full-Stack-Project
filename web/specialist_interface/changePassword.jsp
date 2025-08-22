<%-- 
    Document   : changePassword
    Created on : 2 May, 2025, 3:52:55 PM
    Author     : rohini
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%--<%@ include file="db_connection.jsp" %>--%>
<%    String message = "";
    String currentPass = "";
    String email = (String) session.getAttribute("email");

    if (request.getParameter("change_password") != null) {
        String pass = request.getParameter("pass");
        String cpass = request.getParameter("cpass");

        if (pass == null || pass.trim().isEmpty()) {
            message = "Password field is empty!";
            out.print("<script>alert('Password field is empty!');</script>");

        } else if (!pass.equals(cpass)) {
            message = "Passwords do not match!";
            out.print("<script>alert('Passwords do not match!');</script>");

        } else {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
                // Get the current password from DB
                PreparedStatement checkPs = con.prepareStatement("SELECT password FROM specialist_regdetails WHERE email = ?");
                checkPs.setString(1, email);
                ResultSet rs = checkPs.executeQuery();

                if (rs.next()) {
                    currentPass = rs.getString("password");
                    System.out.println("Password from DB: " + currentPass);
                    System.out.println("Password entered: " + pass);
                    if (pass.equals(currentPass)) {
                        message = "New password must be different from the old password.";
                        out.print("<script>alert('New password must be different from the old password');</script>");
                    } else {
                        // Update password
                        PreparedStatement ps = con.prepareStatement("UPDATE specialist_regdetails SET password = ? WHERE email = ?");
                        ps.setString(1, pass);
                        ps.setString(2, email);

                        int updated = ps.executeUpdate();

                        if (updated > 0) {
                            message = "Password changed successfully!";
                            out.println("<script type='text/javascript'>");
                            out.println("alert('Password Changes Successfully!');");
                            out.println("location='specialist_home.jsp?message=success';");
                            out.println("</script>");
                            return;
                        } else {
                            message = "Password change failed. Please try again.";
                            out.println("<script type='text/javascript'>");
                            out.println("alert('Password change failed. Please try again.');");
                            out.println("location='specialist_home.jsp?message=success';");
                            out.println("</script>");

                        }
                    }
                } else {
                    message = "User not found!";
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

            .error-box {
                /*background-color: #ffe6e6;*/
                /*border: 1px solid #ff4d4d;*/
                color: #cc0000;
                padding: 10px;
                border-radius: 6px;
                margin: 15px 0;
                width: 90%;
                text-align: center;
                font-weight: 500;
                animation: fadeIn 0.3s ease-in-out;
            }

            @keyframes fadeIn {
                from {opacity: 0;}
                to {opacity: 1;}
            }        </style>
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
                        <form method="post" onsubmit ="return change()">

                            <div class="form_data">
                                <!-- Close Icon -->
                                <span class="close-btn" onclick="closeModal()">×</span>

                                <h3 style="color:#fd7e14; margin-bottom: 30px;">Change Your Password</h3>
                                <input type="hidden" name="email" value="<%=email%>" readonly >



                                <div class="input">
                                    <input type="password" name="pass" id="pass" placeholder="Enter New Password" >
                                </div>
                                <div class="input">
                                    <input type="password" name="cpass" id="cpass" placeholder="Confirm Password" >
                                </div>
                                <div class="login_btn">
                                    <button type="submit" name="change_password" onsubmit="return change();"> Update Password </button>

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
                //                event.preventDefau
                lt();

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
                    //                    alert("Password Changed successfully !!");
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
