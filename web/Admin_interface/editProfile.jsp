<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Edit Profile Page</title>
        <script src="https://unpkg.com/feather-icons"></script>

        <style>
            body {
                font-family: 'Segoe UI', sans-serif;
                background-color: #f0f2f5;
                margin: 0;
                padding: 0;
            }

            .container {
                max-width: 1000px;
                margin: 40px auto;
                background: white;
                border-radius: 20px;
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
                padding: 40px;
                display: flex;
                gap: 30px;
            }

            .sidebar {
                flex: 1;
                text-align: center;
            }

            .sidebar img {
                width: 120px;
                height: 120px;
                border-radius: 50%;
                object-fit: cover;
            }

            .sidebar h2 {
                margin: 15px 0 5px;
            }

            .sidebar p {
                color: gray;
            }

            .form-section {
                flex: 3;
                display: grid;
                grid-template-columns: 1fr 1fr;
                gap: 20px;
            }

            .form-group {
                display: flex;
                flex-direction: column;
            }

            .form-group.full-width {
                grid-column: span 2;
            }

            .form-group label {
                font-weight: 600;
                margin-bottom: 6px;
            }

            .form-group input,
            .form-group select,
            .form-group textarea {
                padding: 10px;
                border: 1px solid #ccc;
                border-radius: 8px;
                font-size: 15px;
            }

            .gender-options {
                display: flex;
                gap: 20px;
                align-items: center;
            }

            .buttons {
                grid-column: span 2;
                display: flex;
                justify-content: flex-end;
                gap: 10px;
                margin-top: 20px;
            }

            .buttons button {
                padding: 10px 20px;
                font-size: 15px;
                border: none;
                border-radius: 8px;
                cursor: pointer;
            }

            .save-btn {
                background-color: #ff7b00;
                color: white;
            }

            .discard-btn {
                background-color: #f0f0f0;
                color: #333;
            }
        </style>
    </head>
    <body>
        <div class="main">

            <%@ include file="sidebar.jsp" %>
            <div class="main_right">
                <%@ include file="nav.jsp"%>
                <div class="container">
                    <div class="sidebar">
                        <img src="https://via.placeholder.com/120" alt="Profile Picture">
                        <label for="profileImage" class="upload-icon">
                            <i data-feather="upload"></i>
                        </label>
                        <h2>John Doe</h2>
                        <p>Software Engineer</p>
                    </div>

                    <form class="form-section" onsubmit="event.preventDefault(); saveForm();">
                        <div class="form-group">
                            <label for="name">Name</label>
                            <input type="text" id="name" required>
                        </div>

                        <div class="form-group">
                            <label for="email">Email</label>
                            <input type="email" id="email" required>
                        </div>

                        <div class="form-group">
                            <label for="phone">Phone</label>
                            <input type="tel" id="phone" pattern="\\(\\d{3}\\) \\d{3}-\\d{4}" placeholder="(123) 456-7890" required>
                        </div>

                        <div class="form-group">
                            <label for="password">Password</label>
                            <input type="password" id="password" required minlength="6">
                        </div>

                        <div class="form-group">
                            <label for="specialization">Specialization</label>
                            <input type="text" id="specialization">
                        </div>

                        <div class="form-group">
                            <label for="experience">Experience (Years)</label>
                            <input type="number" id="experience" min="0">
                        </div>

                        <div class="form-group">
                            <label for="expertise">Expertise Domain</label>
                            <input type="text" id="expertise">
                        </div>

                        <div class="form-group">
                            <label>Gender</label>
                            <div class="gender-options">
                                <label><input type="radio" name="gender" value="male" required> Male</label>
                                <label><input type="radio" name="gender" value="female"> Female</label>
                                <label><input type="radio" name="gender" value="other"> Other</label>
                            </div>
                        </div>

                        <div class="form-group full-width">
                            <label for="bio">Bio</label>
                            <textarea id="bio" rows="3"></textarea>
                        </div>

                        <div class="buttons">
                            <button class="discard-btn" type="reset">Discard Changes</button>
                            <button class="save-btn" type="submit">Save Changes</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script>
            function saveForm() {
                const genderEl = document.querySelector('input[name="gender"]:checked');
                const data = {
                    name: document.getElementById('name').value.trim(),
                    email: document.getElementById('email').value.trim(),
                    phone: document.getElementById('phone').value.trim(),
                    password: document.getElementById('password').value,
                    specialization: document.getElementById('specialization').value.trim(),
                    experience: document.getElementById('experience').value.trim(),
                    expertise: document.getElementById('expertise').value.trim(),
                    bio: document.getElementById('bio').value.trim(),
                    gender: genderEl ? genderEl.value : ''
                };

                if (!data.name || !data.email || !data.phone || !data.password || !data.gender) {
                    alert('Please fill out all required fields.');
                    return;
                }

                console.log('Saved Data:', data);
                alert('Profile information saved successfully!');
            }
        </script>
    </body>
</html>
