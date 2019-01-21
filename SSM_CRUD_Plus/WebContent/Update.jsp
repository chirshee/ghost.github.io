<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<body>
${stu.name }
<form action="updateStus" method = "post">
<input type = "hidden" name = "id"  value="${stu.id}">
姓名:<input type="text" name="name" value ="${stu.name }"><br>
年龄:<input type = "text" name = "age" value = "${stu.age }"><br>
性别:<input type ="radio" name = "sex"  value="男">男
	<input type = "radio" name = "sex"  value ="女">女<br>
地址:<input type = "text" name = "address" value = "${stu.address}"><br>
	<input type="submit" name = "submit" value = "提交"> 
</form>
</body>
</html>