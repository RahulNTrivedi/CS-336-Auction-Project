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
					result.next();
					
					out.print("<h4>User Info</h4>");
					
					out.print("<h4>Username</h4>");
					out.print("<p>" + result.getString("username") + "</p>");
					
					out.print("<h4>Password</h4>");
					out.print("<p>" + result.getString("password") + "</p>");
					
					out.print("<h4>Email</h4>");
					out.print("<p>" + result.getString("email") + "</p>");
					
					out.print("<h4>Phone</h4>");
					out.print("<p>" + result.getString("phone") + "</p>");
					
					out.print("<h4>Address</h4>");
					out.print("<p>" + result.getString("address") + "</p>");

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
				
				Statement stmt = con.createStatement();
				ResultSet result = stmt.executeQuery("SELECT * FROM auction a, makesbid m WHERE a.auctionID=m.auctionID AND m.accountUser='" + session.getAttribute("user") + "';");
				out.print("<table>");
				out.print("<tr>");
				out.print("<td>");
				out.print("Auction");
				out.print("</td>");
				out.print("<td>");
				out.print("Amount");
				out.print("</td>");
				out.print("</tr>");
				while(result.next()){
					out.print("<tr>");
					out.print("<td>");
					out.print("<form method='get' action='ItemPage.jsp'>");
					out.print("<input type='hidden' name='auctionID' value='" + result.getString("a.auctionID") +"'>");
					out.print("<input type='submit' value='View'>");
					out.print("</form>");
					out.print("</td>");
					out.print("<td>");
					out.print(result.getString("m.amount"));
					out.print("</td>");
					out.print("</tr>");
				}
				out.print("</table>");
				
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
				
				Statement stmt = con.createStatement();
				ResultSet result = stmt.executeQuery("SELECT * FROM auction a WHERE a.accountUser='" + session.getAttribute("user") + "';");
				out.print("<table>");
				out.print("<tr>");
				out.print("<td>");
				out.print("Auction");
				out.print("</td>");
				out.print("</tr>");
				while(result.next()){
					out.print("<tr>");
					out.print("<td>");
					out.print("<form method='get' action='ItemPage.jsp'>");
					out.print("<input type='hidden' name='auctionID' value='" + result.getString("a.auctionID") +"'>");
					out.print("<input type='submit' value='View'>");
					out.print("</form>");
					out.print("</td>");
					out.print("</tr>");
				}
				out.print("</table>");
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
				
				Statement stmt = con.createStatement();
				String str = "SELECT * FROM asksquestion WHERE endUsername='" + session.getAttribute("user") + "';";
				ResultSet result = stmt.executeQuery(str);
	
				out.print("<h4>My Questions</h4>");
				//parse out the results
				while (result.next()) {
					//make a row
					out.print("<tr>");
					//make a column
					out.print("<form method='get' action='ViewQuestion.jsp'>");
					out.print("<input type='hidden' value='" + result.getString("questionID") + "' name='questionID'>");
					out.print("<input type='submit' value='" + result.getString("questionDetails") + "'>");
					
					out.print("</form>");
					out.print("</tr>");
	
				} 				
				
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
				
				Statement stmt = con.createStatement();
				String str = "SELECT * FROM asksquestion;";
				ResultSet result = stmt.executeQuery(str);
				
				out.print("<h4>View Questions</h4>");
				
				out.print("<form name='faqForm' method='post'>");
				out.print("<input id='searchQueryFAQ' type='text'>");
				out.print("<input type='hidden' name='faqSearch'>");
				out.print("<input type='button' value='Search' onclick='setFaqSearch()'>");
				out.print("</form>");
				
				out.print("<table'>");
				while(result.next()){
					if(request.getParameter("faqSearch") == null || ((String) request.getParameter("faqSearch")).equals("")
							|| (result.getString("endUsername") + " " + result.getString("questionDetails")).toLowerCase().contains((String) request.getParameter("faqSearch"))){
						out.print("<tr>");
						//make a column
						out.print("<form method='get' action='ViewQuestion.jsp'>");
						out.print("<input type='hidden' value='" + result.getString("questionID") + "' name='questionID'>");
						out.print("<input type='submit' value='" + result.getString("endUsername") + ": " + result.getString("questionDetails") + "'>");
						
						out.print("</form>");
						out.print("</tr>");
					}
				}
				
				out.print("</table>");
				
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
				
				Statement stmt = con.createStatement();
				String str = "SELECT * FROM account WHERE isStaff = 0;";
				ResultSet result = stmt.executeQuery(str);
		
				out.print("<h4>View Users</h4>");
				
				out.print("<form name='userForm' method='post'>");
				out.print("<input id='searchQueryUser' type='text'>");
				out.print("<input type='hidden' name='userSearch'>");
				out.print("<input type='button' value='Search' onclick='setUserSearch()'>");
				out.print("</form>");
				
				out.print("<table'>");
				while(result.next()){
					if(request.getParameter("userSearch") == null || ((String) request.getParameter("userSearch")).equals("")
							|| (result.getString("username")).toLowerCase().contains((String) request.getParameter("userSearch"))){
						out.print("<tr>");
						//make a column
						out.print("<form method='get' action='EditUser.jsp'>");
						out.print("<input type='hidden' value='" + result.getString("username") + "' name='username'>");
						out.print("<input type='submit' value='" + result.getString("username") + "'>");
						
						out.print("</form>");
						out.print("</tr>");
					}
				}
	
				
				out.print("</table>");
				
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
		
				Statement stmt = con.createStatement();
				String str = "SELECT SUM(a.maxBid) val FROM auction a WHERE winner IS NOT null;";
				ResultSet result = stmt.executeQuery(str);
				result.next();
				
				out.print("<h4>Generate Sales Report</h4>");
				out.print("<h2>Total Earnings: " + result.getString("val")+ "</h2>");
				out.print("<h2>Earnings per Item Type: </h2>");
				
				str = "SELECT itemType, SUM(max) earnings FROM (SELECT auctionID, a.maxBid max FROM auction a WHERE winner IS NOT null) AS bids, hasa_schoolsupply has WHERE has.auctionID = bids.auctionID GROUP BY itemType;";
				result = stmt.executeQuery(str);
				
				out.print("<table border='1' cellpadding='5' style='table-layout: fixed; width:100%;'>");
				out.print("<tr>");
				out.print("<th style='word-wrap: break-word; width:20%'>Item Type</th>");
				out.print("<th style='word-wrap: break-word; width:20%'>Earnings</th>");
				out.print("</tr>");
				while(result.next() && result.getString("itemType") != null){
					out.print("<tr>");
					out.print("<td style='word-wrap: break-word'>" + result.getString("itemType") + "</td>");
					out.print("<td style='word-wrap: break-word'>" + result.getString("earnings") + "</td>");
					out.print("</tr>");
				}
				out.print("</table>");
				
				out.print("<h2>Earnings per Item: </h2>");
				
				out.print("<h3>Notebook:</h3>");
				str = "SELECT color, name, SUM(max) earnings FROM (SELECT a.auctionID, a.maxBid max FROM auction a WHERE winner IS NOT null) AS auc, notebook n WHERE auc.auctionID = n.auctionID GROUP BY color, name;";
				result = stmt.executeQuery(str);
				out.print("<table border='1' cellpadding='5' style='table-layout: fixed; width:100%;'>");
				out.print("<tr>");
				out.print("<th style='word-wrap: break-word; width:20%'>Color</th>");
				out.print("<th style='word-wrap: break-word; width:20%'>Name</th>");
				out.print("<th style='word-wrap: break-word; width:20%'>Earnings</th>");
				out.print("</tr>");
				while(result.next() && result.getString("name") != null){
					out.print("<tr>");
					out.print("<td style='word-wrap: break-word'>" + result.getString("color") + "</td>");
					out.print("<td style='word-wrap: break-word'>" + result.getString("name") + "</td>");
					out.print("<td style='word-wrap: break-word'>" + result.getString("earnings") + "</td>");
					out.print("</tr>");
				}
				out.print("</table>");
				
				out.print("<h3>Textbook:</h3>");
				str = "SELECT title, author, SUM(max) earnings FROM (SELECT a.auctionID, a.maxBid max FROM auction a WHERE winner IS NOT null) AS auc, textbook t WHERE auc.auctionID = t.auctionID GROUP BY author, title";
				result = stmt.executeQuery(str);
				out.print("<table border='1' cellpadding='5' style='table-layout: fixed; width:100%;'>");
				out.print("<tr>");
				out.print("<th style='word-wrap: break-word; width:20%'>Title</th>");
				out.print("<th style='word-wrap: break-word; width:20%'>Author</th>");
				out.print("<th style='word-wrap: break-word; width:20%'>Earnings</th>");
				out.print("</tr>");
				while(result.next() && result.getString("title") != null){
					out.print("<tr>");
					out.print("<td style='word-wrap: break-word'>" + result.getString("title") + "</td>");
					out.print("<td style='word-wrap: break-word'>" + result.getString("author") + "</td>");
					out.print("<td style='word-wrap: break-word'>" + result.getString("earnings") + "</td>");
					out.print("</tr>");
				}
				out.print("</table>");
				
				out.print("<h3>Calculator:</h3>");
				str = "SELECT model, brand, SUM(max) earnings FROM (SELECT a.auctionID, a.maxBid max FROM auction a WHERE winner IS NOT null) AS auc, calculator c WHERE auc.auctionID = c.auctionID GROUP BY model, brand;";
				result = stmt.executeQuery(str);
				out.print("<table border='1' cellpadding='5' style='table-layout: fixed; width:100%;'>");
				out.print("<tr>");
				out.print("<th style='word-wrap: break-word; width:20%'>Model</th>");
				out.print("<th style='word-wrap: break-word; width:20%'>Brand</th>");
				out.print("<th style='word-wrap: break-word; width:20%'>Earnings</th>");
				out.print("</tr>");
				while(result.next() && result.getString("model") != null){
					out.print("<tr>");
					out.print("<td style='word-wrap: break-word'>" + result.getString("model") + "</td>");
					out.print("<td style='word-wrap: break-word'>" + result.getString("brand") + "</td>");
					out.print("<td style='word-wrap: break-word'>" + result.getString("earnings") + "</td>");
					out.print("</tr>");
				}
				out.print("</table>");
				
				out.print("<h2>Earnings per End User: </h2>");
				str = "SELECT winner username, SUM(maxBid) earnings FROM auction WHERE winner IS NOT null GROUP BY winner;";
				result = stmt.executeQuery(str);
				
				out.print("<table border='1' cellpadding='5' style='table-layout: fixed; width:100%;'>");
				out.print("<tr>");
				out.print("<th style='word-wrap: break-word; width:20%'>Username</th>");
				out.print("<th style='word-wrap: break-word; width:20%'>Earnings</th>");
				out.print("</tr>");
				while(result.next() && result.getString("username") != null){
					out.print("<tr>");
					out.print("<td style='word-wrap: break-word'>" + result.getString("username") + "</td>");
					out.print("<td style='word-wrap: break-word'>" + result.getString("earnings") + "</td>");
					out.print("</tr>");
				}
				out.print("</table>");
				
				out.print("<h2>Best Buyers: </h2>");
				str = "SELECT winner username, SUM(maxBid) earnings FROM auction WHERE winner IS NOT null GROUP BY winner ORDER BY earnings DESC LIMIT 5;";
				result = stmt.executeQuery(str);
				
				out.print("<table border='1' cellpadding='5' style='table-layout: fixed; width:100%;'>");
				out.print("<tr>");
				out.print("<th style='word-wrap: break-word; width:20%'>Username</th>");
				out.print("<th style='word-wrap: break-word; width:20%'>Earnings</th>");
				out.print("</tr>");
				while(result.next() && result.getString("username") != null){
					out.print("<tr>");
					out.print("<td style='word-wrap: break-word'>" + result.getString("username") + "</td>");
					out.print("<td style='word-wrap: break-word'>" + result.getString("earnings") + "</td>");
					out.print("</tr>");
				}
				out.print("</table>");
				
				out.print("<h2>Best Selling Items: </h2>");
				str = "SELECT items.auctionID, items.author, items.title, items.brand, items.model, items.color, items.name, maxVal.max as earnings FROM (SELECT a.auctionID, t.author, t.title, c.brand, c.model, n.color, n.name FROM hasa_schoolsupply a LEFT JOIN textbook AS t ON a.auctionID = t.auctionID LEFT JOIN calculator AS c ON a.auctionID = c.auctionID LEFT JOIN notebook AS n ON a.auctionID = n.auctionID) AS items, (SELECT a.auctionID, a.maxBid max FROM auction a WHERE winner IS NOT null) AS maxVal WHERE maxVal.auctionID = items.auctionID ORDER BY earnings DESC LIMIT 5;";
				result = stmt.executeQuery(str);
				int x = 1;
				while(result.next() && result.getString("earnings") != null){
					if(result.getString("name") != null){
						out.print(x++ + ".");
						out.print("<p>Item Type: Notebook</p><p>Color: " + result.getString("color") + "</p><p>Name: " + result.getString("name") + "</p><p>Earnings: " + result.getString("earnings")+ "</p><br />");
					} else if (result.getString("brand") != null){
						out.print(x++ + ".");
						out.print("<p>Item Type: Calculator</p><p>Brand: " + result.getString("brand") + "</p><p>Model: " + result.getString("model") + "</p><p>Earnings: " + result.getString("earnings") + "</p><br />");
					} else {
						out.print(x++ + ".");
						out.print("<p>Item Type: Textbook</p><p>Title: " + result.getString("title") + "</p><p>Author: " + result.getString("author") + "</p><p>Earnings: " + result.getString("earnings") + "</p><br />");
					}
				}
				
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