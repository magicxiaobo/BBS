<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>

<%@ page import="java.sql.*" %>

<%!
String str = "";
public void tree(Connection conn, int id, int level) {
	Statement stmt = null;
	ResultSet rs = null;
	
	String preStr = "";
	for (int i = 0; i < level; i++) {
		preStr += "----";
	}
	
	try {
		stmt = conn.createStatement();
		rs = stmt.executeQuery("select * from article where pid =" + id);
		while (rs.next()) {
			str += "<tr><td>" + rs.getInt("id") + "</td><td>" + preStr + rs.getString("title") + "</td></tr>";
			if (rs.getInt("isleaf") != 0) {
				tree(conn, rs.getInt("id"), level + 1);
			}
		}
	} catch (SQLException ex) {
		ex.printStackTrace();
	} finally {
		try {
			if (rs != null) {
				rs.close();
				rs = null;
			}
			if (stmt != null) {
				stmt.close();
				stmt = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
 %>
 
 <%
 Class.forName("com.mysql.jdbc.Driver");
 Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs?user=root&password=tiger");
 Statement stmt = conn.createStatement();
 String sql = "select * from article where pid = 0";
 ResultSet rs = stmt.executeQuery(sql);
 while (rs.next()) {
 	str += "<tr><td>" + rs.getInt("id") + "</td><td>" + rs.getString("title") + "</td></tr>";
 	if (rs.getInt("isleaf") != 0) {
 		tree(conn, rs.getInt("id"), 1);
 	}
 }
 
 rs.close();
 stmt.close();
 conn.close();
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
<table border="1"> 
	<%= str %>
	
</table> 
<% str = ""; %>
</body>
</html>