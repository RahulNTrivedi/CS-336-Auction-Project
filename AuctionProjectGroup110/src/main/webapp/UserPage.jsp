<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Log In</title>
</head>
<body>
	<%
	try {
		out.print("<h1>Welcome user</h1>");
		out.print("<br>");

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//Make a search query from account table:
			String str =  (String)request.getAttribute("query");

			ResultSet result = stmt.executeQuery(str);
			
			out.print("<table>");

			//make a row
			out.print("<tr>");
			//make a column
			out.print("<td>");
			//print out column header
			out.print("Username");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Email");
			out.print("</td>");
			//make a column
			out.print("<td>");
			out.print("Phone");
			out.print("</td>");
			out.print("<td>");
			out.print("Address");
			out.print("</td>");
			out.print("</tr>");

			//parse out the results
			while (result.next()) {
				//make a row
				out.print("<tr>");
				//make a column
				out.print("<td>");
				//Print out current username:
				out.print(result.getString("username"));
				out.print("</td>");
				out.print("<td>");
				//Print out current email:
				out.print(result.getString("email"));
				out.print("</td>");
				out.print("<td>");
				//Print out current phone
				out.print(result.getString("phone"));
				out.print("</td>");
				out.print("<td>");
				//Print out current address
				out.print(result.getString("address"));
				out.print("</td>");
				out.print("</tr>");

			} 
			
			out.print("</table>");
			out.print("<a href=\"LogInPage.jsp\">Log Out</a>");

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed");
	}
%>
</body>
</html>