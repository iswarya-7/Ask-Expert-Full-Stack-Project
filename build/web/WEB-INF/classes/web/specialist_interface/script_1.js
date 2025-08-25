document.addEventListener('DOMContentLoaded', function() {
    // Load default content (questions page)
    loadContent('questions.jsp');
    
    // Set active nav link
    const navLinks = document.querySelectorAll('.nav-link');
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            
            // Remove active class from all links
            navLinks.forEach(l => l.classList.toggle('active'));
            
            // Add active class to clicked link
            this.classList.add('active');
            
            // Load content
            const page = this.getAttribute('href');
            loadContent(page);
        });
    });
    
    // Add mobile menu toggle
    const body = document.querySelector('body');
    const mobileToggle = document.createElement('button');
    mobileToggle.classList.add('mobile-menu-toggle');
    mobileToggle.innerHTML = '<i class="fas fa-bars"></i>';
    body.appendChild(mobileToggle);
    
    mobileToggle.addEventListener('click', function() {
        const sidebar = document.querySelector('.sidebar');
        sidebar.classList.toggle('active');
        
        // Change icon based on sidebar state
        if (sidebar.classList.contains('active')) {
            this.innerHTML = '<i class="fas fa-times"></i>';
        } else {
            this.innerHTML = '<i class="fas fa-bars"></i>';
        }
    });
    
    // Add event listener for add button
    const addBtn = document.querySelector('.add-btn');
    if (addBtn) {
        addBtn.addEventListener('click', function() {
            showAddQuestionModal();
        });
    }
    
    // Initialize content-specific scripts
    initializeContentScripts();
});

// Function to load content via AJAX
function loadContent(page) {
    fetch(page)
        .then(response => response.text())
        .then(html => {
            document.getElementById('main-content').innerHTML = html;
            
            // Initialize content-specific scripts
            initializeContentScripts();
            
            // Update browser history
            history.pushState({page: page}, '', page);
        })
        .catch(error => {
            console.error('Error loading page:', error);
            document.getElementById('main-content').innerHTML = `
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i>
                    <h2>Error loading content</h2>
                    <p>Please try again later.</p>
                </div>
            `;
        });
}

// Function to initialize content-specific scripts
function initializeContentScripts() {
    // Filter buttons for questions page
    const filterBtns = document.querySelectorAll('.filter-btn');
    if (filterBtns.length > 0) {
        filterBtns.forEach(btn => {
            btn.addEventListener('click', function() {
                // Remove active class from all buttons
                filterBtns.forEach(b => b.classList.remove('active'));
                
                // Add active class to clicked button
                this.classList.add('active');
                
                // Filter questions
                const filter = this.getAttribute('data-filter');
                filterQuestions(filter);
            });
        });
    }
    
    // Question action buttons
    const questionActionBtns = document.querySelectorAll('.question-action-btn');
    if (questionActionBtns.length > 0) {
        questionActionBtns.forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.stopPropagation();
                
                // Show dropdown menu
                showQuestionActionMenu(this);
            });
        });
    }
    
    // Make question cards clickable
    const questionCards = document.querySelectorAll('.question-card');
    if (questionCards.length > 0) {
        questionCards.forEach(card => {
            card.addEventListener('click', function() {
                const questionTitle = this.querySelector('h3').textContent;
                const questionStatus = this.getAttribute('data-status');
                
                if (questionStatus === 'answered') {
                    // Navigate to view answer page
                    loadContent('view_answers.jsp');
                } else {
                    // Show question details
                    showQuestionDetails(this);
                }
            });
        });
    }
    
    // Answer action buttons
    const answerActionBtns = document.querySelectorAll('.answer-action-btn');
    if (answerActionBtns.length > 0) {
        answerActionBtns.forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.stopPropagation();
                
                if (this.classList.contains('like-btn')) {
                    // Handle like action
                    const likeCount = this.querySelector('span');
                    let count = parseInt(likeCount.textContent);
                    
                    if (this.classList.contains('liked')) {
                        this.classList.remove('liked');
                        count--;
                    } else {
                        this.classList.add('liked');
                        count++;
                    }
                    
                    likeCount.textContent = count;
                } else if (this.classList.contains('comment-btn')) {
                    // Show comment section
                    showCommentSection(this);
                } else if (this.classList.contains('share-btn')) {
                    // Show share options
                    showShareOptions(this);
                }
            });
        });
    }
}

