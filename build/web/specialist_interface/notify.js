/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


document.addEventListener("DOMContentLoaded", () => {
  // Notification dropdown functionality
  const notificationBtn = document.getElementById("notificationBtn")
  const notificationDropdown = document.getElementById("notificationDropdown")

  if (notificationBtn && notificationDropdown) {
    notificationBtn.addEventListener("click", (e) => {
      e.stopPropagation()
      notificationDropdown.classList.toggle("show")
    })

    // Close dropdown when clicking outside
    document.addEventListener("click", (e) => {
      if (
        notificationDropdown.classList.contains("show") &&
        !notificationDropdown.contains(e.target) &&
        e.target !== notificationBtn
      ) {
        notificationDropdown.classList.remove("show")
      }
    })
  }

  // Notification tabs functionality
  const tabButtons = document.querySelectorAll(".tab-btn")
  const notificationItems = document.querySelectorAll(".full-notification-item")

  if (tabButtons.length > 0) {
    tabButtons.forEach((button) => {
      button.addEventListener("click", function () {
        // Remove active class from all buttons
        tabButtons.forEach((btn) => btn.classList.remove("active"))

        // Add active class to clicked button
        this.classList.add("active")

        const tabType = this.getAttribute("data-tab")

        // Show/hide notification items based on tab
        notificationItems.forEach((item) => {
          if (tabType === "all") {
            item.style.display = "flex"
          } else if (tabType === "unread" && item.classList.contains("unread")) {
            item.style.display = "flex"
          } else if (tabType === item.getAttribute("data-type")) {
            item.style.display = "flex"
          } else {
            item.style.display = "none"
          }
        })
      })
    })
  }

  // Mark as read/unread functionality
  const markReadButtons = document.querySelectorAll(".mark-read-btn")
  const markUnreadButtons = document.querySelectorAll(".mark-unread-btn")
  const markAllButton = document.querySelector(".mark-all-btn")
  const deleteButtons = document.querySelectorAll(".delete-btn")

  if (markReadButtons.length > 0) {
    markReadButtons.forEach((button) => {
      button.addEventListener("click", function () {
        const notificationItem = this.closest(".full-notification-item")
        notificationItem.classList.remove("unread")
        this.textContent = "Mark as unread"
        this.className = "mark-unread-btn"
      })
    })
  }

  if (markUnreadButtons.length > 0) {
    markUnreadButtons.forEach((button) => {
      button.addEventListener("click", function () {
        const notificationItem = this.closest(".full-notification-item")
        notificationItem.classList.add("unread")
        this.textContent = "Mark as read"
        this.className = "mark-read-btn"
      })
    })
  }

  if (markAllButton) {
    markAllButton.addEventListener("click", () => {
      const unreadItems = document.querySelectorAll(".notification-item.unread")
      unreadItems.forEach((item) => {
        item.classList.remove("unread")
      })

      // Update notification badge
      const badge = document.querySelector(".notification-badge")
      if (badge) {
        badge.textContent = "0"
        badge.style.display = "none"
      }
    })
  }

  if (deleteButtons.length > 0) {
    deleteButtons.forEach((button) => {
      button.addEventListener("click", function () {
        const notificationItem = this.closest(".full-notification-item")
        notificationItem.style.height = notificationItem.offsetHeight + "px"
        notificationItem.style.opacity = "1"

        // Animate removal
        setTimeout(() => {
          notificationItem.style.height = "0"
          notificationItem.style.opacity = "0"
          notificationItem.style.padding = "0"
          notificationItem.style.margin = "0"
          notificationItem.style.overflow = "hidden"
          notificationItem.style.transition = "all 0.3s ease"
        }, 10)

        // Remove from DOM after animation
        setTimeout(() => {
          notificationItem.remove()
        }, 300)
      })
    })
  }
})
