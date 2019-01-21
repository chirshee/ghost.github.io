<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib prefix="c" uri ="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>查询页面</title>
</head>
<body>
<table border="1">
<tr>
		<th>ID</th>
		<th>NAME</th>
		<th>AGE</th>
		<th>SEX</th>
		<th>ADDRESS</th>
		<th>操作</th>
		<th>操作2</th>	
</tr>
<c:forEach items="${list }" var="l">
	<tr>
		<th>${l.id }</th>
		<th>${l.name }</th>
		<th>${l.age }</th>
		<th>${l.sex }</th>
		<th>${l.address}</th>
		<td><a href="deleStus?id=${l.id}">删除</a></td>
		<td><a href="selectByPrimaryKey?id=${l.id}">修改</a></td>
	</tr>
</c:forEach>
</table>
<a href="Insert.jsp">插入新的数据</a>
</body>
</html>