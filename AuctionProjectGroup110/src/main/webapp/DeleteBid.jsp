<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete User</title>
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
			
		String bidid = request.getParameter("bidID");
		String auctionid = request.getParameter("auctionID");
		
		PreparedStatement ps = con.prepareStatement("DELETE FROM makesbid WHERE bidID=" + bidid+ ";");
		ps.executeUpdate();
		
		String sql = "SELECT MAX(amount) maxVal FROM makesbid WHERE auctionID = " + auctionid +";";
		ResultSet result = stmt.executeQuery(sql);
		result.next();
		
		if(result.getString("maxVal") == null){
			PreparedStatement ps2 = con.prepareStatement("UPDATE auction SET maxBid = 0 WHERE auctionID ="+ auctionid+";");
			ps2.executeUpdate();
		} else {
			int maxVal = Integer.parseInt(result.getString("maxVal"));
			PreparedStatement ps2 = con.prepareStatement("UPDATE auction SET maxBid = "+ maxVal +" WHERE auctionID ="+ auctionid+";");
			ps2.executeUpdate();
		}
		
		
	    
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Delete succeeded");
		out.print("<form action='ItemPage.jsp'>");
		out.print("<input type='hidden' name='auctionID' value='" + auctionid + "'>");
		out.print("<input type='submit' value='Return'/>");
		out.print("</form>");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Delete failed");
	}
%>
	<a href="MainPage.jsp">Back to Home</a>
</body>
</html>