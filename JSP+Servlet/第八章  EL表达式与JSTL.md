# EL表达式与JSTL

### EL

> Expression Language()  表达式语言

```java
	${requestScope.user }
```

* EL常用内置对象（11个）

1. 作用域访问对象：
     * PageScope
     * requestScope
     * sessionScope
     * applicationScope

2. 参数访问对象：
   * param
   * paramValues

3. JSP隐式对象:
   * pageContext 

4. 头相关对象：

   * header
   * headerValues

5. 参数信息相关对象

   * param
   * paramValues

   * cookie

6. 全局初始化参数：
   * initParam

### JSTL

> JavaServerPages   Standard  Tag  Library  **(JSP标准标签库)**

* 功能:  实现JSP页面标签化
* 优点:

1. 提供一组标准标签

2. 可用于缩写各种JSP动态页面

3. 用于访问数据库

* 使用：必须使用1.1，1.0不支持el表达式

```xml
	<!-- 声明一个对象name,对象的值heyuting,指定的是session域 -->
	<c:set var= "name" value  = "heyuting" scope="session"></c:set>
	<!-- 判断语句-->
	<c:if test ="${age > 16}">
	年龄大于16
	</c:if>
	<!-- 遍历 会储存到page域中  step = 2的意思是跨度-->
	<c:forEach begin = "1" end = "10" var = "i" step = "2">
	${i}
	</c:forEach>
	
```

