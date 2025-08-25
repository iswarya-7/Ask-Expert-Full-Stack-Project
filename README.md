# 🧑‍💻 Ask Expert – Full Stack Web Application
## 📌 Project Overview


Ask Expert is a full-stack web application where users can ask questions on various topics and experts can provide answers.
The platform bridges the gap between learners and specialists, providing an interactive Q&A system.

This project is built using Java, JSP, Servlets, MySQL, and XAMPP with a responsive HTML, CSS, and JavaScript frontend.

🚀 Features

User Registration & Login (with session handling)
Profile Management (view & update profile with image upload)
View Expert Profiles – Users can browse expert profiles with details about their expertise.
Ask Questions to Experts – After viewing an expert's profile, users can directly ask questions to that expert.
Ask Questions – Users can submit their queries
Expert Answers – Specialists can view and reply to questions
Filter & Search – Questions can be filtered by All, Pending, or Answered

| Technology                  | Purpose               |
| --------------------------- | --------------------- |
| **Java (JSP + Servlet)**    | Backend logic         |
| **MySQL**                   | Database              |
| **XAMPP**                   | MySQL & Tomcat Server |
| **HTML5, CSS3, JavaScript** | Frontend design       |
| **NetBeans IDE**            | Project development   |
| **JDBC**                    | Database connectivity |


**📂 Folder Structure**
```bash
Ask-Expert/
├── src/
│ ├── main/
│ │ ├── java/ # Servlets, Controllers, DAO classes
│ │ ├── webapp/ # JSP pages
│ │ ├── resources/ # Static assets (CSS, JS, images)
├── sql/
│ └── ask_expert.sql # Database schema & sample data
├── README.md # Project documentation
└── pom.xml / lib/ # Dependencies (if any)
```



**⚙️ Installation & Setup**

**Step 1 — Clone the Repository**
git clone https://github.com/your-username/Ask-Expert-Full-Stack-Project.git


**Step 2 — Import Project in NetBeans**
```bash
Open NetBeans IDE
Go to File → Open Project
Select the Ask Expert project folder
```

**Step 3 — Setup XAMPP**
```bash
Start XAMPP Control Panel
**Enable:**
Apache → For Tomcat server
MySQL → For database
```


**Step 4 — Configure Database**
```bash
Open phpMyAdmin → http://localhost:8080/phpmyadmin
Create a new **database** named:
**ask_expert**
Import the provided ask_expert.sql file from the sql/ folder.
```


**Step 5 — Update Database Credentials**
In your DBConnection.java (or wherever JDBC connection is configured), set:

```bash
String url = "jdbc:mysql://localhost:3306/ask_expert";
String username = "root";
String password = "";  // Default XAMPP password is empty
```


**Step 6 — Run the Project**
Right-click the project in NetBeans
Select Run
Open your browser and visit:
**http://localhost:8080/AskExpert/**

































**🧑‍💻 Author**
Iswarya A
📧 Email: iswaryaab4@gmail.com
🔗 GitHub Profile - https://github.com/iswarya-7
🔗 LinkedIn Profile - https://www.linkedin.com/in/iswarya28/


