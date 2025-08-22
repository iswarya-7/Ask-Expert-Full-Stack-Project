<%-- 
    Document   : edit
    Created on : 16 Apr, 2025, 5:57:29 PM
    Author     : rohini
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Edit Profile Page</title>

        <!-- Google font link -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
            rel="stylesheet">



        <style>
            /* registration form */
            .register {
                margin-top: 20px;
                font-family: 'poppins', sans-serif;
            }

            .register form {
                /* height: 100vh; */
                display: flex;
                flex-direction: column;
                justify-content: center;
                align-items: center;
            }


            .register .form_data h4 {
                font-size: 20px;
                padding-bottom: 20px;
                color: #fd7e14;
                font-weight: 600;
                text-align: center;
                margin-top: -30px;
            }
            #category_area:focus {
                outline: none;
                border-color:#fd7e14;
                color: #212529;
                box-shadow:0 0 5px rgba(253, 126, 20, 0.5);
                /* Add a glowing effect */
            }

            #category_area{
                padding: 10px 0px 10px 10px;
                width: 300px;
                margin-bottom: 15px;
                border: 1px solid #5555554d;
                border-radius: 4px;
                color: #555555d8;
                cursor: pointer;
            }

            #gender:focus {
                outline: none;
                border-color: #fd7e14;
                color:#212529;
                box-shadow:0 0 5px rgba(253, 126, 20, 0.5);
                /* Add a glowing effect */
            }


            select option:hover {
                background:#fd7e14;
                color: #fff;
            }

            input[type="checkbox"] {
                accent-color:#fd7e14;
            }
            .register form .input input {
                width: 280px;
                font-size: 15px;
                padding:10px;
            }

            .register form .input input::placeholder {
                font-size: 14px;
            }

            .register form .input label {
                font-size: 13px;
                font-weight: 500;
                display: block;
                padding: 4px 0px 4px 3px;
            }

            .register form .input .portfolio {
                font-size: 14px;
                font-weight: 500;
                display: block;
                padding: 4px 0px 4px 3px;
            }

            .register form .input .portfolio::after {
                content: " ";
            }

            .register form .input label::after {
                content: " * ";
                color: red;
                position: relative;
                top: -3px;
            }

            .input textarea {
                font-family: 'poppins', sans-serif;
                font-size: 14px;
                padding: 10px 0px 10px 10px;
                width: 280px;
                margin-bottom: 15px;
                border: 1px solid #5555554d;
                border-radius: 4px;
            }

            .input textarea::placeholder {
                font-size: 14px;
            }

            .register form .input textarea:focus {
                outline: none;
                border-color:#fd7e14;
                color:#212529;
                box-shadow: 0 0 5px rgba(253, 126, 20, 0.5);
                /* Add a glowing effect */
            }

            .register .login_btn p {
                text-align: center;
                font-size: 14px;
                padding-top: 5px;
            }

            .register .login_btn p a {
                text-decoration: none;
                color: #212529;
                color: #fd7e14;
            }


            select {
                font-size: 14px;
            }


            /* login form */
            form {
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                font-family: 'poppins', sans-serif
            }

            .form_data {
                background:#fff;
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.1);
                padding: 50px;
                border-radius: 10px;
            }

            .form_data h5 {
                font-size: 20px;
                padding-bottom: 30px;
                color: #fd7e14;
                font-weight: 600;
                text-align: center;
            }

            .form_data .input input {
                padding: 12px 0px 12px 10px;
                width: 280px;
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
            .login_btn1   button {
                margin-top: 10px;
                padding: 10px 0px;
                border: none;
                border-radius: 4px;
                background: #fd7e14;
                color: #fff;
                font-size: 14px;
                font-weight: bold;
                text-align: center;
            }


        </style>
    </head>
    <body>

        <%
            String name = (String) session.getAttribute("name");
            String email = (String) session.getAttribute("email");
            String expertise = (String) session.getAttribute("expertise");
            String bio = (String) session.getAttribute("bio");
        %>
        <div class="register">
            <form method="post" action="update.jsp" onsubmit="return registers(event)">
                <div class="form_data">
                    <h4>Edit Your Profile</h4>
                    <!-- personal information -->
                    <!-- full name -->
                    <div class="input">
                        <label>Name </label>
                        <input type="text" name="name" value="<%=name%>" id="fname">
                    </div>
                    <div class="input">
                        <label>Email </label>
                        <input type="email" name="email" value="<%= email %>" id="email" readonly>
                    </div>

                    <div class="input">
                        <label>Select your Extpertise Category </label>
                        <!-- <input type="text" name="full_name" placeholder="Full Name"> -->
                        <select name="category" id="category_area" style="color: #555555d8;" >
                            <option selected disabled>Select your category</option>
                            <option value="technology">Technology</option>
                            <option value="healthcare">Healthcare</option>
                            <option value="business">Business</option>
                            <option value="education">Education</option>
                            <option value="laws">Laws </option>
                            <option value="finance">Finance</option>
                            <option value="arts">Arts</option>
                            <option value="science">Science</option>
                            <option value="engineering">Engineering</option>
                        </select>
                    </div>

                    <div class="input">
                        <!-- insert sub category selection -->
                        <label>Give your Expertised Domain </label>
                        <input type="text" name="sub-category" id="sub_category">
                    </div>

                    <div class="login_btn1">
                        <button type="submit" name="submit"
                                style="width: 300px; cursor: pointer; font-size: 15px;">Update</button>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>
