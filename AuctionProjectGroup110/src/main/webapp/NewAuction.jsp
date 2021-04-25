<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>New Auction</title>
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
	
		<h1>Create Auction</h1>
		<form method="post" action="AddAuction.jsp">
		<table>
		<tr>
		<td>Condition</td>
		</tr>
		<tr>
			<td>
				<select 
					name="condition"
					required = "required">
					<option value="used">Used</option>
					<option value="new">New</option>
				</select>
			</td>
		</tr>
		<tr>
		<td>Item Type</td>
		</tr>
		<tr>
			<td>
			<select 
					name="itemtype"
					required = "required">
					<option value="notebook">Notebook</option>
					<option value="textbook">Textbook</option>
					<option value="calculator">Calculator</option>
				</select>
			</td>
		</tr>
		<tr>
		
		<td>Notebook Color (type NA if not notebook)</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="notebookColor" title="NA if not notebook" required="required">
			</td>
		</tr>
		<tr>
		<td>Notebook Name (type NA if not notebook)</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="notebookName" title="NA if not notebook" required="required">
			</td>
		</tr>
		<tr>
		
		<td>Textbook Title (type NA if not textbook)</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="textbookTitle" title="NA if not textbook" required="required">
			</td>
		</tr>
		<tr>
		<td>Textbook Author (type NA if not textbook)</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="textbookAuthor" title="NA if not textbook" required="required">
			</td>
		</tr>
		<tr>
		
		<td>Calculator Brand (type NA if not calculator)</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="calcBrand" title="NA if not calculator" required="required">
			</td>
		</tr>
		<tr>
		<td>Calculator Model (type NA if not calculator)</td>
		</tr>
		<tr>
			<td>
				<input type="text" name="calcModel" title="NA if not calculator" required="required">
			</td>
		</tr>
		<tr>
		
		
		<td>Closing Date (Format YYYY-MM-DD hh:mm:ss)</td>
		</tr>
		<tr>
			<td>
				<input 
					type="text" 
					name="closedate"
					pattern="[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}" 
					title="Required format is YYYY-MM-DD hh:mm:ss. For example, 2020-04-21 15:32:00 is valid."
					required = "required">
			</td>
		</tr>
		<tr>
		<td>Reserve (Minimum Bid)</td>
		</tr>
		<tr>
			<td>
				<input type="number" name="reserve" min="1" step="1" max="2500"" >
			</td>
		</tr>
		</table>
		<input type="submit" value="Create">
		</form>
	<%
    }
	%>


</body>
</html>