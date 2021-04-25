<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Question Created</title>
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
			
		String question = request.getParameter("question");
		String username = (String) session.getAttribute("user");
		
		String sql = "SELECT MAX(questionID) maxVal from asksquestion;";
		ResultSet result = stmt.executeQuery(sql);
		result.next();
		
		int questionid = 1;
		if(result.getString("maxVal") != null){
			questionid = Integer.parseInt(result.getString("maxVal")) +1;
		}
		
		PreparedStatement ps = con.prepareStatement("INSERT INTO asksquestion VALUES (" + questionid+ ", '" + username + "', '" + question + "');");
		ps.executeUpdate();
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Question succeeded");
		out.print("<form action='ViewQuestion.jsp'>");
		out.print("<input type='hidden' name='questionID' value='" + questionid + "'>");
		out.print("<input type='submit' value='View Question'/>");
		out.print("</form>");
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Insert failed");
	}
%>
	<a href="MainPage.jsp">Back to Home</a>
</body>
</html>