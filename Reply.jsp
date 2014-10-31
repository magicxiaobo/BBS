<%@ page language="java" contentType="text/html; charset=gbk"
    pageEncoding="gbk"%>
    

<% 
	int id = Integer.parseInt(request.getParameter("id"));
	int rootId = Integer.parseInt(request.getParameter("rootid"));
	
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gbk">
<title>Insert title here</title>
</head>
<body>

<form action="ReplyOK.jsp" method="post">
	<input type="hidden" name="id" value=<%= id %>>
	<input type="hidden" name="rootid" value=<%=rootId %>>
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