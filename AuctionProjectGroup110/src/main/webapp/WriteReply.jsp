<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Write Reply</title>
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
		String reply = request.getParameter("reply");
		String id = request.getParameter("questionID");
		String username = (String) session.getAttribute("user");
		
		String sql = "SELECT MAX(replyID) maxVal from writesreplies;";
		ResultSet result = stmt.executeQuery(sql);
		result.next();
		
		int replyid = 1;
		if(result.getString("maxVal") != null){
			replyid = Integer.parseInt(result.getString("maxVal")) +1;
		}
		
		PreparedStatement ps = con.prepareStatement("INSERT INTO writesreplies VALUES (" + replyid+ ", '" + username + "', " + id +", '" + reply + "');");
		ps.executeUpdate();
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Insert succeeded");
		response.sendRedirect("MainPage.jsp");


	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed");
	}
%>
</body>
</html>