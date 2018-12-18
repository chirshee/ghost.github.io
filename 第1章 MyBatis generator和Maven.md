# 第1章 MyBatis generator和Maven

## MyBatis generator

​	MyBatis generator可以根据数据库表 **反向** 自动生成对应的实体类

​	我们可以修改mybatis-generator-core-1.3.2\lib目录下的 *generatorConfig.xml* ，配置指定的数据库信息和实体类信息

```xml
<?xml version="1.0" encoding="UTF-8"?>  
<!DOCTYPE generatorConfiguration  
  PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"  
  "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">  
<generatorConfiguration>  
	<!-- 基本信息 --> 
    <classPathEntry  location="mysql-connector-java-5.0.7-bin.jar"/>  
    <context id="DB2Tables"  targetRuntime="MyBatis3">  
        <commentGenerator>  
            <property name="suppressDate" value="true"/>  
            <property name="suppressAllComments" value="true"/>  
        </commentGenerator>  
        <!--数据连接信息 -->  
        <jdbcConnection driverClass="com.mysql.jdbc.Driver" connectionURL="jdbc:mysql://localhost:3306/test" userId="root" password="root">  
        </jdbcConnection>  
        <javaTypeResolver>  
            <property name="forceBigDecimals" value="false"/>  
        </javaTypeResolver>  
        <!-- 导出JAVAbean的位置-->  
        <javaModelGenerator targetPackage="com.gonna.domain" targetProject="src">  
            <property name="enableSubPackages" value="true"/>  
            <property name="trimStrings" value="true"/>  
        </javaModelGenerator>  
        <!-- 生成映射文件的位置-->  
        <sqlMapGenerator targetPackage="com.gonna.mapper" targetProject="src">  
            <property name="enableSubPackages" value="true"/>  
        </sqlMapGenerator>  
        <!-- 生产dao的位置-->  
        <javaClientGenerator type="XMLMAPPER" targetPackage="com.gonna.dao" targetProject="src">  
            <property name="enableSubPackages" value="true"/>  
        </javaClientGenerator>  
        <!--表和实体类对应-->  
		<table tableName="student" domainObjectName="Student" enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false"></table>
		<table tableName="parent" domainObjectName="Parent" enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false"></table>
		<table tableName="class" domainObjectName="Class" enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false"></table>
    </context>  
</generatorConfiguration>  
```

​	将mybatis-generator-core-1.3.2\lib\src目录下之前的文件夹清空

​	cmd命令行在mybatis-generator-core-1.3.2\lib目录下运行：

​	*java -jar mybatis-generator-core-1.3.2.jar -configfile generatorConfig.xml -overwrite*

```
C:\Users\Administrator>e:

E:\>cd 常用jar包\mybatis-generator-core-1.3.2\lib

E:\常用jar包\mybatis-generator-core-1.3.2\lib>java -jar mybatis-generator-core-1.3.2.jar -configfile generatorConfig.xml -overwrite
MyBatis Generator finished successfully.

E:\常用jar包\mybatis-generator-core-1.3.2\lib>
```

​	出现 *MyBatis Generator finished successfully.* 则说明配置成功

​	可以看到mybatis-generator-core-1.3.2\lib\src目录下的变化[^数据库表 ]

![MyBatis generator配置结果.gif](https://i.loli.net/2018/11/21/5bf53c6349e54.gif)

​	自动生成的类和数据库的表属性都是一一对应的，mapper中常用的语句也都写好了，直接ctrl+c到工程src下即可直接使用！[^1]

## Maven基础配置

### settings.xml的一些简单配置

```xml
	<!--本地（jar包）仓库路径-->
	<localRepository>E:\maven_localRepository</localRepository>
	<!--获取（jar包）的镜像地址-->
	<mirror>
		<id>nexus-aliyun</id>
		<mirrorOf>central</mirrorOf>
		<name>Nexus aliyun</name>
		<url>http://maven.aliyun.com/nexus/content/groups/public</url>
	</mirror>
	<!--jdk版本-->
	<profile>
		<id>jdk-1.8</id>
		<activation>
			<activeByDefault>true</activeByDefault>
			<jdk>1.8</jdk>
		</activation>
		<properties>
			<maven.compiler.source>1.8</maven.compiler.source>
			<maven.compiler.target>1.8</maven.compiler.target>
			<maven.compiler.compilerVersion>1.8</maven.compiler.compilerVersion>
		</properties>
	</profile>
```

### 建立和Eclipse的关联

 	配置可下载源码等选项

![Maven下载源码.png](https://i.loli.net/2018/11/21/5bf540418b902.png)

 	引入maven的目录

![Maven配置路径.png](https://i.loli.net/2018/11/21/5bf540418d575.png)

 	配置settings.xml文件路径（会自动照文件中配置的本地仓库）

![Maven的user setting.png](https://i.loli.net/2018/11/21/5bf54040aefed.png)

 	新建一个Maven工程

![新建maven工程1.png](https://i.loli.net/2018/11/21/5bf541b505853.png)

![新建maven工程2.png](https://i.loli.net/2018/11/21/5bf541b521ecf.png)

​	 *P.s.Eclipse有一个小bug，新建maven项目若pom.xml出现…missing的错误，需要进行如下操作*

![Eclipse配置Maven的一个小bug.png](https://i.loli.net/2018/11/21/5bf5404183025.png)

​	接下来会看见maven的工程目录和一工程目录的不同：

![maven和一般工程的不同.png](https://i.loli.net/2018/11/21/5bf54389c85d5.png)

​	去maven官网[^2] 搜索需要的jar包

![maven官网搜索jar包.png](https://i.loli.net/2018/11/21/5bf546c758d78.png)

​	最好选择最近最多下载量的版本，打开后复制 **路径依赖**

![maven官网jar包复制依赖.png](https://i.loli.net/2018/11/21/5bf546c6c337e.png)

​	拷贝到pom.xml中

```xml
	<dependencies>
		<!-- https://mvnrepository.com/artifact/org.springframework/spring-webmvc -->
		<dependency>
			<groupId>org.springframework</groupId>
			<artifactId>spring-webmvc</artifactId>
			<version>5.1.1.RELEASE</version>
		</dependency>
	</dependencies>
```

​	保存以后jar包会自动开始下载

![maven官网jar包下载进度条.png](https://i.loli.net/2018/11/21/5bf546c32ef08.png)

​	下载完成以后可以看到maven工程中已有所需jar包（都不用buildpath）

![maven工程的jar包导入结果.png](https://i.loli.net/2018/11/21/5bf546c2b2360.png)

​	此时去maven的本地仓库看看会有惊喜

![maven本地仓库导入结果.png](https://i.loli.net/2018/11/21/5bf546c2b0545.png)





---
[^1]: config.xml需要自行配置指定的mapper.xml
[^2]: https://mvnrepository.com/
[^数据库表 ]: ![SSM测试所用表结构.png](https://i.loli.net/2018/11/25/5bfa46a691fc2.png)
