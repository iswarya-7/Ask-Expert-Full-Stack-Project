<%-- 
    Document   : index
    Created on : 16 Apr, 2025, 4:10:49 PM
    Author     : rohini
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Specialist Home Page</title>

        <!-- css file link -->
        <link href="/specialist_interface/specialist.css" rel="stylesheet">
        <link href="/user_interface/user.css" rel="stylesheet">

        <!-- Google font link -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
            rel="stylesheet">
        <!-- FOnt awesome cdn -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
              integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />



        <!-- Internal css file -->
        <style>
            * {
                margin: 0px;
                padding: 0px;
                box-sizing: border-box;
            }
            a{
                text-decoration:none;
                color:black;
            }

            header {
                display: flex;
                justify-content: space-around;
                align-items: center;
                background: linear-gradient(to right, #FF7F00, #FF4500);
                font-family: 'Poppins', sans-serif;
                padding: 6px;
                position: sticky;
                top: 0;
                width: 100%;
            }

            .logo {
                color: #F8F9FA;
                font-size: 23px;
                font-weight: 500;
            }

            .search {
                padding: 5px;
                position: relative;
                margin-left: 130px;
            }

            .search input {
                height: 38px;
                width: 500px;
                border: none;
                border-radius: 70px;
                background: rgba(255, 255, 255, 0.347);
                outline: none;
                padding-left: 30px;
                color: #F8F9FA;
                font-size: 18px;
            }

            .search input::placeholder {
                color: #F8F9FA;
                font-size: 17px;
            }

            .plus {
                background: #fff;
                color: #fd7e14;
                border: none;
                border-radius: 50px;
                margin-left: 50px;
            }

            .plus i {
                font-size: 18px;
                padding: 10px;
                cursor: pointer;
            }

            .bell {
                margin-left: 20px;
                background: rgba(255, 255, 255, 0.347);
                color: #fff;
                border: none;
                border-radius: 3px;
            }

            .bell i {
                font-size: 19px;
                padding: 10px;
                cursor: pointer;
            }

            .user {
                margin-left: 20px;
                background-color: #F8F9FA;
                color: #fd7e14;
                border: none;
                border-radius: 50px;
            }

            .user i {
                font-size: 19px;
                padding: 10px;
                cursor: pointer;
            }

            .block {
                display: flex;
                width: 100%;
                font-family: 'Poppins', sans-serif;
            }

            aside {
                width: 290px;
                height: 100vh;
                position: fixed;
                font-family: 'Poppins', sans-serif;
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
                background: #ff8000bd;
            }

            .side_bar {
                width: 100%;
                padding: 10px;
            }

            .add_qn {
                flex-grow: 1;
                margin-left: 320px;
                z-index: 10;
                position: relative;
                padding: 20px;
                width: 100%;
                display: flex;
                justify-content: space-around;
                margin-top: 30px;
                font-family: 'Poppins', sans-serif;
            }

            .add_qn.active {
                display: flex;
                justify-content: space-around;
                transition: 0.3s;
            }

            .add_qn h2 {
                padding: 15px 10px 5px 10px;
                font-size: 22px;
                font-weight: 600;
            }

            .add {
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
                width: 50%;
                padding: 20px;
                border-radius: 8px;
                margin-right: 60px;
            }

            .live_preview {
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
                width: 40%;
                padding: 20px;
                border-radius: 8px;
            }

            .live_preview h2 {
                padding: 15px 10px 5px 10px;
                font-size: 22px;
                font-weight: 600;
            }

            .live_preview h3 {
                font-size: 17px;
                font-weight: 540;
                padding: 10px 10px 0px 30px;
            }

            .live_preview span {
                font-size: 15px;
                font-weight: 450;
            }

            .add button {
                padding: 15px 0px;
                margin-left: 30px;
                font-size: 14px;
                width: 120px;
                border: none;
                margin-right: 10px;
                border-radius: 8px;
                background: #a8a6a663;
                cursor: pointer;
            }

            .add button:hover,
            .add button.active {
                background: linear-gradient(to right, #FF7F00, #FF4500);
                color: #fff;
                font-weight: 500;
            }

            .write_qn input {
                width: 90%;
                padding: 10px;
                border-radius: 4px;
                border: 1px solid #9b9494;
                outline: none;
                margin-left: 25px;
                font-size: 14px;
            }

            .ques span {
                text-transform: justify;
            }

            .hidden {
                display: none;
            }

            .submit_btn {
                margin: 10px;
                float: right;
                margin-right: 20px;
            }

            .submit_btn button {
                background: linear-gradient(to right, #FF7F00, #FF4500);
                color: #fff;
                width: 80px;
                height: 40px;
                text-align: center;
                font-size: 14px;
                font-weight: 500;
                padding: 0px;
            }

            .side_bar button {
                border-radius: 4px;
                margin-bottom: 3px;
                font-size: 15px;
                width: 100%;
            }

            .side_bar button:hover {
                background: #fff;
            }

            .side_bar .topic {
                text-align: left;
                width: 100%;
                border: none;
                padding:  15px 20px 15px 40px;
                font-size: 17px;
                cursor: pointer;
                background: linear-gradient(to right, #FF7F00, #FF4500);
                color: #212529;
                font-weight: 400;
            }

            .side_bar .topic:hover {
                background: #fff;
                color: #212529;
                font-weight: 600;
            }
            .side_bar li{
                /*margin:10px;*/
                list-style-type: none;
            }


            /*Answer page*/
            .total_block {
                /* display: flex;
                width: 100%; */
                font-family: 'poppins', sans-serif;
            }
            .answer_container {
                display: flex;
                flex-direction: column;
                justify-content: center;
                margin: 0px 50px 20px 340px;
            }

            .box,
            .answer-section {
                border: 1px solid #cccccc48;
                transition: all 0.3s ease;
                opacity: 1;
                transform: translateX(0);
            }

            .question_box {
                /* display: none; */
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
                padding: 20px;
                border-radius: 8px;
                width: 98%;
                margin-top: 30px;
            }

            .user_info {
                display: flex;
            }

            .user_info img {
                height: 50px;
                width: 50px;
                border-radius: 50%;
                cursor: pointer;
            }

            .user_info p {
                padding: 12px;
                padding-left: 20px;
                font-size: 13px;
                position: relative;
            }

            .user_info p strong {
                margin-right: 10px;
                font-size: 16px;
            }

            .user_info p strong a {
                text-decoration: none;
                color: black;
            }

            #date {
                margin-top: px;
            }

            #user_ques {
                margin: 10px;
            }

            #user_ques strong {
                padding-right: 10px;
            }

            /* answer box */
            .answer_input {
                /* display: none; */
                box-shadow:  0px 8px 16px rgba(0, 0, 0, 0.2);
                padding: 20px 20px 10px 20px;
                border-radius: 8px;
                width: 98%;
                margin-top: 20px;
            }

            textarea {
                border: 1px solid #5555554d;
                padding: 10px;
                width: 100%;
                border-radius: 8px;
                font-size: 15px;
            }

            textarea::placeholder {
                font-size: 14px;

            }


            textarea:focus {
                outline: none;
                border-color:#fd7e14;
                color: #212529;
                box-shadow:  0 0 5px rgba(253, 126, 20, 0.5);
                border-radius: 8px;
            }

            /* .answer_input button {
                float: right;
                background:  linear-gradient(to right, #FF7F00, #FF4500);
                color:  #fff;
                width: 120px;
                height: 40px;
                text-align: center;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                margin: 10px 0px;
            } */

            .ans_btn {
                float: right;
                background:linear-gradient(to right, #FF7F00, #FF4500);
                color: #fff;
                width: 120px;
                height: 40px;
                text-align: center;
                font-size: 14px;
                font-weight: 500;
                cursor: pointer;
                margin: 10px 0px;
                border: none;
                border-radius: 4px;
            }

            .ans_btn:hover {
                background: linear-gradient(to left, #ff8000eb, #FF4500);
                font-weight: 530;
            }

            /* pending question */
            .pendingqn_sec {
                width: 98%;
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
                margin-top: 40px;
                padding: 10px 20px;
                border-radius: 8px;
            }

            .top {
                display: flex;
                flex-direction: row;
            }

            .top p {
                font-weight: 550;
                font-size: 16px;
            }

            #cat_ans {
                background: #fd7e14;
                padding: 5px 10px;
                border: none;
                border-radius: 5px;
                font-weight: 500;
                color: #fff;
                margin-left: 80px;
                font-size: 14px;
                cursor: pointer;
            }

            .user_qn {
                margin-top: 14px;
                font-size: 17px;
                font-weight: 600;
            }

            .bottom {
                display: flex;
                justify-content: space-between;
                margin-top: 10px;
            }

            .bottom p {
                color: #212529cd;
            }

            .bottom button {
                position: relative;
                top: -3px;
            }

            .hidden {
                display: none;
                opacity: 0;
                transform: translateX(20px);
                /* or -20px for reverse */
                pointer-events: none;
                height: 0;
                overflow: hidden;
            }




            /*profile dropdown*/
            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown_btn {
                background: #fd7e14;
                color: white;
                padding: 5px 14px;
                border: none;
                cursor: pointer;
                font-weight: bold;
                border-radius: 8px;
                transition: 0.3s;
                margin-left: -20px;
            }

            .dropdown_content {
                position: absolute;
                top: 45px;
                left: -30px;
                background-color: white;
                min-width: 180px;
                box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.2);
                border-radius: 8px;
                overflow: hidden;
                z-index: 1;
                opacity: 0;
                transition: max-height 0.6s ease-in-out, opacity 0.5s ease-in-out;
            }

            .dropdown_content.show {
                opacity: 1;
                visibility: visible;
            }

            .dropdown_content a {
                display: flex;
                align-items: center;
                gap: 10px;
                padding: 8px 16px;
                font-size: 16px;
                text-decoration: none;
                color: black;
                transition: 0.3s;
            }

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









            /* Modal Background */
            .modal {
                font-family: 'poppins', sans-serif;
                display: none;
                position: fixed;
                z-index: 1000;
                left: 0;
                top: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
            }

            /* Modal Content */
            .modal-content {
                background-color: white;
                padding: 20px;
                border-radius: 10px;
                text-align: center;
                max-width: 400px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
                position: relative;
            }

            /* Close Button */
            .close {
                position: absolute;
                right: 20px;
                top: 10px;
                font-size: 24px;
                cursor: pointer;
            }

            /* Profile Styling */
            .profile-container {
                text-align: center;
            }

            .profile-container h2 {
                margin-bottom: 8px;
            }

            .profile-pic {
                width: 130px;
                height: 130px;
                border-radius: 50%;
            }

            .stats span {
                margin-top: 10px;
            }

            .edit-btn {
                background: linear-gradient(to right, #FF7F00, #FF4500);
                color: white;
                padding: 10px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                margin-top: 10px;
                font-size: 15px;
            }




        </style>


    </head>

    <body>
        <div class="container">
            <header>
                <div class="logo">
                    <h3>Ask Expert</h3>
                </div>
                <div class="search">
                    <input type="text" name="search" id="seach" placeholder="search question...">
                </div>
                <div>
                    <button type="button" class="plus" onclick="addquestion()"><i class="fa-solid fa-plus"></i></button>
                    <button type="button" class="bell"> <i class="fa-regular fa-bell"></i></button>
                    <div class="dropdown">
                        <button type="button" class="user" id="user_icon"><i class="fa-regular fa-user"></i>
                            <div class="dropdown_content" id="user_drop">
                                <a href="" onclick="event.preventDefault(); openProfileModal()"><i
                                        class="fa-solid fa-user"></i> View
                                    Profile</a>
                                <!-- <a href=""><i class="fa-solid fa-gear"></i>Edit Profile</a> -->
                                <a href="/index.html"><i class="fa-solid fa-right-from-bracket"></i> Logout</a>
                            </div>
                        </button>
                    </div>

                </div>
            </header>


            <!-- side bar -->


            <!-- Profile Modal -->
            <div id="profileModal" class="modal">
                <div class="modal-content">
                    <span class="close" onclick="closeProfileModal()">&times;</span>
                    <div class="profile-container">
                        <img src="/assets/ad_profile.jpg" class="profile-pic" alt="Profile Picture">
                        <h2>John</h2>
                        <p style="margin-bottom:7px;">john@gmail.com</p>
                        <p style="margin-bottom:7px;">Engineering | Web Developer</p>
                        <div class="stats">
                            <span>❌ 10 Questions</span>
                            <span>✅ 5 Answers</span>
                            <span>⭐ 4.5 Rating</span>
                        </div>
                        <button class="edit-btn" onclick="window.location.href = 'editProfile.jsp'">Edit Profile</button>
                    </div> 
                </div>
            </div>
            <div class="total_block">
                <aside>
                    <div class="side_bar">
                        <ul>
                            <li id="pending_qn" onclick="toggleQuestionBox()" class="topic"><a href="#">Pending Questions</a></li>
                            <li class="topic"><a href="#" >Answered Questions</a></li>
                            <!-- <li><a href="#">Profile Settings</a></li> -->
                            <li class="topic"><a href="/index.html" >Logout</a></li>

                        </ul>
                    </div>
                </aside>

                <!-- pending qn -->
                <div class="answer_container">
                    <div class="pendingqn_sec  box  hidden">
                        <div class="top">
                            <p><a href="">User Name</a></p>
                            <button type="button" id="cat_ans">Technology and Programming</button>
                        </div>
                        <p class="user_qn">How can I start Java Backend without Spring Boot?</p>
                        <div class="bottom">
                            <p>Posted on : Apr 5,2025 , 12:45pm</p>
                            <button class="ans_btn" onclick="showAnswerBoxes()">Answer</button>
                        </div>
                    </div>
                </div>


                <!-- answer post section -->
                <div class="answer_container">
                    <div class="question_box  answer-section  hidden">
                        <div class="user_info">
                            <span class="close" onclick="closeProfileModal1()">&times;</span>
                            <img src="/assets/sp.jpg" alt="Rahul">
                            <p><strong><a href="">Rahul</a></strong> <span id="date">April 04,2025</span></p>
                        </div>
                        <p id="user_ques"><strong>Question :</strong>How to Integrate a payment Gateway in Java ?</p>
                    </div>
                    <div class="answer_input answer-section hidden">
                        <textarea name="answerText" id="answerText" rows="8"
                                  placeholder="Write Your Answer....."></textarea>
                        <button type="button" class="ans_btn">Submit Answer</button>
                    </div>
                </div>
            </div>
            <div class="block">
                <!-- add question buttton block -->
                <div class="add_qn" id="question">
                    <div class="add">
                        <div class="categories">
                            <h2>Select Category</h2>
                            <button type="button" onclick="selectcategory('Web Devleopment')">Web Dev</button>
                            <button type="button" onclick="selectcategory('AI & ML')">AI & ML</button>
                        </div>
                        <div class="select_specialist">
                            <h2>Select Specialist</h2>
                            <button type="button" onclick="selectspecialist('John Doe')">John Doe</button>
                            <button type="button" onclick="selectspecialist('Alice')">Alice</button>
                        </div>
                        <div class="write_qn">
                            <h2>Ask Your Question</h2>
                            <input type="text" id="qn" placeholder="Write your Question....." oninput="user_question()">
                        </div>
                        <div class="submit_btn">
                            <button type="button" onclick="qnsubmit()">Submit</button>
                        </div>
                    </div>
                    <div class="live_preview">
                        <h2>Live Preview</h2>
                        <h3>Category : <span id="preview_category">None</span>
                        </h3>
                        <h3>Specialist : <span id="preview_specialistname">None</span>
                        </h3>
                        <h3 class="ques">Your Question : <span id="preview_userqn">None</span>
                        </h3>
                    </div>
                </div>
            </div>
        </div>

        <script>
// display answer page specialist click answer btn
            var ansBtn = document.querySelector(".ans_btn");
            var ansBox = document.querySelector(".answer_container");

            ansBtn.addEventListener("click", function () {
                pendingQn.classList.toggle("hidden");
                ansBox.classList.toggle("show");
            });


            function toggleQuestionBox() {
                const questionBox = document.querySelector('.pendingqn_sec');
                const answerBox1 = document.querySelector('.question_box');
                const answerBox2 = document.querySelector('.answer_input');

                questionBox.classList.toggle('hidden');
                answerBox1.classList.add('hidden');
                answerBox2.classList.add('hidden');
            }
// open question
            function showAnswerBoxes() {
                const questionBox = document.querySelector('.pendingqn_sec');
                const answerBox1 = document.querySelector('.question_box');
                const answerBox2 = document.querySelector('.answer_input');


                questionBox.classList.add('hidden');
                answerBox1.classList.remove('hidden');
                answerBox2.classList.remove('hidden');

            }
// close answer qn section
            function closeProfileModal1() {
                const answerBox1 = document.querySelector('.question_box');
                const answerBox2 = document.querySelector('.answer_input');
                answerBox1.classList.add('hidden');
                answerBox2.classList.add('hidden');
            }



// user drop down -profile view
            const User = document.getElementById('user_icon');
            const Drop = document.getElementById('user_drop');

            User.addEventListener("click", function (event) {
                event.stopPropagation(); // Prevents immediate closing
                Drop.classList.toggle("show");
            });

// Close dropdown when clicking outside
            window.addEventListener("click", function (event) {
                if (!User.contains(event.target) && !Drop.contains(event.target)) {
                    Drop.classList.remove("show");
                }
            });


            // profile page
            function openProfileModal() {
                var modal = document.getElementById("profileModal");
                modal.style.display = "flex";
                // Set alignment properties when showing
                modal.style.alignItems = "center";
                modal.style.justifyContent = "center";
            }

            function closeProfileModal() {
                document.getElementById("profileModal").style.display = "none";
            }

// Close modal when clicking outside
            window.onclick = function (event) {
                let modal = document.getElementById("profileModal");
                if (event.target === modal) {
                    modal.style.display = "none";
                }
            };



            // add question -working

// select qn and plus icon
            const addQuestionButton = document.querySelector('.plus');
            const questionForm = document.querySelector('.add_qn');
            const livePreview = document.querySelector(".live_preview")


// toggle form for open and close
            function addquestion() {
                console.log("Add question is clicked....");
                questionForm.classList.toggle("hidden");

                // Save visibility state in localStorage
                localStorage.setItem("formVisible", !questionForm.classList.contains("hidden"));
            }

// to view the data in preview
            function selectcategory(category) {
                document.getElementById('preview_category').innerHTML = category;
            }

            function selectspecialist(specialistn) {
                document.getElementById('preview_specialistname').innerHTML = specialistn;
            }

            function user_question() {
                document.getElementById('preview_userqn').innerHTML = document.getElementById('qn').value;
            }


// Check and restore form visibility after refresh
            function checkFormVisiblity() {
                if (localStorage.getItem("formVisible") === "true") {
                    questionForm.classList.remove("hidden");
                } else {
                    questionForm.classList.add("hidden");
                }
            }

// function to clear only entered when page reload
            function clearDataOnfresh() {
                document.getElementById('preview_category').innerText = " ";
                document.getElementById('preview_specialistname').innerText = " ";
                document.getElementById('preview_userqn').innerText = " ";
            }


// Run functions on page Load
            document.addEventListener("DOMContentLoaded", function () {
                // your code here
                checkFormVisiblity();
                clearDataOnfresh();

            });

            function qnsubmit() {
                //   select all the input values
                var selected_Category = document.getElementById('preview_category').innerText;
                var selected_Specilaist = document.getElementById('preview_specialistname').innerText;
                var selected_userQn = document.getElementById('preview_userqn').innerText;
                var question_input = document.getElementById('qn').value;
                console.log(question_input);
                if (selected_Category === "" || selected_Specilaist === "" || selected_userQn === "") {
                    alert(" Please select category, specialist & enter your question! ")
                } else {
                    // to clear the input box details 
                    // document.getElementById('preview_userqn').innerText = question_input;
                    alert("✅Your question has been submitted successfully!");

                    // Reset Form
//                    question_input = "";
                    document.getElementById('qn').value = "";
                    document.getElementById("preview_category").innerText = "None";
                    document.getElementById("preview_specialistname").innerText = "None";
                    document.getElementById("preview_userqn").innerText = "---";
                }
            }

// open edit profile



        </script>
    </body>



</html>