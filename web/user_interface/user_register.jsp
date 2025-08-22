<%-- 
    Document   : register
    Created on : 9 Apr, 2025, 3:10:31 PM
    Author     : rohini
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Registration form</title>

        <!-- google fonts -->
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
            rel="stylesheet">

        <!-- external css -->
        <!--<link rel="stylesheet" href="/style.css">-->

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

            #category_area,#gender {
                padding: 10px 0px 10px 10px;
                width: 320px;
                margin-bottom: 15px;
                border: 1px solid #5555554d;
                border-radius: 4px;
                color: #555555d8;
                cursor: pointer;
            }

            #photo {
                /* width: 100%; */
                color: #555555d8;
            }

            #category_area:focus {
                outline: none;
                border-color:#fd7e14;
                color: #212529;
                box-shadow:0 0 5px rgba(253, 126, 20, 0.5);
                /* Add a glowing effect */
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

            .terms span {
                font-size: 13px;
                color: #212529;
                position: relative;
                top: -3px;
                left: 5px;
            }

            .register form .input input {
                width: 320px;
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
                width: 320px;
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
                padding: 50px;
                border-radius: 8px;
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
                width: 260px;
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
                font-size: 14px;
                padding-left: 135px;
            }

            .login_btn button {
                margin-top: 20px;
                width: 260px;
                padding: 10px 0px;
                border: none;
                border-radius: 4px;
                background: #fd7e14;
                color:#fff;
                font-size: 14px;
                font-weight: bold;
                text-align: center;
            }

            .sign_up {
                margin: 10px;
                text-align: center;
            }

            .sign_up p {
                font-size: 14px;
                line-height: 18px;
            }

            .sign_up p a {
                text-decoration: none;
                cursor: pointer;
                color: #fd7e14;
                font-weight: bold;
            }
        </style>
    </head>

    <body>

        <div class="register">
            <form method="post" onsubmit="return signup()"  action="<%=request.getContextPath()%>/RegisterDetails"   enctype="multipart/form-data">
                <div class="form_data">
                    <h4>Create a User account</h4>
                    <!-- personal information -->
                    <!-- full name -->
                    <div class="input">
                        <label>Full Name </label>
                        <input type="text" name="full_name" id="fname" placeholder="Full Name">
                    </div>
                    <!-- gender -->
                    <div class="input">
                        <label>Gender</label>
                        <select name="gender" id="gender" style="width:340px">
                            <option selected disabled>Select your Gender</option>
                            <option value="male">Male</option>
                            <option value="female">Female</option>
                        </select>
                    </div>
                    <!-- date of birth -->
                    <div class="input">
                        <label>Date of Birth </label>
                        <input type="date" name="dob" id="dob" style="color: #555555d8;">
                    </div>
                    <!-- Email id -->
                    <div class="input">
                        <label>Email</label>
                        <input type="email" name="email" id="email" placeholder="Email ">
                    </div>
                    <!-- Phone no -->
                    <div class="input">
                        <label>Mobile no</label>
                        <input type="number" name="phone_no" id="phone" placeholder="Phone ">
                    </div>
                    <!-- profile photo -->
                    <div class="input">
                        <label>Upload your Photo </label>
                        <input type="file" name="profile_photo" id="photo" placeholder="Upload your image">
                    </div>
                    <!-- Password -->
                    <div class="input">
                        <label>Password </label>
                        <input type="password" name="pass" id="pass" placeholder="Password">
                    </div>
                    <!-- Confirm Password -->
                    <div class="input">
                        <label>Confirm Password</label>
                        <input type="password" name="cpass" id="cpass" placeholder="Confirm Password">
                    </div>
                    <!-- terms and conditions -->
                    <div class="terms">
                        <input type="checkbox" id="term"><span>I accept the Terms and Conditions of your website</span>
                    </div>

                    <!-- submit button -->
                    <div class="login_btn">
                        <button type="submit" name="submit" style="width: 340px; cursor: pointer;">Sign up</button>
                        <p>Have an account ? <a href="<%=request.getContextPath()%>/user_interface/user_login.jsp">Log in</a></p>
                    </div>

                </div>
            </form>
        </div>





        <!-- script code -->
        <script>

            function signup() {
                // selecting all the input elements
                var Fname = document.getElementById('fname').value.trim();
                var Gender = document.getElementById('gender').value;
                var Dob = document.getElementById('dob').value;
                var Email = document.getElementById('email').value.trim();
                var Phone = document.getElementById('phone').value.trim();
                var Photo = document.getElementById('photo').value;
                var Password = document.getElementById('pass').value.trim();
                var Cpasword = document.getElementById('cpass').value.trim();
                var Terms = document.getElementById('term').checked;

//                event.preventDefault();
//                 patterns
                var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                var phonePattern = /^(\+\d{1,3})?[6-9]\d{9}$/;
                var passwordPattern = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d).{6,}$/;

                // validating the user account

                // full name validation
                if (Fname === '') {
                    alert("Enter Your Full Name");
                    document.getElementById('fname').focus();
                    return false;
                }
                // gender validation
                else if (Gender === '' || document.getElementById('gender').selectedIndex === 0) {
                    alert("Select Your Gender");
                    document.getElementById('gender').focus();
                    return false;
                } else if (Dob === '') {
                    alert("Enter your Date of Birth");
                    document.getElementById('dob').focus();
                    return false;
                }

                // email validation
                else if (Email === '') {
                    alert("Enter a Email Address");
                    document.getElementById('email').focus();
                    return false;

                } else if (!emailPattern.test(Email)) {
                    alert("Enter a valid Email Address");
                    document.getElementById('email').focus();
                    return false;
                }

                // phone number validation
                else if (Phone === '') {
                    alert("Enter a Phone number");
                    document.getElementById('phone').focus();
                    return false;

                } else if (!phonePattern.test(Phone)) {
                    alert("Phone number must be a 10 digits");
                    document.getElementById('phone').focus();
                    return false;
                } else if (Photo === '') {
                    alert("Please upload your photo");
                    document.getElementById('photo').focus();
                    return false;
                } else if (Password === '') {
                    alert("Enter a Password");
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
                } else if (!Terms) {
                    alert("You must accept the Terms and Conditions");
                    document.getElementById('term').focus();
                    return false;
                }

//                alert("User Account created successfully !!");
                // All validations passed
                return true;
//                else {
//                    alert("User Account created successfully !!");
////                    window.location.href = "../user_interface/user_login.jsp" //redirect the login page
//                    response.sendRedirect("user_interface/user_login.jsp");
//
//                    return true;
//                }
            }


        </script>
    </body>



</html>
