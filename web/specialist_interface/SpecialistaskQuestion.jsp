<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<%
    Integer spId = (Integer) session.getAttribute("specialistId");
    String fname = "";
    Integer sId = 0;
    if (spId != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM specialist_regdetails WHERE id = ?");
            ps.setInt(1, spId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                fname = rs.getString("full_name");
                sId = rs.getInt("id");

            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>



<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Specialist - Ask Question</title>

        <!-- CSS file link -->
        <link href="style.css" rel="stylesheet">
        <link href="add_question.css" rel="stylesheet">

        <!-- Google font link -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">

        <!-- Font awesome cdn -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
              integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />

        <!--jquery for specilaist selection-->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <style>/* Add Question Form Styles */

            /* Container layout */
            .container {
                display: flex;
                min-height: calc(100vh - 60px);

            }



            /* Main content styles */
            .main-content1 {
                flex: 1;
                padding: 30px;
                background-color: #f5f5f5;
                max-width: 530px;
                margin-left: 400px;
            }

            .page-header {
                margin-bottom: 20px;
            }

            .page-header h2 {
                font-size: 28px;
                color: #333;
                margin-bottom: 10px;
            }

            .page-header p {
                color: #666;
                font-size: 16px;
            }

            /* Form container */
            .question-form-container {
                background-color: white;
                border-radius: 10px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding: 10px 30px 30px;
                margin-top: 20px;
            }

            .question-form {
                max-width: 500px;
                margin: 0 auto;
            }

            /* Form elements */
            .form-group {
                margin-bottom: 25px;
            }

            .form-group label {
                display: block;
                margin-bottom: 8px;
                font-weight: 500;
                color: #333;
            }

            .required {
                color: #ff4500;
            }

            input[type="text"],
            select,
            textarea {
                width: 100%;
                padding: 12px 15px;
                border: 1px solid #ddd;
                border-radius: 6px;
                font-size: 15px;
                font-family: "Poppins", sans-serif;
                transition: border-color 0.3s ease;
            }

            input[type="text"]:focus,
            select:focus,
            textarea:focus {
                outline: none;
                border-color: #ff8c00;
                box-shadow: 0 0 5px rgba(255, 140, 0, 0.3);
            }
            select,option{
                cursor: pointer;
            }
            /* File upload styling */
            .file-upload {
                /*position: absolute;*/
                border: 2px dashed #ddd;
                border-radius: 6px;
                padding: 10px;
                text-align: center;
                transition: all 0.3s ease;
                cursor: pointer;
            }
            .flie-upload input{
                padding-left: 0px;
            }
            #attachment{
                position: relative;
                left:-10px;
            }
            .file-upload:hover {
                border-color: #ff8c00;
            }


            /*            .file-upload-label {
                            display: flex;
                            flex-direction: column;
                            align-items: center;
                            color: #666;
                        }
            
                        .file-upload-label i {
                            font-size: 30px;
                            margin-bottom: 10px;
                            color: #ff8c00;
                        }
            
                        .file-info {
                            margin-top: 10px;
                            font-size: 13px;
                            color: #888;
                        }*/

            /* Button styles */
            .form-actions {
                display: flex;
                justify-content: flex-end;
                gap: 15px;
                margin-top: 30px;
            }

            .btn {
                padding: 12px 25px;
                border: none;
                border-radius: 6px;
                font-size: 16px;
                font-weight: 500;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .btn-primary {
                background-color: #ff8c00;
                color: white;
            }

            .btn-primary:hover {
                background-color: #ff7000;
            }

            .btn-secondary {
                background-color: #e0e0e0;
                color: #333;
            }

            .btn-secondary:hover {
                background-color: #d0d0d0;
            }
            .file-remove {
                font-size: 22px;
                color: #ff4500;
                cursor: pointer;
                user-select: none;
                position: relative;
                left: 400px;
                top: 10px;
            }
            .file-remove:hover {
                color: #ff0000;
            }

            /* Responsive adjustments */
            @media (max-width: 992px) {
                .container {
                    flex-direction: column;
                }

                .sidebar {
                    width: 100%;
                    min-height: auto;
                    padding: 10px 0;
                }

                .sidebar-item {
                    padding: 10px 20px;
                }

                .main-content {
                    padding: 20px;
                }
            }

            @media (max-width: 768px) {
                .form-actions {
                    flex-direction: column;
                }

                .btn {
                    width: 100%;
                }

                .search-container {
                    width: 60%;
                }
            }

            @media (max-width: 576px) {
                .page-header h2 {
                    font-size: 24px;
                }

                .question-form-container {
                    padding: 20px 15px;
                }

                .search-container {
                    display: none;
                }
            }
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

                    <!--                     Content will be loaded here 
                                        <div class="container">-->
                    <!-- Main content -->
                    <div class="main-content1">
                        <div class="question-form-container">

                            <div class="page-header">
                                <span class="file-remove" onclick="closeForm()">&times;</span>
                                <h2>Ask a New Question</h2>
                                <!--<p>Get expert answers to your questions from specialists in various domains</p>-->
                            </div>
                            <form action="${pageContext.request.contextPath}/SpecialistQuestionServlet" method="post" class="question-form"  enctype="multipart/form-data">


                                <!--get the user name and id in hidden input field using session id-->
                                <input type="hidden" id="sname" name="sname" value="<%= fname%>"  required>
                                <input type="hidden" id="sid" name="sid" value="<%= spId%>"  required>




                                <div class="form-group">
                                    <label for="category">Category <span class="required">*</span></label>
                                    <select id="category" name="category" required > 
                                        <option selected disabled>-- Select your category --</option>
                                        <option value="Technology">Technology</option>
                                        <option value="Medicine">Medicine</option>
                                        <option value="Sports">Sports</option>
                                        <option value="Education">Education</option>

                                        <!--                                        <option value="Business">Business</option>
                                                                                <option value="Laws">Laws </option>
                                                                                <option value="Finance">Finance</option>
                                                                                <option value="Arts">Arts</option>
                                                                                <option value="Science">Science</option>
                                                                                <option value="Engineering">Engineering</option>-->
                                    </select>
                                </div>





                                <div class="form-group">
                                    <label for="specialist">Specialist <span class="required">*</span></label>
                                    <select id="specialist" name="specialist" required>
                                        <option value="" disabled selected>-- Select a specialist --</option>
                                        <!--This will be populated based on the selected category using JavaScript--> 
                                    </select>
                                </div>



                                <div class="form-group">
                                    <label for="question_title">Question Title <span class="required">*</span></label>
                                    <input type="text" id="question" name="question" placeholder="Enter a clear, specific title for your question" required>
                                </div>

<!--                                <div class="form-group">
                                    <label for="attachment">Attachment (Optional)</label>
                                    <div class="file-upload">
                                        <input type="file" name="qnfile" id="attachment" /> 
                                    </div>-->
                                    <!--                                    <div class="file-upload">
                                                                            <input type="file" id="attachment" name="attachment">
                                                                            <div class="file-upload-label">
                                                                                <i class="fa fa-cloud-upload-alt"></i>
                                                                                <span>Drag & drop files or click to browse</span>
                                                                            </div>
                                                                        </div>-->
                                    <!--<p class="file-info">Max file size: 5MB. Supported formats: jpg, png, pdf</p>-->
                                    <!-- No need to change here, we will add file name separately in JavaScript -->

                                </div>

                                <div class="form-actions">
                                    <button type="button" class="btn btn-secondary" onclick="window.location.href = 'specialist_home.jsp'">Cancel</button>
                                    <button type="submit" class="btn btn-primary">Submit Question</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </main>
            </div>
        </div>









        <script>


            $(document).ready(function () {
                $('#category').change(function () {
                    var selectedCategory = $(this).val();
                    console.log("Selected Category: " + selectedCategory); // Log category

                    $.ajax({
                        url: '<%= request.getContextPath()%>/AddQuestionServlet',
                        type: 'POST',
                        data: {category: selectedCategory},
                        success: function (response) {
                            console.log("Response from server: " + response); // Log response
                            $('#specialist').html(response);
                        }
                    });
                });

                // Add this new function to capture the specialist ID when a specialist is selected
                $('#specialist').change(function () {
                    var selectedOption = $(this).find('option:selected');
                    var specialistId = selectedOption.data('id');

                    // Store the specialist ID in a session via AJAX
                    $.ajax({
                        url: '<%= request.getContextPath()%>/StoreSpecialistIdServlet',
                        type: 'POST',
                        data: {specialistId: specialistId},
                        success: function (response) {
                            console.log("Specialist ID stored: " + specialistId);
                        }
                    });
                });
            });

            function closeForm() {
                document.querySelector('.main-content1').style.display = "none";
                window.location.href = "specialist_home.jsp";
            }


















//            $(document).ready(function () {
//                $('#category').change(function () {
//                    var selectedCategory = $(this).val();
//                    console.log("Selected Category: " + selectedCategory); // Log category
//
//                    $.ajax({
//                        url: '<= request.getContextPath()%>/AddQuestionServlet',
//                        type: 'POST',
//                        data: {category: selectedCategory},
//                        success: function (response) {
//                            console.log("Response from server: " + response); // Log response
//                            $('#specialist').html(response);
//                        }
////                    error: function (xhr, status, error) {
////                    console.log("AJAX Error: " + status + ", " + error);
////                    }
//                    });
//                });
//            });
//            function closeForm() {
//                document.querySelector('.main-content1').style.display = "none";
//                window.location.href = "specialist_home.jsp";
//            }
//
////            function closeForm() {
////                const mainContent = document.querySelector('.main-content1'); // not All
////                if (mainContent) {
////                    mainContent.style.display = "none";
////                }
////            }

        </script>
    </body>
</html>
