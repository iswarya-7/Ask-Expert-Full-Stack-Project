<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Forgot Password</title>
        <!-- external css link -->
        <link rel="stylesheet" href="/style.css">

        <!-- google fonts -->
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
            rel="stylesheet">

        <style>
            *{
                padding:0px;
                margin: 0px;
                box-sizing: border-box;
            }
            body{
                background-color: #F8F9FA;
            }
            .form {
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                font-family: 'poppins', sans-serif;

            }

            .form_data {
                background:#fff;
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.1);
                padding: 30px 50px;
                border-radius: 8px;
            }

            .form_data h5 {
                font-size: 20px;
                color: #fd7e14;
                font-weight: 600;
                text-align: center;
                padding-bottom: 30px;
            }

            .form_data .input input {
                padding: 15px 0px 15px 10px;
                width: 300px;
                margin-bottom: 10px;
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
                margin-bottom: 20px;
                width:300px;
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

    <body>
        <form method="post" action="PassUserResetLinkServlet" class="form" onsubmit="return forgot(event)">
            <div class="form_data">
                <h5>Forgot Password</h5>

                <div class="input">
                    <!--<label>Email</label>-->
                    <input type="email" name="email" id="mail" placeholder="Enter you email address  ">
                </div>


                <!-- login button -->
                <div class="login_btn">
                    <button type="submit" style="cursor: pointer;" name="forgot_password">Reset Password</button>
                </div>

            </div>
        </form>

        <!--
                <div class="register">
                    <form method="post" enctype="multipart/form-data" class="form" onsubmit="return forgot(event)">
                        <div class="form_data">
                            <h4>Forgot Password</h4>
        
        
                             Email id 
                            <div class="input">
                                <input type="email" name="email" id="email" placeholder="Enter you email address ">
                            </div>
                             submit button 
                            <div class="login_btn">
                                <button type="submit" name="submit" style="width: 320px; cursor: pointer;">Reset Password</button>
                            </div>
                        </div>
                    </form>
                </div>-->

        <script>
            function forgot() {
                event.preventDefault();

                // selecting mail value
                var Email = document.getElementById('email').value.trim();

                // patterns
                var emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

                // email validation
                if (Email === '') {
                    alert("Enter a Email Address");
                    document.getElementById('email').focus();
                    return false;

                } else if (!emailPattern.test(Email)) {
                    alert("Enter a valid Email Address");
                    document.getElementById('email').focus();
                    return false;
                } else {
                    return true;
                }
            }
        </script>
    </body>

</html>