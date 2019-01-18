# Spring

#### Spring ：管理层  （软件的可维护性）

#### SpringMVC : 表现层（Servelet）

#### Mybatis: 持久层（ DAO 数据在内存中是瞬时状态  存在硬盘里面持久化）

### Spring：

* 管理项目中的所有的对象。

> spring Framework 是一个开源的轻量级java/javaEE全功能栈的应用程序框架，作用是实现了程序解耦合和面向切面（AOP）编程

* 核心内容：

> **IOC , AOP**

* 目标：

> 使现有的技术更加易用，推进编码最佳实践，将避免那些可能导致底层代码变得繁杂混乱的大量的属性文件和帮助类。

* 作者：

> Rod  Johnson

* 一站式框架：

> * web层 ：SpringMVC
> * Service:  Spring的bean管理层，Spring声明式事务
> * DAO层：Spring的jdbc模板，Spring的ORM模块

* spring的官方网站

> https://spring.io/

* Spring开发包的结构：

> * docs ：Spring的开发规范和API
> * libs   ：Spring开发的jar和源码
> * scheme: Spring的配置文件约束

### Spring 的创建:

**对扩展开放，对修改开放（OCP原则）**

（1）引入jar包：
​	[![spring.PNG](https://i.loli.net/2018/11/01/5bdadef38e5d9.png)](https://i.loli.net/2018/11/01/5bdadef38e5d9.png)



（2）Spring底层的实现原理

​	[![IOC底层实现.PNG](https://i.loli.net/2018/11/01/5bdaef811e743.png)](https://i.loli.net/2018/11/01/5bdaef811e743.png)



（3）如何不修改源代码，进行扩展

 * 将实现类交给Spring管理：

   ```java
   	//创建Spring的容器
    	ApplicationContext atx = new 		   
           ClassPathXmlApplicationContext("applicationContext.xml");					BaseBean u = (BaseBean) atx.getBean("u1");
   ```

* applicationContext.xml中的配置

    ```xml
    	<!--id属性中为创建的对象  class为类的绝对路径 -->
    	<bean id="u1" class="com.hyt.springtest.User">
          <!--property 中的name为类的属性（eg：getId中的id就是属性）value为该属性进行赋值 -->
    		<property name="no"  value = "20"></property>
    		<property name="addr" ref = "address"></property>
    	</bean>
    	<bean id="address" class = "com.hyt.springtest.address">
    		<property name="city" value = "harbin"></property>
    		<property name="street" value = "songbeijie"></property>
    	</bean>
    ```


### IOC(DI)

> Inverse  of Control(控制反转)  : 将对象的创建权力反转交给Spring
>
> DI: Dependency  Injection（依赖注入）：前提必须有IOC的环境，Spring管理这个类的时候将类的依赖属性注入（设置）进来。
>
> 依赖：比如两个方法互相调用

 ######  Spring的工厂类：

​	[![Spring工厂类.jpg](https://i.loli.net/2018/11/01/5bdaf5f6da807.jpg)](https://i.loli.net/2018/11/01/5bdaf5f6da807.jpg)



###### ApplicationContext :加载配置文件的时候，就会将Spring管理的类都实例化

> ApplicationContext 有两个实现类：
>
> * ClassPathXmlApplicationContext: 加载类路径下的配置文件
> * FileSystemXmlApplicationContext: 加载文件系统下的配置文件

###### Spring的配置：

* bean的相关配置

```xml
		<!--name 和 id的区别：
 		id:使用了约束中的唯一约束，里面不可能出现特殊字符
		name:没有唯一约束，里面可以出现特殊字符
		-->
		<bean id="u1"  name = " " class="com.hyt.springtest.User">
```

* bean生命周期的配置

```xml
        <!-- bean的生命周期 init-method="setup" bean被初始化 destroy-method="destory" bean 			被销毁  setup为初始化方法和destroy销毁方法-->
        <bean id="calc" class = "com.hyt.aoptest01.Cala" init-method="setup" destroy-method="destory"></bean>
```

* bean的作用范围的配置

  Scope:  Bean的作用范围

  * singleton ： 默认的 Spring会采用单例模式创建这个对象
  * prototype:    多例模式
  * request:        应用在web项目中，Spring创建这个类以后，将这个类存入到request范围中
  *  session:        应用在web项目中，Spring创建这个类以后，将这个类存入到session范围中
  * globalsession :   应用在web项目中,必须在porlet（在一个地方存入数据，进入子网站不需要登陆）环境下使用，没有这样的环境，相当于session 

###### Spring属性的注入：

给bean中属性设置值的方式：

* 构造方法：

  ```java
      public class User{
          private String name;
          private String password;
          public User(String name,String password){
              this.name = name;
              this.password = password;
          }
      }
  ```

* set方法方式

  ```java
      public class User{
          private String name；
          private String password；
          public void setName(String name){
          this.name = name;
          }
      }
  ```

* 接口注入方法：

  ```java
      public interface Injection{
          public void setName(String name);
      }
      public class User implements Injection{
          private String name;
          public void setName(String name){
              this.name = name;   
          }
      }
  ```

* Spring 的属性注入支持 **构造方法**和 **set方法方式**

  ```xml
  	<!--构造方法进行属性注入 -->
  	<bean id = "u1"  class="com.hyt.springtest.User">
  		<constructor-arg name ="name" value = "张三"></constructor-arg>
          <constructor-arg name ="password " value = "12345"></constructor-arg>
  	</bean>
  	
  	<!-- set方法进行属性注入-->
  	<bean id = "u1"  class="com.hyt.springtest.User">
  		<property name="name"  value = "张三"></property>
  		<property name="password" value = "12345"></property>
  	</bean>
  	
  	<!-- 设置对象类型  用ref-->
  	<bean id="u1"  class="com.hyt.springtest.User">
  		<property name="no" value = "20"></property>
  		<property name="addr" ref = "address"></property>
  	</bean>
  
  	<bean id="address" class = "com.hyt.springtest.address">
  		<property name="city" value = "harbin"></property>
  		<property name="street" value = "songbeijie"></property>
  	</bean>
  ```

* p名称空间的属性注入(在spring 2.5以后的版本才能用)

  * 通过引用p名称空间完成属性的注入

    * 写法：

      * 普通属性： p:属性名 = “值”

        ```xml
        <!-- p命名空间,用p代替property -->
        <bean id = "student2" class = "com.hyt.DaoImpl.Student" p:name ="李四"></bean>
        ```

      * 对象属性： P:属性名-ref = “值”

        ```xml
        <bean id = "student2" class = "com.hyt.DaoImpl.Student" p:name ="李四" p:address-ref="address"></bean>
        	<bean id = "address" class = "com.hyt.DaoImpl.Address"  p:city = "吉林"  p:street = "baishan"></bean>
        ```

* SpEl的属性注入（Spring3.0以后）

> spEl（Spring Expression Language）SpEL是一种强大的、简洁的装配Bean的方式，它通过运行期执行的表达式将值装配到Bean的属性或构造器参数中。
>
> 可以进行一些计算等，表达式

```xml
	<!--spEl属性注入 -->
	<bean id = "student2" class = "com.hyt.DaoImpl.Student">
	<property name="name" value="#{'小明'}"></property>
	<property name="address" value = "#{address}"></property>
	</bean>
	<!-- address为引用类型变量-->
	<bean id = "address" class = "com.hyt.DaoImpl.Address">
	<property name="city" value ="#{'上海'}"></property>
	<property name="street" value = "#{'南京路'}"></property>
	</bean>
	<!--可以调用方法-->
	<bean id = "student2" class = "com.hyt.DaoImpl.Student">
	<property name="name" value="#{student2.name}"></property>
	<property name="address" value = "#{student2.getName()}"></property>
	</bean>
```

* 集合类型属性注入：

```xml
		<!--spring集合属性的注入 -->
		<!-- 	注入数组类型		 -->
	<bean id = "collectionbean"  class="com.hyt.spring01.CollectionBean">
		<property name="str">
		<list>
			<value>张三</value>
			<value>李四</value>
		</list>
		</property>
        <!--集合属性的注入 -->
		<property name="list">
		<list>
			<value>张三</value>
			<value>李四</value>
		</list>
		</property>
        <!--集合map属性的注入 -->
        <property name="map">
		<map>
            <entry keu = "aaa" value = "张三"></entry>
            <entry keu = "bbb" value = "李四"></entry>
		</map>
		</property>
	</bean>
		
```

###### Spring的分模块开发配置

* 分模块配置
  * 在加载配置文件的时候，加载多个
  * 在一个配置文件中引入多个配置文件

```java
	//（1）可以在创建容器的时候，同时添加几个配置文件进去
	ApplicationContext atx = new ClassPathXmlApplicationContext("ApplicationContext.xml","ApplicationContext2.xml");
	//（2）在一个配置文件中引入另一个或多个配置文件
	<import resoource = "ApplicationContext2.xml">
```

###### SpringIOC注解的使用：

1. 在spring配置文件中组件扫描：

   ```xml
   	//扫描包下的组件	
   	<context:component-scan base-package="com.hyt.springtest02">	</context:component-scan>
   ```

2. 将类声明为组件

   ```java
   	@Component（"User"）
   	public class UserDaoImpl implements UserDao{
   		//没有set方法
       	@Value("小明")
   		private String name;
   		//有set方法时设置值
   		@Value("小明")
   		public void setName(String name){
   			this.name = name;
   		}
   		@Override
   		public void test(){
   			system.out.print("方法执行了")
   		}
   	}
   ```

3. 为属性设置值：
   * 注解方式，使用注解方式，可以没有set方法的
     * 属性如果有set方法，需要将属性注入的注解添加到set方法
     * 属性如果没有set方法，需要将属性注入的注解添加属性上

###### Spring的IOC的注解详解：

**@Component：组件**

* 修饰一个类，将这个类叫给Spring管理
* 这个注解有三个衍生注解（功能类似）
  * @Controller : web层
  * @Service ：业务层
  * @Repository ：Dao层

**属性注入的注解**

* 普通属性：

  * @Value : 设置普通属性的值

* 对象类型的属性：

  * @Autowired  : 设置对象类型的属性的值，但是按照类型完成属性注入

    * 习惯按照名称进行属性的注入，必须让@Autowired注解和@Qualifier一起使用完成按照名称属性注入。

    * @Resource: 完成对象类型的属性值的注入

      ```java
      	@Resource()
      ```

###### Bean的一些其他注解

生命周期相关的注解

* @PostConstruct : 相当于init-method
* @PreDestory ：相当于destory-method

bean的作用范围的注解：

- singleton ： 默认的 Spring会采用单例模式创建这个对象
- prototype:    多例模式
- request:        应用在web项目中，Spring创建这个类以后，将这个类存入到request范围中
- session:        应用在web项目中，Spring创建这个类以后，将这个类存入到session范围中
- globalsession :   应用在web项目中,必须在porlet（在一个地方存入数据，进入子网站不需要登陆）环境下使用，没有这样的环境，相当于session 

###### XML和注解的比较

* 使用场景
  * XML:适用于任何场景
    * 结构清晰，维护方便
  * 注解：有一些地方用不了，这个类不是自己提供的
    * 开发方便

###### XML和注解整合开发：

* XML管理bean ,使用注解进行属性注入

  可以不用扫描包下来判断组件

  在配置文件中使用</context:annotation-config>

