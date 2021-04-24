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
		
		//Make an insert statement for the auction table:
		String insert = "INSERT INTO auction(auctionID, accountUser, reserve, winner, closingDateTime, maxBid)"
				+ "VALUES (?, ?, ?, ?, ?,?)";
		
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
		
		
		//insert into createAuction table
		insert = "INSERT INTO createauction(auctionID, accountUserID, reserveAmount)"
				+ "VALUES (?, ?, ?)";
		PreparedStatement createAuctionPs = con.prepareStatement(insert);
		createAuctionPs.setInt(1, auctionId);
		createAuctionPs.setString(2, username);
		createAuctionPs.setInt(3, reserve);
		createAuctionPs.executeUpdate();
		
		
		//insert into hasa_schoolsupply
		String q = "INSERT INTO hasa_schoolsupply VALUES (" + auctionId + ",'" + itemType + "', '" + cond + "');";
		con.prepareStatement(q).executeUpdate();
		
		
		//insert into notebook/textbook/calculator table
		if (itemType.equals("notebook")){
			String ins = "INSERT INTO notebook VALUES ('" + itemType + "'," + auctionId + ", '" + cond + "','" + notebookColor + "','" + notebookName + "');";
			con.prepareStatement(ins).executeUpdate();
		} else if (itemType.equals("textbook")){
			String ins = "INSERT INTO textbook VALUES ('" + itemType + "'," + auctionId + ", '" + cond + "','" + textbookTitle + "','" + textbookAuthor + "');";
			con.prepareStatement(ins).executeUpdate();
		} else {
			String ins = "INSERT INTO calculator VALUES ('" + itemType + "'," + auctionId + ", '" + cond + "','" + calcBrand + "','" + calcModel + "');";
			con.prepareStatement(ins).executeUpdate();
		}
		

		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Insert success");
		response.sendRedirect("MainPage.jsp");
		//out.print("Insert succeeded");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed");
	}
%>
</body>
</html>