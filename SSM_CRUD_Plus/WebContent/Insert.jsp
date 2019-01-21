<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
<h1>请输入您的信息</h1>
<form action="insertStus" method = "post">
姓名:<input type="text" name="name"><br>
年龄:<input type = "text" name = "age"><br>
性别:<input type ="radio" name = "sex"  value="1">男
	<input type = "radio" name = "sex"  value = "2">女<br>
地址:<input type = "text" name = "address"><br>
	<input type="submit" name = "submit" value = "提交"> 
</form>
</body>
</html>