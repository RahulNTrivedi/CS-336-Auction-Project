<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Login Page</title>
		<link rel="stylesheet" href="logIn.css">
	</head>
	
	<body>

		<h1>CS336 Log-in/Register</h1> <!-- the usual HTML way -->
	
		 <!-- Show html form to i) display something, ii) choose an action via a 
		  | radio button -->
		<!-- forms are used to collect user input 
			The default method when submitting form data is GET.
			However, when GET is used, the submitted form data will be visible in the page address field-->
	
	<h2>Log In:</h2>
		<form method="get" action="LogInSuccess.jsp">
			<table>
				<tr>    
					<td>Username</td>
				</tr>
				<tr>    
					<td><input type="text" name="username"></td>
				</tr>				
				<tr>
					<td>Password</td>
				</tr>
				<tr>
					<td><input type="text" name="password"></td>
				</tr>
			</table>
			<input type="submit" value="Submit">
		</form>
	<br>
	<a href="RegisterPage.jsp">New? Register Account</a>
</body>
</html>