<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete User</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the RegisterPage.jsp
			
		String auctionid = request.getParameter("auctionID");
		
		PreparedStatement ps = con.prepareStatement("DELETE FROM auction WHERE auctionID=" + auctionid+ ";");
		ps.executeUpdate();
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Insert succeeded");
		response.sendRedirect("MainPage.jsp");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed");
	}
%>
	<a href="MainPage.jsp">Back to Home</a>
</body>
</html>