// Function to filter questions
function filterQuestions(filter) {
    const questionCards = document.querySelectorAll('.question-card');
    
    questionCards.forEach(card => {
        const status = card.getAttribute('data-status');
        
        if (filter === 'all' || status === filter) {
            card.style.display = 'block';
        } else {
            card.style.display = 'none';
        }
    });
}

// Function to show question action menu
function showQuestionActionMenu(button) {
    // Create menu if it doesn't exist
    let menu = document.querySelector('.question-action-menu');
    
    if (menu) {
        menu.remove();
    }
    
    menu = document.createElement('div');
    menu.classList.add('question-action-menu');
    
    menu.innerHTML = `
        <ul>
            <li><i class="fas fa-edit"></i> Edit Question</li>
            <li><i class="fas fa-trash"></i> Delete Question</li>
            <li><i class="fas fa-share"></i> Share Question</li>
        </ul>
    `;
    
    // Position menu
    const rect = button.getBoundingClientRect();
    menu.style.position = 'absolute';
    menu.style.top = `${rect.bottom + window.scrollY}px`;
    menu.style.right = `${window.innerWidth - rect.right}px`;
    menu.style.zIndex = '1000';
    menu.style.backgroundColor = 'white';
    menu.style.boxShadow = '0 2px 5px rgba(0, 0, 0, 0.2)';
    menu.style.borderRadius = '4px';
    menu.style.overflow = 'hidden';
    
    menu.querySelector('ul').style.padding = '0';
    menu.querySelector('ul').style.margin = '0';
    
    const menuItems = menu.querySelectorAll('li');
    menuItems.forEach(item => {
        item.style.padding = '10px 15px';
        item.style.cursor = 'pointer';
        item.style.transition = 'background-color 0.2s ease';
        
        item.addEventListener('mouseover', function() {
            this.style.backgroundColor = '#f5f5f5';
        });
        
        item.addEventListener('mouseout', function() {
            this.style.backgroundColor = 'transparent';
        });
        
        item.addEventListener('click', function() {
            const action = this.textContent.trim();
            
            if (action.includes('Edit')) {
                console.log('Edit question');
                // Implement edit functionality
            } else if (action.includes('Delete')) {
                console.log('Delete question');
                // Implement delete functionality
            } else if (action.includes('Share')) {
                console.log('Share question');
                // Implement share functionality
            }
            
            menu.remove();
        });
    });
    
    document.body.appendChild(menu);
    
    // Close menu when clicking outside
    document.addEventListener('click', function closeMenu(e) {
        if (!menu.contains(e.target) && e.target !== button) {
            menu.remove();
            document.removeEventListener('click', closeMenu);
        }
    });
}

