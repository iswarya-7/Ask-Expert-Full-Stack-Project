<%-- 
    Document   : specialist_register
    Created on : 17 Apr, 2025, 9:29:17 AM
    Author     : rohini
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Specialist Registration Form</title>
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

            #category_area,#gender {
                padding: 10px 0px 10px 10px;
                width: 345px;
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
                padding:12px;
            }

            .register form .input input::placeholder {
                font-size: 14px;
            }

            .register form .input label {
                font-family: 'poppins', sans-serif;
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
                width: 330px;
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
                padding: 15px 0px 15px 10px;
                width: 250px;
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
                width: 265px;
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
    <body style="background:#F8F9FA;">

        <!-- form -->
        <div class="register">
            <form method="post" action="<%=request.getContextPath()%>/SpecialistRegister_Details" onsubmit="return registers()"  enctype="multipart/form-data">
                <div class="form_data">
                    <h4>Create a Specialist account</h4>
                    <!-- personal information -->
                    <!-- full name -->
                    <div class="input">
                        <label>Full Name </label>
                        <input type="text" name="full_name" placeholder="Full Name" id="fname">
                    </div>
                    <!-- gender -->
                    <div class="input">
                        <label>Gender</label>

                        <select name="gender" id="gender">
                            <option selected disabled>Select your Gender </option>
                            <option value="male">Male</option>
                            <option value="female">Female</option>
                        </select>
                    </div>
                    <!-- date of birth -->
                    <div class="input">
                        <label>Date of Birth </label>
                        <input type="date" name="dob" id="dob" style="color: #555555d8;" >
                    </div>
                    <!-- Email id -->

                    <div class="input">
                        <label >Email </label>
                        <input type="email" name="email" placeholder="Email" id="email">
                    </div>
                    <!-- Phone no -->
                    <div class="input">
                        <label >Mobile no</label>
                        <input type="number" name="phone_no" placeholder="Phone" id="phone">
                    </div>
                    <!-- city -->
                    <div class="input">
                        <label >City name</label>
                        <input type="text" name="city" placeholder="Enter your city" id="city">
                    </div>
                    <!-- profile photo -->
                    <div class="input">
                        <label >Upload your Photo</label>
                        <input type="file" name="profile_photo" id="photo">
                    </div>




                    <!-- catory selection -->
                    <div class="input">
                        <label >Select your Extpertise Category </label>
                        <!-- <input type="text" name="full_name" placeholder="Full Name"> -->
                        <select name="category" id="category_area" placeholder="Select your category"
                                style="color: #555555d8;">
                            <option selected disabled>Select your category</option>
                            <option value="Technology">Technology</option>
                            <option value="Medicine">Medicine</option>
                            <option value="Sports">Sports</option>
                            <option value="Education">Education</option>


                            <!--                            <option value="Business">Business</option>
                                                        <option value="laws">Laws </option>
                                                        <option value="finance">Finance</option>
                                                        <option value="arts">Arts</option>
                                                        <option value="science">Science</option>
                                                        <option value="engineering">Engineering</option>-->
                        </select>


                    </div>
                    <div class="input">
                        <!-- insert sub category selection -->
                        <label >Give your Expertised Domain </label>
                        <input type="text" name="sub-category"
                               placeholder="Enter the sub categories Eg: Web development,Devops" id="sub_category">
                    </div>
                    <!-- no of experience in this field -->
                    <div class="input">
                        <label >Experience</label>
                        <input type="text" name="experience" placeholder="Years of Experience in the field" id="experience">
                    </div>
                    <!-- current workplace -->
                    <div class="input">
                        <label >Current Workplace</label>
                        <input type="text" name="workplace" placeholder="Current Workplace / Organization"
                               id="working_place">
                    </div>
                    <!-- about yourself -->
                    <div class="input">
                        <label >About Yourself </label>
                        <!-- <input type="text" placeholder="Short Bio" name="bio" class="bio"> -->
                        <textarea name="bio" rows="3" placeholder="Short Bio....." id="about_specialist"></textarea>
                    </div>
                    <!-- Professional Website/Portfolio Link -->
                    <div class="input">                  
                        <label class="portfolio" >Portfolio</label>
                        <input type="url" name="personal_website" placeholder="Professional Website/Portfolio Link"
                               id="portfolio">
                    </div>
                    <!-- linkedIn profile -->
                    <div class="input">
                        <label class="portfolio" >Linkedin Profile</label>
                        <input type="url" name="linkedin" placeholder="LinkedIn Profile or other professional social media"   id="linkedin">
                    </div>


                    <!-- terms and conditions -->
                    <div class="terms">
                        <input type="checkbox" id="terms"><span>I accept the Terms and Conditions of your website</span>
                    </div>

                    <!-- submit button -->
                    <div class="login_btn">
                        <button type="submit" name="submit" style=" cursor: pointer; width:340px; font-size: 15px;">Sign
                            up</button>

                        <!--This way, no matter where the current JSP file is located, it will always redirect correctly ---<=request.getContextPath()>/login.jsp"    .-->
                        <p style="font-size: 14px;"> Have an account ? <a href="<%=request.getContextPath()%>/specialist_interface/specialist_login.jsp">Log in</a></p>
                    </div>
                </div>
            </form>
        </div>




        <script>
            // form validation
            function registers() {



                // selecting all the input elements
                var Fname = document.getElementById('fname').value.trim();
                var Gender = document.getElementById('gender').value;
                var Dob = document.getElementById('dob').value;
                var Email = document.getElementById('email').value.trim();
                var Phone = document.getElementById('phone').value.trim();
                var City = document.getElementById('city').value.trim();
                var Category = document.getElementById('category_area').value;
                var Subcategory = document.getElementById('sub_category').value.trim();
                var Experience = document.getElementById('experience').value.trim();
                var Current_working = document.getElementById('working_place').value.trim();
                var Bio = document.getElementById('about_specialist').value.trim();
                var Portfolio = document.getElementById('portfolio').value.trim();
                var LinkedIn = document.getElementById('linkedin').value.trim();
                var Terms = document.getElementById('terms').checked;

                // patterns
                var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                var phonePattern = /^(\+\d{1,3})?[6-9]\d{9}$/;

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
                }

//dob validation
                if (!Dob) {
                    alert("Please select your date of birth.");
                    document.getElementById('dob').focus();
                    return false;
                }

                const dob = new Date(Dob);
                const today = new Date();

                let age = today.getFullYear() - dob.getFullYear();
                const monthDiff = today.getMonth() - dob.getMonth();

                if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < dob.getDate())) {
                    age--;
                }

                if (age < 23) {
                    alert("Specialists must be at least 23 years old.");
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
                } else if (City === '') {
                    alert("Enter your city name");
                    document.getElementById('city').focus();
                    return false;

                } else if (Category === '' || document.getElementById('category_area').selectedIndex === 0) {
                    alert("select your Expertise Category");
                    document.getElementById('category_area').focus();
                    return false;
                } else if (Subcategory === '') {
                    alert("Enter the subcategory of your area (e.g., Web Development, DevOps)");
                    document.getElementById('sub_category').focus();
                    return false;
                } else if (Experience === '') {
                    alert("Enter your experience in this field");
                    document.getElementById('experience').focus();
                    return false;
                } else if (Current_working === '') {
                    alert("Enter your working organization");
                    document.getElementById('working_place').focus();
                    return false;
                }
                // about specilaist
                else if (Bio === '') {
                    alert("Give a short intro about yourself");
                    document.getElementById('about_specialist').focus();
                    return false;

                }  else if (!Terms) {
                    alert("You must accept the Terms and Conditions");
                    return false;
                } else {
//             
                    return true;
                }


            }
        </script>
    </body>
</html>
