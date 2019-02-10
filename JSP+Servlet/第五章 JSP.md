### JSP
> JSP(Java Server Pages) 是一种建立在Servlet规范功能之上的动态网页技术

* 在Html中嵌入java脚本语言
* 由应用服务器中的JSP引擎来编译和执行的嵌入的java脚本语言命令
* 将生成的整个页面信息返回给客户端
* JSP页面组成元素
    * HTML
    * Java片段
    * JSP标签
    * javascript
    * css
### JSP的执行过程
1. 向服务器请求JSP页面
2. tomcat会判断是否是JSP页面,如果是JSP,首先会将JSP进行翻译,翻译成Servlet(.java文件),放在servlet文件夹下的work文件夹,并且进行编译.
3. 然后创建Servlet对象,运行,最后将html中的内容放入打印流中,发送给浏览器进行显示.

### JSP注释
1. JSP注释
    *  一般不会被翻译,也不会被编译
    *  <% …… %>
2. Java注释
    * 会被翻译，不会被编译
    * <% //……  %>
    * <%/*……*/%>
    * <%/**…… */>
3. html注释
    * 会被翻译，也会被编译
    * <!--  ……  -->
### JSP三种指令元素
* Page指令：提供整个JSP网页相关的信息，并且用来设置JSP页面的相关属性（JSP继承了Servlet ,可以说就是Servlet）

  * 一般形式：<%@指令 属性= "属性值" %>
  * 指令不会产生任何的输出到当前的输出流。
  * 在翻译过程中进行处理

1. 功能：设定整个JSP网页的属性和相关功能。

2. 常用属性：page指令共有15个属性

    language ："java" ，指定语言

    import:对象用于导包

    contentType ：“text/html”

    pageEncoding：字符集

    session:可以选择的值只有true和false  ,用于控制在jsp页面能否直接使用session对象。（可以看翻译之后的文件,看是否有session对象）

    errorPage:如果是错误的页面，就跳到该页面

    isErrorPage:errorpage用于指定错误的时候跑到哪一个页面，就是证明一个页面是不是错误页面。
* 脚本元素
1. 声明：
    * 说明：用于声明常量、变量和方法等。
    * 语法：<% ……%>
    * 作用范围：当前JSP页面成员变量，成员方法）
    * 可在一个声明语句中写入多个变量方法，也可以使用多个声明语句。
2. 脚本段
    * 说明：用于处理请求的java代码，可以用于声明，输入，逻辑运算。
    * 语法:<% % >
    * 注：声明的变量为局部变量，不能定义方法。
3. 表达式
    * 说明：写入java语言中完整的表达式
    * 语法：<% %>
    * 等价形式：<% out.print(……)%>
* 动作元素

常用的动作元素：
* <jsp:param>

  > 在包含某个页面的时候，或者跳转某个页面的时候，加入这个参数

* <jsp:forword>

  > <jsp:forword page = "XXX.jsp"></jsp:forword>

* <jsp:test>

* <jsp:setProperty>

* <jsp:getProperty>

* <jsp:useBean>

* <jsp:include>

  > <jsp:include page = "XXX.jsp"></jsp:include>>

* <% include  file = “ ”%>: 包含另一个jsp文件的内容 

  > include的细节：翻译的文件，将另外一个页面的所有内容都包含进来，进行输出。

* <%@taglib  prefix = " " uri =""%>:引入标签库



### JSP内置对象

> 可以在jsp页面中使用这些对象不用创建

（pageContext、request、session、application、   out、exception、page 、config、response）一共九个

1. JSP页面中的对象 ：包括JSP内置对象和用户创建的对象。
2. JSP内置对象是Web容器创建的一组对象
3. JSP内置对象是直接可以正在JSP页面使用的对象，无需使用new获取实例
4. JSP内置对象的名称是JSP的保留字。



### JSP对象的范围

作用范围的分类：

1. Page范围： 只在当前页面
* 客户端在请求时创建，页面发送响应或者转发后销毁
* 绑定在javax.servlet.jsp.PageContext类的对象中
2. request范围：请求有效
* 每个用户对同一个页面访问的访问请求不同
* 转发（forward）为相同请求，重定向（sendRedirect）,为不同的请求
* 绑定在javax.servlet.http.HttpServletRequest类对象中
3. session范围：一次会话（多次请求与响应）
* 绑定在javax.servlet.http.HttpServletSession类对象中
4. application范围：应用有效（服务器关闭不能访问）
* 服务器启动后，访问一个项目所有用户在相同的application范围内
* 绑定在javax.servlet.ServletContext类的对象中。
5. 属性：
* 设置：setAttribute（String  key,String value）方法
* 获取：getAttribute(String key)方法

