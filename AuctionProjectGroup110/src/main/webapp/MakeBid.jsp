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

		//Get parameters from the HTML form at the HelloWorld.jsp
		String id = request.getParameter("auctionID");	
		
		out.print("<form action='ItemPage.jsp'>");
		out.print("<input type='hidden' name='auctionID' value='" + id + "'>");
		out.print("<input type='submit' value='Auction Page'/>");
		out.print("</form>");
		
		String str = "SELECT * FROM auction AS a LEFT OUTER JOIN hasa_schoolsupply AS h ON a.auctionID = h.auctionID WHERE a.auctionID = '" + id + " ';";
		
		ResultSet result = stmt.executeQuery(str);
		result.next();
		
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
		
		String bidType = request.getParameter("bidType");
		if(bidType == null) {
			bidType = "manual";
		}
		
		out.print("<form method=\"get\" action=\"MakeBid.jsp\">");
			out.print("<select name=\"bidType\" onchange='this.form.submit()'>");
			if(bidType!=null && bidType.equals("automatic")) {
				out.print("<option value='manual'>Manual Bid</option>");
				out.print("<option value='automatic' selected='selected'>Automatic Bid</option>");
			}
			else {
				out.print("<option value='manual'>Manual Bid</option>");
				out.print("<option value='automatic'>Automatic Bid</option>");
			}
			out.print("</select>");
			out.print("<input type='hidden' name='auctionID' value='" + id + "'>");
			out.print("<input type='hidden' name='bidType' value='" + bidType + "'>");
		out.print("</form>");
		out.print("<br>");
	
		out.print("<form method='get' action='MakeBidValidate.jsp'>");	
			out.print("<table>");
			out.print("<tr>");   
				out.print("<td>Bid Amount</td>");
			out.print("</tr>");  
			out.print("<tr>");   
				out.print("<td><input type='text' name='amount' pattern='[0-9]{1,}' title='Enter a number' required = 'required'></td>");
			out.print("</tr>");
			if(bidType!=null && bidType.equals("automatic")) {
				out.print("<tr>");  
					out.print("<td>Bid Increment</td>");
				out.print("</tr>");  
				out.print("<tr>");  
					out.print("<td><input type='text' name='increment' pattern='[0-9]{1,}' title='Enter a number'required = 'required'></td>");
				out.print("</tr>");
				out.print("<tr>");  
					out.print("<td>Secret Upper Limit</td>");
				out.print("</tr>");  
				out.print("<tr>");  
					out.print("<td><input type='text' name='upperLimit' pattern='[0-9]{1,}' title='Enter a number'required = 'required'></td>");
				out.print("</tr>");  
			}
			out.print("</table>");
			out.print("<input type='hidden' name='auctionID' value='" + id + "'>");
			out.print("<input type='hidden' name='bidType' value='" + bidType + "'>");
			out.print("<input type='submit' value='Submit'>");
		out.print("</form>");
		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed");
	}
%>
</body>
</html>