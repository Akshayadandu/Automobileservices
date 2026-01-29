<!DOCTYPE html>
<html>
<head><title>Test Image Loading</title></head>
<body style="font-family: Arial; padding: 20px;">
<h1>Image Loading Test</h1>

<%
    // Get last uploaded image from database
    try {
        com.db.Dbconnection db = new com.db.Dbconnection();
        java.sql.Connection conn = db.getConnection();
        java.sql.Statement stmt = conn.createStatement();
        java.sql.ResultSet rs = stmt.executeQuery("SELECT image_path FROM invoice_images ORDER BY uploaded_date DESC LIMIT 1");
        
        if (rs.next()) {
            String imageName = rs.getString("image_path");
%>
    <h2>Testing: <%= imageName %></h2>
    
    <h3>Test 1: Direct Servlet Access</h3>
    <p><a href="imageserve/<%= imageName %>" target="_blank">Open: imageserve/<%= imageName %></a></p>
    
    <h3>Test 2: Display Image</h3>
    <img src="imageserve/<%= imageName %>" 
         alt="Test" 
         style="max-width: 500px; border: 2px solid red;"
         onload="document.getElementById('status1').innerHTML='✅ Loaded'"
         onerror="document.getElementById('status1').innerHTML='❌ Failed'">
    <p id="status1">Waiting...</p>
    
    <h3>Test 3: Check File Exists</h3>
    <%
        java.io.File file = new java.io.File("D:/mechanic_shop/invoice_images/" + imageName);
    %>
    <p>Path: D:/mechanic_shop/invoice_images/<%= imageName %></p>
    <p>Exists: <%= file.exists() %></p>
    <p>Size: <%= file.exists() ? file.length() + " bytes" : "N/A" %></p>
    
<%
        } else {
            out.println("<p style='color:red'>No images found in database</p>");
        }
        
        conn.close();
    } catch (Exception e) {
        out.println("<p style='color:red'>Error: " + e.getMessage() + "</p>");
    }
%>

<h3>Debug Info</h3>
<p>Context Path: <%= request.getContextPath() %></p>
<p>Server: <%= request.getServerName() %>:<%= request.getServerPort() %></p>

<script>
console.log("Test page loaded");
</script>
</body>
</html>