<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.sql.*,java.util.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.time.temporal.TemporalAdjusters.*"%>  
<%@ page import="java.time.LocalDateTime" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New Auction</title>
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
		String username = (String) session.getAttribute("user");
		
		String itemName = request.getParameter("itemname");
		String cond = request.getParameter("condition");
		String itemType = request.getParameter("itemtype");
		
		String notebookColor = request.getParameter("notebookColor");
		String notebookName = request.getParameter("notebookName");
		String textbookTitle = request.getParameter("textbookTitle");
		String textbookAuthor = request.getParameter("textbookAuthor");
		String calcBrand = request.getParameter("calcBrand");
		String calcModel = request.getParameter("calcModel");
		
		String closeDate = request.getParameter("closedate");
		int reserve = Integer.parseInt(request.getParameter("reserve"));
		

		out.print(itemName);
		out.print(cond);
		out.print(itemType);
		out.print(notebookColor);
		out.print(notebookName);
		out.print(textbookTitle);
		out.print(textbookAuthor);
		out.print(calcBrand);
		out.print(calcModel);
		out.print(closeDate);
		out.print(reserve);
		
		//create Date from input
		int year = Integer.parseInt(closeDate.substring(0,4)) - 1900;
		int month = Integer.parseInt(closeDate.substring(5,7)) - 1;
		int day = Integer.parseInt(closeDate.substring(8,10));
		int hours = Integer.parseInt(closeDate.substring(11,13));
		int minutes = Integer.parseInt(closeDate.substring(14,16));
		int seconds = Integer.parseInt(closeDate.substring(17,19));
		
		java.util.Date cDate = new java.util.Date(year,month,day, hours,minutes,seconds);

		
		//get next auctionID
		int auctionId = 1;
		String sql = "SELECT MAX(auctionID) maxID from auction;";
		ResultSet result = stmt.executeQuery(sql);
		result.next();
		if(result.getString("maxID") != null){
			auctionId = Integer.parseInt(result.getString("maxID")) +1;
		}
		
		//Make an insert statement for the account table:
		String insert = "INSERT INTO auction(auctionID, accountUser, reserve, winner, closingDateTime, maxBid)"
				+ "VALUES (?, ?, ?, ?, ?,?)";
		
		// also need to insert into "hasaschoolsupply
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setInt(1, auctionId);
		ps.setString(2, username);
		ps.setInt(3, reserve);
		ps.setNull(4, java.sql.Types.NULL);
		ps.setObject(5, cDate);
		ps.setInt(6, 0);
		//Run the query against the DB
		ps.executeUpdate();

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		//response.sendRedirect("MainPage.jsp");
		//out.print("Insert succeeded");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed");
	}
%>
</body>
</html>