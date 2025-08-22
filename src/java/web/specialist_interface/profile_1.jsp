<%-- 
    Document   : profile
    Created on : 1 May, 2025, 11:27:43 AM
    Author     : rohini
--%>

<%@page import="java.sql.*"%>
<%

    String success = request.getParameter("success");
    Integer specialistId = (Integer) session.getAttribute("specialistId");
    String fname = "", gender = "", mobile = "", email = "", dob = "", profilePhoto = "", category = "", expertise_domain = "", years = "", bio = "", portfolio = "", linkedin = "", workplace = "", id = "";
    if (specialistId != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM specialist_regdetails WHERE id = ?");
            ps.setInt(1, specialistId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                fname = rs.getString("full_name");
                gender = rs.getString("gender");
                email = rs.getString("email");
                mobile = rs.getString("mobile");
                dob = rs.getString("dob");
                profilePhoto = rs.getString("profile_photo");
                category = rs.getString("expertise_category");
                expertise_domain = rs.getString("expertise_domain");
                years = rs.getString("years_experience");
                workplace = rs.getString("workplace");
                portfolio = rs.getString("portfolio");
                linkedin = rs.getString("linkedin");
                bio = rs.getString("bio");
                id = rs.getString("id");
            }
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    } else {
        out.println("<script>alert('session is null');</script>");
    }
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Expert Profile</title>
        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background: #f5f7fb;
                margin: 0;
                padding: 20px;
            }

            .profile-card {
                max-width: 900px;
                margin: auto;
                background: white;
                display: flex;
                border-radius: 20px;
                box-shadow: 0 10px 25px rgba(0,0,0,0.1);
                overflow: hidden;
                margin-top: 40px;
                margin-left: 250px;
            }

            .left-panel {
                background:  #fff;
                color: white;
                padding: 15px 20px;
                width: 30%;
                text-align: center;
            }

            .left-panel img {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
                border: 4px solid white;
                margin-bottom: 15px;
            }

            .left-panel h2 {
                margin: 10px 0 5px;
                font-size: 22px;
                color: #000;
            }

            .status {
                font-weight: bold;
                padding: 5px 10px;
                border-radius: 20px;
                display: inline-block;
                font-size: 12px;
                margin-top: 10px;
                background-color: #ffc107;
                color: black;
            }

            .status.approved {
                background-color: #28a745;
                color: white;
            }

            .right-panel {
                padding: 30px;
                width: 70%;
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
            }

            .info-group label {
                font-weight: bold;
                color: #666;
                font-size: 14px;
            }

            .info-group span, .info-group a {
                display: block;
                margin-top: 5px;
                color: #333;
                font-size: 16px;
                text-decoration: none;
            }

            .info-group a.button {
                background: #6a59d1;
                color: white;
                padding: 8px 12px;
                border-radius: 8px;
                display: inline-block;
                text-align: center;
            }

            .info-group.full-width {
                grid-column: span 2;
            }

            .edit-btn {
                grid-column: span 2;
                text-align: right;
            }

            .edit-btn a {
                background: #ff7b00;
                color: white;
                padding: 10px 20px;
                text-decoration: none;
                border-radius: 8px;
                font-weight: 500;
            }

            @media (max-width: 768px) {
                .profile-card {
                    flex-direction: column;
                }

                .left-panel, .right-panel {
                    width: 100%;
                }

                .right-panel {
                    grid-template-columns: 1fr;
                }

                .edit-btn {
                    text-align: center;
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
                    <div class="profile-card">

                        <div class="left-panel">
                            <h2 style="margin-bottom:30px;">Profile Preview</h2>

                            <img src="<%= request.getContextPath()%>/Specialist_profile/<%=profilePhoto %>" alt="Profile Picture" />
                            <h2><%=fname%> </h2>
                            <div class="status approved">Approved</div>
                        </div>

                        <div class="right-panel">
                            <div class="info-group">
                                <label>Full name</label>
                                <span><%=fname%></span>
                            </div>

                            <div class="info-group">
                                <label>Email</label>
                                <span><%=email%></span>
                            </div>

                            <div class="info-group">
                                <label>Phone</label>
                                <span><%=mobile%></span>
                            </div>

                            <!--                            <div class="info-group">
                                                            <label>Gender</label>
                                                            <span>Female</span>
                                                        </div>-->

                            <div class="info-group">
                                <label>Date of Birth</label>
                                <span><%=dob%></span>
                            </div>

                            <div class="info-group">
                                <label>Category</label>
                                <span><%=category%></span>
                            </div>

                            <div class="info-group">
                                <label>Domain</label>
                                <span><%=expertise_domain%></span>
                            </div>

                            <div class="info-group">
                                <label>Experience</label>
                                <span><%=years%></span>
                            </div>

                            <div class="info-group">
                                <label>Workplace</label>
                                <span><%=workplace%></span>
                            </div>

                            <div class="info-group">
                                <label>Portfolio</label>
                                <a href="<%=portfolio%>" target="_blank" style=" color: #6a59d1;
                                   text-decoration: none;">View Portfolio</a>

                            </div>

                            <div class="info-group">
                                <label>LinkedIn</label>
                                <a href="<%=linkedin%>" target="_blank"  style=" color: #6a59d1;
                                   text-decoration: none;">LinkedIn</a>
                            </div>

                            <div class="info-group full-width">
                                <label>Bio</label>
                                <span><%=bio%></span>
                            </div>

                            <div class="edit-btn">
                                <a href="specialist_editProfile.jsp">Edit Profile</a>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>
    </body>
</html>


<script>
    function closeProfileModal() {
        const modal = document.querySelector(".center");
        if (modal) {
            modal.style.display = "none";
            window.location.href = "specialist_home.jsp";

        }
    }

</script>
</body>
</html>
