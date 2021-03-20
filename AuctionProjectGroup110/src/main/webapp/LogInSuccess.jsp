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

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		//Make a search query from account table:
		String str = "SELECT * FROM account WHERE username = '" + username + "' AND password = '" + password + "';";
		
		ResultSet result = stmt.executeQuery(str);
		if(result.next() == false){
			out.print("Failed Login");
			out.print("<br>");
			out.print("<a href=\"LogInPage.jsp\">Back to Log In</a>");
		} else {
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
			do {
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

			} while (result.next());
			
			out.print("</table>");
			out.print("Log In Succeeded");
		}


		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed");
	}
%>
</body>
</html>