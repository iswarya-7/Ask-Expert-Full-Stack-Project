<%-- 
    Document   : addquestion
    Created on : 26 Apr, 2025, 11:37:00 AM
    Author     : rohini
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Question</title>
        <link rel="stylesheet" href="style.css">
        <link rel="stylesheet" href="user.css">

        <!-- google fonts -->
        <link
            href="https://fonts.googleapis.com/css2?family=Poppins:ital,wght@0,100;0,200;0,300;0,400;0,500;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,500;1,600;1,700;1,800;1,900&display=swap"
            rel="stylesheet">

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
                </main>

            </div>
        </div>







        <script>
            /* 
             * To change this license header, choose License Headers in Project Properties.
             * To change this template file, choose Tools | Templates
             * and open the template in the editor.
             */

//This file contains user drop down code ,user profile shown



// Add this at the beginning of your script
            document.addEventListener("DOMContentLoaded", function () {
                // Make sure modal is hidden on page load
                document.getElementById("profileModal").style.display = "none";



// user drop down
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

                    // To prevent scrolling of the main page while the modal is open
//    document.body.style.overflow = "hidden";
                }

                function closeProfileModal() {
                    document.getElementById("profileModal").style.display = "none";
                    document.querySelector('.container').style.display = "none";

                }

// Close modal when clicking outside
                window.onclick = function (event) {
                    let modal = document.getElementById("profileModal");
                    if (event.target === modal) {
                        modal.style.display = "none";
                    }
//    document.body.style.overflow = "auto";

                };



// add question


// select qn and plus icon
                const addQuestionButton = document.querySelector('.plus');
                const questionForm = document.querySelectorall('.add-qn');
                const livePreview = document.querySelector(".live_preview");

// toggle form for open and close
           if (addQuestionButton && questionForm) {
        addQuestionButton.addEventListener("click", function () {
            console.log("Add question is clicked....");
            questionForm.classList.toggle("hidden");
            localStorage.setItem("formVisible", !questionForm.classList.contains("hidden"));
        });
    } else {
        console.error("Add question button or question form not found.");
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
                        alert(" Please select category, specialist & enter your question! ");
                    } else {
                        // to clear the input box details 
                        // document.getElementById('preview_userqn').innerText = question_input;
                        alert("✅Your question has been submitted successfully!");

                        // Reset Form
                        question_input = "";
                        document.getElementById("preview_category").innerText = "None";
                        document.getElementById("preview_specialistname").innerText = "None";
                        document.getElementById("preview_userqn").innerText = "---";
                    }
                }
            });



        </script>




    </body>
</html>



