# JDBC

### JDBC的驱动程序

> 应用程序编程接口（API）,描述了一套访问关系数据库的标准java类库



#### JDBC驱动

> 实例化时自动向DriverManager注册，不需要显式调用

* 加载JDBC驱动：

1. **Class.forName(String   classname)**

   *  调用类加载器，加载数据库的JDBC驱动类，执行静态方法
   *  java.lang.Class类中的静态方法，返回Class<T>对象（类）

   ```java
   	//1.加载jdbc去驱动类
   	Class.forName("com.mysql.jdbc.Driver")；
   ```

2. **newInstance()**

   * 创建数据库的JDBC驱动类的实例
   * Java.lang.Class类中的静态方法，返回<T>类型的实例

   ```java
   	Class.forName("com.mysql.jdbc.Driver").newInstance()；
   ```

   * 特点：低耦合，只能调用午餐构造方法

3. **new  DriverName()**

   * 创建数据库的JDBC驱动类的实例

   ```java
   	new com.mysql.jdbc.Driver()
   ```

   * 特点：强类型，能调用任何public修饰的构造方法



#### 连接数据库

```java
        //2. 连接数据库
		String url = "jdbc:mysql://localhost:3306/test";
        String user = "root";
        String password = "root";

        Connection conn = DriverManager.getConnection(url, user, password);
```



#### 创建传输对象

```java
        //3.创建传输对象		
        Statement st = conn.createStatement();
```



#### 执行sql语句

```java
		//4.创建sql语句
		String sql = "select * from logintable where username=? and password=?";
		PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, name_page);
        ps.setString(2, pass_page);
		//5.得到结果集，进行遍历
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
            System.out.println(rs.getString("username"));
            System.out.print(rs.getString("password"));
            }
        }
```

#### 资源释放

```java
		conn.close();
		st.close();
		ps.close();
```





### PrepareStatement

* PrepareStatement继承Statement接口
* 更加灵活：以？的形式作为参数，可防止注入攻击

* 效率更高：当需要多次执行sql语句的时候，尽量使用 PrepareStatement。