// Function to show question details
function showQuestionDetails(questionCard) {
    const title = questionCard.querySelector('h3').textContent;
    const content = questionCard.querySelector('p').textContent;
    const category = questionCard.querySelector('.question-category').textContent;
    const date = questionCard.querySelector('.question-date').textContent;
    
    // Create modal
    const modal = document.createElement('div');
    modal.classList.add('modal');
    
    modal.innerHTML = `
        <div class="modal-content">
            <div class="modal-header">
                <h2>${title}</h2>
                <button class="modal-close">&times;</button>
            </div>
            <div class="modal-body">
                <div class="question-info">
                    <span class="question-category">${category}</span>
                    <span class="question-date">${date}</span>
                </div>
                <p>${content}</p>
                <div class="question-status-info">
                    <p>Your question is currently pending. Our experts will answer it soon.</p>
                </div>
            </div>
        </div>
    `;
    
    // Style modal
    modal.style.position = 'fixed';
    modal.style.top = '0';
    modal.style.left = '0';
    modal.style.width = '100%';
    modal.style.height = '100%';
    modal.style.backgroundColor = 'rgba(0, 0, 0, 0.5)';
    modal.style.display = 'flex';
    modal.style.alignItems = 'center';
    modal.style.justifyContent = 'center';
    modal.style.zIndex = '2000';
    
    const modalContent = modal.querySelector('.modal-content');
    
    modalContent.style.backgroundColor = 'white';
    modalContent.style.borderRadius = '8px';
    modalContent.style.width = '90%';
    modalContent.style.maxWidth = '600px';
    modalContent.style.maxHeight = '80vh';
    modalContent.style.overflow = 'auto';
    
    const modalHeader = modal.querySelector('.modal-header');
    modalHeader.style.display = 'flex';
    modalHeader.style.justifyContent = 'space-between';
    modalHeader.style.alignItems = 'center';
    modalHeader.style.padding = '15px 20px';
    modalHeader.style.borderBottom = '1px solid #eee';
    
    const modalClose = modal.querySelector('.modal-close');
    modalClose.style.background = 'none';
    modalClose.style.border = 'none';
    modalClose.style.fontSize = '24px';
    modalClose.style.cursor = 'pointer';
    
    const modalBody = modal.querySelector('.modal-body');
    modalBody.style.padding = '20px';
    
    const questionInfo = modal.querySelector('.question-info');
    questionInfo.style.display = 'flex';
    questionInfo.style.justifyContent = 'space-between';
    questionInfo.style.marginBottom = '15px';
    
    const questionStatusInfo = modal.querySelector('.question-status-info');
    questionStatusInfo.style.marginTop = '20px';
    questionStatusInfo.style.padding = '15px';
    questionStatusInfo.style.backgroundColor = '#fff3e0';
    questionStatusInfo.style.borderRadius = '4px';
    questionStatusInfo.style.color = '#ff9800';
    
    document.body.appendChild(modal);
    
    // Close modal when clicking close button or outside
    modalClose.addEventListener('click', function() {
        modal.remove();
    });
    
    modal.addEventListener('click', function(e) {
        if (e.target === modal) {
            modal.remove();
        }
    });
}

