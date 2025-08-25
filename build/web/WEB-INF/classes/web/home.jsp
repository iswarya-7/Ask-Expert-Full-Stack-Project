<%-- 
    Document   : home.jsp
    Created on : 8 Apr, 2025, 5:08:19 PM
    Author     : rohini
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>  

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Ask Expert / Home Page</title>

        <!-- css file link -->
        <link href="style.css" rel="stylesheet">

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
        <link rel='stylesheet' href='expert_home.css'>
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


        </style>

    </head>

    <body>
        <div class="container1">
            <!-- header section -->
            <header>
                <div class="logo">
                    <h3>Ask Expert</h3>
                </div>
                <nav>
                    <a href="#home">Home</a>
                    <!--<a href="#about">About</a>-->
                    <a href="#expert">Experts</a>
                    <a href="#contact">Contact</a>

                    <div class="button">
                        <!--                        <a href="login."><button type="button" class="login_button">Login</button></a>-->
                        <div class="dropdown">
                            <button type="button" class="dropdown_btn">Login</button>
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
            </header>
            <!-- home section -->
            <section class="home" id="home">
                <div class="container row">
                    <div class="col-sm-5 home_content ">
                        <h3 class="title">Welcome to Ask Expert - Your Go-To Knowledge Hub!</h3>
                        <p>Get expert answers to your questions instantly. Whether it's technology, health, business, or any
                            other field, we connect you with specialists who can help.</p>
                        <a href="login.jsp" style="text-decoration: none;"> <button type="button" class="login">Ask a
                                Question Now !</button></a>
                    </div>
                    <div class="col-sm-5 img">
                        <img src="assets/home_img.webp" />
                    </div>
                </div>
            </section>

            <!-- About Section -->
            <!--            <section class="about" id="about">
                            <div>
                                <div class="top">
                                    <h3 class="title line">Behind Ask Expert</h3>
                                    <p>We believe that knowledge should be accessible to everyone. Our mission is to bridge the gap
                                        between <br>
                                        seekers and specialists by providing a trusted platform where users can ask questions and
                                        receive
                                        professional guidance.</p>
                                </div>
                                <div class="works">
                                    <div class="vision-left">
                                        <h4 class="line">Our Vision</h4>
                                        <p class="p">
                                            Empowering individuals with accurate and expert-driven information to make informed
                                            decisions in
                                            various aspects of life.
                                        </p>
                                    </div>
            
                                    <div class="works-right">
                                        <h4 class="line">How It Works?</h4>
                                        <div class="steps">
                                            <div class="firstr">
                                                <p><span class="step_number">1</span> Post your question in any category.</p>
                                                <p> <span class="step_number">3</span> Rate the response to help others find the best
                                                    advice.</p>
                                            </div>
                                            <div class="secondr">
                                                <p><span class="step_number">2</span> Experts provide detailed and insightful answers.
                                                </p>
                                                <p> <span class="step_number">4</span> Get notified when an expert responds.</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
            
                            </div>
                        </section>-->

            <section class="feature" >
                <!--<h3 class="title line">Experts</h3>-->
                <div class="forum">
                    <div class="experts-showcase" id="expert">
                        <h3 class="title line">Meet Our Experts</h3>

                        <div class="experts-title">

                            <!--<h2>Meet Our Experts</h2>-->
                            <p>Connect with professionals across various domains ready to answer your questions</p>
                        </div>

                        <div class="experts-marquee-container">
                            <div class="experts-marquee">
                                <!-- Original cards -->
                                <div class="expert-card">
                                    <!--<div class="expert-icon"><i>👩‍💻</i></div>-->
                                    <div class="expert-name">Sarah Johnson</div>
                                    <div class="expert-domain"><span>Web Development</span></div>
                                </div>

                                <div class="expert-card">
                                    <!--<div class="expert-icon"><i>🖥️</i></div>-->
                                    <div class="expert-name">David Chen</div>
                                    <div class="expert-domain"><span>Software Solution</span></div>
                                </div>

                                <div class="expert-card">
                                    <!--<div class="expert-icon"><i>🏢</i></div>-->
                                    <div class="expert-name">Jessica Miller</div>
                                    <div class="expert-domain"><span>Enterprise Apps</span></div>
                                </div>

                                <div class="expert-card">
                                    <!--<div class="expert-icon"><i>⚙️</i></div>-->
                                    <div class="expert-name">Michael Taylor</div>
                                    <div class="expert-domain"><span>DevOps Services</span></div>
                                </div>

                                <div class="expert-card">
                                    <!--<div class="expert-icon"><i>📱</i></div>-->
                                    <div class="expert-name">Emma Wilson</div>
                                    <div class="expert-domain"><span>Custom Web Apps</span></div>
                                </div>

                                <div class="expert-card">
                                    <!--<div class="expert-icon"><i>🎨</i></div>-->
                                    <div class="expert-name">Robert Garcia</div>
                                    <div class="expert-domain"><span>UI/UX Design</span></div>
                                </div>

                                <div class="expert-card">
                                    <!--<div class="expert-icon"><i>📊</i></div>-->
                                    <div class="expert-name">Amanda Lee</div>
                                    <div class="expert-domain"><span>Data Analysis</span></div>
                                </div>

                                <div class="expert-card">
                                    <!--<div class="expert-icon"><i>☁️</i></div>-->
                                    <div class="expert-name">Thomas Wright</div>
                                    <div class="expert-domain"><span>Cloud Solutions</span></div>
                                </div>

                                <!-- Duplicate cards for continuous scrolling -->
                                <div class="expert-card">
                                    <!--<div class="expert-icon"><i>👩‍💻</i></div>-->
                                    <div class="expert-name">Sarah Johnson</div>
                                    <div class="expert-domain"><span>Web Development</span></div>
                                </div>

                                <div class="expert-card">
                                    <!--<div class="expert-icon"><i>🖥️</i></div>-->
                                    <div class="expert-name">David Chen</div>
                                    <div class="expert-domain"><span>Software Solution</span></div>
                                </div>

                                <div class="expert-card">
                                    <!--<div class="expert-icon"><i>🏢</i></div>-->
                                    <div class="expert-name">Jessica Miller</div>
                                    <div class="expert-domain"><span>Enterprise Apps</span></div>
                                </div>

                                <div class="expert-card">
                                    <!--<div class="expert-icon"><i>⚙️</i></div>-->
                                    <div class="expert-name">Michael Taylor</div>
                                    <div class="expert-domain"><span>DevOps Services</span></div>
                                </div>

                                <div class="expert-card">
                                    <!--<div class="expert-icon"><i>📱</i></div>-->
                                    <div class="expert-name">Emma Wilson</div>
                                    <div class="expert-domain"><span>Custom Web Apps</span></div>
                                </div>

                                <div class="expert-card">
                                    <!--<div class="expert-icon"><i>🎨</i></div>-->
                                    <div class="expert-name">Robert Garcia</div>
                                    <div class="expert-domain"><span>UI/UX Design</span></div>
                                </div>
                            </div>
                        </div>

                        <main class="container_ans">
                            <div class="heading">
                                <h1 class="title line">Expert Forum</h1>
                                <p>Browse questions answered by our community of experts across various domains</p>
                            </div>

                            <div class="forum-container">
                                <div class="forum-cards" id="forum-cards-container">
                                    <!-- Card 1 -->
                                    <div class="card1">
                                        <div class="card-header">
                                            <h3>What are the best practices for optimizing React application performance?</h3>
                                            <span class="badge">Web Development</span>
                                        </div>
                                        <div class="card-content">
                                            <div class="expert-info">
                                                <div class="expert-avatar">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path>
                                                    <circle cx="12" cy="7" r="4"></circle>
                                                    </svg>
                                                </div>
                                                <div>
                                                    <p class="expert-name">Jessica Miller</p>
                                                    <p class="expert-title">Senior Frontend Developer</p>
                                                </div>
                                            </div>
                                            <div class="answer-container">
                                                <p class="answer collapsed" id="answer-1">To optimize React performance, you should: 1) Use React.memo for component memoization to prevent unnecessary re-renders. 2) Implement proper key usage in lists to help React identify which items have changed. 3) Lazy load components and code-splitting to reduce initial load time. 4) Use the useCallback hook for memoizing functions. 5) Implement virtualization for long lists with libraries like react-window. 6) Avoid inline function definitions in render methods. 7) Use the Chrome Performance tab and React DevTools Profiler to identify bottlenecks. 8) Consider using state management solutions like Redux or Context API efficiently.</p>
                                                <button class="read-more-btn" onclick="toggleReadMore('answer-1')">Read more</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Card 2 -->
                                    <div class="card1">
                                        <div class="card-header">
                                            <h3>How can I implement secure authentication in a Node.js application?</h3>
                                            <span class="badge">Backend Development</span>
                                        </div>
                                        <div class="card-content">
                                            <div class="expert-info">
                                                <div class="expert-avatar">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path>
                                                    <circle cx="12" cy="7" r="4"></circle>
                                                    </svg>
                                                </div>
                                                <div>
                                                    <p class="expert-name">Michael Taylor</p>
                                                    <p class="expert-title">DevOps Engineer</p>
                                                </div>
                                            </div>
                                            <div class="answer-container">
                                                <p class="answer collapsed" id="answer-2">For secure authentication in Node.js, I recommend: 1) Use battle-tested libraries like Passport.js or Auth0 rather than building your own. 2) Always hash passwords using bcrypt or Argon2 with proper salt rounds. 3) Implement JWT (JSON Web Tokens) for stateless authentication but be mindful of their security implications. 4) Set secure and httpOnly flags on cookies. 5) Implement CSRF protection. 6) Use HTTPS exclusively in production. 7) Add rate limiting to prevent brute force attacks. 8) Implement proper session management with secure session storage.</p>
                                                <button class="read-more-btn" onclick="toggleReadMore('answer-2')">Read more</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Card 3 -->
                                    <div class="card1">
                                        <div class="card-header">
                                            <h3>What's the best approach for responsive design in 2023?</h3>
                                            <span class="badge">UI/UX Design</span>
                                        </div>
                                        <div class="card-content">
                                            <div class="expert-info">
                                                <div class="expert-avatar">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path>
                                                    <circle cx="12" cy="7" r="4"></circle>
                                                    </svg>
                                                </div>
                                                <div>
                                                    <p class="expert-name">Emma Wilson</p>
                                                    <p class="expert-title">UX Designer</p>
                                                </div>
                                            </div>
                                            <div class="answer-container">
                                                <p class="answer collapsed" id="answer-3">The best approach for responsive design in 2023 includes: 1) Mobile-first design philosophy is still relevant and important. 2) Use modern CSS features like Grid, Flexbox, and Container Queries instead of just media queries. 3) Implement fluid typography with clamp() for responsive text without breakpoints. 4) Consider designing for foldable devices and unusual screen ratios. 5) Use relative units (rem, em, %) rather than fixed pixels. 6) Test on real devices, not just browser emulators. 7) Consider accessibility across all device sizes. 8) Optimize images with srcset and modern formats like WebP and AVIF.</p>
                                                <button class="read-more-btn" onclick="toggleReadMore('answer-3')">Read more</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Card 4 -->
                                    <div class="card1">
                                        <div class="card-header">
                                            <h3>How do I implement CI/CD pipelines for a microservices architecture?</h3>
                                            <span class="badge">DevOps</span>
                                        </div>
                                        <div class="card-content">
                                            <div class="expert-info">
                                                <div class="expert-avatar">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path>
                                                    <circle cx="12" cy="7" r="4"></circle>
                                                    </svg>
                                                </div>
                                                <div>
                                                    <p class="expert-name">Robert Garcia</p>
                                                    <p class="expert-title">DevOps Architect</p>
                                                </div>
                                            </div>
                                            <div class="answer-container">
                                                <p class="answer collapsed" id="answer-4">For CI/CD in microservices: 1) Use containerization with Docker for consistent environments. 2) Implement infrastructure as code using Terraform or CloudFormation. 3) Set up separate pipelines for each microservice to enable independent deployment. 4) Use a container orchestration platform like Kubernetes for deployment. 5) Implement automated testing at multiple levels (unit, integration, end-to-end). 6) Set up centralized logging and monitoring with tools like ELK stack or Prometheus/Grafana. 7) Use feature flags to safely deploy new features. 8) Implement blue/green or canary deployment strategies to minimize risk.</p>
                                                <button class="read-more-btn" onclick="toggleReadMore('answer-4')">Read more</button>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Card 5 -->
                                    <div class="card1">
                                        <div class="card-header">
                                            <h3>What are the key considerations when designing a database schema for scalability?</h3>
                                            <span class="badge">Database Design</span>
                                        </div>
                                        <div class="card-content">
                                            <div class="expert-info">
                                                <div class="expert-avatar">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                                    <path d="M19 21v-2a4 4 0 0 0-4-4H9a4 4 0 0 0-4 4v2"></path>
                                                    <circle cx="12" cy="7" r="4"></circle>
                                                    </svg>
                                                </div>
                                                <div>
                                                    <p class="expert-name">Sophia Chen</p>
                                                    <p class="expert-title">Database Architect</p>
                                                </div>
                                            </div>
                                            <div class="answer-container">
                                                <p class="answer collapsed" id="answer-5">When designing for scalability: 1) Properly normalize data to reduce redundancy, but know when to denormalize for performance. 2) Choose appropriate primary keys and create necessary indexes, but be careful of over-indexing. 3) Consider partitioning strategies for large tables. 4) Plan for horizontal scaling from the beginning if you expect significant growth. 5) Implement caching strategies at various levels. 6) Consider read/write splitting for read-heavy applications. 7) Design with eventual consistency in mind for distributed systems. 8) Plan for data archiving strategies for historical data.</p>
                                                <button class="read-more-btn" onclick="toggleReadMore('answer-5')">Read more</button>
                                            </div>
                                        </div>
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
                            </div>
                        </main>

                    </div>
                </div>


            </section>


            <!--              Features
                        <section class="feature" id="feature">
                            <h3 class="title line">Why Choose Ask Expert ?</h3>
            
                            <div class="feature-grid">
                                 expert verified answer 
                                <div class="feature-card">
                                    <span> <i class="fa-solid fa-rocket"></i></span>
                                    <h4> Expert-Verified Answers</h4>
                                    <p>Get responses only from professionals and experienced individuals.</p>
                                </div>
                                 notification 
                                <div class="feature-card">
                                    <span> <i class="fa-solid fa-bell"></i></span>
                                    <h4>Real-Time Notifications</h4>
                                    <p>Stay updated with alerts whenever an expert responds to your question.</p>
                                </div>
                                 ratings 
                                <div class="feature-card">
                                    <span> <i class="fa-solid fa-star"></i></span>
                                    <h4>Rating System</h4>
                                    <p>Rate expert answers to improve content quality and help other users.</p>
                                </div>
                                 multi category support 
                                <div class="feature-card">
                                    <span> <i class="fa-solid fa-screwdriver-wrench"></i></span>
                                    <h4> Multi-Category Support</h4>
                                    <p>Ask questions across various fields such as technology, health, business, education, and more.
                                    </p>
                                </div>
                                 dashboard 
                                <div class="feature-card">
                                    <span> <i class="fas fa-chart-bar"></i></span>
                                    <h4> User-Friendly Dashboard</h4>
                                    <p>Easily track your questions, responses, and expert interactions in one place.</p>
                                </div>
                                 profile management 
                                <div class="feature-card">
                                    <span> <i class="fa-solid fa-gear"></i></span>
                                    <h4>Personalized Profile Management</h4>
                                    <p>Edit your profile details, update preferences, and manage your account settings easily.</p>
                                </div>
                            </div>
                        </section>-->

            <!-- footer -->
            <footer id="contact">
                <div class="foot row">
                    <div class="col-sm-4 head">
                        <h4> Ask Expert – <br> Knowledge at Your Fingertips! </h4>
                    </div>
                    <div class="col-sm-4 link">
                        <h4>Quick Links</h4>
                        <a href="#home">
                            <p>Home</p>
                        </a>
                        <a href="#about">
                            <p>About</p>
                        </a>
                        <a href="#feature">
                            <p>Features</p>
                        </a>
                        <a href="#contact">
                            <p>Contact</p>
                        </a>

                    </div>
                    <div class="col-sm-4 contact">
                        <div class="touch">
                            <h4>Get in Touch </h4>
                            <p>Email : <a href="mailto:sample@gmail.com"></a>askexpert@gmail.com</p>
                            <p>Phone :+91 9876543210 </p>
                        </div>
                        <div class="follow">
                            <a href="#"><i class="fa-brands fa-instagram"></i></a>
                            <a href="#"><i class="fa-brands fa-linkedin-in"></i></a>
                            <a href="#"><i class="fa-brands fa-twitter"></i></a>
                        </div>
                    </div>

                </div>
            </footer>

        </div>
        <!-- Bootstrap cdn -->
        <!-- Latest compiled JavaScript -->

        <script>

            function toggleReadMore(answerId) {
                const answerElement = document.getElementById(answerId);
                const button = answerElement.nextElementSibling;

                if (answerElement.classList.contains('collapsed')) {
                    answerElement.classList.remove('collapsed');
                    button.textContent = 'Show less';
                } else {
                    answerElement.classList.add('collapsed');
                    button.textContent = 'Read more';
                }
            }

            function scrollContainer(direction) {
                const container = document.getElementById('forum-cards-container');
                const scrollAmount = direction === 'left' ? -400 : 400;
                container.scrollBy({left: scrollAmount, behavior: 'smooth'});
            }


            document.addEventListener("DOMContentLoaded", () => {
                // Fix for the experts marquee section that's blocking clicks
                const expertsMarquee = document.querySelector(".experts-marquee")

                if (expertsMarquee) {
                    // Add pointer-events: none to the animation container
                    // This allows clicks to pass through to elements underneath
                    expertsMarquee.style.pointerEvents = "none"

                    // But make the cards themselves clickable
                    const expertCards = document.querySelectorAll(".expert-card")
                    expertCards.forEach((card) => {
                        card.style.pointerEvents = "auto"
                    })
                }

                // Ensure all navigation links maintain their clickable state
                const navLinks = document.querySelectorAll("nav a")
                navLinks.forEach((link) => {
                    link.addEventListener("click", (e) => {
                        // Prevent any potential event capturing issues
                        e.stopPropagation()
                    })
                })

                // Fix for the forum cards section
                const forumCards = document.querySelector(".forum-cards")
                if (forumCards) {
                    // Ensure the scrolling container doesn't block clicks
                    forumCards.style.pointerEvents = "auto"
                }
            })

        </script>

    </body>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</html>