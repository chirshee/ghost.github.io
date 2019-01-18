### SpringMVC

Spring代替servlet

1.url到执行代码的映射

2.接受页面的数据（表达，超链接）

3.跳转页面

4.向页面发送数据

5.其他（session cookie）

###### SpringMVC介绍：

* Spring为表现层提供的基于MVC设计理念的优秀web框架，是目前最主流的MVC框架之一。
* SpringMVC通过一套MVC注解，让POJO（POJO（Plain Ordinary Java Object）简单的Java对象，实际就是普通JavaBeans，是为了避免和EJB混淆所创造的简称）成为处理请求的控制器，而无需实现任何接口。
* 支持REST风格的URL请求
* 采用了松散耦合可插拔组件结构，比其他的MVC框架更具有扩展性和灵活性

###### SpringMVC的基础和配置：

###### [![SpringMVC.png](https://i.loli.net/2018/11/03/5bdd4bd5d4e0e.png)](https://i.loli.net/2018/11/03/5bdd4bd5d4e0e.png)

步骤：

* 加入jar包：

  ​	[![sprimvc02.jpg](https://i.loli.net/2018/11/03/5bdd4ebc05fec.jpg)](https://i.loli.net/2018/11/03/5bdd4ebc05fec.jpg)

* 配置web.xml文件

```xml
    <servlet>
            <servlet-name>springDispatcherServlet</servlet-name>
            <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-		class>
            <init-param>
                <param-name>contextConfigLocation</param-name>
                <!--遵守命名规则  src下的spring xml配置文件 为：spring-servlet.xml-->
                <!--加载配置文件,如果没有写,则默认寻找WEB-INF下的<servlet-name>-servlet.xml-->
                <param-value>classpath:spring-servlet.xml</param-value>
            </init-param>
        	<!--创建servlet对象的时机-->
            <load-on-startup>1</load-on-startup>
        </servlet>

        <!-- Map all requests to the DispatcherServlet for handling -->
        <servlet-mapping>
            <servlet-name>springDispatcherServlet</servlet-name>
            <!--为符号“/”代表拦截所有的请求-->
            <!--要拦截的url-->
            <url-pattern>*.do</url-pattern>
        </servlet-mapping>
```

* DispatcherServlet(拦截器)

> DispatcherServlet是前端控制器设计模式的实现,提供Spring Web MVC的集中访问点,而且负责分派,与Spring IOC容器进行无缝连接

* 创建SpringMVC核心配置文件

> 创建SpringMVC核心配置文件Spring-servlet.xml,添加组件扫描.这种基于annotation的方式,SpringMVC会将所有的控制器(功能类似Servlet)看成组件,对标有组件标识的类,自动进行依赖注入.所以要在配置文件中,扫描包.

```java
//对标识了组件的包进行扫描
<context:component-scan base-package="com.springmvc"></context:component-scan>
```

* 创建HelloWorld

```java
    //定义组件的几种方式:
	//@Repository //将dao定义为组件
    //@Service //将service层的类定义为组件
    //@Component //通用
	@Controller//将springmvc的controller定义为组件
    public class HelloController {
        //hello为地址栏输入的url
        //@RequestMapping注解是一个用来请求地址映射的注解，用于类上，表示类中所有的响应请求的方法都是以该地址作为父路径
        //@RequestMapping的属性：
        //value：指定请求的实际地址
        //method:指定请求的method的类型
        @RequestMapping(value="hello",method = RequestMethod.POST)
        public void test() {
            System.out.println("hello  world");
        }
    }

```

###### 页面接收参数的方法：

* url传值
* form表单传值

无论哪种传值方式在控制器的接受方式都是一样的，我们有两种接受传值的方式

* 将页面传值的key(或者表单中name属性的值)作为方法的形参

* 封装成javaBean对象

```java
	//传入的参数为username 和 password
	public void test(String username,String password) {
		System.out.println(username);
		System.out.println(password);
		System.out.println("hello  world");
	}
	//前端页面用<a href="test.do?name=tom&age=10">哈哈哈</a>来传递参数
	@RequestMapping("test")
	public void test1(String name,Integer age) {
		System.out.println(name);
		System.out.println(age);
	}
	
```

* 将表单数据封装成实体类

```java
	/**
	 * 将数据封装成实体类进行传值
	 * @author hyt
	 * */
	@RequestMapping(value = "hello",method = RequestMethod.POST)
	public void test(Users Users) {
		System.out.println(Users);
	}
```

* 使用RequestParam注解来传递参数

```java
	@RequestMapping(value = "hello",method = RequestMethod.POST)
	//value：参数名
	//required：是否必须，默认值为true,表示的请求的参数中必须包含对应的参数，若参数不存在，则会抛出异常

	public void hello(@RequestParam(value="u",required=false) String username,
			@RequestParam(value ="p") String password) {
		System.out.println(username);
		System.out.println(password);
	}
```



###### 跳转页面：

* 如果在Controller方法没有返回值，则会自动按照请求url+.jsp进行访问。如果要指定返回值，则需要在在方法中将返回值定义为String，并对想要跳转的页面进行返回。

```java
  	//没有视图解析器的情况
  	public String  hello(@RequestParam(value="u",required=false) String username,
  			@RequestParam(value ="p") String password) {
  		System.out.println(username);
  		System.out.println(password);
  		return "welcome.jsp";
  	}
```

* 使用视图解析器：

  在配置文件中配置视图解析器：

  视图解析器会将方法返回值和其属性的值进行拼接，得到实际的返回地址，如果方法的返回值为hello,则实际返回的为/WEB-INF/hello.jsp

> WEB-INF的作用：从内部跳转，默认为forword方式跳转

````java
	//配置视图解析器，将welcome.jsp放在WEB-INF下面
	<!--WEB-INF/welcome.jsp -->
	<bean class = "org.springframework.web.servlet.view.InternalResourceViewResolver">
	//prefix为前缀   suffix为后缀
	<property name="prefix" value = "WEB-INF/"></property>
	<property name="suffix" value = ".jsp"></property>
	</bean>
    //java代码
    @RequestMapping(value = "hello",method = RequestMethod.POST)
	public String  hello(@RequestParam(value="u",required=false) String username,
			@RequestParam(value ="p") String password) {
		System.out.println(username);
		System.out.println(password);
		return "welcome";
	}
````

* 如果想要使用redirect(跳过视图解析器)

```java
	//jsp页面不能放在WEB-INF中
	//请求转发
	return "forword:/welcome.jsp"
    //跳转
    return "redirect:/welcome.jsp"
```

* ModelMap：如果想要向Request域储存数据，可在形参中加入ModelMap。SpringMVC在调用方法前会创建一个隐含的模型数据的储存容器。

参数可以在多个servlet中存活

```java
	
	@RequestMapping(value = "hello",method = RequestMethod.POST)
	public String  hello( ModelMap map) {
		List<String> list  = new ArrayList<String>();
		list.add("aa");
		list.add("bb");
		list.add("cc");
		map.addAttribute("list",list);
        //跳转到welcome.jsp页面
		return "welcome";
	}
	@RequestMapping("test")
	public String test1(ModelMap map) {
		return "welcome";
	}
//页面中获取list,此时list在request域中
	${list}
```