// Function to show add question modal
function showAddQuestionModal() {
    // Create modal
    const modal = document.createElement('div');
    modal.classList.add('modal');
    
    modal.innerHTML = `
        <div class="modal-content">
            <div class="modal-header">
                <h2>Ask a Question</h2>
                <button class="modal-close">&times;</button>
            </div>
            <div class="modal-body">
                <form id="question-form">
                    <div class="form-group">
                        <label for="question-title">Title</label>
                        <input type="text" id="question-title" placeholder="Enter a clear, specific title for your question" required>
                    </div>
                    <div class="form-group">
                        <label for="question-category">Category</label>
                        <select id="question-category" required>
                            <option value="">Select a category</option>
                            <option value="Health">Health</option>
                            <option value="Technology">Technology</option>
                            <option value="Education">Education</option>
                            <option value="Finance">Finance</option>
                            <option value="Lifestyle">Lifestyle</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="question-details">Details</label>
                        <textarea id="question-details" rows="5" placeholder="Provide all the details needed for an expert to answer your question" required></textarea>
                    </div>
                    <div class="form-actions">
                        <button type="button" class="cancel-btn">Cancel</button>
                        <button type="submit" class="submit-btn">Submit Question</button>
                    </div>
                </form>
            </div>
        </div>
    `;
    
    // Style modal
    modal.style.position = 'fixed';
    modal.style.top = '0';
    modal.style.left = '0';
    modal.style.width = '100%';
    modal.style.height = '100%';
    modal.style.backgroundColor = 'rgba(0, 0, 0, 0.5)';
    modal.style.display = 'flex';
    modal.style.alignItems = 'center';
    modal.style.justifyContent = 'center';
    modal.style.zIndex = '2000';
    
    const modalContent = modal.querySelector('.modal-content');
    modalContent.style.backgroundColor = 'white';
    modalContent.style.borderRadius = '8px';
    modalContent.style.width = '90%';
    modalContent.style.maxWidth = '600px';
    modalContent.style.maxHeight = '80vh';
    modalContent.style.overflow = 'auto';
    
    const modalHeader = modal.querySelector('.modal-header');
    modalHeader.style.display = 'flex';
    modalHeader.style.justifyContent = 'space-between';
    modalHeader.style.alignItems = 'center';
    modalHeader.style.padding = '15px 20px';
    modalHeader.style.borderBottom = '1px solid #eee';
    
    const modalClose = modal.querySelector('.modal-close');
    modalClose.style.background = 'none';
    modalClose.style.border = 'none';
    modalClose.style.fontSize = '24px';
    modalClose.style.cursor = 'pointer';
    
    const modalBody = modal.querySelector('.modal-body');
    modalBody.style.padding = '20px';
    
    const form = modal.querySelector('form');
    form.style.display = 'flex';
    form.style.flexDirection = 'column';
    form.style.gap = '15px';
    
    const formGroups = modal.querySelectorAll('.form-group');
    formGroups.forEach(group => {
        group.style.display = 'flex';
        group.style.flexDirection = 'column';
        group.style.gap = '5px';
    });
    
    const labels = modal.querySelectorAll('label');
    labels.forEach(label => {
        label.style.fontWeight = '500';
    });
    
    const inputs = modal.querySelectorAll('input, select, textarea');
    inputs.forEach(input => {
        input.style.padding = '10px';
        input.style.borderRadius = '4px';
        input.style.border = '1px solid #ddd';
    });
    
    const formActions = modal.querySelector('.form-actions');
    formActions.style.display = 'flex';
    formActions.style.justifyContent = 'flex-end';
    formActions.style.gap = '10px';
    formActions.style.marginTop = '10px';
    
    const cancelBtn = modal.querySelector('.cancel-btn');
    cancelBtn.style.padding = '10px 15px';
    cancelBtn.style.borderRadius = '4px';
    cancelBtn.style.border = '1px solid #ddd';
    cancelBtn.style.backgroundColor = '#f5f5f5';
    cancelBtn.style.cursor = 'pointer';
    
    const submitBtn = modal.querySelector('.submit-btn');
    submitBtn.style.padding = '10px 15px';
    submitBtn.style.borderRadius = '4px';
    submitBtn.style.border = 'none';
    submitBtn.style.backgroundColor = '#FF7F00';
    submitBtn.style.color = 'white';
    submitBtn.style.cursor = 'pointer';
    
    document.body.appendChild(modal);
    
    // Close modal when clicking close button or cancel
    modalClose.addEventListener('click', function() {
        modal.remove();
    });
    
    cancelBtn.addEventListener('click', function() {
        modal.remove();
    });
    
    modal.addEventListener('click', function(e) {
        if (e.target === modal) {
            modal.remove();
        }
    });
    
    // Handle form submission
    form.addEventListener('submit', function(e) {
        e.preventDefault();
        
        const title = document.getElementById('question-title').value;
        const category = document.getElementById('question-category').value;
        const details = document.getElementById('question-details').value;
        
        // Here you would typically send the data to the server
        console.log('Question submitted:', { title, category, details });
        
        // Show success message
        modalBody.innerHTML = `
            <div class="success-message">
                <i class="fas fa-check-circle" style="font-size: 48px; color: #4caf50; margin-bottom: 15px;"></i>
                <h3>Question Submitted Successfully!</h3>
                <p>Our experts will review your question and provide an answer soon.</p>
                <button class="close-btn" style="margin-top: 20px; padding: 10px 15px; background-color: #FF7F00; color: white; border: none; border-radius: 4px; cursor: pointer;">Close</button>
            </div>
        `;
        
        const successMessage = modal.querySelector('.success-message');
        successMessage.style.display = 'flex';
        successMessage.style.flexDirection = 'column';
        successMessage.style.alignItems = 'center';
        successMessage.style.textAlign = 'center';
        successMessage.style.padding = '20px';
        
        const closeBtn = modal.querySelector('.close-btn');
        closeBtn.addEventListener('click', function() {
            modal.remove();
            
            // Reload questions page to show the new question
            loadContent('questions.jsp');
        });
    });
}

