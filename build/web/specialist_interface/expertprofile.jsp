<%-- 
    Document   : expertprofile
    Created on : 16 May, 2025, 5:18:07 PM
    Author     : rohini
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    String currentSpecialistEmail = (String) session.getAttribute("email"); // or "specialistId" if you're storing ID

    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    String keyword = request.getParameter("keyword");
    String city = request.getParameter("city");

    // Flags to track conditions
    boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
    boolean hasCity = city != null && !city.trim().isEmpty();

    String query = "SELECT * FROM specialist_regdetails where status='Approved'";

    if (hasKeyword) {
        query += " AND (full_name LIKE ? OR expertise_category LIKE ? OR expertise_domain LIKE ?)";
    }
    if (hasCity) {
        query += " AND city LIKE ?";
    }
    query += " AND email != ?";
    query += " ORDER BY RAND()";

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

        ps = con.prepareStatement(query);

        int index = 1;
        if (hasKeyword) {
            ps.setString(index++, "%" + keyword + "%");
            ps.setString(index++, "%" + keyword + "%");
            ps.setString(index++, "%" + keyword + "%");
        }
        if (hasCity) {
            ps.setString(index++, "%" + city + "%");
        }
        ps.setString(index++, currentSpecialistEmail); // exclude current specialist

        rs = ps.executeQuery();
%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Expert Profiles</title>
        <link rel="stylesheet" href="style.css">

        <style>
            body {
                font-family: 'poppins', sans-serif;
                background: #f4f4f4;
                margin: 0;
                padding: 0;
            }
            .maincontent {
                width: 100% ;
                padding: 0;
                margin: 0;
                box-sizing: border-box;
                margin-left: 170px; /* Account for sidebar */
                width: calc(100% - 200px); /* Dynamically calculate width */
                margin-top: 20px;
                margin-right: 20px;
            }
            /* 🔍 Search Bar */
            .search-bar {
                display: flex;
                gap: 10px;
                padding: 15px;
                margin-top:60px;
                background: #fff;
                border-radius: 15px;
                box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            }
            .search-bar input {
                flex: 1;
                padding: 10px 15px;
                border-radius: 10px;
                border: 1px solid #ccc;
            }
            .search-bar input:focus{
                outline: none;
                border-color: #fd7e14;
                color:#212529;
                box-shadow:0 0 5px rgba(253, 126, 20, 0.5);
            }
            .search-bar button {
                padding: 10px 20px;
                background-color: #ff8c00;
                color: #fff;
                border-radius: 10px;
                border: none;
                cursor: pointer;
            }
            .search-bar button:hover{
                background: linear-gradient(to right, #ff7f00, #ff4500);
            }

            /* 👨‍⚕️ Expert Cards */
            .experts-container {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                gap: 20px;
                padding: 20px;
            }

            .expert-card {
                background-color: #fff;
                border-radius: 15px;
                padding: 20px;
                box-shadow: 0 8px 16px rgba(0, 0, 0, 0.1);
                text-align: center;
                transition: transform 0.2s;
                margin-top:10px; 
            }

            .expert-card:hover {
                transform: translateY(-5px);
            }

            .expert-card img {
                width: 100px;
                height: 100px;
                border-radius: 50%;
                object-fit: cover;
                margin-bottom: 15px;
                border: 3px solid #fd7e14;
            }

            .expert-card h3 {
                margin: 10px 0;
                color: #333;
                margin-bottom: 15px;
            }

            .expert-card p {
                margin: 5px 0;
                color: #666;
                text-align: left;
                padding-left: 30px;
                padding-right: 10px;

            }


            @media (max-width: 768px) {
                .sidebar {
                    position: absolute;
                    left: -100%;
                    transition: left 0.3s ease;
                }
                .sidebar.active {
                    left: 0;
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
                    <div class="maincontent">

                        <!-- 🔍 Search Bar -->
                        <form method="post" action="expertprofile.jsp" class="search-bar">
                            <input type="text" placeholder="Search by name or domain" name="keyword"
                                   value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : ""%>">
                            <input type="text" placeholder="Enter city (optional)" name="city"
                                   value="<%= request.getParameter("city") != null ? request.getParameter("city") : ""%>">
                            <button type="submit">Search</button>
                        </form>

                        <!-- 👨‍⚕️ Expert Cards -->
                        <div class="experts-container">
                            <%
                                boolean found = false;
                                while (rs.next()) {
                                    found = true;

                                    Integer sid = rs.getInt("id");
                                    String sname = rs.getString("full_name");
                                    String sprofile = rs.getString("profile_photo");
                                    String gender = rs.getString("gender");
                                    String password = rs.getString("password");
                                    String email = rs.getString("email");
                                    String mobile = rs.getString("mobile");
                                    String expertise_category = rs.getString("expertise_category");
                                    String expertise_domain = rs.getString("expertise_domain");
                                    Integer experience = rs.getInt("years_experience");
                                    String status = rs.getString("status");
                                    String company = rs.getString("workplace");

                                    String city1 = rs.getString("city");
                            %>

                            <div class="expert-card">



                                <img src="<%= request.getContextPath()%>/profileimages/<%=sprofile%>" alt="Expert" class="uprofile">
                                <h3><%=sname%></h3>
                                <p ><strong>Category :</strong> <%=expertise_category%></p>
                                <p><strong>Domain:</strong> <%=expertise_domain%></p>
                                <p><strong>Experience:</strong> <%=experience%> Years</p>
                                <p><strong>Working Place :</strong> <%=company%> </p>
                                <p><strong>City:</strong> <%=city1%></p>




                                <!-- Add your button here -->
                                <form action="specialistaskqncard.jsp" method="post">
                                    <input type="hidden" name="expertId" value="<%= sid%>">
                                    <button type="submit" style="margin-top:10px; background-color:#fd7e14; color:white; border:none; padding:8px 15px; border-radius:8px; cursor:pointer;">
                                        Ask Question
                                    </button>
                                </form>
                            </div>                         
                            <% }
                                if (!found) {
                            %>
                            <p style="padding: 20px; color: red;">No experts found matching your search.</p>
                            <% } %>


                        </div>

                    </div>

                </main>
            </div>
        </div>

    </body>
    <%        } catch (Exception e) {
            out.println("Error: " + e.getMessage());
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (con != null) {
                con.close();
            }
        }
    %>

    <script>
        // Get input fields and form
        const keywordInput = document.querySelector('input[name="keyword"]');
        const cityInput = document.querySelector('input[name="city"]');
        const form = document.querySelector('form.search-bar');

        // Function to submit form if inputs are empty or user presses Enter
        function autoSubmit() {
            if (keywordInput.value.trim() === '' && cityInput.value.trim() === '') {
                form.submit();
            }
        }

        // Listen for input changes
        keywordInput.addEventListener('input', () => {
            if (keywordInput.value.trim() === '') {
                autoSubmit();
            }
        });

        cityInput.addEventListener('input', () => {
            if (cityInput.value.trim() === '') {
                autoSubmit();
            }
        });
    </script>

</html>
