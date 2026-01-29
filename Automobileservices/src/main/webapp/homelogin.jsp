<!DOCTYPE html>
<html>
<head>
    <title>Login</title>
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
        <h2>QC Login</h2>
<% if (request.getParameter("error") != null) { %>
    <p style="color:red; font-size:14px;">Invalid username or password</p>
<% } %>

<% if (request.getParameter("success") != null) { %>
    <p style="color:green; font-size:14px;">Login successful</p>
<% } %>

        <form action="homeloginservlet" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
    </div>
</div>

<!-- Footer -->
<div class="footer">
    © 2026 Dreams Soft Solutions
</div>

</body>
</html>
