# Request和Response

### 重定向：

```java
			//1.早期的写法
			//response.setStatus(302);
			//response.setHeader("Location", "welcome.html");
			//2.重定向
			response.sendRedirect("welcome.html");

			1.地址显示的最后的资源的路径地址
			2.请求地址最少有两次，服务器在第一次请求之后，会返回302以及一个地址，浏览器在根据这个地址，执行第二次访问
			3.可以跳转到任意的路径，不是自己的工程也可以跳转
			4.效率低一点，执行两次请求
			5.后续的请求，没有办法使用上一个request储存数据，或者是没有办法使用上一次的request的对象，因为这是两次不同的请求
```



### 请求转发

```java
			//重定向
			request.getRequestDispatcher("welcome.html").forward(request, response);

			1.地址上显示的是请求servlet的地址，返回200
			2.请求次数只有一次，因为是服务器内部客户执行了后续的工作
			3.只能跳转自己项目的资源路径
			4.效率上高一点，因为只执行一次请求
			5.可以使用上一次的request的对象
```

