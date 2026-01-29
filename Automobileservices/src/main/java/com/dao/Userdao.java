package com.dao;
import java.sql.*;
import com.model.*;
import com.db.Dbconnection;
public class Userdao 
{
	Dbconnection db=new Dbconnection();
	public Usermodel valid(Usermodel s) 
	{
		String sql = "SELECT * FROM users WHERE username = ? AND password = ?";

	    try(Connection con=db.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql))
	    {
	        ps.setString(1, s.getusername());
	        ps.setString(2, s.getpassword());
	        ResultSet rs = ps.executeQuery();
	        if(rs.next())
	        {
	            Usermodel um = new Usermodel();
	            um.setusername(rs.getString("username"));
	            um.setpassword(rs.getString("password")); 
	            return um;
	        }
	        return null;
	    }
	    catch(Exception e)
	    {
	        e.printStackTrace();
	        return null;
	    }
	}
	public boolean register(Usermodel s) 
	{
	    String sql = "INSERT INTO users(username, password) VALUES (?, ?)";
	    System.out.println("Attempting to register user: " + s.getusername());
	    try(Connection con = db.getConnection();
	        PreparedStatement ps = con.prepareStatement(sql)) 
	    {    
	        ps.setString(1, s.getusername());
	        ps.setString(2, s.getpassword());
	        
	        int rs = ps.executeUpdate();
	        System.out.println("Rows affected: " + rs);
	        return rs > 0;
	        
	    }
	    catch(Exception e) 
	    {
	        System.out.println("Database error: " + e.getMessage());
	        return false;
	    }
	}
		

}
