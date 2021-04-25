<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Make Bid</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		Statement stmt2 = con.createStatement();

		//Get parameters
		String username = (String) session.getAttribute("user");
		String id = request.getParameter("auctionID");
		String bidType = request.getParameter("bidType");
		String amount = request.getParameter("amount");
		String increment = request.getParameter("increment");
		String upperLimit = request.getParameter("upperLimit");
		
		int bidAmount = Integer.parseInt(amount);

		//Make a search query from account table:
		String str = "SELECT * FROM auction WHERE auctionID = '" + id + "';";	
		ResultSet result = stmt.executeQuery(str);
		
		if(result.next() == false){
			out.print("Failed Bid");
			out.print("<br>");
			out.print("<form action='MakeBid.jsp'>");
			out.print("<input type='hidden' name='auctionID' value='" + id + "'>");
			out.print("<input type='submit' value='Return'/>");
			out.print("</form>");
		} else {			
			str = "SELECT maxBid FROM auction WHERE auctionID = '" + id + "';";
			ResultSet maxBid = stmt.executeQuery(str);
			if(maxBid.next() != false && bidAmount <= maxBid.getInt("maxBid")) {
				out.print("Please bet higher than the max bid of $" + maxBid.getString("maxBid"));
				out.print("<br>");
				out.print("<form action='MakeBid.jsp'>");
				out.print("<input type='hidden' name='auctionID' value='" + id + "'>");
				out.print("<input type='submit' value='Return'/>");
				out.print("</form>");
			}
			else {
				String sql = "SELECT MAX(bidID) maxVal from makesbid;";
				ResultSet maxID = stmt.executeQuery(sql);
				maxID.next();
				
				int bidID = 1;
				if(maxID.getString("maxVal") != null){
					bidID = Integer.parseInt(maxID.getString("maxVal"))+1;
				}
				if(bidType.equals("automatic")) {
					int bidUpperLimit = Integer.parseInt(upperLimit);
					if(bidUpperLimit < bidAmount) {
						out.print("Please set the upper limit to be higher than your bet");
						out.print("<br>");
						out.print("<form action='MakeBid.jsp'>");
						out.print("<input type='hidden' name='auctionID' value='" + id + "'>");
						out.print("<input type='submit' value='Return'/>");
						out.print("</form>");
						return;
					}
				}
				
				String insert = "INSERT INTO makesbid VALUES (" +bidID+ ", '" +username+ "', " +id+ ", '"
						+bidType+ "', " +amount+ ", " +increment+ ", " +upperLimit+ ");";
				PreparedStatement ps = con.prepareStatement(insert);
				ps.executeUpdate();
				
				String lastBidInserted = amount;
				String lastBidUser = username;

				String query = "SELECT * FROM makesbid WHERE amount in (SELECT max FROM (SELECT m.accountUser, max(amount) max FROM makesbid m, auction a WHERE m.typeOfBidding = 'automatic' AND m.auctionID = "
						+id+ " AND a.auctionID = " +id+ " AND " +lastBidInserted+ " + m.increment <= m.upperLimit " + "GROUP BY accountUser) temp);";
				ResultSet autobidUsers = stmt.executeQuery(query);
				ArrayList<String[]> autoBids = new ArrayList<String[]>();
				while(autobidUsers.next()) {
						autoBids.add(new String[]{autobidUsers.getString("accountUser"), autobidUsers.getString("increment"), autobidUsers.getString("upperLimit")});
				}
				while(autoBids.size() > 0) {
					for(int i = 0; i < autoBids.size(); i++) {
						String autoUsername = autoBids.get(i)[0];
						if(autoUsername.equals(lastBidUser)){
							continue;
						}
						String getMax = "SELECT MAX(bidID) maxVal from makesbid;";
						ResultSet newMaxID = stmt.executeQuery(getMax);
						newMaxID.next();
						int newBidID = 1;
						if(newMaxID.getString("maxVal") != null){
							newBidID = Integer.parseInt(newMaxID.getString("maxVal"))+1;
						}
						int lastBid = Integer.parseInt(lastBidInserted);
						int autoIncrement = Integer.parseInt(autoBids.get(i)[1]);
						int autoUpperLimit = Integer.parseInt(autoBids.get(i)[2]);
						int newAmount = lastBid+autoIncrement;
						String sum = "" + newAmount;
						if(newAmount > autoUpperLimit) {
							autoBids.remove(i);
						}
						else {
							insert = "INSERT INTO makesbid VALUES (" +newBidID+ ", '" +autoUsername+ "', " +id+
									", 'automatic', " +sum+ ", " +autoIncrement+ ", " +autoUpperLimit+ ");";
							ps = con.prepareStatement(insert);
							ps.executeUpdate();
							lastBidUser = autoUsername;
							lastBidInserted = sum;
						}
					}
					if(autoBids.size() == 1) {
						break;
					}
				}
				
				String update = "UPDATE auction SET maxBid = " +lastBidInserted+ " WHERE auctionID = " +id+ ";";
				ps = con.prepareStatement(update);
				ps.executeUpdate();
				
				//Alert
				String itemQuery = "SELECT * FROM auction AS a LEFT OUTER JOIN hasa_schoolsupply AS h ON a.auctionID = h.auctionID WHERE a.auctionID = '" + id + " ';";
				
				ResultSet items = stmt.executeQuery(itemQuery);
				items.next();
				
				String itemName = "";
				if(items.getString("h.itemType").equals("textbook")){
					str = "SELECT * FROM textbook AS t WHERE t.auctionID = '" + id + " ';";
					ResultSet itemDetails = stmt.executeQuery(str);
					itemDetails.next();
					itemName += itemDetails.getString("t.title");
					itemName += " ";
					itemName += itemDetails.getString("t.author");
				} else if(items.getString("h.itemType").equals("notebook")){
					str = "SELECT * FROM notebook AS n WHERE n.auctionID = '" + id + " ';";
					ResultSet itemDetails = stmt.executeQuery(str);
					itemDetails.next();
					itemName += itemDetails.getString("n.color");
					itemName += " ";
					itemName += itemDetails.getString("n.name");
				} else if(items.getString("h.itemType").equals("calculator")){
					str = "SELECT * FROM calculator AS c WHERE c.auctionID = '" + id + " ';";
					ResultSet itemDetails = stmt.executeQuery(str);
					itemDetails.next();
					itemName += itemDetails.getString("c.brand");
					itemName += " ";
					itemName += itemDetails.getString("c.model");
				}
				
				String notifyManualUsers = "SELECT DISTINCT(m.accountUser) FROM makesbid m WHERE m.accountUser NOT IN (" +
					"SELECT m.accountUser FROM makesbid m, auction a WHERE a.auctionID = " +id+
					" AND a.auctionID = m.auctionID AND m.amount = a.maxBid) AND typeOfBidding = 'manual' AND m.auctionID =" +id+ ";";
				ResultSet notifyManual = stmt.executeQuery(notifyManualUsers);
				while(notifyManual.next()) {
					String insertAlert = "INSERT INTO alerts VALUES('A higher bid has been placed on " +itemName+ " at $" +lastBidInserted+ "', '" +notifyManual.getString(1)+ "');";
					ps = con.prepareStatement(insertAlert);
					ps.executeUpdate();
				}
				
				String notifyAutoUsers = "SELECT DISTINCT(m.accountUser) FROM makesbid m WHERE m.accountUser NOT IN (" +
					"SELECT m.accountUser FROM makesbid m, auction a WHERE a.auctionID = " +id+
					" AND a.auctionID = m.auctionID AND m.amount = a.maxBid) AND typeOfBidding = 'automatic' AND m.auctionID =" +id+ ";";
				ResultSet notifyAuto = stmt2.executeQuery(notifyAutoUsers);
				while(notifyAuto.next()) {
					String insertAlert = "INSERT INTO alerts VALUES('Your upper limit has been outbid on " +itemName+ " at $" +lastBidInserted+ "', '" +notifyAuto.getString(1)+ "');";
					ps = con.prepareStatement(insertAlert);
					ps.executeUpdate();
				}
				
				
				out.print("Your bid has been placed.");
				out.print("<br>");
				out.print("<form action='ItemPage.jsp'>");
				out.print("<input type='hidden' name='auctionID' value='" + id + "'>");
				out.print("<input type='submit' value='Return'/>");
				out.print("</form>");
			}
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