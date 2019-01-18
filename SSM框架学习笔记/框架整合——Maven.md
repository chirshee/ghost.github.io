# SSM框架整合（1）——Maven

### Maven

> Maven项目对象模型，可以通过一小段的描述信息来管理项目的构建，报告和文档的项目管理工具软件。																	

### Mybatis根据数据库中的表自动生成实体类以及映射文件

* 配置generatorConfig.xml文件

```xml
<?xml version="1.0" encoding="UTF-8"?>  
<!DOCTYPE generatorConfiguration  
  PUBLIC "-//mybatis.org//DTD MyBatis Generator Configuration 1.0//EN"  
  "http://mybatis.org/dtd/mybatis-generator-config_1_0.dtd">  
<generatorConfiguration>  
	<!-- 基本信息 --> 
    <classPathEntry  location="mysql-connector-java-5.1.47.jar"/>  
    <context id="DB2Tables"  targetRuntime="MyBatis3">  
        <commentGenerator>  
            <property name="suppressDate" value="true"/>  
            <property name="suppressAllComments" value="true"/>  
        </commentGenerator>  
        <!--数据连接信息 -->  
        <jdbcConnection driverClass="com.mysql.jdbc.Driver" connectionURL="jdbc:mysql://localhost:3306/mybatis" userId="root" password="root">  
        </jdbcConnection>  
        <javaTypeResolver>  
            <property name="forceBigDecimals" value="false"/>  
        </javaTypeResolver>  
        <!-- 导出JAVAbean的位置 targetProject里面的路径-->  
        <javaModelGenerator targetPackage="com.hyt.domain" targetProject="src">  
            <property name="enableSubPackages" value="true"/>  
            <property name="trimStrings" value="true"/>  
        </javaModelGenerator>  
        <!-- 生成映射文件的位置-->  
        <sqlMapGenerator targetPackage="com.hyt.mapper" targetProject="src">  
            <property name="enableSubPackages" value="true"/>  
        </sqlMapGenerator>  
        <!-- 生产dao的位置-->  
        <javaClientGenerator type="XMLMAPPER" targetPackage="com.hyt.dao" targetProject="src">  
            <property name="enableSubPackages" value="true"/>  
        </javaClientGenerator>  
       <!--数据中的名 以及实体类的名-->
		<table tableName="student" domainObjectName="Student" enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false"></table>
		<table tableName="parents" domainObjectName="Parents"      	enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false"></table>
		<table tableName="class" domainObjectName="Class" enableCountByExample="false" enableUpdateByExample="false" enableDeleteByExample="false" enableSelectByExample="false" selectByExampleQueryId="false"></table>
    </context>  
</generatorConfiguration>  
```

