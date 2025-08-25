<%-- 
    Document   : home.jsp
    Created on : 8 Apr, 2025, 5:08:19 PM
    Author     : rohini
--%>

<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>  
<%
    String sprofile = "", domain = "";
    Connection con = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

        String query = "SELECT * FROM specialist_regdetails";
        ps = con.prepareStatement(query);
        rs = ps.executeQuery();

        String query1 = "SELECT a.*, q.* FROM answers a JOIN questions q ON a.question_id = q.question_id";
        PreparedStatement ps1 = con.prepareStatement(query1);
        ResultSet rs1 = ps1.executeQuery();

%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ask Expert / Home Page</title>

        <!-- css file link -->
        <link href="style1.css" rel="stylesheet">

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

        <!-- Bootstrap cdn -->
        <!-- Latest compiled and minified CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel='stylesheet' href='experthome.css'>
        <style>

            body {
                font-family: 'poppins', sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f5f5f5;
            }
            section {
                margin-top: 120px; /* enough padding for fixed navbar */
                min-height: 100vh; /* optional: make sections full screen */
            }
            a{
                cursor: pointer;
            }
            .main-header {
                position: fixed;
                top: 0;
                left: 0;
                right: 0;
                z-index: 1000;
            }
            .home {
                padding: 120px 0 60px;
            }
            .experts-carousel {
                width: 100%;
                overflow: hidden;
                position: relative;
            }

            /* Sidebar styles */
            .sidebar {
                position: fixed;
                top: 0;
                left: -250px;
                height: 100%;
                width: 250px;
                background-color: #ff7f00;
                display: flex;
                flex-direction: column;
                padding: 20px;
                transition: left 0.3s ease;
                z-index: 2000;
            }

            .sidebar a {
                color: #fff;
                text-decoration: none;
                padding: 15px 0;
                font-size: 18px;
                border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            }

            .sidebar .close-btn {
                font-size: 26px;
                color: white;
                cursor: pointer;
                align-self: flex-end;
                margin-bottom: 20px;
            }

            .sidebar-dropdown {
                width: 100%;
                margin-top: 10px;
            }

            .dropdown-btn {
                background: none;
                border: none;
                color: white;
                font-size: 18px;
                text-align: left;
                padding: 10px 0;
                cursor: pointer;
                width: 100%;
                outline: none;
            }

            .dropdown-content {
                display: none;
                flex-direction: column;
                padding-left: 10px;
            }

            .dropdown-content a {
                font-size: 16px;
                padding: 6px 0;
                color: #fff;
                text-decoration: none;
            }

            .dropdown-content a:hover {
                /*                background-color: #3a3a3a;  slightly lighter on hover */
                background-color: rgba(255, 255, 255, 0.1); /* soft light hover */

                text-decoration: none;
                border-radius: 4px;
            }

            .sidebar-dropdown.open .dropdown-content {
                display: flex;
            }


            /* Backdrop for sidebar */
            .backdrop {
                position: fixed;
                top: 0;
                left: 0;
                height: 100%;
                width: 100%;
                background: rgba(0,0,0,0.5);
                display: none;
                z-index: 1500;
            }

            /* Sidebar open state */
            .sidebar.open {
                left: 0;
            }

            .backdrop.show {
                display: block;
            }

            /* Hamburger button */
            .mobile-menu-toggle {
                position: fixed;
                top: 15px;
                right: 20px;
                font-size: 26px;
                cursor: pointer;
                z-index: 2100;
                color: white;
            }

            /*            @media (max-width: 768px) {
                            nav {
                                position: fixed;
                                top: 70px;
                                left: -100%;
                                width: 80%;
                                height: calc(100vh - 70px);
                                background-color: #ff7b00;
                                flex-direction: column;
                                transition: left 0.3s ease;
                            }
            
                            nav.active {
                                left: 0;
                            }
                        }*/
            @media (max-width: 576px) {
                .expert-card {
                    width: 160px;
                    padding: 12px;
                }
            }



        </style>

    </head>

    <body>
        <div class="container1">
            <!-- header section -->
            <header class="main-header">
                <div class="logo">
                    <h3>Ask Expert</h3>
                </div>
                <nav id="main-nav">
                    <a href="#home">Home</a>
                    <a href="#expert" style="margin-right:40px;">Experts</a>
                    <!--<a href="#contact">Contact</a>-->

                    <div class="button">
                        <div class="dropdown">
                            <button type="button" class="dropdown_btn me-2" >Login</button>
                            <div class="dropdown_content">
                                <a href="<%=request.getContextPath()%>/Admin_interface/admin_login.jsp">Admin</a>
                                <a href="<%=request.getContextPath()%>/specialist_interface/specialist_login.jsp">Specialists</a>
                                <a href="<%=request.getContextPath()%>/user_interface/user_login.jsp">User</a>
                            </div> 
                        </div>  &nbsp;&nbsp;&nbsp;&nbsp;        
                        <div class="dropdown">
                            <button type="button" class="dropdown_btn">Register</button>
                            <div class="dropdown_content">
                                <a href="<%=request.getContextPath()%>/specialist_interface/specialist_register.jsp">Specialists</a>
                                <a href="<%=request.getContextPath()%>/user_interface/user_register.jsp">User</a>
                            </div>
                        </div>  
                    </div>
                </nav>
                <!-- Hamburger icon -->
                <div class="mobile-menu-toggle" id="menuToggle">&#9776;</div>

                <!-- Sidebar menu -->
                <div id="sidebar" class="sidebar">
                    <div class="close-btn" id="closeSidebar">&times;</div>
                    <a href="#home"">Home</a>
                    <a href="#expert">Experts</a>
                    <!--login-->
                    <div class="sidebar-dropdown">
                        <button class="dropdown-btn">Login ▼</button>
                        <div class="dropdown-content">
                            <a href="<%=request.getContextPath()%>/user_interface/user_login.jsp">User Login</a>
                            <a href="<%=request.getContextPath()%>/specialist_interface/specialist_login.jsp">Specialist Login</a>
                            <a href="<%=request.getContextPath()%>/Admin_interface/admin_login.jsp">Admin Login</a>
                        </div>
                    </div>
                    <!--<a href="#">Register</a>-->
                    <!-- Register Dropdown -->
                    <div class="sidebar-dropdown">
                        <button class="dropdown-btn">Register ▼</button>
                        <div class="dropdown-content">
                            <a href="<%=request.getContextPath()%>/user_interface/user_register.jsp">User Register</a>
                            <a href="<%=request.getContextPath()%>/specialist_interface/specialist_register.jsp">Specialist Register</a>
                        </div>
                    </div>
                </div>

                <!-- Backdrop -->
                <div id="backdrop" class="backdrop"></div>
            </header>
            <!-- home section -->
            <section class="home" id="home">
                <div class="container row">
                    <div class="col-sm-5 home_content ">
                        <h3 class="title">Welcome to Ask Expert - Your Go-To Knowledge Hub!</h3>
                        <p>Get expert answers to your questions instantly. Whether it's technology, health, business, or any
                            other field, we connect you with specialists who can help.</p>
                        <a href="<%=request.getContextPath()%>/user_interface/user_login.jsp" style="text-decoration: none;"> <button type="button" class="login">Ask a
                                Question Now !</button></a>
                    </div>
                    <div class="col-sm-5 img">
                        <img src="assets/home_img.webp" alt="Ask Expert" />
                    </div>
                </div>
            </section>


            <section class="feature" id="expert">
                <!--<h3 class="title line">Experts</h3>-->
                <div class="forum">
                    <div class="experts-showcase">
                        <h3 class="title line">Meet Our Experts</h3>

                        <div class="experts-title">
                            <p>Connect with professionals across various domains ready to answer your questions</p>
                        </div>




                        <div class="experts-marquee-container">
                            <div class="experts-marquee">
                                <% while (rs.next()) {
                                        String sname = rs.getString("full_name");
                                        String category = rs.getString("expertise_category");
                                        String sphoto = rs.getString("profile_photo");
                                %>
                                <div class="expert-card " style="display:flex;flex-direction: row;">
                                    <div><img src="<%= request.getContextPath()%>/profileimages/<%=sphoto%>" alt="Profile Picture" style="width:60px;height:60px;border-radius: 50%;object-fit: cover;border-color: red;  margin-right: 20px;" />
                                    </div>
                                    <div>
                                        <div class="expert-name"><%=sname%></div>
                                        <div class="expert-domain"><span><%=category%></span></div>
                                    </div>
                                </div>
                                <% } %>
                                <div class="expert-card">
                                    <!--<div class="expert-icon"><i>🏢</i></div>-->
                                    <div class="expert-name">Jessica Miller</div>
                                    <div class="expert-domain"><span>Education</span></div>
                                </div>

                                <div class="expert-card">
                                    <!--<div class="expert-icon"><i>⚙️</i></div>-->
                                    <div class="expert-name">Michael Taylor</div>
                                    <div class="expert-domain"><span>Medicine</span></div>
                                </div>



                            </div>
                        </div>

                        <!--                                <div class="expert-card">
                                                            <div class="expert-icon"><i>🖥️</i></div>
                                                            <div class="expert-name">David Chen</div>
                                                            <div class="expert-domain"><span>Software Solution</span></div>
                                                        </div>
                        
                                                        <div class="expert-card">
                                                            <div class="expert-icon"><i>🏢</i></div>
                                                            <div class="expert-name">Jessica Miller</div>
                                                            <div class="expert-domain"><span>Enterprise Apps</span></div>
                                                        </div>
                        
                                                        <div class="expert-card">
                                                            <div class="expert-icon"><i>⚙️</i></div>
                                                            <div class="expert-name">Michael Taylor</div>
                                                            <div class="expert-domain"><span>DevOps Services</span></div>
                                                        </div>
                        
                                                        <div class="expert-card">
                                                            <div class="expert-icon"><i>📱</i></div>
                                                            <div class="expert-name">Emma Wilson</div>
                                                            <div class="expert-domain"><span>Custom Web Apps</span></div>
                                                        </div>
                        
                                                        <div class="expert-card">
                                                            <div class="expert-icon"><i>🎨</i></div>
                                                            <div class="expert-name">Robert Garcia</div>
                                                            <div class="expert-domain"><span>UI/UX Design</span></div>
                                                        </div>
                        
                                                        <div class="expert-card">
                                                            <div class="expert-icon"><i>📊</i></div>
                                                            <div class="expert-name">Amanda Lee</div>
                                                            <div class="expert-domain"><span>Data Analysis</span></div>
                                                        </div>
                        
                                                        <div class="expert-card">
                                                            <div class="expert-icon"><i>☁️</i></div>
                                                            <div class="expert-name">Thomas Wright</div>
                                                            <div class="expert-domain"><span>Cloud Solutions</span></div>
                                                        </div>
                        
                                                         Duplicate cards for continuous scrolling 
                                                        <div class="expert-card">
                                                            <div class="expert-icon"><i>👩‍💻</i></div>
                                                            <div class="expert-name">Sarah Johnson</div>
                                                            <div class="expert-domain"><span>Web Development</span></div>
                                                        </div>
                        
                                                        <div class="expert-card">
                                                            <div class="expert-icon"><i>🖥️</i></div>
                                                            <div class="expert-name">David Chen</div>
                                                            <div class="expert-domain"><span>Software Solution</span></div>
                                                        </div>
                        
                                                        <div class="expert-card">
                                                            <div class="expert-icon"><i>🏢</i></div>
                                                            <div class="expert-name">Jessica Miller</div>
                                                            <div class="expert-domain"><span>Enterprise Apps</span></div>
                                                        </div>
                        
                                                        <div class="expert-card">
                                                            <div class="expert-icon"><i>⚙️</i></div>
                                                            <div class="expert-name">Michael Taylor</div>
                                                            <div class="expert-domain"><span>DevOps Services</span></div>
                                                        </div>
                        
                                                        <div class="expert-card">
                                                            <div class="expert-icon"><i>📱</i></div>
                                                            <div class="expert-name">Emma Wilson</div>
                                                            <div class="expert-domain"><span>Custom Web Apps</span></div>
                                                        </div>
                        
                                                        <div class="expert-card">
                                                            <div class="expert-icon"><i>🎨</i></div>
                                                            <div class="expert-name">Robert Garcia</div>
                                                            <div class="expert-domain"><span>UI/UX Design</span></div>
                                                        </div>-->
                    </div>

                </div>

                <main class="container_ans">


                    <div class="heading">
                        <h1 class="title line">Expert Forum</h1>
                        <p>Browse questions answered by our community of experts across various domains</p>
                    </div>

                    <div class="forum-container">                       
                        <div class="forum-cards" id="forum-cards-container">
                            <%
                                while (rs1.next()) {
                                    String sname = rs1.getString("specialist_name");
                                    String category = rs1.getString("category");
                                    String question = rs1.getString("question");
                                    String answer = rs1.getString("answer_text");
                                    Integer sid = rs1.getInt("specialist_id");

                                    String query2 = "SELECT * FROM specialist_regdetails where id=?";
                                    PreparedStatement ps2 = con.prepareStatement(query2);
                                    ps2.setInt(1, sid);
                                    ResultSet rs2 = ps2.executeQuery();

                                    if (rs2.next()) {
                                        sprofile = rs2.getString("profile_photo");
                                        domain = rs2.getString("expertise_domain");
                                    }
                            %>
                            <!-- Card 1 -->
                            <div class="card1">
                                <div class="card-header">
                                    <h3><%=question%></h3>
                                    <span class="badge"><%=category%></span>
                                </div>
                                <div class="card-content">
                                    <div class="expert-info">
                                        <div class="expert-avatar">
                                            <img src="<%= request.getContextPath()%>/profileimages/<%=sprofile%>" alt="Profile Picture" style="width:40px;height:40px;border-radius: 50%;object-fit: cover;" />
                                            <!--                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                                                        <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path>
                                                                                        <circle cx="12" cy="7" r="4"></circle>
                                                                                        </svg>-->
                                        </div>
                                        <div>
                                            <p class="expert-name"><%=sname%></p>
                                            <p class="expert-title"><%=domain%></p>
                                        </div>
                                    </div>
                                    <div class="answer-container">
                                        <p class="answer collapsed" id="answer-1"><%=answer%></p>
                                        <button class="read-more-btn" >Read more</button>
                                    </div>
                                </div>
                            </div>

                            <%}
                            %>
                        </div>
                    </div>

                    <div class="navigation-buttons">
                        <button class="nav-button" onclick="scrollContainer('left')">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="m15 18-6-6 6-6"/>
                            </svg>
                        </button>
                        <button class="nav-button" onclick="scrollContainer('right')">
                            <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="m9 18 6-6-6-6"/>
                            </svg>
                        </button>
                    </div>
                </main>

        </div>
        <%
            } catch (Exception e) {
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
        <!--</div>-->


    </section>




    <!-- footer -->
    <footer id="contact">
        <div class="foot row">
            <div class="col-sm-12 head">
                <h4> Ask Expert – Knowledge at Your Fingertips! </h4>
            </div>
            <div class="col-sm-12 head">
                <p>&copy; <span id="year1">2025</span> Ask Expert. All rights reserved.</p>
            </div>
        </div>
    </footer>
    <!--                    <div class="col-sm-4 link" style="display:flex;justify-content: space-between;">
                            <h4>Quick Links</h4>
                            <a href="#home" >
                                <p>Home</p>
                            </a>
                            <a href="#expert">
                                <p>Experts</p>
                            </a>
                            <a href="#contact">
                                <p>Contact</p>
                            </a>
                        </div>-->
    <!--<div class="col-sm-4 contact">-->
    <!--                        <div class="touch">
                                <h4>Get in Touch </h4>
                                <p>Email : <a href="mailto:askexpert@gmail.com">askexpert@gmail.com</a></p>
                                <p>Phone : +91 9876543210 </p>
                            </div>
                            <div class="follow">
                                <a href="#"><i class="fa-brands fa-instagram"></i></a>
                                <a href="#"><i class="fa-brands fa-linkedin-in"></i></a>
                                <a href="#"><i class="fa-brands fa-twitter"></i></a>
                            </div>-->
    <!--</div>-->

</div>

<!-- JavaScript -->
<script>



    document.addEventListener("DOMContentLoaded", function () {

        const toggleBtn = document.getElementById("menuToggle");
        const sidebar = document.getElementById("sidebar");
        const closeBtn = document.getElementById("closeSidebar");
        const backdrop = document.getElementById("backdrop");
        toggleBtn.addEventListener("click", () => {
            sidebar.classList.add("open");
            backdrop.classList.add("show");
        });
        closeBtn
                .addEventListener("click", () => {
                    sidebar.
                            classList.remove("open");
                    backdrop.classList.remove("show");
                });
        backdrop
                .addEventListener("click", () => {
                    sidebar.classList.remove("open");
                    backdrop.classList.remove("show");
                });
    });

//    for responsive navigation login dropdown adn register dropdown
    document.addEventListener("DOMContentLoaded", function () {
        const toggleBtn = document.getElementById("menuToggle");
        const sidebar = document.getElementById("sidebar");
        const closeBtn = document.getElementById("closeSidebar");
        const backdrop = document.getElementById("backdrop");
        toggleBtn.addEventListener("click", () => {
            sidebar.classList.add("open");
            backdrop.classList.add("show");
        });

        closeBtn.addEventListener("click", () => {
            sidebar.classList.remove("open");
            backdrop.classList.remove("show");
        });

        backdrop.addEventListener("click", () => {
            sidebar.classList.remove("open");
            backdrop.classList.remove("show");
        });

        // Dropdown toggle logic
        const dropdowns = document.querySelectorAll(".sidebar-dropdown");
        dropdowns.forEach(drop => {
            const btn = drop.querySelector(".dropdown-btn");
            btn.addEventListener("click", () => {
                drop.classList.toggle("open");
            });
        });
    });



//    document.addEventListener("DOMContentLoaded", function () {
//        const toggleButton = document.querySelector('.mobile-menu-toggle');
//        const nav = document.querySelector('nav');
//
//        toggleButton.addEventListener('click', () => {
//            nav.classList.toggle('active');
//        });
//    });




// Footer year
    document.getElementById('year1').textContent = new Date().getFullYear();

// Fix dropdown menu links
    document.addEventListener("DOMContentLoaded", () => {
        const dropdownLinks = document.querySelectorAll(".dropdown_content a");
        dropdownLinks.forEach((link) => {
            link.addEventListener("click", function (e) {
                e.stopPropagation();
                const href = this.getAttribute("href");
                if (href) {
                    window.location.href = href;
                }
            });
        });
    });

// Mobile menu toggle
    const mobileMenuToggle = document.querySelector(".mobile-menu-toggle");
    const mainNav = document.getElementById("main-nav");

    if (mobileMenuToggle && mainNav) {
        mobileMenuToggle.addEventListener("click", function () {
            mainNav.classList.toggle("active");
            this.classList.toggle("active");
        });
    }

// Toggle read more/less for answers
    document.addEventListener("DOMContentLoaded", function () {
        const readMoreButtons = document.querySelectorAll(".read-more-btn");
        readMoreButtons.forEach(function (btn) {
            btn.addEventListener("click", function () {
                const answer = btn.previousElementSibling;
                if (answer.classList.contains("collapsed")) {
                    answer.classList.remove("collapsed");
                    btn.textContent = "See Less";
                } else {
                    answer.classList.add("collapsed");
                    btn.textContent = "See More";
                }
            });
        });
    });

// Scroll forum cards container
    function scrollContainer(direction) {
        const container = document.getElementById('forum-cards-container');
        const scrollAmount = direction === 'left' ? -400 : 400;
        container.scrollBy({left: scrollAmount, behavior: 'smooth'});
    }

// Fix z-index and navigation issues
    document.addEventListener("DOMContentLoaded", function () {
        const header = document.querySelector('.main-header');
        const headerHeight = header.offsetHeight;

        document.querySelectorAll('section').forEach(section => {
            if (section.id !== 'home') {
                section.style.paddingTop = (headerHeight + 20) + 'px';
            }
        });

        const navLinks = document.querySelectorAll('nav a');
        navLinks.forEach(link => {
            link.addEventListener('click', function (e) {
                e.preventDefault();
                const targetId = this.getAttribute('href');
                const targetElement = document.querySelector(targetId);
                if (targetElement) {
                    const targetPosition = targetElement.getBoundingClientRect().top + window.pageYOffset - headerHeight;
                    window.scrollTo({
                        top: targetPosition,
                        behavior: 'smooth'
                    });
                }
            });
        });

// Mobile menu toggle again (redundant but harmless)
        const mobileMenuToggle = document.querySelector('.mobile-menu-toggle');
        const mainNav = document.getElementById('main-nav');
        if (mobileMenuToggle && mainNav) {
            mobileMenuToggle.addEventListener('click', function () {
                mainNav.classList.toggle('active');
                this.classList.toggle('active');
            });
        }

// Fix for the experts marquee section
        const expertsMarquee = document.querySelector(".experts-marquee");
        if (expertsMarquee) {
            const expertCards = document.querySelectorAll(".expert-card");
            expertCards.forEach(card => {
                card.style.pointerEvents = "auto";
            });
        }

// Fix for the forum cards section
        const forumCards = document.querySelector(".forum-cards");
        if (forumCards) {
            forumCards.style.pointerEvents = "auto";
        }

// Handle scroll events to adjust header visibility
        let lastScrollTop = 0;
        window.addEventListener('scroll', function () {
            const scrollTop = window.pageYOffset || document.documentElement.scrollTop;
            if (scrollTop > 10) {
                header.classList.add('scrolled');
            } else {
                header.classList.remove('scrolled');
            }
            lastScrollTop = scrollTop;
        });
    });
</script>


<!-- Bootstrap JavaScript -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
