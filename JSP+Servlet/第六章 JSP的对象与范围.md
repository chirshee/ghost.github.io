# JSP的对象与范围

### 内置对象

* JSP页面中的对象：包括JSP内置对象和用户创建的对象

* JSP内置对象：

  >是web容器创建的一组对象
  >
  >可以在JSP页面上直接使用的对象，无需使用new来获取实例
  >
  >JSP内置对象的名称是JSP中的保留字 

### 范围分类

**Page范围：**页面内有效

 * 客户端请求时，或者发送响应或者转发后销毁
 * 绑定在javax.servlet.jsp.PageContext类的对象中

**request范围：**请求有效

* 每一个用户对同一个页面的请求不同
* 转发（forword）为相同的请求，重定向（sendRedirect）为不同的请求
* 绑定在javax.servlet.http.HttpServletRequest类的对象中

**session范围：**会话有效

* 绑定在javax.servlet.http.HttpServletSession类的对象中

**application范围：**应用有效

* 服务器启动后，访问每一个项目所有用户在相同的application范围内
* 绑定在javax.servlet.ServletContext类的对象中

**属性：**

* 设置：setAttribute(String key,String value)

* 获取：getAttribute(String key)


**PageContext对象：**

> 提供了对JSP页面内所有的对象以及名字空间的访问-------可以访问到本页的session、application的属性等

