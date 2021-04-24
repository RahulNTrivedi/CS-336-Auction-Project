<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>User Page</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		out.print("<form action='MainPage.jsp'>");
		out.print("<input type='submit' value='Home'/>");
		out.print("</form>");
		out.print("<button type='button' name='back' onclick='history.back()'>Back</button>");
		//Create a SQL statement
		Statement stmt = con.createStatement();

		String username = request.getParameter("username");
		out.print("<h1>User: " + username + "</h1>");
		
		out.print("<div style='border: 1px solid black; padding: 5px; margin: 5px'>");
		out.print("<h2>Buyer Auctions</h2>");
		ResultSet result = stmt.executeQuery("SELECT * FROM auction a, makesbid m WHERE a.auctionID=m.auctionID AND m.accountUser='" + username + "';");
		out.print("<table>");
		out.print("<tr>");
		out.print("<td>");
		out.print("Auction");
		out.print("</td>");
		out.print("<td>");
		out.print("Amount");
		out.print("</td>");
		out.print("</tr>");
		while(result.next()){
			out.print("<tr>");
			out.print("<td>");
			out.print("<form method='get' action='ItemPage.jsp'>");
			out.print("<input type='hidden' name='auctionID' value='" + result.getString("a.auctionID") +"'>");
			out.print("<input type='submit' value='View'>");
			out.print("</form>");
			out.print("</td>");
			out.print("<td>");
			out.print(result.getString("m.amount"));
			out.print("</td>");
			out.print("</tr>");
		}
		out.print("</table>");
		out.print("</div>");
		
		out.print("<div style='border: 1px solid black; padding: 5px; margin: 5px'>");
		out.print("<h2>Seller Auctions</h2>");
		result = stmt.executeQuery("SELECT * FROM auction a WHERE a.accountUser='" + username + "';");
		out.print("<table>");
		out.print("<tr>");
		out.print("<td>");
		out.print("Auction");
		out.print("</td>");
		out.print("</tr>");
		while(result.next()){
			out.print("<tr>");
			out.print("<td>");
			out.print("<form method='get' action='ItemPage.jsp'>");
			out.print("<input type='hidden' name='auctionID' value='" + result.getString("a.auctionID") +"'>");
			out.print("<input type='submit' value='View'>");
			out.print("</form>");
			out.print("</td>");
			out.print("</tr>");
		}
		out.print("</table>");
		out.print("</div>");
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed");
	}
%>
</body>
</html>