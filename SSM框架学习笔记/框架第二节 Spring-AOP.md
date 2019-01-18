# (SSM)框架第二节: Spring  -  AOP

### AOP（Aspect Oriented Programming）:

> 面向切面编程，通过[预编译](https://baike.baidu.com/item/%E9%A2%84%E7%BC%96%E8%AF%91/3191547)方式和运行期动态代理实现程序功能的统一维护的一种技术。AOP是[OOP](https://baike.baidu.com/item/OOP)的延续，是软件开发中的一个热点，也是[Spring](https://baike.baidu.com/item/Spring)框架中的一个重要内容，是[函数式编程](https://baike.baidu.com/item/%E5%87%BD%E6%95%B0%E5%BC%8F%E7%BC%96%E7%A8%8B/4035031)的一种衍生范型。利用AOP可以对业务逻辑的各个部分进行隔离，从而使得业务逻辑各部分之间的[耦合度](https://baike.baidu.com/item/%E8%80%A6%E5%90%88%E5%BA%A6/2603938)降低，提高程序的可重用性，同时提高了开发的效率。

#### AOP的功能：

 	AOP可以进行权限的检验，日志记录，性能监测，事务控制

#### Spring底层AOP的实现：

*  JDK的动态代理：只能对实现了接口的类产生代理

* Cglib动态代理：对没有接口的类产生代理对象，生成子类对象

**cglib**:开源的代码生成类库，可以动态添加方法和属性（spring的环境已经带cglib的包）

#### SpringAOP的开发（AspectJ的xml方式）：

> aop思想是aop联盟提出的，spring是使用最好的。**AspectJ**是AOP的框架。

#### AOP开发的术语：

* JoinPoint（连接点）:可以被拦截到的点
* PointCount（切入点）：真正被拦截到的点
* advice(通知，增强): 权限的校验的方法称是通知（方法层面的增强）
* Introduction(引介):类层面的增强

* Target(目标)：被增强的对象
* Weaving(织入)：将通知应用（advice）到目标（Target）的过程，将权限校验的方法的代码应用到对象的方法上的过程

#### Spring的AOP入门

###### 创建web项目，引入jar包

* 引入基本开发包
* 引入AOP开发相关jar包

###### 引入Spring 的配置文件

```java
/**
 * AOP入门
 * spring的单元测试
 * @author Administrator
 *
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("classpath:applicationContext.xml")
public class Springtest {
	@Resource(name="productDao")
	private productDao productDao;
	
	@Test
	public void demo1() {
		productDao.save();
		productDao.apdate();
		productDao.delete();
		productDao.find();
	}
}
```

###### 编写一个切面类：

* 编写切面

```java
    public class MyAspectXML {
        public void checkpri() {
            System.out.println("权限校验========");
        }
    }
```

* 将切面类交给Spring管理

```xml
	<!-- 配置目标对象  -->
	<bean id ="productDao"  class = "com.springaop.daoimpl.productDaoImpl"></bean>
	<!-- 将切面类交给Spring -->
	<bean id = "MyAspect" class = "test.MyAspectXML"></bean>
	<!-- 通过AOP的配置完成对目标类产生代理 -->

	<aop:config>
		<!-- 表达式配置有哪些方法需要进行增强 -->
		<aop:pointcut expression="execution(* com.springaop.daoimpl.productDaoImpl.save(..))"  id="pointcut1"/>
		<!-- 配置切面 -->
		<aop:aspect ref = "MyAspect">
			<aop:before method="checkPri" pointcut-ref="pointcut1"/>
		</aop:aspect>
	</aop:config>
```

###### 切面的通知类型：

* 前置通知：在目标方法执行之前进行操作

  ```xml
  	<aop:before method = "checkpri" pointcut-ref="pointcut1"></aop:before>
  ```

* 后置通知：在目标方法执行之后进行操作

  ```xml
  	<!--可以获得方法返回值-->
  	<aop:after-returning method = "writeLog" pointcut-ref="pointcut2" returning = "result"></aop:after-returning>
  ```

* 环绕通知：在目标方法执行之前和之后进行操作

  ```xml
      <!--可以阻止目标方法的执行-->	
      <aop:around method = "around" pointcut-ref = "pointcut3"></aop:around>
  ```

* 异常抛出通知：程序出现异常的时候，进行的操作

  ```xml
  	<!--异常抛出-->
  	<aop:after-throwing method = "afterThrowing" pointcut-ref = "pointcut4"></aop:after-throwing>
  ```

* 最终通知：无论代码是否有异常，总是会执行

  ```xml
  	<!--相当于finlly-->
  	<aop:after method = "finally"  pointcut-ref = "pointcut5" ></aop:after>
  ```

* 引介通知（不需要会）：

###### spring切入点表达式的写法：

* 语法：
  * 【访问修饰符】   方法返回值 包名类名.方法名（参数）
  * public void com.hyt.springaop.CustomerDao.save(**)
  * *号代表任意   并且 * 可以代替任何的词



### Spring的AOP的基于AspectJ注解的开发

###### 创建web项目

###### 引入jar包

​		[![AOP.png](https://i.loli.net/2018/11/14/5bebe0a2c6a8d.png)](https://i.loli.net/2018/11/14/5bebe0a2c6a8d.png)

###### 引入配置文件

###### 创建目标类

```xml
	<!-- 配置目标类 -->
	<bean id= "orderDao" class = "com.springaop.demo01.OrderDao"></bean>
```

###### 编写切面类

```java
	public class MyAspectAnno {
        public void before() {
            System.out.println("前置通知");
        }
}
```

###### 配置切面类

```xml
	<!-- 配置切面类 -->
	<bean id = "MyAspect" class = "com.springaop.demo01.MyAspectAnno"></bean>
```

###### 使用注解的AOP对象目标类进行增强

* 在配置文件中打开注解的AOP开发

```xml
	<!-- 在配置文件中开启注解的AOP开发 -->
	<aop:aspectj-autoproxy></aop:aspectj-autoproxy>
```

* 在切面类上使用注解

```java
 /**
 * 注解的aop切面类
 * @author Administrator
 *
 */
@Aspect
public class MyAspectAnno {
	@Before(value ="execution(* com.springaop.demo01.OrderDao.delete(..))")
	public void before() {
		System.out.println("前置通知.......");
	}
}
```

### 注解AOP的通知类型：

* @Before: 前置通知

* @AfterReturning :后置通知

  ```java
  	//可以获得save方法中result的值，并且returing参数的值和方法的参数名一样
  	@AfterReturning(value ="execution(* com.springaop.demo01.OrderDao.save(..))",
  			returning = "result")
  	public void  AfterReturning(Object result) {
  		System.out.println("后置通知......."+ result);
  		
  	}
  ```

* @Around:环绕通知

  ```java
      	@Around(value ="execution(* com.springaop.demo01.OrderDao.update(..))")
          public Object Around(ProceedingJoinPoint joinPoint) throws Throwable {
              System.out.println("环绕前.......");
              //proceed用来执行update方法
              Object object = joinPoint.proceed();
              System.out.println("环绕后.......");
              return object;
          }
  ```

* @AfterThrowing:异常抛出通知

  ```java
  @AfterThrowing(value ="execution(* com.springaop.demo01.OrderDao.find(..))",throwing="e")
  	public void AfterThrowing(Throwable e)  {
  		System.out.println("抛出异常==========="+e.getMessage());
  		
  	}
  ```

* @After:最终通知

  ```java
  @After("execution(* com.springaop.demo01.OrderDao.find(..))")
  	public void After() {
  		System.out.println("最后通知.........");
  	}
  ```


