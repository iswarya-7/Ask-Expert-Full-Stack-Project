<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<html>
    <head>
        <title>Test</title>
        <style>
            /* Sidebar Styles */
            .sidebar {
                width: 260px;
                height: 100%;
                background: linear-gradient(to bottom, #ff8c2f, #ff6a00);
                color: white;
                position: fixed;
                top: 60px;
                left: 0;
                bottom: 0;
                z-index: 900;
                overflow-y: auto;
                transition: all 0.3s ease;
                box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            }

            .sidebar-header {
                padding: 20px;
                border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            }

            .sidebar-logo {
                display: flex;
                align-items: center;
                gap: 10px;
                font-size: 18px;
                font-weight: 600;
            }

            .sidebar-logo i {
                font-size: 22px;
            }

            .sidebar-content {
                padding: 15px 0;
            }

            .sidebar-menu {
                list-style: none;
                padding: 0;
                margin: 0;
            }

            .sidebar-item {
                margin-bottom: 5px;
            }

            .sidebar-link {
                display: flex;
                align-items: center;
                padding: 12px 20px;
                color: white;
                text-decoration: none;
                transition: all 0.3s ease;
                border-radius: 0 30px 30px 0;
                margin-right: 15px;
                position: relative;
            }

            .sidebar-link:hover {
                background-color: rgba(255, 255, 255, 0.2);
            }

            .sidebar-link.active {
                background-color: white;
                color: #ff6a00;
                font-weight: 600;
            }

            .sidebar-link i {
                margin-right: 10px;
                font-size: 18px;
                width: 20px;
                text-align: center;
            }

            .sidebar-link span {
                flex: 1;
            }

            .dropdown-icon {
                font-size: 12px;
                transition: transform 0.3s ease;
            }

            .sidebar-link.open .dropdown-icon {
                transform: rotate(90deg);
            }

            .submenu {
                list-style: none;
                padding: 0;
                margin: 0;
                max-height: 0;
                overflow: hidden;
                transition: max-height 0.3s ease;
            }

            .submenu.open {
                max-height: 500px;
            }

            .submenu-link {
                display: flex;
                align-items: center;
                padding: 10px 20px 10px 50px;
                color: rgba(255, 255, 255, 0.9);
                text-decoration: none;
                transition: all 0.3s ease;
                font-size: 14px;
            }

            .submenu-link:hover {
                background-color: rgba(255, 255, 255, 0.1);
                color: white;
            }

            .submenu-link i {
                margin-right: 10px;
                font-size: 14px;
                width: 16px;
                text-align: center;
            }

            .sidebar-footer {
                padding: 15px 20px;
                border-top: 1px solid rgba(255, 255, 255, 0.1);
                position: absolute;
                bottom: 0;
                width: 100%;
                background: rgba(0, 0, 0, 0.1);
            }

            .sidebar-info {
                display: flex;
                align-items: center;
                gap: 10px;
                font-size: 12px;
                color: rgba(255, 255, 255, 0.7);
            }

            /* Responsive */
            @media (max-width: 768px) {
                .sidebar {
                    transform: translateX(-100%);
                }

                .sidebar.open {
                    transform: translateX(0);
                }

                .content-wrapper {
                    margin-left: 0 !important;
                }
            }
        </style>
    </head>
    <body>
        <div class="sidebar" id="sidebar">
            <div class="sidebar-header">
                <div class="sidebar-logo">
                    <i class="fas fa-lightbulb"></i>
                    <span>Categories</span>
                </div>
            </div>

            <div class="sidebar-content">
                <ul class="sidebar-menu">
                    <li class="sidebar-item">
                        <a href="${pageContext.request.contextPath}/user_interface/user_home.jsp" class="sidebar-link">
                            <i class="fas fa-home"></i>
                            <span>Home</span>
                        </a>
                    </li>

                    <li class="sidebar-item">
                        <a href="javascript:void(0)" class="sidebar-link has-dropdown" onclick="toggleSubmenu(this)">
                            <i class="fas fa-question-circle"></i>
                            <span>My Questions</span>
                            <i class="fas fa-chevron-right dropdown-icon"></i>
                        </a>
                        <ul class="submenu">
                            <li>
                                <a href="${pageContext.request.contextPath}/GetQuestionServlet?filter=all&userId=<%= session.getAttribute("userId")%>" class="submenu-link">
                                    <i class="fas fa-list"></i>
                                    <span>All Questions</span>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/GetQuestionServlet?filter=Pending&userId=<%= session.getAttribute("userId")%>" class="submenu-link">
                                    <i class="fas fa-clock"></i>
                                    <span>Pending</span>
                                </a>
                            </li>
                            <li>
                                <a href="${pageContext.request.contextPath}/GetQuestionServlet?filter=Answered&userId=<%= session.getAttribute("userId")%>" class="submenu-link">
                                    <i class="fas fa-check-circle"></i>
                                    <span>Answered</span>
                                </a>
                            </li>
                        </ul>
                    </li>

                    <li class="sidebar-item">
                        <a href="javascript:void(0)" class="sidebar-link has-dropdown" onclick="toggleSubmenu(this)">
                            <i class="fas fa-book"></i>
                            <span>Categories</span>
                            <i class="fas fa-chevron-right dropdown-icon"></i>
                        </a>
                        <ul class="submenu">
                            <%
                                // Get categories from servlet or hardcode for now
                                String[] categories = {"Technology", "Health", "Education", "Business", "Science", "Arts"};
                                for (String category : categories) {
                            %>
                            <li>
                                <a href="${pageContext.request.contextPath}/GetQuestionServlet?category=<%= category%>&userId=<%= session.getAttribute("userId")%>" class="submenu-link">
                                    <i class="fas fa-tag"></i>
                                    <span><%= category%></span>
                                </a>
                            </li>
                            <% }%>
                        </ul>
                    </li>

                    <li class="sidebar-item">
                        <a href="${pageContext.request.contextPath}/user_interface/ask_question.jsp" class="sidebar-link">
                            <i class="fas fa-plus-circle"></i>
                            <span>Ask Question</span>
                        </a>
                    </li>

                    <li class="sidebar-item">
                        <a href="${pageContext.request.contextPath}/user_interface/view_answers.jsp" class="sidebar-link">
                            <i class="fas fa-eye"></i>
                            <span>View Answers</span>
                        </a>
                    </li>

                    <li class="sidebar-item">
                        <a href="${pageContext.request.contextPath}/user_interface/profile.jsp" class="sidebar-link">
                            <i class="fas fa-user"></i>
                            <span>My Profile</span>
                        </a>
                    </li>
                </ul>
            </div>

            <div class="sidebar-footer">
                <div class="sidebar-info">
                    <i class="fas fa-info-circle"></i>
                    <span>Ask Expert v1.0</span>
                </div>
            </div>
        </div>



        <script>
            function toggleSubmenu(element) {
                // Toggle the 'open' class on the clicked sidebar link
                element.classList.toggle('open');

                // Find the submenu that follows the clicked link
                const submenu = element.nextElementSibling;
                submenu.classList.toggle('open');

                // Close other open submenus
                const allSubmenus = document.querySelectorAll('.submenu.open');
                const allDropdowns = document.querySelectorAll('.sidebar-link.has-dropdown.open');

                allSubmenus.forEach(menu => {
                    if (menu !== submenu && submenu.classList.contains('open')) {
                        menu.classList.remove('open');
                    }
                });

                allDropdowns.forEach(dropdown => {
                    if (dropdown !== element && submenu.classList.contains('open')) {
                        dropdown.classList.remove('open');
                    }
                });
            }

            // Set active link based on current page
            document.addEventListener('DOMContentLoaded', function () {
                const currentPath = window.location.pathname;
                const sidebarLinks = document.querySelectorAll('.sidebar-link, .submenu-link');

                sidebarLinks.forEach(link => {
                    const href = link.getAttribute('href');
                    if (href && currentPath.includes(href)) {
                        link.classList.add('active');

                        // If it's a submenu link, open the parent dropdown
                        if (link.classList.contains('submenu-link')) {
                            const submenu = link.closest('.submenu');
                            submenu.classList.add('open');
                            const parentLink = submenu.previousElementSibling;
                            parentLink.classList.add('open');
                        }
                    }
                });
            });
        </script>
    </body>
</html>