# 框架第三节  SpringMVC(2)

### ModelAndView  

> 使用ModelAndView类来储存处理完后的结果数据，以及显示该数据的视图（跳转页面）

```java
        @RequestMapping("test2")
        public ModelAndView test2() {
            List<String> list  = new ArrayList<String>();
            list.add("aa");
            list.add("bb");
            list.add("cc");
            Map<String,Object> map = new HashMap<>();
            //map相当于request的载体
            map.put("list",list);
            ModelAndView mav  = new ModelAndView("welcome", map);
            //另一种表示方法：
            //设置跳转的页面 
            //   ModelAndView mav  = new ModelAndView();
            //mav.setView("welcome");
            //添加传输的数据
            //mav.addObjective("map",map);
            return mav;
        }
    }
```

### 命名空间：

* **页面添加命名空间**：直接建立文件夹，将页面放入

* **在Controller中添加命名空间：**

```java
      //@RequestMapping直接放在类前面 "user"为命名空间的文件夹
      @Controller
      //任何的url带有命名空间，都会保留命名空间
      @RequestMapping("user")
      public class HelloController {
  
      }
```

###### 命名空间之间的切换：

* 命名空间下的页面访问上一级页面中的页面使用**../页面**

* 上一级访问命名空间下的页面用 **命名空间/页面**

###### 使用<base>标签来进行命名空间切换

```xml
    <%String basepath = request.getScheme()+"://"+request.getServerName()
    +":" +request.getServerPort()+request.getContextPath()+"/"; %>
    <html>
    <head>
    <!-- base标签必须在head里面 -->
    <!--添加base标签意味着跳转页面都会从basepath开始 ——>
    <base href ="<%=basepath%>">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Insert title here</title>
    </head>
    <body>
    <a href="test2.jsp">aaaa</a>
    </body>
    </html>
```

### springmvc的form标签：

```xml
    <form:form action="check.do" modelAttribute="user">
    <!-- path相当于普通表单中的name -->
    <!-- 页面绑定的属性和实体类中的属性一定是一样的 -->
    username:<form:input path="username"/><br>
    password:<form:password path="password"/><br>
    <!-- 单选框 -->
    sex:<form:radiobutton path="gender" value = "男" label = "男"/>
    <form:radiobutton path="gender" value = "女" label = "女"/><br>
    <!-- 多选 -->
    telcols:<form:checkbox path="telcols" value = "画画" label = "画画"/>
    <form:checkbox path="telcols" value = "唱歌" label = "唱歌"/><br>
   	<!--下拉框-->
    <form:select path="address" >
    <form:option value ="中国">中国</form:option>
    <form:option value ="美国">美国</form:option> 
    </form:select><br>
    <input type = "submit" value = "submit">
    </form:form>
```

### 解析器：

​	[![解析器.PNG](https://i.loli.net/2018/11/13/5bea2822cdb20.png)](https://i.loli.net/2018/11/13/5bea2822cdb20.png)

* **使用CommonsMultipartResolver来上传文件：**

```java
	@RequestMapping("upload")
	public String fileUpload(MultipartFile file,HttpServletRequest request) throws IllegalStateException, IOException  {
		//上传文件的时候需要关注的两件事情：
		//1.文件存储的路径
		//2.刷新的文件名（当前日期）  
		String path  = request.getSession().getServletContext().getContextPath();
		System.out.println("path:  "+ path);
		System.out.println("filename:  "+file.getName());
		System.out.println("originalFilename:  " + file.getOriginalFilename());
		//刷新当前文件名（文件名不能重复）
		String name = "file" + new Date().getTime()+file.getOriginalFilename();
		System.out.println(name);
		//给储存到服务器的新文件一个相对路径，将上传的文件传到该文件夹
		String realPath = request.getSession().getServletContext().getRealPath("/fileUpload");
		System.out.println("realpath: " + realPath);
		//java中文件处理
		File upfile = new File(realPath,name);
		//将页面的传来的文件转成新的文件，并保存到服务器
		file.transferTo(upfile);
		return "welcome"; 
	}
```

* **文件上传的xml的配置：**

```xml
	<!-- 文件上传的xml-->
	<bean id = "multipartResolver" class = 	"org.springframework.web.multipart.commons.CommonsMultipartResolver"> 
	<property name="maxUploadSize" value = "1024000" ></property>
	<property name="defaultEncoding" value = "utf-8"></property>
```

