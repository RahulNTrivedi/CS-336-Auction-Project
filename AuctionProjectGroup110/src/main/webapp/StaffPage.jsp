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
	out.print("<h1>Customer Representative " + (String)session.getAttribute("user") + "</h1>");
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