* 在cmd下执行生成实体类以及mapper文件的命令行

  java -jar mybatis-generator-core-1.3.2.jar -configfile generatorConfig.xml -overwrite​	[![Mybatis自动生成实体类命令行.PNG](https://i.loli.net/2018/11/22/5bf60265616e3.png)](https://i.loli.net/2018/11/22/5bf60265616e3.png)

* 生成的文件的目录结构

  [![mybatis生成的文件.PNG](https://i.loli.net/2019/01/03/5c2defbcf3748.png)](https://i.loli.net/2019/01/03/5c2defbcf3748.png)

* sql语句进行查询时select * from stu 中的 * 可以被代替

  ```sql
  	#将所有的字段写进来，用来代替 * 
  	<sql id ="Base_Column_List">
  		id,name,age
  	</sql>
  	
  	select <include refid="Base_Column_List"/>d
  	where id = #{id}
  
  ```

### 创建Maven工程

* 配置Maven的settings.xml文件 

```xml
	<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
    <!--jar下载后存放的本地仓库路径-->
	<localRepository>E:/Maven</localRepository>
	<pluginGroups>
		<!-- pluginGroup | Specifies a further group identifier to use 
for plugin 
			lookup. <pluginGroup>com.your.plugins</pluginGroup> -->
	</pluginGroups>

	<proxies>
		<!-- proxy | Specification for one proxy, to be used in connecting to the 
			network. | <proxy> <id>optional</id> <active>true</active> <protocol>http</protocol> 
			<username>proxyuser</username> <password>proxypass</password> <host>proxy.host.net</host> 
			<port>80</port> <nonProxyHosts>local.net|some.host.com</nonProxyHosts> </proxy> -->
	</proxies>
	<!-- servers | This is a list of authentication profiles, keyed by the server-id 
		used within the system. | Authentication profiles can be used whenever maven 
		must make a connection to a remote server. | -->
	<servers>
		<!-- server | Specifies the authentication information to use when connecting 
			to a particular server, identified by | a unique name within the system (referred 
			to by the 'id' attribute below). | | NOTE: You should either specify username/password 
			OR privateKey/passphrase, since these pairings are | used together. | <server> 
			<id>deploymentRepo</id> <username>repouser</username> <password>repopwd</password> 
			</server> -->

		<!-- Another sample, using keys to authenticate. <server> <id>siteServer</id> 
			<privateKey>/path/to/private/key</privateKey> <passphrase>optional; leave 
			empty if not used.</passphrase> </server> -->
    </servers>
    <!--maven自动下载jar包的地址，此处使用的阿里云-->
	<mirrors>
		<mirror>
			<id>nexus-aliyun</id>
			<mirrorOf>central</mirrorOf>
			<name>Nexus aliyun</name>
			<url>http://maven.aliyun.com/nexus/content/groups/public</url>
		</mirror>
	</mirrors>
	<!--配置jdk的版本-->
	<profiles>
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
	</profiles>
</settings>
```

* eclipse和Maven关联

  * 对下载jar包的选项进行勾选

![[![maven第一步.PNG](https://i.loli.net/2018/11/22/5bf60b015f9a0.png)](https://i.loli.net/2018/11/22/5bf60b015f9a0.png)
* 将Setting文件配置到进来，自动读取本地仓库的位置

![[![maven步骤二.PNG](https://i.loli.net/2018/11/22/5bf60bad40f31.png)](https://i.loli.net/2018/11/22/5bf60bad40f31.png)

  * 对Maven进行安装/找到maven的路径进行安装

![[![maven步骤三.PNG](https://i.loli.net/2018/11/22/5bf60c5a0ec55.png)](https://i.loli.net/2018/11/22/5bf60c5a0ec55.png)

  * 创建的Maven项目的结构

![[![Maven项目的结构.PNG](https://i.loli.net/2018/11/22/5bf60d5000024.png)](https://i.loli.net/2018/11/22/5bf60d5000024.png)

* 创建maven工程出现的小问题pom.xml出现红叉，显示**web.xml is missing and is set to true**

  原因：这种错误是因为maven默认简单构建项目是sevlet3.0版本，web.xml不是必须的，这时候需要手动创建webapp/WEB-INF/web.xml，web.xml可以从其他项目复制一个过来改改

  ```xml
  	<build>
  	    <pluginManagement>
  	        <plugins>
  	            <plugin>  
  	                <groupId>org.apache.maven.plugins</groupId>  
  	                <artifactId>maven-war-plugin</artifactId>  
  	                <configuration>  
  	                    <failOnMissingWebXml>false</failOnMissingWebXml>  
  	                </configuration>  
  	            </plugin> 
  	        </plugins>
  	    </pluginManagement>
  	</build>
  ```

* 添加WebContent

  ![[![条件webContentG.PNG](https://i.loli.net/2018/11/22/5bf60f39e2909.png)](https://i.loli.net/2018/11/22/5bf60f39e2909.png)

**PS：**可能会出现有一个bug,重复选择Dynamic Web Module错误会取消

### 添加jar包

* 访问https://mvnrepository.com/地址
* 将想要的jar包的配置文件复制，放入pom.xml中
* 第一次使用需要联网，会将所需要的jar包自动下载到本地仓库中

