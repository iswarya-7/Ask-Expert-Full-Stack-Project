<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%
    // Get user ID from session
    Integer userId = (Integer) session.getAttribute("userId");
    
    // Fetch notifications from database
    int unreadCount = 0;
    String notificationsHtml = "";
    
    if (userId != null) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");
            
            // Get unread count
            PreparedStatement countPs = conn.prepareStatement(
                "SELECT COUNT(*) as count FROM notifications WHERE user_id = ? AND is_read = 0"
            );
            countPs.setInt(1, userId);
            ResultSet countRs = countPs.executeQuery();
            if (countRs.next()) {
                unreadCount = countRs.getInt("count");
            }
            
            // Get recent notifications
            PreparedStatement ps = conn.prepareStatement(
                "SELECT * FROM notifications WHERE user_id = ? ORDER BY created_at DESC LIMIT 5"
            );
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                String type = rs.getString("type");
                String message = rs.getString("message");
                String timeAgo = rs.getString("time_ago"); // This would be calculated or stored
                boolean isRead = rs.getBoolean("is_read");
                
                String iconClass = "";
                if (type.equals("answer")) {
                    iconClass = "answer-icon";
                } else if (type.equals("expert")) {
                    iconClass = "expert-icon";
                } else {
                    iconClass = "system-icon";
                }
                
                String unreadClass = isRead ? "" : "unread";
                
                notificationsHtml += 
                    "<div class='notification-item " + unreadClass + "'>" +
                    "    <div class='notification-icon " + iconClass + "'>" +
                    "        <i class='fas fa-" + (type.equals("answer") ? "check-circle" : 
                                                  type.equals("expert") ? "user-tie" : "info-circle") + "'></i>" +
                    "    </div>" +
                    "    <div class='notification-content'>" +
                    "        <p class='notification-title'>" + message + "</p>" +
                    "        <p class='notification-time'>" + timeAgo + "</p>" +
                    "    </div>" +
                    "</div>";
            }
            
            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
%>

<!-- Add this to your header.jsp or wherever your notification button is -->
<div class="notification-container">
    <button class="action-btn notification-btn" id="notificationBtn">
        <i class="fas fa-bell"></i>
        <% if (unreadCount > 0) { %>
            <span class="notification-badge"><%= unreadCount %></span>
        <% } %>
    </button>
    <div class="notification-dropdown" id="notificationDropdown">
        <div class="notification-header">
            <h3>Notifications</h3>
            <button class="mark-all-btn" onclick="markAllAsRead(<%= userId %>)">Mark all as read</button>
        </div>
        <div class="notification-list">
            <% if (notificationsHtml.isEmpty()) { %>
                <div class="empty-notifications">
                    <p>No notifications yet</p>
                </div>
            <% } else { %>
                <%= notificationsHtml %>
            <% } %>
        </div>
        <div class="notification-footer">
            <a href="all-notifications.jsp" class="view-all-btn">View all notifications</a>
        </div>
    </div>
</div>

<!-- Add this script to your page -->
<script>
    function markAllAsRead(userId) {
        // Using fetch API to call a servlet that marks all notifications as read
        fetch('markNotificationsRead?userId=' + userId, {
            method: 'POST'
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                // Remove unread class from all notifications
                document.querySelectorAll('.notification-item.unread').forEach(item => {
                    item.classList.remove('unread');
                });
                
                // Hide notification badge
                const badge = document.querySelector('.notification-badge');
                if (badge) {
                    badge.style.display = 'none';
                }
            }
        })
        .catch(error => console.error('Error:', error));
    }
</script>