// Function to show comment section
function showCommentSection(button) {
    const answerCard = button.closest('.answer-card');
    
    // Check if comment section already exists
    let commentSection = answerCard.querySelector('.comment-section');
    
    if (commentSection) {
        // Toggle comment section
        commentSection.style.display = commentSection.style.display === 'none' ? 'block' : 'none';
        return;
    }
    
    // Create comment section
    commentSection = document.createElement('div');
    commentSection.classList.add('comment-section');
    
    commentSection.innerHTML = `
        <div class="comments">
            <div class="comment">
                <div class="comment-header">
                    <div class="user-info">
                        <img src="assets/user1.jpg" alt="User" class="user-avatar">
                        <div>
                            <h4>John Doe</h4>
                            <span class="comment-date">2 days ago</span>
                        </div>
                    </div>
                </div>
                <div class="comment-content">
                    <p>Thanks for the detailed answer! I'll try implementing these suggestions.</p>
                </div>
            </div>
            <div class="comment">
                <div class="comment-header">
                    <div class="user-info">
                        <img src="assets/user2.jpg" alt="User" class="user-avatar">
                        <div>
                            <h4>Jane Smith</h4>
                            <span class="comment-date">1 day ago</span>
                        </div>
                    </div>
                </div>
                <div class="comment-content">
                    <p>I found the CDN suggestion particularly helpful. My site is much faster now!</p>
                </div>
            </div>
        </div>
        <div class="add-comment">
            <textarea placeholder="Add a comment..."></textarea>
            <button class="post-comment-btn">Post</button>
        </div>
    `;
    
    // Style comment section
    commentSection.style.marginTop = '15px';
    commentSection.style.borderTop = '1px solid #eee';
    commentSection.style.paddingTop = '15px';
    
    const comments = commentSection.querySelector('.comments');
    comments.style.display = 'flex';
    comments.style.flexDirection = 'column';
    comments.style.gap = '15px';
    comments.style.marginBottom = '15px';
    
    const commentElements = commentSection.querySelectorAll('.comment');
    commentElements.forEach(comment => {
        comment.style.backgroundColor = '#f9f9f9';
        comment.style.borderRadius = '8px';
        comment.style.padding = '10px';
    });
    
    const commentHeaders = commentSection.querySelectorAll('.comment-header');
    commentHeaders.forEach(header => {
        header.style.marginBottom = '5px';
    });
    
    const userInfos = commentSection.querySelectorAll('.user-info');
    userInfos.forEach(info => {
        info.style.display = 'flex';
        info.style.alignItems = 'center';
        info.style.gap = '10px';
    });
    
    const userAvatars = commentSection.querySelectorAll('.user-avatar');
    userAvatars.forEach(avatar => {
        avatar.style.width = '30px';
        avatar.style.height = '30px';
        avatar.style.borderRadius = '50%';
        avatar.style.objectFit = 'cover';
    });
    
    const commentDates = commentSection.querySelectorAll('.comment-date');
    commentDates.forEach(date => {
        date.style.fontSize = '12px';
        date.style.color = '#888';
    });
    
    const addComment = commentSection.querySelector('.add-comment');
    addComment.style.display = 'flex';
    addComment.style.gap = '10px';
    
    const textarea = commentSection.querySelector('textarea');
    textarea.style.flex = '1';
    textarea.style.padding = '10px';
    textarea.style.borderRadius = '4px';
    textarea.style.border = '1px solid #ddd';
    textarea.style.resize = 'vertical';
    textarea.style.minHeight = '60px';
    
    const postBtn = commentSection.querySelector('.post-comment-btn');
    postBtn.style.padding = '10px 15px';
    postBtn.style.borderRadius = '4px';
    postBtn.style.border = 'none';
    postBtn.style.backgroundColor = '#FF7F00';
    postBtn.style.color = 'white';
    postBtn.style.cursor = 'pointer';
    
    // Append comment section to answer card
    const answerFooter = answerCard.querySelector('.answer-footer');
    answerFooter.parentNode.insertBefore(commentSection, answerFooter.nextSibling);
    
    // Handle post comment button
    postBtn.addEventListener('click', function() {
        const commentText = textarea.value.trim();
        
        if (commentText) {
            // Create new comment
            const newComment = document.createElement('div');
            newComment.classList.add('comment');
            
            newComment.innerHTML = `
                <div class="comment-header">
                    <div class="user-info">
                        <img src="assets/profile.jpg" alt="User" class="user-avatar">
                        <div>
                            <h4>You</h4>
                            <span class="comment-date">Just now</span>
                        </div>
                    </div>
                </div>
                <div class="comment-content">
                    <p>${commentText}</p>
                </div>
            `;
            
            // Style new comment
            newComment.style.backgroundColor = '#f9f9f9';
            newComment.style.borderRadius = '8px';
            newComment.style.padding = '10px';
            
            // Add new comment to comments
            comments.appendChild(newComment);
            
            // Clear textarea
            textarea.value = '';
        }
    });
}

