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
	<%!
	public String generateQuery(String items, String searchBy, String searchQuery, String sortBy){
		String query = "SELECT * FROM auction AS a "
						+"LEFT OUTER JOIN hasa_schoolsupply AS h "
						+ "ON a.auctionID = h.auctionID ";
		if(items!=null){
			if(items.equals("all")){
				query+= "LEFT OUTER JOIN calculator AS c " 
						+ "ON a.auctionID = c.auctionID " 
						+ "LEFT OUTER JOIN notebook AS n "
						+ "ON a.auctionID = n.auctionID " 
						+ "LEFT OUTER JOIN textbook AS t "
						+ "ON a.auctionID = t.auctionID ";
			} else if(items.equals("notebooks")){
				query+= "INNER JOIN notebook AS n "
						+ "ON a.auctionID = n.auctionID ";
			} else if(items.equals("calculators")){
				query+="INNER JOIN calculator AS c " 
						+ "ON a.auctionID = c.auctionID ";
			} else if(items.equals("textbooks")){
				query+= "INNER JOIN textbook AS t "
						+ "ON a.auctionID = t.auctionID ";
			}
			
			if(sortBy.equals("dateAscending")){
				query+="ORDER BY a.closingDateTime ASC ";
			} else if(sortBy.equals("dateDescending")){
				query+="ORDER BY a.closingDateTime DESC ";
			} else if(sortBy.equals("priceAscending")){
				query+="LEFT OUTER JOIN (SELECT auctionID, MAX(amount) AS amt "
						+ "FROM makesbid AS m "
						+ "GROUP BY auctionID) AS p "
						+ "ON a.auctionID = p.auctionID "
						+ "ORDER BY p.amt ASC ";
			} else if(sortBy.equals("priceDescending")){
				query+="LEFT OUTER JOIN (SELECT auctionID, MAX(amount) AS amt "
						+ "FROM makesbid AS m "
						+ "GROUP BY auctionID) AS p "
						+ "ON a.auctionID = p.auctionID "
						+ "ORDER BY p.amt DESC ";
			} else if(sortBy.equals("conditionAscending")){
				query+="ORDER BY FIELD(h.condition, 'old', 'used', 'slightly used', 'new') ";
			} else if(sortBy.equals("conditionDescending")){
				query+="ORDER BY FIELD(h.condition, 'new', 'slightly used', 'used', 'old') ";	
			}
		} else {
			query+= "LEFT OUTER JOIN calculator AS c " 
					+ "ON a.auctionID = c.auctionID " 
					+ "LEFT OUTER JOIN notebook AS n "
					+ "ON a.auctionID = n.auctionID " 
					+ "LEFT OUTER JOIN textbook AS t "
					+ "ON a.auctionID = t.auctionID ";
		}

		query+=";";
		return query;
	}
	%>
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
			
			ResultSet setAccount = stmt.executeQuery("SELECT * FROM account WHERE username = '" + (String)session.getAttribute("user") + "';");
			setAccount.next();
			//Make a search query from account table:
			if(setAccount.getString("isAdmin").equals("1")){
				out.print("<form action='AdminPage.jsp'>");
				out.print("<input type='submit' value='Account'/>");
				out.print("</form>");
			} else if(setAccount.getString("isStaff").equals("1")){
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
				out.print("<select name=\"searchSelect\">");
					out.print("<option value='all'>All Items</option>");
					out.print("<option value='textbooks'>Textbooks</option>");
					out.print("<option value='notebooks'>Notebooks</option>");
					out.print("<option value='calculators'>Calculators</option>");
				out.print("</select>");
				out.print("<select name=\"searchBy\">");
					out.print("<option value='title'>Title</option>");
					out.print("<option value='username'>Users</option>");
				out.print("</select>");
				out.print("<input type=\"text\" name=\"searchQuery\" placeholder=\"Search\">");
				out.print("<input type=\"submit\" value=\"Search\">");
				out.print("<label for='searchSort'>&nbsp;Sort by:</label>");
				out.print("<select name=\"searchSort\">");
					out.print("<option value='none'>Not sorted</option>");
					out.print("<option value='dateAscending'>Closing Date: Soon to Later</option>");
					out.print("<option value='dateDescending'>Closing Date: Later to Soon</option>");
					out.print("<option value='priceAscending'>Bid Price: Low to High</option>");
					out.print("<option value='priceDescending'>Bid Price: High to Low</option>");
					out.print("<option value='conditionAscending'>Condition: Old to New</option>");
					out.print("<option value='conditionDescending'>Condition: New to Old</option>");
			out.print("</select>");
			out.print("</form>");
			out.print("<br>");
			
			String searchSelect = request.getParameter("searchSelect");
			String searchBy = request.getParameter("searchBy");
			String searchQuery = request.getParameter("searchQuery");
			String searchSort = request.getParameter("searchSort");
			
			String generatedQuery = generateQuery(searchSelect, searchBy, searchQuery, searchSort);
			ResultSet searchedItems = stmt.executeQuery(generatedQuery);
			out.print("<table>");
			while(searchedItems.next()){
				if(searchBy != null && searchBy.equals("username") && !searchQuery.equals("")){
					if(!searchedItems.getString("a.accountUser").toLowerCase().contains(searchQuery.toLowerCase())){
						continue;
					}
				} else if(searchBy != null && searchBy.equals("title") && !searchQuery.equals("")){
					String itemTitle = "";
					if(searchedItems.getString("h.itemType").equals("textbook")){
						itemTitle += searchedItems.getString("t.title") + " " + searchedItems.getString("t.author");
					} else if(searchedItems.getString("h.itemType").equals("notebook")){
						itemTitle += searchedItems.getString("n.color") + " " + searchedItems.getString("n.name");
					} else if(searchedItems.getString("h.itemType").equals("calculator")){
						itemTitle += searchedItems.getString("c.brand") + " " + searchedItems.getString("c.model");
					}
					if(!itemTitle.toLowerCase().contains(searchQuery.toLowerCase())){
						continue;
					}
				}
				
				out.print("<div style='width:200px; height: auto; border: 1px solid black; padding:5px ; margin: 5px; float: left'>");
				out.print("<h5 style='overflow-wrap:break-word; word-wrap: break-word; hyphens: auto;'>" + searchedItems.getString("h.itemType") + "</h5>");
				out.print("<h5 style='overflow-wrap:break-word; word-wrap: break-word; hyphens: auto;'>Condition: " + searchedItems.getString("h.condition") + "</h5>");
				out.print("<h2 style='overflow-wrap:break-word; word-wrap: break-word; hyphens: auto;'>");
				if(searchedItems.getString("h.itemType").equals("textbook")){
					out.print(searchedItems.getString("t.title"));
					out.print("&nbsp;");
					out.print(searchedItems.getString("t.author"));
				} else if(searchedItems.getString("h.itemType").equals("notebook")){
					out.print(searchedItems.getString("n.color"));
					out.print("&nbsp;");
					out.print(searchedItems.getString("n.name"));
				} else if(searchedItems.getString("h.itemType").equals("calculator")){
					out.print(searchedItems.getString("c.brand"));
					out.print("&nbsp;");
					out.print(searchedItems.getString("c.model"));
				}
				out.print("</h2>");
				out.print("<h4 style='overflow-wrap:break-word; word-wrap: break-word; hyphens: auto;'>User: " + searchedItems.getString("a.accountUser") + "</h4>");
				if(searchedItems.getString("a.winner") == null){
					out.print("<h4 style='overflow-wrap:break-word; word-wrap: break-word; hyphens: auto;'> Status: Open</h4>");
				} else {
					out.print("<h4 style='overflow-wrap:break-word; word-wrap: break-word; hyphens: auto;'> Status: Closed</h4>");
				}
				out.print("<form method='get' action='ItemPage.jsp'>");
				out.print("<input type='hidden' name='auctionID' value='" + searchedItems.getString("a.auctionID") +"'>");
				out.print("<input type='submit' value='View'>");
				out.print("</form>");
				out.print("</div>");
			
			}
			
			out.print("</table>");
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