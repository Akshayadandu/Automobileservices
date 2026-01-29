<!DOCTYPE html>
<html>
<head>
    <title>Test Database</title>
</head>
<body>
    <h2>Database Test</h2>
    
    <%@ page import="com.db.Dbconnection, java.sql.*" %>
    
    <%
        try {
            // Test connection
            Dbconnection db = new Dbconnection();
            Connection conn = db.getConnection();
            out.println("<p style='color:green;'>✅ Connected to: " + conn.getMetaData().getURL() + "</p>");
            
            // Check invoice_images table
            Statement stmt = conn.createStatement();
            
            // Check if table exists
            ResultSet tables = conn.getMetaData().getTables(null, null, "invoice_images", null);
            if (tables.next()) {
                out.println("<p style='color:green;'>✅ Table 'invoice_images' exists</p>");
                
                // Show table structure
                out.println("<h3>Table Structure:</h3>");
                ResultSet rs = stmt.executeQuery("DESCRIBE invoice_images");
                out.println("<table border='1' cellpadding='5'>");
                out.println("<tr><th>Field</th><th>Type</th><th>Null</th><th>Key</th><th>Default</th></tr>");
                while (rs.next()) {
                    out.println("<tr>");
                    out.println("<td>" + rs.getString("Field") + "</td>");
                    out.println("<td>" + rs.getString("Type") + "</td>");
                    out.println("<td>" + rs.getString("Null") + "</td>");
                    out.println("<td>" + rs.getString("Key") + "</td>");
                    out.println("<td>" + rs.getString("Default") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
                
                // Show data
                out.println("<h3>Data in table:</h3>");
                ResultSet data = stmt.executeQuery("SELECT * FROM invoice_images");
                boolean hasData = false;
                out.println("<table border='1' cellpadding='5'>");
                out.println("<tr><th>ID</th><th>Image Path</th><th>Upload Date</th></tr>");
                while (data.next()) {
                    hasData = true;
                    out.println("<tr>");
                    out.println("<td>" + data.getInt("image_id") + "</td>");
                    out.println("<td>" + data.getString("image_path") + "</td>");
                    out.println("<td>" + data.getTimestamp("uploaded_date") + "</td>");
                    out.println("</tr>");
                }
                out.println("</table>");
                
                if (!hasData) {
                    out.println("<p style='color:orange;'>No data in table yet</p>");
                }
                
            } else {
                out.println("<p style='color:red;'>❌ Table 'invoice_images' does not exist!</p>");
                out.println("<p>Create it with:</p>");
                out.println("<pre>");
                out.println("CREATE TABLE invoice_images (");
                out.println("    image_id INT PRIMARY KEY AUTO_INCREMENT,");
                out.println("    image_path VARCHAR(500) NOT NULL,");
                out.println("    uploaded_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP");
                out.println(")");
                out.println("</pre>");
            }
            
            conn.close();
            
        } catch (Exception e) {
            out.println("<p style='color:red;'>❌ Error: " + e.getMessage() + "</p>");
        }
    %>
    
    <br><br>
    <a href="image.jsp">← Go to PDF Upload</a>
</body>
</html>