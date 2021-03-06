<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Change Address</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		out.print("<form action='MainPage.jsp'>");
		out.print("<input type='submit' value='Home'/>");
		out.print("</form>");
		//Get parameters from the HTML form at the HelloWorld.jsp
		String username = request.getParameter("username");
		
		String street = request.getParameter("address");
		String city = request.getParameter("city");
		String state = request.getParameter("state");
		String zip = request.getParameter("zip");
		String country = request.getParameter("country");
		String address = street;
		if(!city.equals("")) address += ", " + city;
		if(!state.equals("")) address += ", " + state;
		if(!zip.equals("")) address += ", " + zip;
		if(!country.equals("")) address += ", " + country;
		
		PreparedStatement ps = con.prepareStatement("UPDATE account SET address ='"+ address +"' WHERE username='"+username+"';");
		ps.executeUpdate();
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Change succeeded");
		out.print("<form action='EditUser.jsp'>");
		out.print("<input type='hidden' name='username' value='" + username + "'>");
		out.print("<input type='submit' value='Return'/>");
		out.print("</form>");


	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed");
	}
%>
</body>
</html>