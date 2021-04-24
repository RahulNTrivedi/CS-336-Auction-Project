<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Question</title>
</head>
<body>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		out.print("<form action='MainPage.jsp'>");
		out.print("<input type='submit' value='Home'/>");
		out.print("</form>");
		out.print("<button type='button' name='back' onclick='history.back()'>Back</button>");
		//Get parameters from the HTML form at the HelloWorld.jsp
		String id = request.getParameter("questionID");
		
		String question = "SELECT questionDetails,endUsername from asksquestion where questionID = '" + id + "';";
		ResultSet result = stmt.executeQuery(question);
		result.next();
		out.print("<h2>Question: '" + result.getString("questionDetails")+ "'</h2>");
		out.print("<h2>Username: '" + result.getString("endUsername")+ "'</h2>");
		
		String replies = "SELECT * FROM writesreplies w where w.questionID='" + id + "';";
		result = stmt.executeQuery(replies);
		
		out.print("<div>");
		out.print("<table border='1' cellpadding='5' style='table-layout: fixed; width:100%;'>");
		out.print("<tr>");
		out.print("<th style='word-wrap: break-word; width:20%'>Username</th>");
		out.print("<th style='word-wrap: break-word'>Reply</th>");
		out.print("</tr>");

		
		while(result.next() && result.getString("repUsername") != null){
			out.print("<tr>");
			out.print("<td style='word-wrap: break-word'>" + result.getString("repUsername") + "</td>");
			out.print("<td style='word-wrap: break-word'>" + result.getString("replyDetails") + "</td>");
			out.print("</tr>");
		}
		
		out.print("</table>");
		
		String username = (String) session.getAttribute("user");
		String str = "SELECT * FROM account WHERE username = '"+username+ "';";
		result = stmt.executeQuery(str);
		result.next();
		
		if(result.getByte("isStaff") == 1 && result.getByte("isAdmin") == 0){
			out.print("<form name='replyInfo' method='post' action='WriteReply.jsp'>");
	        out.print("Reply: <input type = 'text' name = 'reply'><br /><br />");
	        out.print("<input type='hidden' name='questionID'  value='"+id+"'>");
			out.print("<input type='submit' value='Reply'>");
			out.print("</form><br />");
		}
		
		out.print("</div>");
		
		

		
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed");
	}
%>
</body>
</html>