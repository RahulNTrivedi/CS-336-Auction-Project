<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Hi Beer World</title>
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
		<form method="get" action="logIn.jsp">
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
	
	
	<h2>Register Account:</h2>
		<form method="post" action="register.jsp">
		<table>
		<tr>    
			<td>Username</td>
		</tr>
		<tr>
			<td>
				<input 
					type="text" 
					name="username"
					pattern="[a-zA-Z][A-Za-z0-9]{1,20}" 
					title="Only letters and numbers. Must start with a letter. Size 1 to 20 characters">
			</td>
		</tr>
		<tr>
		<td>Password</td>
		</tr>
		<tr>
			<td>
				<input 
					type="text" 
					name="password"
					pattern="[a-zA-Z][a-zA-Z0-9-_.]{1,20}" 
					title="Only letters, numbers, hyphens, underscores, and periods. Must start with a letter. Size 1 to 20 characters">
			</td>
		</tr>
		<tr>
		<td>Email</td>
		</tr>
		<tr>
			<td>
				<input 
					type="email" 
					name="email"
					pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" 
					title="email@website.extension">
			</td>
		</tr>
		<tr>
		<td>Phone</td>
		</tr>
		<tr>
			<td>
				<input 
					type="text" 
					name="phone"
					pattern="[0-9]{3}-[0-9]{3}-[0-9]{4}" 
					title="111-111-1111">
			</td>
		</tr>
		<tr>
		<td>Address</td>
		</tr>
		<tr>
			<td>
				<input 
					type="text" 
					name="address"
					placeholder = "Street"
					pattern = "[a-zA-z0-9]">
			</td>
		</tr>
		<tr>
			<td>
				<input 
					type="text" 
					name="city"
					placeholder = "City"
					pattern = "[a-zA-z]">
			</td>
			<td>
				<input 
					type="text" 
					name="state"
					placeholder = "State"
					pattern = "[a-zA-z]">
			</td>
			<td>
				<input 
					type="text" 
					name="zip"
					placeholder = "Zip"
					pattern = "[0-9]{5}">
			</td>
		</tr>
		<tr>
			<td>
				<input 
					type="text" 
					name="country" 
					placeholder = "Country"
					pattern = "[a-zA-z]">
			</td>
		</tr>
		</table>
		<input type="submit" value="Add me!">
		</form>
	<br>
</body>
</html>