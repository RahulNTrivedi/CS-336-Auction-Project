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
		
		//Get parameters from the HTML form at the HelloWorld.jsp
		String id = request.getParameter("username");
		
		
		String str = "SELECT * FROM account WHERE username='" + id + "';";
		ResultSet result = stmt.executeQuery(str);
		result.next();
		
		out.print("<table border='1' cellpadding='5' style='table-layout: fixed; width:100%;'>");
		
		
		out.print("<tr>");
		out.print("<th style='word-wrap: break-word; width:20%'>Username</th>");
		out.print("<th style='word-wrap: break-word; width:20%'>Password</th>");
		out.print("<th style='word-wrap: break-word; width:20%'>Email</th>");
		out.print("<th style='word-wrap: break-word; width:20%'>Phone</th>");
		out.print("<th style='word-wrap: break-word; width:20%'>Address</th>");
		out.print("</tr>");


		out.print("<tr>");
		//make a column
		out.print("<td style='word-wrap: break-word'>"+result.getString("username")+ "</td>");
		out.print("<td style='word-wrap: break-word'>"+result.getString("password")+ "</td>");
		out.print("<td style='word-wrap: break-word'>"+result.getString("email")+"</td>");
		out.print("<td style='word-wrap: break-word'>"+result.getString("phone")+"</td>");
		out.print("<td style='word-wrap: break-word'>"+result.getString("address")+"</td>");
		out.print("</tr>");


		
		out.print("</table><br />");
		
		out.print("<form name='passInfo' method='post' action='ChangePass.jsp'>");
        out.print("Password: <input type = 'text' name = 'password' pattern='[a-zA-Z][a-zA-Z0-9-_.]{1,45}' maxLength='45' title='Only letters, numbers, hyphens, underscores, and periods. Must start with a letter. Size 1 to 45 characters'><br /><br />");
        out.print("<input type='hidden' name='username'  value='"+result.getString("username")+"'>");
		out.print("<input type='submit' value='Change Password'>");
		out.print("</form><br />");
		
		out.print("<form name='emailInfo' method='post' action='ChangeEmail.jsp'>");
		out.print("Email: <input type = 'text' name = 'email' pattern='[a-z0-9._%+-]+@[a-z0-9.-]+\\.[a-z]{0,45}$' maxLength='45' title='email@website.extension'><br /><br />");
		out.print("<input type='hidden' name='username'  value='"+result.getString("username")+"'>");
		out.print("<input type='submit' value='Change Email'>");
		out.print("</form><br />");
		
		out.print("<form name='phoneInfo' method='post' action='ChangePhone.jsp'>");
		out.print("Phone: <input type = 'text' name = 'phone' pattern='[0-9]{3}-[0-9]{3}-[0-9]{4}' maxLength='15' title='111-111-1111'><br /><br />");
		out.print("<input type='hidden' name='username'  value='"+result.getString("username")+"'>");
		out.print("<input type='submit' value='Change Phone'>");
		out.print("</form><br />");
		
		out.print("<form name='addressInfo' method='post' action='ChangeAddress.jsp'>");
		out.print("Address:<br /><input type = 'text' name = 'address' placeholder= 'Street' pattern = '[a-zA-z0-9 ]{0,33}' maxLength='33' title ='Only letters and numbers. Max length 33'><br /><br />");
		out.print("<input type = 'text' name = 'city' placeholder= 'City' pattern = '[a-zA-z ]{0,33}' maxLength='33' title ='Only letters. Max length 33'><br /><br />");
		out.print("<input type = 'text' name = 'state' placeholder= 'State' pattern = '[a-zA-z ]{2}' maxLength='2' title ='Only letters. Use 2 letter abreviation'><br /><br />");
		out.print("<input type = 'text' name = 'zip' placeholder= 'Zip' pattern = '[0-9]{5}' maxLength='5' title ='Enter a 5 digit number'><br /><br />");
		out.print("<input type = 'text' name = 'country' placeholder= 'Country' pattern = '[a-zA-z ]{0,33}' maxLength='33' title ='Only letters. Max length 33'><br /><br />");
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