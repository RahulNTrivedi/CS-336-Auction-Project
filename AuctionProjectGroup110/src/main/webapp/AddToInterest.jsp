<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Added to Wishlist</title>
</head>
<body>
	<%
	String id = request.getParameter("auctionID");
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the RegisterPage.jsp
		
		String str = "SELECT itemType FROM hasa_schoolsupply WHERE auctionID = '" + id + " ';";
		ResultSet result = stmt.executeQuery(str);
		result.next();
		
		String itemType = result.getString("itemType");
		
		String itemID1 = "";
		String itemID2 = "";
		if(itemType.equals("calculator")){
			str = "SELECT brand, model FROM calculator WHERE auctionID = '" + id + " ';";
			result = stmt.executeQuery(str);
			result.next();
			itemID1 = result.getString("brand");
			itemID2 = result.getString("model");
		} else if(itemType.equals("notebook")){
			str = "SELECT color, name FROM notebook WHERE auctionID = '" + id + " ';";
			result = stmt.executeQuery(str);
			result.next();
			itemID1 = result.getString("color");
			itemID2 = result.getString("name");
		} else if(itemType.equals("textbook")){
			str = "SELECT title, author FROM textbook WHERE auctionID = '" + id + " ';";
			result = stmt.executeQuery(str);
			result.next();
			itemID1 = result.getString("title");
			itemID2 = result.getString("author");
		} else {
			out.print("Insert failed");
			out.print("<form action='ItemPage.jsp'>");
			out.print("<input type='hidden' name='auctionID' value='" + id + "'>");
			out.print("<input type='submit' value='Auction Page'/>");
			out.print("</form>");
			return;
		}
		
		PreparedStatement ps = con.prepareStatement("INSERT INTO itemsofinterest VALUES ('" + itemID1 + "', '" + itemID2 + "', '" + session.getAttribute("user") + "', '" + itemType + "');");
		ps.executeUpdate();
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Added to Wishlist");
		
	} catch (Exception ex) {
		out.print("Already on Wishlist");
	}
	out.print("<form action='ItemPage.jsp'>");
	out.print("<input type='hidden' name='auctionID' value='" + id + "'>");
	out.print("<input type='submit' value='Auction Page'/>");
	out.print("</form>");
%>
</body>
</html>