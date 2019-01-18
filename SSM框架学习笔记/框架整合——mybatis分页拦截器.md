# 框架整合——mybatis分页拦截器

### 分页拦截器的使用：

###### 1.引入jar包，向pom.xml中添加依赖

```xml
	<!-- pagehelper分页插件 -->
	<dependency>
	    <groupId>com.github.pagehelper</groupId>
	    <artifactId>pagehelper</artifactId>
	    <version>5.1.2</version>
	</dependency>
```

###### 2. 在mybatis配置文件中进行配置

```xml
<plugins>
    <!-- com.github.pagehelper为PageHelper类所在包名 -->
    <plugin interceptor="com.github.pagehelper.PageInterceptor">
        <!-- 使用下面的方式配置参数，后面会有所有的参数介绍 -->
        <property name="pageSizeZero" value="true"/>
	</plugin>
</plugins>
```

如果使用spring进行托管mybatis，另一种用法详见文档

###### 3.在controller中进行配置

```java
	@RequestMapping("getStus")
	//给page设置默认值，没有输入页数的时候，默认是第一页
	public void getStus(@RequestParam(value="page",defaultValue="1") Integer page) {
		PageHelper.startPage(page,getUtil.PageSize);
		List<Student> list = stuSerive.selectStudents();
		for(Student s: list) {
			System.out.println(s);
		}
	}	
```

