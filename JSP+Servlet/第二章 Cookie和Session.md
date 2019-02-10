# Cookie和Session

### cookie

> 是一份小数据，是服务器端给客户端，并且储存在客户端上的一份小数据

* 应用场景
> 自动登陆、浏览记录

* 为什么要有Cookie

>http请求是无状态的。为了更好的用户体验更好

* cookie的使用

  * 添加cookie给客户端

  1. 在响应的时候，添加cookie

  ```java
     Cookie cookie = new Cookie("aa", "bb");
     response.addCookie(cookie );
  ```

  2. 客户端收到的信息里面，相应头中多了一个字段，set-cookie



  * 获取客户端带来的coookie

  ```java
      //获取客户端传过来的cookie
      Cookie[] cookies = request.getCookies();
  
      if(cookies!=null) {
          for(Cookie c :cookies) {
              String cookieName = c.getName();
              String cookieValue = c.getValue();
  
              System.out.println(cookieName + " "+ cookieValue);
          }
      }
  ```

  * 设置cookie过期时间

  ```java
      //正值表示在这个数字过后，cookie即将消失
      //负值表示关闭浏览器就失效
      cookie.setMaxAge(60*60*24*14);
      //讲cookie给客户端
  ```

* [例子] 显示上次登陆的时间

  1. 判断账号是否正确
  2. 如果正确的话，则获取cookie，但是得到的cookie是一个数组，我们要从一个数组里面找到想要的对象
  3. 如果找到对象为空，表明是第一次登陆，那么就添加cookie
  4. 如果找到的对象不为空，表明不是第一次登陆。

### session

> 会话，Session是基于Cookie的一种会话机制，Cookie是服务器返回的一小份数据给客户，并且存放在客户端上。Session是，数据存放在服务器端。

* session常用方法

```java
        HttpSession session = request.getSession();
        //得到会话id
        session.getId();
		//存值
        session.setAttribute(name, value);
		//取值
        session.getAttribute(name);
		//移除元素
        session.removeAttribute(name);
```

* session何时创建，何时访问
* 创建：

> 如果有在servlet里面调用了request.getSession()

* 销毁

> session是存放在服务器的内存的一个数据，可以持久化。Redis.  即使关了浏览器也不会被销毁
>
> 1. 关闭服务器
> 2. Session会话时间过期。 有效期默认30分钟。

