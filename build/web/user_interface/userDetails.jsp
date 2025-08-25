<%-- 
    Document   : registerDetails
    Created on : 17 Apr, 2025, 4:10:44 PM
    Author     : rohini
--%>

<%@page import="java.nio.file.Paths"%>
<%@page import="java.io.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat, java.util.Date, java.sql.*, javax.servlet.http.Part" %>
<%@ page import="javax.servlet.annotation.MultipartConfig" %>
<%@ page import="javax.servlet.annotation.WebServlet" %>

<%-- Add MultipartConfig annotation --%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Details</title>
    </head>
    <body>
        <%
            String fname = request.getParameter("full_name");
            String gen = request.getParameter("gender");
            String db = request.getParameter("dob");
            String mail = request.getParameter("email");
            String phone = request.getParameter("phone_no");
//            String profile = request.getParameter("profile_photo");
            String password = request.getParameter("pass");
            String cPassword = request.getParameter("cpass");

            String UPLOAD_DIRECTORY = "uploads"; // Folder name
            // Get the upload folder path
            String uploadPath = getServletContext().getRealPath("/") + UPLOAD_DIRECTORY;

            // Create the directory if it doesn't exist
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            Part filePart = request.getPart("profile_photo"); // Get the file
            String fileName = "";
            if (filePart != null && filePart.getSubmittedFileName() != null) {
                fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            }
//            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); // File Name

            if (!fileName.isEmpty()) {
                String filePath = uploadPath + File.separator + fileName;
                filePart.write(filePath); // Save file

                // Display success message
                response.setContentType("text/html");
            }
//            for uploading image
//            String uploadPath = getServletContext().getRealPath("/") + "uploads";
//            File uploadDir = new File(uploadPath);
//            if (!uploadDir.exists()) {
//                uploadDir.mkdir();
//            }
//            // Handle file upload
//            //get the image folder
//            Part imagePart = request.getPart("profile_photo");
//            String fileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
//
////            String imagePath = "uploads/" + fileName;
//            if (fileName != null && !fileName.isEmpty()) {
//                try (InputStream input = imagePart.getInputStream();
//                        FileOutputStream output = new FileOutputStream(uploadPath + File.separator + fileName)) {
//                    byte[] buffer = new byte[1024];
//                    int bytesRead;
//                    while ((bytesRead = input.read(buffer)) != -1) {
//                        output.write(buffer, 0, bytesRead);
//                    }
//                }
//            }
// Dob [convert 'yyyy-mm-dd' to 'dd-mm-yyyy']
            String formattedDob = "";

            try {
//    convert it to 'dd-mm-yyyy'
                SimpleDateFormat fromFormat = new SimpleDateFormat("yyyy-MM-dd");
                SimpleDateFormat toFormat = new SimpleDateFormat("dd-MM-yyyy");

//     change string into date obj           
                Date date = fromFormat.parse(db);
                formattedDob = toFormat.format(date);

            } catch (Exception e) {
                out.println("Error: " + e);
            }

            //  String submitbtn = request.getParameter("submit");
            Connection con = null;
            PreparedStatement pst = null;

            // Step 2: Load JDBC driver and connect to DB
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/askexpert", "root", "");

            try {
                // Step 3: Insert query
                String query = "INSERT INTO user_regdetails1(full_name, gender, dob, email, mobile,profile_photo,password,cpassword) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                pst = con.prepareStatement(query);
                pst.setString(1, fname);
                pst.setString(2, gen);
                pst.setString(3, formattedDob);
                pst.setString(4, mail);
                pst.setString(5, phone);
                pst.setString(6, fileName);
                pst.setString(7, password);
                pst.setString(8, cPassword);

                int result = pst.executeUpdate();
                System.out.println("Insert result: " + result); // Should be 1

                if (result > 0) {
//                        out.println("<script type='text/javascript'>");
//                        out.println("window.location = '/user_interface/user_login.jsp'>;");
//                        out.println("</script>");
//                        out.println("Registered Successfully! <a href='" + request.getContextPath() + "/user_interface/user_login.jsp'>Login</a>");

                    out.println("<script type=\"text/javascript\">");
                    out.println("alert('User Profile Created Successfully !!  Please login.');");
                    out.println("location='user_interface/user_login.jsp?message=success';");
                    out.println("</script>");
//             sendRedirect(request.getContextPath() + "/user_interface/user_login.jsp");

                } else {
                    //                    out.println("<script> alert('Registration Failed!')</script>");
                    out.println("Registered Failed! <a href='" + request.getContextPath() + "/user_interface/user_register.jsp'>Login</a>");
                }
            } catch (Exception e) {
                out.println("<h3>Error: " + e.getMessage() + "</h3>");
            } finally {
                try {
                    if (pst != null) {
                        pst.close();
                    }
                } catch (Exception e) {
                }
                try {
                    if (con != null) {
                        con.close();
                    }
                } catch (Exception e) {
                    e.printStackTrace();  // ✅ Print full error to Tomcat logs
                    out.println("<h3>Database Error: " + e + "</h3>");
                }
            }

        %> 
    </body>
</html>