<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Auction Project</title>
</head>
<body>
	<%
	if ((session.getAttribute("user") == null)) {
	%>
	You are not logged in<br/>
	<a href="LogInPage.jsp">Please Login</a>
	<%} else {
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			out.print("<table>");
			out.print("<tr>");
			
			out.print("<form action='MainPage.jsp'>");
			out.print("<input type='submit' value='Home'/>");
			out.print("</form>");
			
			out.print("<form action='NewAuction.jsp'>");
			out.print("<input type='submit' value='New Auction'/>");
			out.print("</form>");
			
			out.print("<form action='NewQuestion.jsp'>");
			out.print("<input type='submit' value='Ask Question'/>");
			out.print("</form>");
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			ResultSet result = stmt.executeQuery("SELECT * FROM account WHERE username = '" + (String)session.getAttribute("user") + "';");
			result.next();
			//Make a search query from account table:
			if(result.getString("isAdmin").equals("1")){
				out.print("<form action='AdminPage.jsp'>");
				out.print("<input type='submit' value='Account'/>");
				out.print("</form>");
			} else if(result.getString("isStaff").equals("1")){
				out.print("<form action='StaffPage.jsp'>");
				out.print("<input type='submit' value='Account'/>");
				out.print("</form>");
			} else {
				out.print("<form action='UserPage.jsp'>");
				out.print("<input type='submit' value='Account'/>");
				out.print("</form>");
			}
			
			out.print("<form action='AlertsPage.jsp'>");
			out.print("<input type='submit' value='Alerts'/>");
			out.print("</form>");
			
			out.print("<form action='LogOut.jsp'>");
			out.print("<input type='submit' value='Log Out'/>");
			out.print("</form>");
			
			out.print("</tr>");
			out.print("</table>");
			
			out.print("<form method=\"get\" action=\"MainPage.jsp\">");
				out.print("<input type=\"text\" name=\"searchQuery\" placeholder=\"Search\" required = \"required\">");
				out.print("<input type=\"submit\" value=\"Search\">");
			out.print("</form>");
			//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
			con.close();
			
		} catch (Exception ex) {
			out.print(ex);
			out.print("Failed");
		}
    }
	%>


</body>
</html>