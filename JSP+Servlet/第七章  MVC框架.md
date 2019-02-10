# MVC框架

摘要:

* 掌握javaBean
* 掌握MVC模式
* 掌握DAO模式
* 简单框架的搭建

###  组件(Conponent)

> 是对数据和方法的简单封装

### JavaBean
> 一个遵循一些编码约定的Java类

* 规范:

  1.公开类:public修饰

  2.有默认的构造方法

  3.提供了set和get方法以获得javaBean的属性

  4.实现java.io.Serialzable或java.io.Externalizable接口(支持序列化)

* 特性:

  1.可以实现代码的重复利用

  2.易编写、易维护、易使用

  3.可以在java运行环境的平台上的使用，而不要重新编译

* JavaBean的两种调用方式:

   **嵌入java方法**

```java
<%  ………………  %>
```

​	**使用jsp动作元素**

  ```jsp
    <jsp:useBean id = ... class =....  scope =..../>
  ```

  * id :   javaBean实例对象的名字(严格区分大小写)

  * class:  JavaBean实例对象的完整限定类名(java反射机制)

  * scope:  JavaBean保存的范围(Page,request,session,application)

```jsp
    <jsp:setProperty name =""  property="" param=""
```

* name：已经存在的JavaBean实例对象名字
* property:  javaBean实例对象的书属性名称，可以使用* 代替所有属性同名参数
* param:  请求中获得的参数

```java
	<jsp:getProperty name = ……  property ……>
```

* name:  已经存在的JavaBean实例对象的名字
* property:  javaBean实例对象的属性名称

### MVC

**M**:Model     

> 模型层  封装数据javaBean  java类  EJB

**Ｖ**:View

> 视图层  JSP  专注于显示

**C**:control

> 控制层 Servlet 接收页面的请求  找模型层去处理  然后响应数据出去

### DAO模式

> 以面向对象的形式操作访问数据库



















 