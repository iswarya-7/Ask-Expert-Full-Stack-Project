<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>View Answers - Ask Expert</title>
  <link rel="stylesheet" href="styles.css"> <!-- Optional external CSS -->
  <style>
    body {
      margin: 0;
      font-family: 'Segoe UI', sans-serif;
      background-color: #f4f4f4;
    }

    .container {
      padding: 30px;
      margin-left: 250px; /* leave space for sidebar */
    }

    h2 {
      color: #333;
      margin-bottom: 20px;
    }

    .answer-card {
      background-color: #fff;
      border-radius: 12px;
      box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
      padding: 20px;
      margin-bottom: 20px;
      transition: transform 0.2s ease;
    }

    .answer-card:hover {
      transform: translateY(-3px);
    }

    .question-title {
      font-size: 18px;
      color: #6a59d1;
      margin: 0;
    }

    .meta-info {
      font-size: 12px;
      color: #888;
      margin-bottom: 10px;
    }

    .answer {
      font-size: 15px;
      margin: 10px 0;
      color: #333;
    }

    .status {
      display: inline-block;
      padding: 5px 12px;
      font-size: 12px;
      border-radius: 20px;
      margin-top: 8px;
    }

    .answered {
      background-color: #e6ffe6;
      color: green;
    }

    .pending {
      background-color: #fff0cc;
      color: orange;
    }

    .btn-view {
      display: inline-block;
      margin-top: 10px;
      background-color: #6a59d1;
      color: white;
      padding: 8px 16px;
      border: none;
      border-radius: 20px;
      text-decoration: none;
      transition: background-color 0.2s ease;
    }

    .btn-view:hover {
      background-color: #5844c2;
    }

    @media screen and (max-width: 768px) {
      .container {
        margin-left: 0;
        padding: 15px;
      }
    }
  </style>
</head>
<body>

  <div class="container">
    <h2>Your Questions & Answers</h2>

    <!-- Repeat this block for each Q&A -->
    <div class="answer-card">
      <h3 class="question-title">How does Spring Boot work internally?</h3>
      <div class="meta-info">Asked on: 2025-04-25</div>

      <div class="answer">
        Spring Boot works by providing a convention-over-configuration framework...
      </div>

      <span class="status answered">? Answered</span>
      <a href="#" class="btn-view">View Full Answer</a>
    </div>

    <div class="answer-card">
      <h3 class="question-title">What is Dependency Injection in Java?</h3>
      <div class="meta-info">Asked on: 2025-04-26</div>

      <div class="answer">
        No answer yet.
      </div>

      <span class="status pending">? Pending</span>
    </div>
    <!-- End repeat -->

  </div>

</body>
</html>
