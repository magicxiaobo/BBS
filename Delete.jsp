<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>

<%!

private void del(Connection conn, int id) {
	Statement stmt = null;
	ResultSet rs = null;
	
	try {
		stmt = conn.createStatement();
		String sql = "select * from article where pid = " + id;		// parent id = id: find out its child post
		rs = stmt.executeQuery(sql);
		while (rs.next()) {
			del(conn, rs.getInt("id"));   		// recursive to delete the child posts
		}
		stmt.executeUpdate("delete from article where id = " + id);		// delete the post 
	} catch (SQLException e) {
		e.printStackTrace();
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
		} catch (SQLException ex) {
			ex.printStackTrace();
		}
	}
}
%>

<%
	int id = Integer.parseInt(request.getParameter("id"));
	int pid = Integer.parseInt(request.getParameter("pid"));
	
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost/bbs?user=root&password=tiger";
	Connection conn = DriverManager.getConnection(url);
	
	conn.setAutoCommit(false);
	
	del(conn, id);
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select count(*) from article where pid = " + pid);  //根据删除帖子的parent id，找到它父节点的子节点，并作为一个resultset,因为被删除的帖子和它的父节点的子节点有相同的pid
	rs.next();		//rs point to the first entry of the resultset
	int count = rs.getInt(1);		//retrieve the value of the first column of the first entry, stored it in count
	rs.close();
	stmt.close();
	
	
	if (count <= 0) { // if the count less than or equal to zero, that means 被删除帖子的父节点的子节点的数目为0，应该把被删除帖子的父节点 的isleaf设置为0 
		Statement stmtUpdate = conn.createStatement();
		stmtUpdate.executeUpdate("update article set isleaf = 0 where id = " + pid);
		stmtUpdate.close();
	}
	
	conn.commit();
	conn.setAutoCommit(true);
	conn.close();
	
	response.sendRedirect("ShowArticleTree.jsp");
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>

</body>

</html>