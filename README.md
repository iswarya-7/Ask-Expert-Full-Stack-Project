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





**📸 Output Screenshots**

**1) Home Page**
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/747a4cae-0fe8-4041-aa01-0ebcaeee7496" />


<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/c75d6ef1-6758-4af3-a673-626c8f66875a" />



**2) Registration**


 i) User Registration
 
  <img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/ddde8a98-0f37-41a6-9baa-6687d4131485" />



 ii) Specialist Registration
 
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/c930da8f-f448-4358-b1ac-e524bcbad9e5" />




**3) Login Page**

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/9c02eaf2-5102-4e4d-ad40-3c429b98ae33" />




**4) User Dashboard**

i) User Home page

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/b96c0e95-a55f-41af-bb90-c4687222ef82" />


ii)User Profile

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4a5d282c-9647-41cf-9ae3-33e4758d21f4" />


iii)Change Password

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/9657b8ec-f44b-414f-8cf8-6c4a8bbf7aca" />


iv)Experts Profile

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4a84bbca-613a-48c9-8a06-b3dc0ff11812" />


v) User Asked Questions

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/02636fed-00e9-4d7a-93a6-13bc6109f2ca" />


vi) Questions Responses

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/16f4c93b-f462-483b-b296-325f8312468a" />


vii) Ask a Question

First select the specialist profile then ask a question using the ask question button

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/ea6633b9-f842-416d-82bf-2ba03eda13d9" />


<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/db0b462d-a648-493d-b504-a5c85e107b1b" />



**5) Specialist Dashboard**


i)Specialist profile

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/2939fd53-ff97-4160-8a26-465c5d860d66" />


ii)Specialist Edit profile

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/568b94ef-9ef5-48cc-a772-d2ae739f968a" />


iii) Change password

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/c7156e80-8006-4328-9860-117c82054f5f" />


iv)Experts Profile (other domain Experts)

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/db611942-8e69-42a7-b3b6-7c9bdd9899d7" />


v)Questions to answer

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/68cf7859-ae44-4ff8-812a-ccc22afda351" />


vi) Answer box

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/37399a80-7b43-40af-9d9b-d7bdc9a62272" />


vii)Specialist answers page

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/a9c1ba7e-1fa2-43b7-82e2-a01c8f7910d6" />


viii)Specialist answers to questions

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/469b2e65-90ea-483c-b46e-02d0f7a09237" />


ix)Specialist asked questions

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/d1a1146a-85c4-4a83-8cd8-e1bf87f843ef" />


x)Answers for Specialist questions

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/4eb3096d-f7e2-43c0-b843-74376467b708" />



6) Admin Page
i)Admin home page

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/86bc0b0b-f9b9-430d-88a3-536ca93b19d6" />


ii)Admin Dashboard

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/0938bcc8-d090-406f-82f9-f90485bfe4f2" />


iii)Manage Specialist Request By Admin

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/f9d62445-2549-46fd-b298-d9e8e9894110" />


iv)Manage Specialist Details by Admin

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/73281b9c-1276-4824-b7b5-642b329f0e53" />


v)Manage users by Admin

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/62fe81d1-f7a9-4e94-bf7e-faae59ec9713" />


vi)Manage Questions and Answers by Admin

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/93f189e8-fa87-4dcd-a6bb-a7b47c7b8875" />
























































**🧑‍💻 Author**
```base
Iswarya A
📧 Email: iswaryaab4@gmail.com
🔗 GitHub Profile - https://github.com/iswarya-7
🔗 LinkedIn Profile - https://www.linkedin.com/in/iswarya28/
```

