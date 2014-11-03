<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
<%@ page import="java.sql.*" %>


<%
	int pageSize = 3;
	
	String strPageNo = request.getParameter("pageNo");
	int pageNo;
	
	if (strPageNo == null || strPageNo.equals("")) {
		pageNo = 1;
	} else {
		try {
			pageNo = Integer.parseInt(strPageNo.trim());
		} catch (NumberFormatException e) {
			pageNo = 1;
		}
		if (pageNo <= 0) {
			pageNo = 1;
		}
	}
	
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost/bbs?user=root&password=tiger";
	Connection conn = DriverManager.getConnection(url);
	
	Statement stmtCount = conn.createStatement();
	ResultSet rsCount = stmtCount.executeQuery("select count(*) from article where pid = 0");
	rsCount.next();
	int totalRecords = rsCount.getInt(1);
	
	int totalPages = (totalRecords % pageSize == 0) ? (totalRecords / pageSize) : (totalRecords / pageSize + 1);
	if (pageNo > totalPages) {
		pageNo = totalPages;
	} 
	
	int startPos = (pageNo - 1) * pageSize;
	
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select * from article where pid = 0 order by pdate desc limit " + startPos + ", " + pageSize);
	
	

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>
<a href="Post.jsp">New Post</a>
<table border="1">

<% 
while (rs.next()) {
%>
	<tr>
		<td>
			<%=rs.getString("title") %>
		</td>
	</tr>
<% 
}
rs.close();
stmt.close();
conn.close();
%>
</table>

<!-- 分页方法1 -->

<%= pageNo %> / total <%= totalPages %> pages
<a href="ShowArticleFlat.jsp?pageNo=<%=pageNo - 1 %>"> < </a>
&nbsp;&nbsp;&nbsp;&nbsp;
<a href="ShowArticleFlat.jsp?pageNo=<%=pageNo + 1 %>"> > </a>

<!-- 分页方法2 -->

<form name="form1" action="ShowArticleFlat.jsp">
	<select name="pageNo" onchange="document.form1.submit()">
		<%
		for(int i=1; i<=totalPages; i++) {
		%>
		<option value=<%=i%> <%=(pageNo == i) ? "selected" : ""%>> 第<%=i%>页
		<%
		}
		%>
	</select>
</form>

<!-- 分页方法3 -->

<form name="form2" action="ShowArticleFlat.jsp">
	<input type="text" size=4 name="pageNo" value=<%= pageNo %> />
	<input type="submit" value="go" />
</form>

</body>

</html>