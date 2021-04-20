<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account</title>
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
	<%
	out.print("<h1>Admin " + (String)session.getAttribute("user") + "</h1>");
	%>
	<table>
		<tr>
			<form name="infoForm" method="post">
				<input type="hidden" name="type">
				<input type="hidden" name="userSearch">
				<input type="hidden" name="faqSearch">
				<input type="button" value="Info" onclick="setBtn('info')">
			</form>
			<form name="bidsForm" method="post">
				<input type="button" value="Bids" onclick="setBtn('bids')">
			</form>
			<form name="auctionsForm" method="post">
				<input type="button" value="Auctions" onclick="setBtn('auctions')">
			</form>
			<form name="questionsForm" method="post">
				<input type="button" value="Questions" onclick="setBtn('questions')">
			</form>
			<form name="faqForm" method="post">
				<input type="button" value="FAQ" onclick="setBtn('faq')">
			</form>
			<form name="usersForm" method="post">
				<input type="button" value="Users" onclick="setBtn('users')">
			</form>
			<form name="saleReportForm" method="post">
				<input type="button" value="Sale Report" onclick="setBtn('salesReport')">
			</form>
			<form name="createAccountForm" method="post">
				<input type="button" value="Create Account" onclick="setBtn('createAccount')">
			</form>
		</tr>
	</table>
	
	<%
			
		if(request.getParameter("type") != null && ((String)request.getParameter("type")).equals("info")){
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
		
				//Create a SQL statement
				Statement stmt = con.createStatement();
				
				//Make a search query from account table:
					String str =  "SELECT * FROM account WHERE username = '" + session.getAttribute("user") + "';";
		
					ResultSet result = stmt.executeQuery(str);
					out.print("<h4>User Info</h4>");
					
					out.print("<table>");
		
					//make a row
					out.print("<tr>");
					//make a column
					out.print("<td>");
					//print out column header
					out.print("Username");
					out.print("</td>");
					//make a column
					out.print("<td>");
					out.print("Email");
					out.print("</td>");
					//make a column
					out.print("<td>");
					out.print("Phone");
					out.print("</td>");
					out.print("<td>");
					out.print("Address");
					out.print("</td>");
					out.print("</tr>");
		
					//parse out the results
					while (result.next()) {
						//make a row
						out.print("<tr>");
						//make a column
						out.print("<td>");
						//Print out current username:
						out.print(result.getString("username"));
						out.print("</td>");
						out.print("<td>");
						//Print out current email:
						out.print(result.getString("email"));
						out.print("</td>");
						out.print("<td>");
						//Print out current phone
						out.print(result.getString("phone"));
						out.print("</td>");
						out.print("<td>");
						//Print out current address
						out.print(result.getString("address"));
						out.print("</td>");
						out.print("</tr>");
		
					} 
					
					out.print("</table>");
		
				//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
				con.close();
		
				
				
			} catch (Exception ex) {
				out.print(ex);
				out.print("Failed");
			}
		} else if(request.getParameter("type") != null && ((String)request.getParameter("type")).equals("bids")){
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
		
				out.print("<h4>My Bids</h4>");
				
				con.close();
			} catch (Exception ex) {
				out.print(ex);
				out.print("Failed");
			}
		} else if(request.getParameter("type") != null && ((String)request.getParameter("type")).equals("auctions")){
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
		
				out.print("<h4>My Auctions</h4>");
				
				con.close();
			} catch (Exception ex) {
				out.print(ex);
				out.print("Failed");
			}
		} else if(request.getParameter("type") != null && ((String)request.getParameter("type")).equals("questions")){
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
		
				out.print("<h4>My Questions</h4>");
				
				con.close();
			} catch (Exception ex) {
				out.print(ex);
				out.print("Failed");
			}
		} else if(request.getParameter("type") != null && ((String)request.getParameter("type")).equals("faq")){
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
				
				out.print("<h4>View Questions</h4>");
				
				out.print("<form name='faqForm' method='post'>");
				out.print("<input id='searchQueryFAQ' type='text'>");
				out.print("<input type='hidden' name='faqSearch'>");
				out.print("<input type='button' value='Search' onclick='setFaqSearch()'>");
				out.print("</form>");
				
				out.print((String)request.getParameter("faqSearch"));
				con.close();
			} catch (Exception ex) {
				out.print(ex);
				out.print("Failed");
			}
		} else if(request.getParameter("type") != null && ((String)request.getParameter("type")).equals("users")){
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
		
				out.print("<h4>View Users</h4>");
				
				out.print("<form name='userForm' method='post'>");
				out.print("<input id='searchQueryUser' type='text'>");
				out.print("<input type='hidden' name='userSearch'>");
				out.print("<input type='button' value='Search' onclick='setUserSearch()'>");
				out.print("</form>");
				
				out.print((String)request.getParameter("userSearch"));
				con.close();
			} catch (Exception ex) {
				out.print(ex);
				out.print("Failed");
			}
		} else if(request.getParameter("type") != null && ((String)request.getParameter("type")).equals("salesReport")){
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
		
				out.print("<h4>Generate Sales Report</h4>");
				
				con.close();
			} catch (Exception ex) {
				out.print(ex);
				out.print("Failed");
			}
		} else if(request.getParameter("type") != null && ((String)request.getParameter("type")).equals("createAccount")){
			try {
				//Get the database connection
				ApplicationDB db = new ApplicationDB();	
				Connection con = db.getConnection();
		
				out.print("<h4>Create a new sales representative account</h4>");
				%>
						<form method="post" action="CustRepSuccessful.jsp">
							<table>
							<tr>    
								<td>Username</td>
							</tr>
							<tr>
								<td>
									<input 
										type="text" 
										name="username"
										pattern="[a-zA-Z][A-Za-z0-9]{1,45}" 
										title="Only letters and numbers. Must start with a letter. Size 1 to 45 characters"
										required = "required">
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
										pattern="[a-zA-Z][a-zA-Z0-9-_.]{1,45}" 
										maxLength="45"
										title="Only letters, numbers, hyphens, underscores, and periods. Must start with a letter. Size 1 to 45 characters"
										required = "required">
								</td>
							</tr>
							<tr>
							<td>Email</td>
							</tr>
							<tr>
								<td>
									<input 
										type="text" 
										name="email"
										pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{0,45}$" 
										maxLength="45"
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
										maxLength="15" 
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
										pattern = "[a-zA-z0-9 ]{0,33}"
										maxLength="33"
										title = "Only letters and numbers. Max length 33"> 
								</td>
							</tr>
							<tr>
								<td>
									<input 
										type="text" 
										name="city"
										placeholder = "City"
										maxLength="33"
										pattern = "[a-zA-z ]{0,33}"
										title = "Only letters. Max length 33">
								</td>
								<td>
									<input 
										type="text" 
										name="state"
										placeholder = "State"
										maxLength="2"
										pattern = "[a-zA-z ]{2}"
										title = "Only letters. Use 2 letter abreviation">
								</td>
								<td>
									<input 
										type="text" 
										name="zip"
										placeholder = "Zip"
										maxLength="5"
										pattern = "[0-9]{5}"
										title = "Enter a 5 digit number">
								</td>
							</tr>
							<tr>
								<td>
									<input 
										type="text" 
										name="country" 
										placeholder = "Country"
										maxLength="33"
										pattern = "[a-zA-z ]{0,33}"
										title = "Only letters. Max length 33">
								</td>
							</tr>
							</table>
							<input type="submit" value="Create">
							</form>
						<br>
				<% 
				con.close();
			} catch (Exception ex) {
				out.print(ex);
				out.print("Failed");
			}
		}
    }
	%>

</body>
<script language="JavaScript">
	function setBtn(str){
		document.infoForm.type.value = str;
		infoForm.submit();
	}
	function setUserSearch(){
		document.infoForm.type.value = "users";
		document.infoForm.userSearch.value = document.getElementById("searchQueryUser").value;
		infoForm.submit();
	}
	function setFaqSearch(){
		document.infoForm.type.value = "faq";
		document.infoForm.faqSearch.value = document.getElementById("searchQueryFAQ").value;
		infoForm.submit();
	}
</script>
</html>