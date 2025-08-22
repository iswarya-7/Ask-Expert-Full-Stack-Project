<!DOCTYPE html>
<html>
    <head>
        <style>
            /* Main container */
            .experts-showcase {
                width: 100%;
                background-color: #f8f8f8;
                padding: 60px 0 40px;
                position: relative;
                overflow: hidden;
                margin: 30px 50px;
            }

            /* Section title */
            .experts-title {
                text-align: center;
                margin-bottom: 40px;
                position: relative;
                z-index: 5;
            }

            .experts-title h2 {
                font-size: 32px;
                color: #333;
                margin-bottom: 15px;
                position: relative;
                display: inline-block;
            }

            .experts-title h2:after {
                content: "";
                position: absolute;
                width: 70px;
                height: 4px;
                background: #FF8C00;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                border-radius: 2px;
            }

            .experts-title p {
                max-width: 600px;
                margin: 0 auto;
                color: #666;
                font-size: 16px;
            }

            /* Marquee container */
            .experts-marquee-container {
                width: 100%;
                overflow: hidden;
                position: relative;
            }

            /* Animation keyframes - Starting with cards ALREADY visible */
            @keyframes marqueeAnimation {
                0% {
                    transform: translateX(0%); /* Start from beginning of the visible area */
                }
                100% {
                    transform: translateX(-50%); /* Only move half way to show the duplicate set */
                }
            }

            /* Scrolling content */
            .experts-marquee {
                display: flex;
                width: max-content;
                animation: marqueeAnimation 75s linear infinite; /* Slower animation for better readability */
                padding-left: 0; /* Start immediately with first card */
            }

            /* Expert card styling */
            .expert-card {
                min-width: 280px;
                height: 120px;
                margin: 0 15px;
                background: white;
                border-radius: 12px;
                padding: 15px;
                display: flex;
                flex-direction: column;
                justify-content: center;
                transition: all 0.3s ease;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
                position: relative;
                overflow: hidden;
                border-bottom: 4px solid transparent;
            }

            .expert-card:hover {
                transform: translateY(-8px);
                box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
                border-bottom: 4px solid #FF8C00;
            }



            .expert-card:hover:before {
                opacity: 1;
            }

            /* Icon for visual interest */
            .expert-icon {
                position: absolute;
                top: 20px;
                right: 20px;
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background: rgba(255, 140, 0, 0.1);
                display: flex;
                align-items: center;
                justify-content: center;
                color: #FF8C00;
                font-size: 18px;
                opacity: 0.7;
            }

            /* Expert information */
            .expert-name {
                font-size: 20px;
                font-weight: 700;
                margin-bottom: 8px;
                color: #333;
            }

            .expert-domain {
                font-size: 16px;
                color: #FF8C00;
                font-weight: 500;
                display: flex;
                align-items: center;
            }

            .expert-domain span {
                display: inline-block;
                padding: 4px 10px;
                background: rgba(255, 140, 0, 0.1);
                border-radius: 20px;
                font-size: 14px;
                margin-top: 5px;
            }

            /* Add gradient fade effect only at the right edge */
            .experts-marquee-container:after {
                content: "";
                position: absolute;
                right: 0;
                top: 0;
                width: 100px;
                height: 100%;
                z-index: 2;
                background: linear-gradient(to left, #f8f8f8, transparent);
            }

            /* For the icons */
            .expert-icon i {
                font-style: normal;
            }


            /* Base styles */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
                font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                background-color: #f8f9fa;
                color: #333;
                line-height: 1.6;
            }

            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 2rem 1rem;
            }

            /* Header styles */
            header {
                text-align: center;
                margin-bottom: 3rem;
            }

            header h1 {
                font-size: 2.5rem;
                color: #2d3748;
                margin-bottom: 0.5rem;
            }

            header p {
                color: #718096;
                max-width: 600px;
                margin: 0 auto;
            }

            h2 {
                font-size: 1.8rem;
                color: #2d3748;
                margin-bottom: 1.5rem;
                text-align: center;
            }

            /* Experts section */
            .experts-section {
                margin-bottom: 3rem;
                padding: 1.5rem;
                background-color: #fff;
                border-radius: 10px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            }

            .experts-container {
                display: flex;
                overflow-x: auto;
                gap: 1.5rem;
                padding: 1rem 0;
                scroll-behavior: smooth;
                animation: scroll 30s linear infinite;
                width: 100%;
            }

            @keyframes scroll {
                0% {
                    transform: translateX(0);
                }
                100% {
                    transform: translateX(-100%);
                }
            }

            .experts-container:hover {
                animation-play-state: paused;
            }

            .expert-card {
                flex: 0 0 auto;
                display: flex;
                align-items: center;
                gap: 1rem;
                padding: 1rem;
                background-color: #f7fafc;
                border-radius: 8px;
                min-width: 250px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .expert-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
            }

            .expert-avatar img {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                object-fit: cover;
                background-color: #e2e8f0;
            }

            .expert-info h3 {
                font-size: 1rem;
                margin-bottom: 0.25rem;
                color: #2d3748;
            }

            .expert-domain {
                display: inline-block;
                font-size: 0.75rem;
                padding: 0.25rem 0.5rem;
                background-color: #feebc8;
                color: #dd6b20;
                border-radius: 4px;
            }

            /* Forum section */
            .forum-section {
                position: relative;
            }

            .scroll-controls {
                display: flex;
                justify-content: center;
                gap: 1rem;
                margin-bottom: 1rem;
            }

            .scroll-btn {
                width: 40px;
                height: 40px;
                border-radius: 50%;
                background-color: #fff;
                border: 1px solid #e2e8f0;
                color: #4a5568;
                font-size: 1.25rem;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
                transition: all 0.2s ease;
            }

            .scroll-btn:hover {
                background-color: #f7fafc;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            }

            .forum-container {
                display: flex;
                gap: 1.5rem;
                overflow-x: auto;
                padding: 1rem 0;
                scroll-behavior: smooth;
                scrollbar-width: none; /* Firefox */
                -ms-overflow-style: none; /* IE and Edge */
            }

            .forum-container::-webkit-scrollbar {
                display: none; /* Chrome, Safari, Opera */
            }

            .forum-card {
                flex: 0 0 auto;
                width: 350px;
                background-color: #fff;
                border-radius: 10px;
                padding: 1.5rem;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
                transition: transform 0.3s ease, box-shadow 0.3s ease;
            }

            .forum-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 15px rgba(0, 0, 0, 0.1);
            }

            .question-header {
                display: flex;
                justify-content: space-between;
                align-items: flex-start;
                margin-bottom: 1rem;
                gap: 1rem;
            }

            .question-header h3 {
                font-size: 1.1rem;
                color: #2d3748;
                flex: 1;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .category {
                font-size: 0.75rem;
                padding: 0.25rem 0.5rem;
                background-color: #feebc8;
                color: #dd6b20;
                border-radius: 4px;
                white-space: nowrap;
            }

            .expert-details {
                display: flex;
                align-items: center;
                gap: 0.75rem;
                margin-bottom: 1rem;
                padding-bottom: 1rem;
                border-bottom: 1px solid #e2e8f0;
            }

            .expert-avatar-small img {
                width: 30px;
                height: 30px;
                border-radius: 50%;
                object-fit: cover;
                background-color: #e2e8f0;
            }

            .expert-name p {
                font-size: 0.9rem;
                font-weight: 600;
                color: #2d3748;
                margin-bottom: 0.1rem;
            }

            .expert-title {
                font-size: 0.75rem;
                color: #718096;
            }

            .answer {
                position: relative;
            }

            .answer-text {
                font-size: 0.9rem;
                color: #4a5568;
                display: -webkit-box;
                -webkit-line-clamp: 3;
                -webkit-box-orient: vertical;
                overflow: hidden;
                line-height: 1.5;
            }

            .full-answer {
                display: none;
                font-size: 0.9rem;
                color: #4a5568;
                line-height: 1.5;
                margin-bottom: 1rem;
            }

            .read-more-btn {
                display: inline-block;
                margin-top: 0.75rem;
                background: none;
                border: none;
                color: #dd6b20;
                font-size: 0.85rem;
                font-weight: 600;
                cursor: pointer;
                padding: 0.25rem 0;
                transition: color 0.2s ease;
            }

            .read-more-btn:hover {
                color: #c05621;
                text-decoration: underline;
            }

            /* Responsive styles */
            @media (max-width: 768px) {
                .container {
                    padding: 1rem;
                }

                header h1 {
                    font-size: 2rem;
                }

                .forum-card {
                    width: 300px;
                }
            }

            @media (max-width: 480px) {
                header h1 {
                    font-size: 1.75rem;
                }

                .forum-card {
                    width: 280px;
                }
            }

        </style>
    </head>
    <body>
        <div class="experts-showcase">
            <div class="experts-title">
                <h2>Meet Our Experts</h2>
                <p>Connect with professionals across various domains ready to answer your questions</p>
            </div>

            <div class="experts-marquee-container">
                <div class="experts-marquee">
                    <!-- Original cards -->
                    <div class="expert-card">
                        <!--<div class="expert-icon"><i>???</i></div>-->
                        <div class="expert-name">Sarah Johnson</div>
                        <div class="expert-domain"><span>Web Development</span></div>
                    </div>

                    <div class="expert-card">
                        <!--<div class="expert-icon"><i>??</i></div>-->
                        <div class="expert-name">David Chen</div>
                        <div class="expert-domain"><span>Software Solution</span></div>
                    </div>

                    <div class="expert-card">
                        <!--<div class="expert-icon"><i>?</i></div>-->
                        <div class="expert-name">Jessica Miller</div>
                        <div class="expert-domain"><span>Enterprise Apps</span></div>
                    </div>

                    <div class="expert-card">
                        <!--<div class="expert-icon"><i>??</i></div>-->
                        <div class="expert-name">Michael Taylor</div>
                        <div class="expert-domain"><span>DevOps Services</span></div>
                    </div>

                    <div class="expert-card">
                        <!--<div class="expert-icon"><i>?</i></div>-->
                        <div class="expert-name">Emma Wilson</div>
                        <div class="expert-domain"><span>Custom Web Apps</span></div>
                    </div>

                    <div class="expert-card">
                        <!--<div class="expert-icon"><i>?</i></div>-->
                        <div class="expert-name">Robert Garcia</div>
                        <div class="expert-domain"><span>UI/UX Design</span></div>
                    </div>

                    <div class="expert-card">
                        <!--<div class="expert-icon"><i>?</i></div>-->
                        <div class="expert-name">Amanda Lee</div>
                        <div class="expert-domain"><span>Data Analysis</span></div>
                    </div>

                    <div class="expert-card">
                        <!--<div class="expert-icon"><i>??</i></div>-->
                        <div class="expert-name">Thomas Wright</div>
                        <div class="expert-domain"><span>Cloud Solutions</span></div>
                    </div>

                    <!-- Duplicate cards for continuous scrolling -->
                    <div class="expert-card">
                        <!--<div class="expert-icon"><i>???</i></div>-->
                        <div class="expert-name">Sarah Johnson</div>
                        <div class="expert-domain"><span>Web Development</span></div>
                    </div>

                    <div class="expert-card">
                        <!--<div class="expert-icon"><i>??</i></div>-->
                        <div class="expert-name">David Chen</div>
                        <div class="expert-domain"><span>Software Solution</span></div>
                    </div>

                    <div class="expert-card">
                        <!--<div class="expert-icon"><i>?</i></div>-->
                        <div class="expert-name">Jessica Miller</div>
                        <div class="expert-domain"><span>Enterprise Apps</span></div>
                    </div>

                    <div class="expert-card">
                        <!--<div class="expert-icon"><i>??</i></div>-->
                        <div class="expert-name">Michael Taylor</div>
                        <div class="expert-domain"><span>DevOps Services</span></div>
                    </div>

                    <div class="expert-card">
                        <!--<div class="expert-icon"><i>?</i></div>-->
                        <div class="expert-name">Emma Wilson</div>
                        <div class="expert-domain"><span>Custom Web Apps</span></div>
                    </div>

                    <div class="expert-card">
                        <!--<div class="expert-icon"><i>?</i></div>-->
                        <div class="expert-name">Robert Garcia</div>
                        <div class="expert-domain"><span>UI/UX Design</span></div>
                    </div>
                </div>
            </div>
        </div>

            <div class="container">
                <header>
                    <h1>Expert Forum</h1>
                    <p>Browse questions answered by our community of experts across various domains</p>
                </header>

                <div class="experts-section">
                    <h2>Our Experts</h2>
                    <div class="experts-container">
                        <div class="expert-card">
                            <div class="expert-avatar">
                                <img src="/placeholder.svg?height=50&width=50" alt="Expert Avatar">
                            </div>
                            <div class="expert-info">
                                <h3>Jessica Miller</h3>
                                <span class="expert-domain">Web Development</span>
                            </div>
                        </div>

                        <div class="expert-card">
                            <div class="expert-avatar">
                                <img src="/placeholder.svg?height=50&width=50" alt="Expert Avatar">
                            </div>
                            <div class="expert-info">
                                <h3>Michael Taylor</h3>
                                <span class="expert-domain">DevOps Services</span>
                            </div>
                        </div>

                        <div class="expert-card">
                            <div class="expert-avatar">
                                <img src="/placeholder.svg?height=50&width=50" alt="Expert Avatar">
                            </div>
                            <div class="expert-info">
                                <h3>Emma Wilson</h3>
                                <span class="expert-domain">UI/UX Design</span>
                            </div>
                        </div>

                        <div class="expert-card">
                            <div class="expert-avatar">
                                <img src="/placeholder.svg?height=50&width=50" alt="Expert Avatar">
                            </div>
                            <div class="expert-info">
                                <h3>Robert Garcia</h3>
                                <span class="expert-domain">Database Architecture</span>
                            </div>
                        </div>

                        <div class="expert-card">
                            <div class="expert-avatar">
                                <img src="/placeholder.svg?height=50&width=50" alt="Expert Avatar">
                            </div>
                            <div class="expert-info">
                                <h3>Sophia Chen</h3>
                                <span class="expert-domain">Machine Learning</span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="forum-section">
                    <h2>Recent Questions</h2>

                    <div class="scroll-controls">
                        <button id="scroll-left" class="scroll-btn">&lt;</button>
                        <button id="scroll-right" class="scroll-btn">&gt;</button>
                    </div>

                    <div class="forum-container" id="forum-container">
                        <div class="forum-card">
                            <div class="question-header">
                                <h3>What are the best practices for optimizing React application performance?</h3>
                                <span class="category">Web Development</span>
                            </div>
                            <div class="expert-details">
                                <div class="expert-avatar-small">
                                    <img src="/placeholder.svg?height=30&width=30" alt="Expert Avatar">
                                </div>
                                <div class="expert-name">
                                    <p>Jessica Miller</p>
                                    <span class="expert-title">Senior Frontend Developer</span>
                                </div>
                            </div>
                            <div class="answer">
                                <p class="answer-text" id="answer-text-1">To optimize React performance, you should: 1) Use React.memo for component memoization to prevent unnecessary re-renders. 2) Implement proper key usage in lists to help React identify which items have changed.</p>
                                <div class="full-answer" id="full-answer-1">
                                    <p>To optimize React performance, you should: 1) Use React.memo for component memoization to prevent unnecessary re-renders. 2) Implement proper key usage in lists to help React identify which items have changed. 3) Lazy load components and code-splitting to reduce initial load time. 4) Use the useCallback hook for memoizing functions. 5) Implement virtualization for long lists with libraries like react-window. 6) Avoid inline function definitions in render methods. 7) Use the Chrome Performance tab and React DevTools Profiler to identify bottlenecks. 8) Consider using state management solutions like Redux or Context API efficiently.</p>
                                </div>
                                <button class="read-more-btn" onclick="toggleAnswer(1)">Read more</button>
                            </div>
                        </div>

                        <div class="forum-card">
                            <div class="question-header">
                                <h3>How can I implement secure authentication in a Node.js application?</h3>
                                <span class="category">Backend Development</span>
                            </div>
                            <div class="expert-details">
                                <div class="expert-avatar-small">
                                    <img src="/placeholder.svg?height=30&width=30" alt="Expert Avatar">
                                </div>
                                <div class="expert-name">
                                    <p>Michael Taylor</p>
                                    <span class="expert-title">DevOps Engineer</span>
                                </div>
                            </div>
                            <div class="answer">
                                <p class="answer-text" id="answer-text-2">For secure authentication in Node.js, I recommend: 1) Use battle-tested libraries like Passport.js or Auth0 rather than building your own. 2) Always hash passwords using bcrypt or Argon2 with proper salt rounds.</p>
                                <div class="full-answer" id="full-answer-2">
                                    <p>For secure authentication in Node.js, I recommend: 1) Use battle-tested libraries like Passport.js or Auth0 rather than building your own. 2) Always hash passwords using bcrypt or Argon2 with proper salt rounds. 3) Implement JWT (JSON Web Tokens) for stateless authentication but be mindful of their security implications. 4) Set secure and httpOnly flags on cookies. 5) Implement CSRF protection. 6) Use HTTPS exclusively in production. 7) Add rate limiting to prevent brute force attacks. 8) Implement proper session management with secure session storage.</p>
                                </div>
                                <button class="read-more-btn" onclick="toggleAnswer(2)">Read more</button>
                            </div>
                        </div>

                        <div class="forum-card">
                            <div class="question-header">
                                <h3>What's the best approach for responsive design in 2023?</h3>
                                <span class="category">UI/UX Design</span>
                            </div>
                            <div class="expert-details">
                                <div class="expert-avatar-small">
                                    <img src="/placeholder.svg?height=30&width=30" alt="Expert Avatar">
                                </div>
                                <div class="expert-name">
                                    <p>Emma Wilson</p>
                                    <span class="expert-title">UX Designer</span>
                                </div>
                            </div>
                            <div class="answer">
                                <p class="answer-text" id="answer-text-3">The best approach for responsive design in 2023 includes: 1) Mobile-first design philosophy is still relevant and important. 2) Use modern CSS features like Grid, Flexbox, and Container Queries instead of just media queries.</p>
                                <div class="full-answer" id="full-answer-3">
                                    <p>The best approach for responsive design in 2023 includes: 1) Mobile-first design philosophy is still relevant and important. 2) Use modern CSS features like Grid, Flexbox, and Container Queries instead of just media queries. 3) Implement fluid typography with clamp() for responsive text without breakpoints. 4) Consider designing for foldable devices and unusual screen ratios. 5) Use relative units (rem, em, %) rather than fixed pixels. 6) Test on real devices, not just browser emulators. 7) Consider accessibility across all device sizes. 8) Optimize images with srcset and modern formats like WebP and AVIF.</p>
                                </div>
                                <button class="read-more-btn" onclick="toggleAnswer(3)">Read more</button>
                            </div>
                        </div>

                        <div class="forum-card">
                            <div class="question-header">
                                <h3>How do I implement CI/CD pipelines for a microservices architecture?</h3>
                                <span class="category">DevOps</span>
                            </div>
                            <div class="expert-details">
                                <div class="expert-avatar-small">
                                    <img src="/placeholder.svg?height=30&width=30" alt="Expert Avatar">
                                </div>
                                <div class="expert-name">
                                    <p>Robert Garcia</p>
                                    <span class="expert-title">DevOps Architect</span>
                                </div>
                            </div>
                            <div class="answer">
                                <p class="answer-text" id="answer-text-4">For CI/CD in microservices: 1) Use containerization with Docker for consistent environments. 2) Implement infrastructure as code using Terraform or CloudFormation.</p>
                                <div class="full-answer" id="full-answer-4">
                                    <p>For CI/CD in microservices: 1) Use containerization with Docker for consistent environments. 2) Implement infrastructure as code using Terraform or CloudFormation. 3) Set up separate pipelines for each microservice to enable independent deployment. 4) Use a container orchestration platform like Kubernetes for deployment. 5) Implement automated testing at multiple levels (unit, integration, end-to-end). 6) Set up centralized logging and monitoring with tools like ELK stack or Prometheus/Grafana. 7) Use feature flags to safely deploy new features. 8) Implement blue/green or canary deployment strategies to minimize risk.</p>
                                </div>
                                <button class="read-more-btn" onclick="toggleAnswer(4)">Read more</button>
                            </div>
                        </div>

                        <div class="forum-card">
                            <div class="question-header">
                                <h3>What are the key considerations when designing a database schema for scalability?</h3>
                                <span class="category">Database Design</span>
                            </div>
                            <div class="expert-details">
                                <div class="expert-avatar-small">
                                    <img src="/placeholder.svg?height=30&width=30" alt="Expert Avatar">
                                </div>
                                <div class="expert-name">
                                    <p>Sophia Chen</p>
                                    <span class="expert-title">Database Architect</span>
                                </div>
                            </div>
                            <div class="answer">
                                <p class="answer-text" id="answer-text-5">When designing for scalability: 1) Properly normalize data to reduce redundancy, but know when to denormalize for performance. 2) Choose appropriate primary keys and create necessary indexes, but be careful of over-indexing.</p>
                                <div class="full-answer" id="full-answer-5">
                                    <p>When designing for scalability: 1) Properly normalize data to reduce redundancy, but know when to denormalize for performance. 2) Choose appropriate primary keys and create necessary indexes, but be careful of over-indexing. 3) Consider partitioning strategies for large tables. 4) Plan for horizontal scaling from the beginning if you expect significant growth. 5) Implement caching strategies at various levels. 6) Consider read/write splitting for read-heavy applications. 7) Design with eventual consistency in mind for distributed systems. 8) Plan for data archiving strategies for historical data.</p>
                                </div>
                                <button class="read-more-btn" onclick="toggleAnswer(5)">Read more</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <script>
                
                // Function to toggle the answer visibility
