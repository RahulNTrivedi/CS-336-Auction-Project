<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Item Page</title>
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
		out.print("<button type='button' name='back' onclick='history.back()'>Back</button>");
		//Get parameters from the HTML form at the HelloWorld.jsp
		String id = request.getParameter("auctionID");
		
		String str = "SELECT * FROM auction AS a LEFT OUTER JOIN hasa_schoolsupply AS h ON a.auctionID = h.auctionID WHERE a.auctionID = '" + id + " ';";
		
		ResultSet result = stmt.executeQuery(str);
		result.next();
		
		out.print("<div style='border: 1px solid black; padding: 5px; margin: 5px'>");
		out.print("<h4>" + result.getString("h.itemType") + "</h4>");
		out.print("<h4>" + result.getString("h.condition") + "</h4>");
		
		String type = "";
		out.print("<h1 style='line-height:0.4'>");
		if(result.getString("h.itemType").equals("textbook")){
			type = "textbook";
			str = "SELECT * FROM textbook AS t WHERE t.auctionID = '" + id + " ';";
			ResultSet itemDetails = stmt.executeQuery(str);
			itemDetails.next();
			out.print(itemDetails.getString("t.title"));
			out.print("&nbsp;");
			out.print(itemDetails.getString("t.author"));
		} else if(result.getString("h.itemType").equals("notebook")){
			type = "notebook";
			str = "SELECT * FROM notebook AS n WHERE n.auctionID = '" + id + " ';";
			ResultSet itemDetails = stmt.executeQuery(str);
			itemDetails.next();
			out.print(itemDetails.getString("n.color"));
			out.print("&nbsp;");
			out.print(itemDetails.getString("n.name"));
		} else if(result.getString("h.itemType").equals("calculator")){
			type = "calculator";
			str = "SELECT * FROM calculator AS c WHERE c.auctionID = '" + id + " ';";
			ResultSet itemDetails = stmt.executeQuery(str);
			itemDetails.next();
			out.print(itemDetails.getString("c.brand"));
			out.print("&nbsp;");
			out.print(itemDetails.getString("c.model"));
		}		
		out.print("</h1>");
		
		
		str = "SELECT * FROM auction AS a LEFT OUTER JOIN hasa_schoolsupply AS h ON a.auctionID = h.auctionID WHERE a.auctionID = '" + id + " ';";
			
	    result = stmt.executeQuery(str);
	    result.next();
		out.print("<form method='get' action='ViewUserPage.jsp'>");
		out.print("<input type='hidden' name='username' value='" + result.getString("a.accountUser") +"'>");
		out.print("<input type='submit' value='"+ result.getString("a.accountUser") +"'>");
		out.print("</form>");
		
		out.print("<h2>" + result.getString("a.accountUser") + "</h2>");
		out.print("<h3>Current max bid: " + result.getString("a.maxBid") + "</h3>");
		out.print("<h3>Closing Date: " + result.getString("a.closingDatetime") + "</h3>");
		out.print("<form method='get' action='AddToInterest.jsp'>");
		out.print("<input type='hidden' name='username' value=''>");
		out.print("<input type='submit' value='Add to Wishlist'>");
		out.print("</form>");
		out.print("</div>");
		
		out.print("<br>");
		
		if(result.getString("winner") == null){
			out.print("<div style='border: 1px solid black; padding: 5px; margin: 5px'>");
			out.print("<h2>Make a bid</h2>");
			out.print("<form method='get' action='MakeBid.jsp'>");
			out.print("<input type='submit' value='Make bid'>");
			out.print("</form>");
			out.print("</div>");
		} else {
			out.print("<div style='border: 1px solid black; padding: 5px; margin: 5px'>");
			out.print("<h2>Bidding closed</h2>");
			out.print("<h2>Winner: " + result.getString("winner") + "</h2>");
			out.print("</div>");
		}
		
		out.print("<br>");
		
		str="select * from makesbid m where auctionID = " + id + " order by amount DESC";
		result = stmt.executeQuery(str);
		out.print("<div style='border: 1px solid black; padding: 5px; margin: 5px'>");
		out.print("<h3 style='line-height:0.4'>Previous Bids</h3>");
		out.print("<table>");
		out.print("<tr>");
		out.print("<td>Username</td>");
		out.print("<td>Amount</td>");
		out.print("</tr>");
		while(result.next()){
			out.print("<tr>");
			out.print("<td>");
			out.print("<form method='get' action='ViewUserPage.jsp'>");
			out.print("<input type='hidden' name='username' value='" + result.getString("accountUser") +"'>");
			out.print("<input type='submit' value='"+ result.getString("accountUser") +"'>");
			out.print("</form>");
			out.print("</td>");
			out.print("<td>" + result.getString("amount") + "</td>");
			out.print("</tr>");
		}
		out.print("</table>");
		out.print("</div>");
		
		out.print("<br>");
		
		out.print("<div style='padding: 5px; margin: 5px; width:auto; height:auto'>");
		out.print("<h3 style='line-height:0.4'>Similar items</h3>");
		
		String t1 = "";
		String t2 = "";
		if(type.equals("textbook")){
			str = "SELECT * FROM textbook AS t WHERE t.auctionID = '" + id + " ';";
			result = stmt.executeQuery(str);
			result.next();
			
			t1 = result.getString("title");
			t2 = result.getString("author");
			
			str = "select * from textbook where title = '" + t1 + "' or author = '" + t2 + "';";
			result = stmt.executeQuery(str);
			while(result.next()){
				
			}
		} else if(type.equals("notebook")){
			str = "SELECT * FROM notebook AS n WHERE n.auctionID = '" + id + " ';";
			result = stmt.executeQuery(str);
			result.next();
			
			t1 = result.getString("color");
			t2 = result.getString("name");
			
			str = "select * from notebook where color = '" + t1 + "' or name = '" + t2 + "';";
			result = stmt.executeQuery(str);
			while(result.next()){
				
			}
		} else if(type.equals("calculator")){
			str = "SELECT * FROM calculator AS c WHERE c.auctionID = '" + id + " ';";
			result = stmt.executeQuery(str);
			result.next();
			
			t1 = result.getString("brand");
			t2 = result.getString("model");
			
			str = "select * from calculator where brand = '" + t1 + "' or model = '" + t2 + "';";
			result = stmt.executeQuery(str);
			while(result.next()){
				out.print("<div style='width:200px; height: 150px; border: 1px solid black; padding:5px ; margin: 5px; float: left'>");
				out.print("<h5 style='line-height:0.4'>" + result.getString("condition") + "</h5>");
				out.print("<h2 style='line-height:0.4'>");
					out.print(result.getString("brand"));
					out.print("&nbsp;");
					out.print(result.getString("model"));
				out.print("</h2>");
				out.print("<form method='get' action='ItemPage.jsp'>");
				out.print("<input type='hidden' name='auctionID' value='" + result.getString("auctionID") +"'>");
				out.print("<input type='submit' value='View'>");
				out.print("</form>");
				out.print("</div>");
			
			}
		}
		
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