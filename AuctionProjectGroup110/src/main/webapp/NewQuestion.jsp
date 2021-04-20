<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ask Question</title>
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
		
		<h1>Post Question</h1>
		<form method="post" action="RegisterSuccessful.jsp">
		<table>
		<tr>    
			<td>Question</td>
		</tr>
		<tr>
			<td>
				<input 
					type="text" 
					name="question"
					required = "required">
			</td>
		</tr>
		</table>
		<input type="submit" value="Post">
		</form>
	<%
    }
	%>


</body>
</html>