function toggleAnswer(id) {
  const answerText = document.getElementById(`answer-text-${id}`)
  const fullAnswer = document.getElementById(`full-answer-${id}`)
  const button = answerText.nextElementSibling.nextElementSibling

  if (fullAnswer.style.display === "block") {
    fullAnswer.style.display = "none"
    answerText.style.display = "block"
    button.textContent = "Read more"
  } else {
    fullAnswer.style.display = "block"
    answerText.style.display = "none"
    button.textContent = "Show less"
  }
}

// Horizontal scrolling for forum cards
document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("forum-container")
  const scrollLeftBtn = document.getElementById("scroll-left")
  const scrollRightBtn = document.getElementById("scroll-right")

  // Calculate scroll amount based on card width + gap
  const scrollAmount = 370 // card width (350px) + gap (20px)

  scrollLeftBtn.addEventListener("click", () => {
    container.scrollBy({
      left: -scrollAmount,
      behavior: "smooth",
    })
  })

  scrollRightBtn.addEventListener("click", () => {
    container.scrollBy({
      left: scrollAmount,
      behavior: "smooth",
    })
  })

  // Stop marquee animation when hovering over experts
  const expertsContainer = document.querySelector(".experts-container")

  expertsContainer.addEventListener("mouseenter", function () {
    this.style.animationPlayState = "paused"
  })

  expertsContainer.addEventListener("mouseleave", function () {
    this.style.animationPlayState = "running"
  })
})

            </script>

            <!--    <script src="script.js"></script>-->
        </body>
    </html>
