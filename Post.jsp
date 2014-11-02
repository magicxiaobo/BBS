<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
    
<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
    
<%@ page import="java.sql.*" %>

<% 
	request.setCharacterEncoding("gbk");
	String action = request.getParameter("action");
	if (action != null) {
		String title = request.getParameter("title");
		String cont = request.getParameter("cont");
		
		cont = cont.replaceAll("\n", "<br>");
		
		Class.forName("com.mysql.jdbc.Driver");
		String url = "jdbc:mysql://localhost/bbs?user=root&password=tiger";
		Connection conn = DriverManager.getConnection(url);
		
		conn.setAutoCommit(false);
		
		String sql = "insert into article values (null, 0, ?, ?, ?, now(), 0)";
		PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);		//statement在创建的过程中会自动的生成一些keys 
		Statement stmt = conn.createStatement();
				
		pstmt.setInt(1, -1);
		pstmt.setString(2, title);
		pstmt.setString(3, cont);
		pstmt.executeUpdate();
		
		ResultSet rsKey = pstmt.getGeneratedKeys();
		rsKey.next();
		int key = rsKey.getInt(1);
		rsKey.close();
		stmt.executeUpdate("update article set rootid = " + key + "where id= " + key);		//只设置新帖子的rootid 
		 
		conn.commit();
		conn.setAutoCommit(true);
		
		stmt.close();
		pstmt.close();
		conn.close();
		
		response.sendRedirect("ShowArticleTree.jsp");
	}
%>
    

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
		<!-- Post to itself -->
<form action="Post.jsp" method="post">	
	<input type="hidden" name="action" value="post">
	<table border="1">
		<tr>
			<td>
				<input type="text" name="title" size="90">
			</td>
		</tr>
		<tr>
			<td>
				<textarea cols="80" rows="12" name="cont"></textarea>
			</td>
		</tr>
		<tr>
			<td>
				<input type="submit" value="submit">
			</td>
		</tr>
	</table>
</form>

</body>
</html>