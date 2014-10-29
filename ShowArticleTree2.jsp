<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>

<%
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/bbs?user=root&password=tiger";
	Connection conn = DriverManager.getConnection(url);
	
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * from article");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
<table border="1">
<%
	while (rs.next()) {
%>
		<tr>
			<td><%= rs.getInt("id") %></td>
			<td><%= rs.getString("cont") %></td>
		</tr>
<%		
	}
%>
 </table>
 <h2>I am here!</h2>
</body>

<%
	rs.close();
	stmt.close();
	conn.close();
 %>
</html>