<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

<!-- Header -->
<div class="header">
    <img src="images/dreams-soft-logo.jpeg" class="logo">
    <div class="title">Dreams Soft Solutions</div>
</div>

<!-- Content -->
<div class="content">
    <div class="auth-box">
        <h2>Sign Up</h2>
<% if (request.getParameter("success") != null) { %>
    <p style="color:green; font-size:14px;">Signup successful</p>
<% } %>

<% if (request.getParameter("error") != null) { %>
    <p style="color:red; font-size:14px;">Signup failed. Try again.</p>
<% } %>

        <form action="Registerservlet" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <a class="action-link" href="<%=request.getContextPath()%>/image.jsp">
    Open Image Page
</a>

            <button type="submit">Create Account</button>
        </form>
    </div>
</div>

<!-- Footer -->
<div class="footer">
    © 2026 Dreams Soft Solutions
</div>

</body>
</html>
