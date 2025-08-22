<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>All Notifications - AskExpert</title>
        <link rel="stylesheet" href="styles.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                    <div class="main-content">
                        <div class="all-notifications-page">
                            <div class="back-button">
                                <a href="user_home.jsp">
                                    <i class="fas fa-arrow-left"></i> All Notifications
                                </a>
                            </div>

                            <div class="notification-tabs">
                                <button class="tab-btn active" data-tab="all">All</button>
                                <button class="tab-btn" data-tab="unread">Unread</button>
                                <!--                                <button class="tab-btn" data-tab="questions">Questions</button>
                                                                <button class="tab-btn" data-tab="answers">Answers</button>-->
                                <button class="tab-btn" data-tab="system">System</button>
                            </div>

                            <div class="full-notification-list">
                                <div class="full-notification-item" data-type="answer">
                                    <div class="notification-icon answer-icon">
                                        <i class="fas fa-check-circle"></i>
                                    </div>
                                    <div class="notification-content">
                                        <h3>New Answer</h3>
                                        <p>Your question about JavaScript has been answered by Dr. Johnson</p>
                                        <p class="notification-time">7 minutes ago</p>
                                        <div class="notification-actions">
                                            <button class="mark-read-btn">Mark as read</button>
                                            <button class="delete-btn">Delete</button>
                                        </div>
                                    </div>
                                </div>

                                <div class="full-notification-item" data-type="expert">
                                    <div class="notification-icon expert-icon">
                                        <i class="fas fa-user-tie"></i>
                                    </div>
                                    <div class="notification-content">
                                        <h3>Expert Available</h3>
                                        <p>Dr. Smith is now available to answer your questions about Machine Learning</p>
                                        <p class="notification-time">1 hour ago</p>
                                        <div class="notification-actions">
                                            <button class="mark-read-btn">Mark as read</button>
                                            <button class="delete-btn">Delete</button>
                                        </div>
                                    </div>
                                </div>

                                <div class="full-notification-item" data-type="system">
                                    <div class="notification-icon system-icon">
                                        <i class="fas fa-info-circle"></i>
                                    </div>
                                    <div class="notification-content">
                                        <h3>Welcome to AskExpert</h3>
                                        <p>Welcome to AskExpert! Connect with worldwide experts to get answers to your questions.</p>
                                        <p class="notification-time">2 days ago</p>
                                        <div class="notification-actions">
                                            <button class="mark-unread-btn">Mark as unread</button>
                                            <button class="delete-btn">Delete</button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
        </div>

        <script src="notify.js"></script>
    </body>
</html>