// Function to show share options
function showShareOptions(button) {
    // Create share options
    const shareOptions = document.createElement('div');
    shareOptions.classList.add('share-options');
    
    shareOptions.innerHTML = `
        <div class="share-header">
            <h3>Share Answer</h3>
            <button class="share-close">&times;</button>
        </div>
        <div class="share-content">
            <div class="share-link">
                <input type="text" value="https://askexpert.com/answer/12345" readonly>
                <button class="copy-link-btn">Copy</button>
            </div>
            <div class="share-social">
                <button class="social-btn facebook"><i class="fab fa-facebook-f"></i> Facebook</button>
                <button class="social-btn twitter"><i class="fab fa-twitter"></i> Twitter</button>
                <button class="social-btn linkedin"><i class="fab fa-linkedin-in"></i> LinkedIn</button>
                <button class="social-btn whatsapp"><i class="fab fa-whatsapp"></i> WhatsApp</button>
            </div>
        </div>
    `;
    
    // Style share options
    shareOptions.style.position = 'fixed';
    shareOptions.style.top = '50%';
    shareOptions.style.left = '50%';
    shareOptions.style.transform = 'translate(-50%, -50%)';
    shareOptions.style.backgroundColor = 'white';
    shareOptions.style.borderRadius = '8px';
    shareOptions.style.boxShadow = '0 2px 10px rgba(0, 0, 0, 0.2)';
    shareOptions.style.width = '90%';
    shareOptions.style.maxWidth = '400px';
    shareOptions.style.zIndex = '2000';
    
    const shareHeader = shareOptions.querySelector('.share-header');
    shareHeader.style.display = 'flex';
    shareHeader.style.justifyContent = 'space-between';
    shareHeader.style.alignItems = 'center';
    shareHeader.style.padding = '15px 20px';
    shareHeader.style.borderBottom = '1px solid #eee';
    
    const shareClose = shareOptions.querySelector('.share-close');
    shareClose.style.background = 'none';
    shareClose.style.border = 'none';
    shareClose.style.fontSize = '24px';
    shareClose.style.cursor = 'pointer';
    
    const shareContent = shareOptions.querySelector('.share-content');
    shareContent.style.padding = '20px';
    
    const shareLink = shareOptions.querySelector('.share-link');
    shareLink.style.display = 'flex';
    shareLink.style.marginBottom = '20px';
    
    const linkInput = shareOptions.querySelector('input');
    linkInput.style.flex = '1';
    linkInput.style.padding = '10px';
    linkInput.style.borderRadius = '4px 0 0 4px';
    linkInput.style.border = '1px solid #ddd';
    linkInput.style.borderRight = 'none';
    
    const copyBtn = shareOptions.querySelector('.copy-link-btn');
    copyBtn.style.padding = '10px 15px';
    copyBtn.style.borderRadius = '0 4px 4px 0';
    copyBtn.style.border = '1px solid #ddd';
    copyBtn.style.backgroundColor = '#f5f5f5';
    copyBtn.style.cursor = 'pointer';
    
    const shareSocial = shareOptions.querySelector('.share-social');
    shareSocial.style.display = 'grid';
    shareSocial.style.gridTemplateColumns = 'repeat(2, 1fr)';
    shareSocial.style.gap = '10px';
    
    const socialBtns = shareOptions.querySelectorAll('.social-btn');
    socialBtns.forEach(btn => {
        btn.style.display = 'flex';
        btn.style.alignItems = 'center';
        btn.style.justifyContent = 'center';
        btn.style.gap = '5px';
        btn.style.padding = '10px';
        btn.style.borderRadius = '4px';
        btn.style.border = 'none';
        btn.style.color = 'white';
        btn.style.cursor = 'pointer';
    });
    
    const facebookBtn = shareOptions.querySelector('.facebook');
    facebookBtn.style.backgroundColor = '#3b5998';
    
    const twitterBtn = shareOptions.querySelector('.twitter');
    twitterBtn.style.backgroundColor = '#1da1f2';
    
    const linkedinBtn = shareOptions.querySelector('.linkedin');
    linkedinBtn.style.backgroundColor = '#0077b5';
    
    const whatsappBtn = shareOptions.querySelector('.whatsapp');
    whatsappBtn.style.backgroundColor = '#25d366';
    
    // Create overlay
    const overlay = document.createElement('div');
    overlay.classList.add('overlay');
    overlay.style.position = 'fixed';
    overlay.style.top = '0';
    overlay.style.left = '0';
    overlay.style.width = '100%';
    overlay.style.height = '100%';
    overlay.style.backgroundColor = 'rgba(0, 0, 0, 0.5)';
    overlay.style.zIndex = '1999';
    
    // Append to body
    document.body.appendChild(overlay);
    document.body.appendChild(shareOptions);
    
    // Handle close button
    shareClose.addEventListener('click', function() {
        shareOptions.remove();
        overlay.remove();
    });
    
    // Handle overlay click
    overlay.addEventListener('click', function() {
        shareOptions.remove();
        overlay.remove();
    });
    
    // Handle copy button
    copyBtn.addEventListener('click', function() {
        linkInput.select();
        document.execCommand('copy');
        
        // Show copied message
        const originalText = this.textContent;
        this.textContent = 'Copied!';
        this.style.backgroundColor = '#4caf50';
        this.style.color = 'white';
        
        setTimeout(() => {
            this.textContent = originalText;
            this.style.backgroundColor = '#f5f5f5';
            this.style.color = 'inherit';
        }, 2000);
    });
    
    // Handle social buttons
    socialBtns.forEach(btn => {
        btn.addEventListener('click', function() {
            const platform = this.classList[1];
            const url = linkInput.value;
            const text = 'Check out this answer on Ask Expert!';
            
            let shareUrl;
            
            switch (platform) {
                case 'facebook':
                    shareUrl = `https://www.facebook.com/sharer/sharer.php?u=${encodeURIComponent(url)}`;
                    break;
                case 'twitter':
                    shareUrl = `https://twitter.com/intent/tweet?url=${encodeURIComponent(url)}&text=${encodeURIComponent(text)}`;
                    break;
                case 'linkedin':
                    shareUrl = `https://www.linkedin.com/sharing/share-offsite/?url=${encodeURIComponent(url)}`;
                    break;
                case 'whatsapp':
                    shareUrl = `https://api.whatsapp.com/send?text=${encodeURIComponent(text + ' ' + url)}`;
                    break;
            }
            
            window.open(shareUrl, '_blank');
        });
    });
}