<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Edit User</title>
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
		String id = request.getParameter("username");
		
		
		String str = "SELECT * FROM account WHERE username='" + id + "';";
		ResultSet result = stmt.executeQuery(str);
		result.next();
		
		out.print("<table>");
		
		
		out.print("<tr>");
		out.print("<th>Username</th>");
		out.print("<th>Password</th>");
		out.print("<th>Email</th>");
		out.print("<th>Phone</th>");
		out.print("<th>Address</th>");
		out.print("</tr>");


		out.print("<tr>");
		//make a column
		out.print("<td>"+result.getString("username")+ "</td>");
		out.print("<td>"+result.getString("password")+ "</td>");
		out.print("<td>"+result.getString("email")+"</td>");
		out.print("<td>"+result.getString("phone")+"</td>");
		out.print("<td>"+result.getString("address")+"</td>");
		out.print("</tr>");


		
		out.print("</table>");
		
		out.print("<form name='passInfo' method='post' action='ChangePass.jsp'>");
        out.print("Password: <input type = 'text' name = 'password'><br /><br />");
        out.print("<input type='hidden' name='username'  value='"+result.getString("username")+"'>");
		out.print("<input type='submit' value='Change Password'>");
		out.print("</form><br />");
		
		out.print("<form name='emailInfo' method='post' action='ChangeEmail.jsp'>");
		out.print("Email: <input type = 'text' name = 'email'><br /><br />");
		out.print("<input type='hidden' name='username'  value='"+result.getString("username")+"'>");
		out.print("<input type='submit' value='Change Email'>");
		out.print("</form><br />");
		
		out.print("<form name='phoneInfo' method='post' action='ChangePhone.jsp'>");
		out.print("Phone: <input type = 'text' name = 'phone'><br /><br />");
		out.print("<input type='hidden' name='username'  value='"+result.getString("username")+"'>");
		out.print("<input type='submit' value='Change Phone'>");
		out.print("</form><br />");
		
		out.print("<form name='addressInfo' method='post' action='ChangeAddress.jsp'>");
		out.print("Address: <input type = 'text' name = 'address'><br /><br />");
		out.print("<input type='hidden' name='username'  value='"+result.getString("username")+"'>");
		out.print("<input type='submit' value='Change Address'>");
		out.print("</form><br />");
		
		out.print("<form action='DeleteUser.jsp'>");
		out.print("<input type='hidden' name='username'  value='"+result.getString("username")+"'>");
		out.print("<input type='submit' value='Delete User'/>");
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