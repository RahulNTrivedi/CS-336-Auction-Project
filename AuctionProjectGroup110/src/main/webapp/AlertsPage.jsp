<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Alerts</title>
</head>
<body>
	<%
	if ((session.getAttribute("user") == null)) {
	%>
	You are not logged in<br/>
	<a href="LogInPage.jsp">Please Login</a>
	<%} else {
	%>
		<form action="MainPage.jsp">
			<input type="submit" value="Home" />
		</form>
		<br>
	
		<%!
		public void deleteQuery() {
			return;
		}
		
		%>
		
		<h1>Alerts</h1>
		
		<div style='border: 1px solid black; padding: 5px; margin: 5px'>
		<h3>Items of Interest:</h3>
			<% 
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				
				Statement stmt = con.createStatement();
				Statement substmt = con.createStatement();
				String str = "SELECT * FROM itemsofinterest WHERE interestUsername='" + session.getAttribute("user") + "';";
				ResultSet result = stmt.executeQuery(str);
				while(result.next()){
					out.print("<h4>" + result.getString("itemID1") + " " + result.getString("itemID2") + "</h4>");
					int count = 0;
					if(result.getString("itemType").equals("calculator")){
						str = "SELECT * FROM auction AS a INNER JOIN calculator AS c ON a.auctionID = c.auctionID WHERE a.isClosed = 0 AND c.brand='" + result.getString("itemID1") + "' AND c.model = '" + result.getString("itemID2") + "'; ";
						ResultSet subset = substmt.executeQuery(str);
						while(subset.next()){
							out.print("<form method='get' action='ItemPage.jsp'>");
							out.print("<input type='hidden' name='auctionID' value='" + subset.getString("a.auctionID") +"'>");
							out.print("<input type='submit' value='View'>");
							count++;
						}
						if(count==0){
							out.print("Not available");
						}
					} else if(result.getString("itemType").equals("textbook")){
						str = "SELECT * FROM auction AS a INNER JOIN textbook AS t ON a.auctionID = t.auctionID WHERE a.isClosed = 0 AND t.title='" + result.getString("itemID1") + "' AND t.author = '" + result.getString("itemID2") + "'; ";
						ResultSet subset = substmt.executeQuery(str);
						while(subset.next()){
							out.print("<form method='get' action='ItemPage.jsp'>");
							out.print("<input type='hidden' name='auctionID' value='" + subset.getString("a.auctionID") +"'>");
							out.print("<input type='submit' value='View'>");
							count++;
						}
						if(count==0){
							out.print("Not available");
						}
					} else if(result.getString("itemType").equals("notebook")){
						str = "SELECT * FROM auction AS a INNER JOIN notebook AS n ON a.auctionID = n.auctionID WHERE a.isClosed = 0 AND n.color='" + result.getString("itemID1") + "' AND n.name = '" + result.getString("itemID2") + "'; ";
						ResultSet subset = substmt.executeQuery(str);
						while(subset.next()){
							out.print("<form method='get' action='ItemPage.jsp'>");
							out.print("<input type='hidden' name='auctionID' value='" + subset.getString("a.auctionID") +"'>");
							out.print("<input type='submit' value='View'>");
							count++;
						}
						if(count==0){
							out.print("Not available");
						}
					} else {
						out.print("err");
					}
					out.print("<br>");
				}
				out.print("<h3>Other Alerts:</h3>");
				String alertQuery = "SELECT * FROM alerts WHERE alertUsername = '" + session.getAttribute("user") + "';";
				ResultSet alerts = stmt.executeQuery(alertQuery);
				while(alerts.next()) {
					out.print("<table>");
					out.print("<tr>");
					out.print("<form action='DeleteAlert.jsp'>");
					out.print("<input type='hidden' name='alertMsg' value='" + alerts.getString("alertMsg") +"'>");
					out.print("<input type='submit' value='Delete Alert'/>");
					out.print("</form>");
					out.print(alerts.getString("alertMsg"));
					out.print("</tr>");
					out.print("</table>");
				}
				
				
				con.close();
			} catch (Exception ex) {
				out.print(ex);
				out.print("Failed");
			}
			%>
		</div>
	<%
    }
	%>


</body>
</html>