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
		//Statement idstmt = con.createStatement();

		//Get parameters from the HTML form at the HelloWorld.jsp
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
				
				//String lastBidInserted = insertBid(bidID, username, id, bidType, amount, increment, upperLimit);
				String insert = "INSERT INTO makesbid VALUES (" +bidID+ ", '" +username+ "', " +id+ ", '"
						+bidType+ "', " +amount+ ", " +increment+ ", " +upperLimit+ ");";
				PreparedStatement ps = con.prepareStatement(insert);
				ps.executeUpdate();
				String lastBidInserted = amount;
				String lastBidUser = username;
				
				/*String query = "SELECT * FROM makesbid WHERE amount in (SELECT max FROM (SELECT m.accountUser, max(amount) max FROM makesbid m, auction a WHERE m.typeOfBidding = 'automatic' AND m.auctionID = "
						+id+ " AND a.auctionID = " +id+ " AND m.accountUser <> '" +lastBidUser+ "' AND " +lastBidInserted+ " + m.increment <= m.upperLimit " + "GROUP BY accountUser) temp);";
						*/
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