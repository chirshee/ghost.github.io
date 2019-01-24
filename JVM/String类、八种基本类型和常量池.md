# String类、八种基本类型和常量池

### String类和常量池

1. **String创建的对象的两种方式**

```java
String str1 = "abcd";
String str2 = new String("abcd");
System.out.println("str1==str2"); //false
```

上面的两种创建对象的方法是不同的，第一种是在常量池，第二种方式是直接在堆中创建新的对象

**只要使用new方法，就一定要创建新的对象**

2. **String类型的常量池比较特殊，主要有两种使用方法**

* 直接使用双引号声明的String对象，会直接存储在常量池中
* 如果没有直接使用双引号声明String对象，可以使用intern方法，String.intern()是一种native方法，它的作用是：**如果运行时常量池中已经包含一个等于此 String 对象内容的字符串，则返回常量池中该字符串的引用；如果没有，则在常量池中创建与此 String 内容相同的字符串，并返回常量池中创建的字符串的引用。**

```java
String str1 = new String("abcd");
String str2 = str1.intern();
String str3 = "abcd";

System.out.println(str1==str2);//false,因为一个在堆内存中，一个在常量池中
System.out.println(str1==str3);//true 两个String对象都在常量池中
```

3. **字符串的拼接**

```java 
String str1 = "hello"; //常量池对象
String str2 = "world"; //常量池对象

String str3 = "hello"+"world"; //常量池对象
String str4 = str1 + str2; //在堆上创建新的对象
String str5 = "helloworld"; //常量池对象
System.out.println(str3 == str4); //false
System.out.println(str3 == str5);//true
System.out.println(str4 == str5);//false
```

尽量避免多个字符串拼接，因为这样会创建新的对象，如果要改变字符串的话，可以用StringBuffer

4. **分析String源码**

```java
	/** The value is used for character storage. */
    private final char value[];

    /** Cache the hash code for the string */
    private int hash; // Default to 0

    /** use serialVersionUID from JDK 1.0.2 for interoperability */
    private static final long serialVersionUID = -6849794470754667710L;

    /**
     * Class String is special cased within the Serialization Stream Protocol.
     *
     * A String instance is written into an ObjectOutputStream according to
     * <a href="{@docRoot}/../platform/serialization/spec/output.html">
     * Object Serialization Specification, Section 6.2, "Stream Elements"</a>
     */
    private static final ObjectStreamField[] serialPersistentFields =
        new ObjectStreamField[0];
```

* 从源码可以看出来String底层是使用字符数组来维护的
* 成员变量可以知道String类的值是final类型的，不能被改变，所以改变一个值改变就会生成一个新的String类型对象.

5. **浅谈一下String，StringBuffer，StringBuilder的区别**

   > String是不变类，每当我们对String进行操作的时候，总是会创建新的字符串。操作String是很耗资源的，于是java提供了StringBuffer和StringBuilder
   >
   > StringBuffer和StringBuilder可变类，StringBuffer是线程安全的，StringBuilder则是不安全的，所以在多线程操作一个字符串的时候我们用StringBuffer.因为Stringbuilder的效比较高，所以不需要多线程的时候要使用StringBuilder

6. **String不可变的优点**
   * 由于String不可变的，所以在多线程中是线程安全的
   * String是不可变的，它的值也不能被改变，用来存储密码很安全
   * 因为java字符串是不可变的，可以在java运行时节省大量java堆空间。因为不同的字符串变量可以引用池中的相同的字符串。如果字符串是可变得话，任何一个变量的值改变，就会反射到其他变量，那字符串池也就没有任何意义了。

###  八种基本类型和常量池

* **java基本类型基本都实现的常量池技术，即Byte,Short,Integer,Long,Character,Boolean；这五种包装类默认创建了数值[128,127]的相应类型的缓存数据，但是超出了的这个范围仍然会创建对象**

* **两种浮点型的基本数据类型并没有实现常量池技术**

```java
Integer i1 = 33;
Integer i2 = 33;
System.out.println(i1 == i2);// 输出true
Integer i3 = 333;
Integer i4 = 333;
System.out.println(i3 == i4);// 输出false
Double i3 = 1.2;
Double i4 = 1.2;
System.out.println(i3 == i4);// 输出false
```

* Integer缓存源代码

```java
public static Integer valueOf(int i) {
        if (i >= IntegerCache.low && i <= IntegerCache.high)
            return IntegerCache.cache[i + (-IntegerCache.low)];
        return new Integer(i);
    }
```

1. Integer i1=40；Java 在编译的时候会直接将代码封装成Integer i1=Integer.valueOf(40);，从而使用常量池中的对象。
2. Integer i1 = new Integer(40);这种情况下会创建新的对象。

```java
  Integer i1 = 40;
  Integer i2 = new Integer(40);
  System.out.println(i1==i2);//输出false
```

* Integer自动拆箱例子

```java
Integer i1 = 30;
Integer i2 = 30;
Integer i3 = 0;
Integer i4 = new Integer(30);
Integer i5 = new Integer(30);
Integer i6 = new Integer(40);

System.out.println(i1==i2); //true
System.out.println(i1==i2+i3); //true
System.out.println(i1==i4); //false
System.out.println(i4==i5); //false
System.out.println(i4==i5+i6); //true
System.out.println(40==i5+i6); //true		                     
```

语句i4 == i5+i6; + 这个操作不适用于Integer对象，i5和i6自动拆箱，进行数值相加，即i4==30.然后Integer对象无法与数值进行直接比较，所以i4自动拆箱为int=30，进行比较。