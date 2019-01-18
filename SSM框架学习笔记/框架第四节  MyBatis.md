# 框架第四节  MyBatis

### Mybatis介绍：

> MyBatis 是一款优秀的**持久层**框架，它支持定制化 SQL、存储过程以及高级映射。MyBatis 避免了几乎所有的 JDBC 代码和手动设置参数以及获取结果集。MyBatis 可以使用简单的 XML 或注解来配置和映射原生信息，将接口和 Java 的 POJOs(Plain Ordinary Java Object,普通的 Java对象)映射成数据库中的记录。

### MyBatis项目流程：

###### 1.创建工程，引入jar包：

![[![mybatis引入jar包.png](https://i.loli.net/2018/11/28/5bfe70e051710.png)](https://i.loli.net/2018/11/28/5bfe70e051710.png)

###### 2.创建实体类

```java
package com.mybatis.domain;
public class User {
	private int id;
	private String name;
	private int age;
	private String sex;
	private String address;
	private User() {
		
	}
	
	public User( String name, int age, String sex, String address) {
		this.name = name;
		this.age = age;
		this.sex = sex;
		this.address = address;
	}

	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	@Override
	public String toString() {
		return "User [id=" + id + ", name=" + name + ", age=" + age + ", sex=" + sex + ", address=" + address + "]";
	}
	
}

```

###### 创建核心配置文件

```xml
<configuration>
	<properties resource="dbinfo.properties"></properties>
	<!-- 给javabean实体类起一个别名，在其他地方引用时只需要别名 -->
	<typeAliases>
		<typeAlias type="com.mybatis.domain.User" alias="_User"/>
	</typeAliases>
	<environments default="development">
		<environment id="development">
			<transactionManager type="JDBC" />
			<dataSource type="POOLED">
				<property name="driver" value="${driver}" />
				<property name="url" value="${url}" />
				<property name="username" value="${user}" />
				<property name="password" value="${pass}" />
			</dataSource>
		</environment>
	</environments>
	<mappers>
		<!-- 把mapper文件写在配置文件中 -->
		<mapper resource="com/mybatis/mapper/userMapper.xml" />
	</mappers>
</configuration>
```

###### 创建mapper文件

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE mapper  PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" 
 "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
 <!-- namespace必须写 当前包名+文件名 用于区别不同mapper文件-->
 <mapper namespace="com.mybatis.mapper.userMapper" >
    <!--id为sql语句方法  resultType是查询执行后的得到的类型-->
 	<select id="selectUsers"  resultType="_User"> 
 	select * from stu
 	</select>
    <!--将入参和出参写入--> 
 	<select id="selectUserById"  parameterType="int" resultType="_User">
 		select * from stu where id=#{id}
 	</select>
 	<insert id="insertUser"  parameterType ="_User">
 	insert into stu values(0,#{name},#{age},#{sex},#{address})
 	</insert>
</mapper>
```

###### 创建SqlSessionFactory

```java
public class Test {
	public static void main(String[] args) throws IOException {
		//加载核心配置文件
		String resource = "config.xml";
		Reader reader = Resources.getResourceAsReader(resource);
		//创建工厂
		SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
		//创建session载体
		SqlSession session = sqlSessionFactory.openSession();	
		System.out.println("=================根据id查用户====================");
		String statement2  = "com.mybatis.mapper.userMapper.selectUserById";
		User user = session.selectOne(statement2, 1);
		System.out.println(user);
		System.out.println("==================插入一个数据====================");
		String statment3 = "com.mybatis.mapper.userMapper.insertUser";
		User u1 = new User("张三",34,"女","成都");
		int flag = 0;
		try {
			flag = session.insert(statment3,u1);
			//必须提交事务
			session.commit();
		}catch(Exception e) {
			System.out.println("插入失败");
			session.rollback();
		}
		System.out.println("==================查询整个表单=================");
		String statement = "com.mybatis.mapper.userMapper.selectUsers";
		List<User> list = session.selectList(statement);
		for(User u :list) {
			System.out.println(u);
		}
	}
}

```

###### Mapper动态开发（创建接口，不用写实现类）

遵循四个原则：

* 接口方法名==Mapper文件中的sql语句的id名
* 返回值类型要和Mapper文件中的返回值类型一致
* 方法的入参和Mapper文件中的入参类型一致
* 实际开发中Mapper文件中的namespace应该是此接口的名

返回值的类型是mapper.xml文件的返回值类型

###### 注意事项：

* 配置config-dtd和mapper-dtd
* 使用properties文件来连接数据库
* 给实体类器别名

```xml
	<!-- 读取properties数据库文件-->
	<properties resource="dbinfo.properties"></properties>
	<!-- 给javabean实体类起一个别名，在其他地方引用时只需要别名 -->
	<typeAliases>
		<typeAlias type="com.mybatis.domain.User" alias="_User"/>
	</typeAliases>
	<!--扫描包下的实体类，自动配置别名   别名User或者是 user都对-->
	<package name ="com.mybatis.domain"/> 
```

* mybatis自带类型处理器：给基本数据类型起别名，不用写全路径的类名
* Maaper文件的位置需要配置

```xml
	<mappers>
		<!-- 把mapper文件写在配置文件中 -->
        <!-- 也可以通过class找来找到Mapper文件，找到的是UserMapper接口，并且必须mapper.xml文件放在一起 -->
        <!--<mapper class = "com.mybatis.mapper.UserMapper"/>-->
		<mapper resource="com/mybatis/mapper/userMapper.xml" />
        <!-- 可以url的来找到  需要绝对路径（没用）-->
        <!--可以用packeage 条件是mapper.xml和接口必须在同一个目录下 并且同名-->
        <!--<package name = "om.mybatis.mapper"/>-->
	</mappers>
```

###### 动态查询：

```xml
<!-- 动态查询   如果没有相关的字段仍然可以查询 -->
 	<select id="selectbyCondtion" resultMap="studentMap" >
 		select * from student where 1=1 
 		<if test="age!=null">
 		and age=#{age}
 		</if>
 		<if test="id!=null">
 		and id=#{id}
 		</if>
 		<if test="name!=null">
 		and name = #{name}
 		</if> 		
 	</select>
```

###### 一 对一 一对多的关联

```xml
<resultMap type="_Student" id="studentMap">
 		<id property="id" column="id"/>
 		<result property="name" column="name"/>
 		<result property="age" column="age"/>
    	<!-- 一对一使用的是association -->
 		<association property="parents" resultMap="parentsMap"/>
 	</resultMap>
 	<resultMap type="_Parents" id="parentsMap">
 		<id property="id" column="id"/>
 		<result property="fname" column="fname"/>
 		<result property="mname" column="mname"/>
 	</resultMap>
 	
 	<resultMap type="_Class" id="classMap">
 		<id property="c_id" column="c_id"/>
 		<result property="c_name" column="c_name"/>
        <!-- 一对多的用collection -->
 		<collection property="list" resultMap="studentMap"></collection>
 </resultMap>
```

###### Mybatis的缓存：

**Mybatis的一级缓存是指**SqlSession。一级缓存的作用域是Sqlsession. **默认开启一级缓存**

在同一个sqlsession中，执行相同的查询语句时，第一次会去数据库中查询，并写到缓存中；第二次直接从缓存中取，当两次查询中间发生了增删改操作，则Sqlsession清空



**Mybatis的二级缓存是指**映射文件，二级缓存的作用域是同一个namespace下的mapper映射文件内容，多个sqlsession文件共享。**二级缓存需要手动配置**

在同一个namespace下的mapper文件中，执行相同的查询sql,第一次会去数据库查询，并写到缓存中；第二次直接从缓存中取，当两次查询中间发生了增删改操作，则二级缓存清空。

```xml
<!-- 在核心配置文件中开启二级缓存-->
<setting name ="cacheEnabled" value="true"/>
<!—— 在mapper文件中加入二级缓存 ——>
<mapper>
<cache/>
</mapper>
```

###### Mybatis二级缓存回收机制：

- 缓存会使用默认的Least Recently Used(LRU，最近最少使用原则)
- 根据时间表，缓存不会以任何时间顺序来刷新。( eg NO Flush Interval  CNFI,没有刷新间隔)
- 缓存会储存列表集合或对象的1024个引用

###### 开启二级缓存的时候的配置：

```xml
<mapper namespace="com.mybatis.usermapper">
<cache eviction="LRU" flushInternal="1000000" size="1024" readOnly="true">
</mapper>
```

* eviction:缓存回收策略

  — LRU:最少使用原则，移除最长时间不使用的对象

  —FIFO:先进先出原则，按照对象进入缓存的顺序进行回收

  —SOFT:软引用,移除基于垃圾回收器状态和软引用规则的对象

  —WEAK:弱引用，更积极的的移除基于垃圾回收器状态和弱引用规则的对象

* flushInternal：刷新时间间隔，单位为毫秒，如果不配置的话只有数据库发生增删改的时候才会刷新
* size:引用额数目，代表缓存最多可以储存的对象个数
* readOnly:是否只读，如果为true,则所有相同的sql语句返回的是同一个对象（有助于提高性能，但是并发操作同一条数据时，可能会不安全），如果设置为false,则相同的sql，后面访问的只是cache的克隆副本

**缓存的对象需要序列化，如果该类有父类，那么父类也要进行序列化**