### JSP的分页
> 将数据库待查询的记录全部放入结果集,在页面进行分页显示.
* JSP页面分页(假分页)
    * 缺点:占内存,不能实时刷新
    * 优点:减少数据库的压力,速度比较块
    * 定义分页变量:
        * PageSize:每页显示的记录数
        * currentPage:当前的页码(从1开始)
        * recoderCount:记录总条数
        * pageCount:总页数
* JSP数据库分页(真分页)
    * 优点:数据能够实时刷新

    * 缺点:速度比较慢JSP

      > JSP(Java Server Pages) 是一种建立在Servlet规范功能之上的动态网页技术

      * 在Html中嵌入java脚本语言
      * 由应用服务器中的JSP引擎来编译和执行的嵌入的java脚本语言命令
      * 将生成的整个页面信息返回给客户端
      * JSP页面组成元素
          * HTML
          * Java片段
          * JSP标签
          * javascript
          * css
      ### JSP的执行过程
      1. 向服务器请求JSP页面
      2. tomcat会判断是否是JSP页面,如果是JSP,首先会将JSP进行翻译,翻译成Servlet(.java文件),放在servlet文件夹下的work文件夹,并且进行编译.
      3. 然后创建Servlet对象,运行,最后将html中的内容放入打印流中,发送给浏览器进行显示.

      ### JSP注释
      1. JSP注释
          *  一般不会被翻译,也不会被编译
          *  <% …… %>
      2. Java注释
          * 会被翻译，不会被编译
          * <% //……  %>
          * <%/*……*/%>
          * <%/**…… */>
      3. html注释
          * 会被翻译，也会被编译
          * <!--  ……  -->
      ### JSP三种指令元素
      > 指令元素：提供整个JSP网页相关的信息，并且用来设置JSP页面的相关属性

      * 一般形式：<%@指令 属性= "属性值" %>
      * 指令不会产生任何的输出到当前的输出流。
      * 在翻译过程中进行处理

      1. 功能：设定整个JSP网页的属性和相关功能。
      2. 常用属性：page指令共有15个属性

          language

          import
      > 脚本元素
      1. 声明：
          * 说明：用于声明常量、变量和方法等。
          * 语法：<% ……%>
          * 作用范围：当前JSP页面成员变量，成员方法）
          * 可在一个声明语句中写入多个变量方法，也可以使用多个声明语句。
      2. 脚本段
          * 说明：用于处理请求的java代码，可以用于声明，输入，逻辑运算。
          * 语法:<% % >
          * 注：声明的变量为局部变量，不能定义方法。
      3. 表达式
          * 说明：写入java语言中完整的表达式
          * 语法：<% %>
          * 等价形式：<% out.print(……)%>
      > 动作元素

      常用的动作元素：
      * <jsp:param>
      * <jsp:forword>
      * <jsp:test>
      * <jsp:setProperty>
      * <jsp:getProperty>
      * <jsp:useBean>

      ### JSP内置对象
      1. JSP页面中的对象 ：包括JSP内置对象和用户创建的对象。
      2. JSP内置对象是Web容器创建的一组对象
      3. JSP内置对象是直接可以正在JSP页面使用的对象，无需使用new获取实例
      4. JSP内置对象的名称是JSP的保留字。

      ### JSP对象的范围

      作用范围的分类：

      1. Page范围
      * 客户端在请求时创建，页面发送响应或者转发后销毁
      * 绑定在javax.servlet.jsp.PageContext类的对象中
      2. request范围：请求有效
      * 每个用户对同一个页面访问的访问请求不同
      * 转发（forward）为相同请求，重定向（sendRedirect）,为不同的请求
      * 绑定在javax.servlet.http.HttpServletRequest类对象中
      3. session范围：
      * 绑定在javax.servlet.http.HttpServletSession类对象中
      4. application范围：应用有效
      * 服务器启动后，访问一个项目所有用户在相同的application范围内
      * 绑定在javax.servlet.ServletContext类的对象中。
      5. 属性：
      * 设置：setAttribute（String  key,String value）方法
      * 获取：getAttribute(String key)方法

      ### JSP的分页
      > 将数据库待查询的记录全部放入结果集,在页面进行分页显示.
      * JSP页面分页(假分页)
          * 缺点:占内存,不能实时刷新
          * 优点:减少数据库的压力,速度比较块
          * 定义分页变量:
              * PageSize:每页显示的记录数
              * currentPage:当前的页码(从1开始)
              * recoderCount:记录总条数
              * pageCount:总页数
      * JSP数据库分页(真分页)
          * 优点:数据能够实时刷新
          * 缺点:速度比较慢