<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Log In</title>
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
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		//Make a search query from account table:
		String str = "SELECT * FROM account WHERE username = '" + username + "' AND password = '" + password + "';";
		
		ResultSet result = stmt.executeQuery(str);
		if(result.next() == false){
			out.print("Failed Login");
			out.print("<br>");
			out.print("<a href=\"LogInPage.jsp\">Back to Log In</a>");
		} else {
			request.setAttribute("query", str);
			
			if(result.getString("isAdmin").equals("1")){
				RequestDispatcher rd = request.getRequestDispatcher("AdminPage.jsp");
				rd.forward(request, response);
				response.sendRedirect("AdminPage.jsp");
			} else if(result.getString("isStaff").equals("1")){
				RequestDispatcher rd = request.getRequestDispatcher("StaffPage.jsp");
				rd.forward(request, response);
				response.sendRedirect("StaffPage.jsp");
			} else {
				RequestDispatcher rd = request.getRequestDispatcher("UserPage.jsp");
				rd.forward(request, response);
				response.sendRedirect("UserPage.jsp");
			}
		}


		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();

		
		
	} catch (Exception ex) {
		out.print(ex);
		out.print("Failed");
	}
%>
</body>
</html>