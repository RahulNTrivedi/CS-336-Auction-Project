<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Delete Alert</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters
		String username = (String) session.getAttribute("user");
		String alertMsg = request.getParameter("alertMsg");
		
		PreparedStatement ps = con.prepareStatement("DELETE FROM alerts WHERE alertMsg= '" +alertMsg+
				"' AND alertUsername= '"+username+"';");
		ps.executeUpdate();
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Delete succeeded");
		out.print("<br>");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed");
	}
%>
	<a href="AlertsPage.jsp">Back to Alerts</a>
</body>
</html>