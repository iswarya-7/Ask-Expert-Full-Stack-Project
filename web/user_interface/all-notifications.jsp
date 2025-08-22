<%-- 
    Document   : all-notifications
    Created on : 14 May, 2025, 11:27:08 AM
    Author     : rohini
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
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
        <!-- Include your header JSP here -->
        <jsp:include page="header.jsp" />

        <div class="all-notifications-page">
            <div class="back-button">
                <a href="user_home.jsp">
                    <i class="fas fa-arrow-left"></i> All Notifications
                </a>
            </div>

            <div class="notification-tabs">
                <button class="tab-btn active" data-tab="all">All</button>
                <button class="tab-btn" data-tab="unread">Unread</button>
                <button class="tab-btn" data-tab="answer">Questions</button>
                <button class="tab-btn" data-tab="expert">Answers</button>
                <button class="tab-btn" data-tab="system">System</button>
            </div>

            <div class="full-notification-list">
                <%
                    // Get user ID from session
                    Integer userId = (Integer) session.getAttribute("userId");

                    if (userId != null) {
                        try {
                            Class.forName("com.mysql.jdbc.Driver");
                            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

                            // Get all notifications
                            PreparedStatement ps = conn.prepareStatement(
                                    "SELECT * FROM notifications WHERE user_id = ? ORDER BY created_at DESC"
                            );
                            ps.setInt(1, userId);
                            ResultSet rs = ps.executeQuery();

                            while (rs.next()) {
                                int notificationId = rs.getInt("id");
                                String type = rs.getString("type");
                                String title = rs.getString("title");
                                String message = rs.getString("message");
                                String timeAgo = rs.getString("time_ago"); // This would be calculated or stored
                                boolean isRead = rs.getBoolean("is_read");

                                String iconClass = "";
                                String iconName = "";

                                if (type.equals("answer")) {
                                    iconClass = "answer-icon";
                                    iconName = "check-circle";
                                } else if (type.equals("expert")) {
                                    iconClass = "expert-icon";
                                    iconName = "user-tie";
                                } else {
                                    iconClass = "system-icon";
                                    iconName = "info-circle";
                                }

                                String unreadClass = isRead ? "" : "unread";
                                String markButtonText = isRead ? "Mark as unread" : "Mark as read";
                                String markButtonClass = isRead ? "mark-unread-btn" : "mark-read-btn";
                %>
                <div class="full-notification-item <%= unreadClass%>" data-type="<%= type%>" data-id="<%= notificationId%>">
                    <div class="notification-icon <%= iconClass%>">
                        <i class="fas fa-<%= iconName%>"></i>
                    </div>
                    <div class="notification-content">
                        <h3><%= title%></h3>
                        <p><%= message%></p>
                        <p class="notification-time"><%= timeAgo%></p>
                        <div class="notification-actions">
                            <button class="<%= markButtonClass%>" onclick="toggleReadStatus(<%= notificationId%>, <%= isRead%>)">
                                <%= markButtonText%>
                            </button>
                            <button class="delete-btn" onclick="deleteNotification(<%= notificationId%>)">Delete</button>
                        </div>
                    </div>
                </div>
                <%
                            }

                            conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                %>
            </div>
        </div>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                // Tab functionality
                const tabButtons = document.querySelectorAll('.tab-btn');
                const notificationItems = document.querySelectorAll('.full-notification-item');

                tabButtons.forEach(button => {
                    button.addEventListener('click', function () {
                        // Remove active class from all buttons
                        tabButtons.forEach(btn => btn.classList.remove('active'));

                        // Add active class to clicked button
                        this.classList.add('active');

                        const tabType = this.getAttribute('data-tab');

                        // Show/hide notification items based on tab
                        notificationItems.forEach(item => {
                            if (tabType === 'all') {
                                item.style.display = 'flex';
                            } else if (tabType === 'unread' && item.classList.contains('unread')) {
                                item.style.display = 'flex';
                            } else if (tabType === item.getAttribute('data-type')) {
                                item.style.display = 'flex';
                            } else {
                                item.style.display = 'none';
                            }
                        });
                    });
                });
            });

            function toggleReadStatus(notificationId, isCurrentlyRead) {
                // Using fetch API to call a servlet that toggles read status
                fetch('toggleNotificationStatus?id=' + notificationId + '&isRead=' + !isCurrentlyRead, {
                    method: 'POST'
                })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                const notificationItem = document.querySelector(`.full-notification-item[data-id="${notificationId}"]`);
                                const button = notificationItem.querySelector('.mark-read-btn, .mark-unread-btn');

                                if (isCurrentlyRead) {
                                    // Mark as unread
                                    notificationItem.classList.add('unread');
                                    button.textContent = 'Mark as read';
                                    button.className = 'mark-read-btn';
                                } else {
                                    // Mark as read
                                    notificationItem.classList.remove('unread');
                                    button.textContent = 'Mark as unread';
                                    button.className = 'mark-unread-btn';
                                }
                            }
                        })
                        .catch(error => console.error('Error:', error));
            }

            function deleteNotification(notificationId) {
                // Using fetch API to call a servlet that deletes the notification
                fetch('deleteNotification?id=' + notificationId, {
                    method: 'POST'
                })
                        .then(response => response.json())
                        .then(data => {
                            if (data.success) {
                                const notificationItem = document.querySelector(`.full-notification-item[data-id="${notificationId}"]`);

                                // Animate removal
                                notificationItem.style.height = notificationItem.offsetHeight + 'px';
                                notificationItem.style.opacity = '1';

                                setTimeout(() => {
                                    notificationItem.style.height = '0';
                                    notificationItem.style.opacity = '0';
                                    notificationItem.style.padding = '0';
                                    notificationItem.style.margin = '0';
                                    notificationItem.style.overflow = 'hidden';
                                    notificationItem.style.transition = 'all 0.3s ease';
                                }, 10);

                                // Remove from DOM after animation
                                setTimeout(() => {
                                    notificationItem.remove();
                                }, 300);
                            }
                        })
                        .catch(error => console.error('Error:', error));
            }
        </script>
    </body>
</html>
