### synchronized关键字

> synchronized 是重量级的锁，利用锁机制来实现同步（解决数据的不一致性）

###### synchronized实现的原理

> synchornized可以保证方法或者代码块在运行时，同一时刻只有一个方法可以进入临界区，同时它还可以保证共享变量的内存可见性

###### 锁机制的两个特性：

**互斥性：** 即在同一时间内只允许一个线程持有某个对象锁，通过这种特性来实现多线程中的协调机制，这样在同一时间只有一个线程对需同步的代码块（复合操作）进行访问。互斥性也常常称为操作的原子性

**可见性：**必须确保在锁被释放之前，对共享变量的修改，对于随后获得该锁的另一个线程是可见的（即获得锁的时候同时获取最新共享变量的值），否则另一个线程可能是在某个副本上继续操作从而引起不一致。

###### synchronized的用法：

1. **修饰静态方法**实质是在进入方法之前获取**类对象**的内置锁，在退出方法时候释放锁，来完成控制并发。

2. **通过类对象，修饰代码块**，实质上是也是在进入代码块之前，获得修饰**指定类对象的内置锁**，在退出方法块之前释放锁，来完成控制并发

3. **修饰普通方法**，实质是在进入方法前，获得**当前对象实例**的内置锁，在方法结束再释放锁。

4. **通过普通对象，修饰代码块**实质也是在进入方法块前，获得修饰 **指定对象**的内置锁，在退出方法块时，释放锁，来完成并发控制。

* **修饰静态方法：**（实现1000次并发操作）

```java
 	 public class ConcurrentAtomicIncrease {
     // 共享变量
     public static int count = 0;
     /**
     * synchronized 用法一: 修饰静态方法
     * 本质是 synchronized(ConcurrentAtomicIncrease.class), 通过当前类对象锁来实现控制并发
     */
    public synchronized static void countAtomicIncrease() {
        // method before 进入方法前获取 ConcurrentAtomicIncrease.class的锁
        // 相当于执行 ConcurrentAtomicIncrease.class.lock()
        count++;
        // method after 执行完方法内容后，释放 ConcurrentAtomicIncrease.class的锁
        // 相当于执行 ConcurrentAtomicIncrease.class.unlock()

    }
    public static void main(String[] args) {
        for (int i=0; i<1000; i++) {
            new Thread(new Runnable() {
                @Override
                    public void run() {
                        // 所有子线程休息 10s 后执行，增加并发执行的概率
                        try {
                            TimeUnit.SECONDS.sleep(10);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }                       
                       countAtomicIncrease();
                    }
                }
            ).start();
       }
        // 主线程休息 30s 保证所有自线程执行完
        try {
            TimeUnit.SECONDS.sleep(30);
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        System.out.println("执行1000次并发自增操作， count = " + count);
    }
}
```

* **通过类对象，修饰代码块**

```java 
	public class ConcurrentstaticBlock{
		public static int count =0;
        public static void main(String args[]){
            for(int i=0;i<1000;i++){
                new Thread(new Runnable(){
                    @Override
                    public void run(){
					//synchronized用法二：通过类对象修饰代码块
                    //本质上是ConcurrentAtomicIncrease.class，通过获取当前类对象锁，来控制并发
  						synchronized(ConcurrentAtomicIncrease.class){
					// 先获取 ConcurrentAtomicIncrease.class的锁
        			// 相当于执行 ConcurrentAtomicIncrease.class.lock()
                            count++;
                    //代码执行完，释放锁，相当于执行 ConcurrentAtomicIncrease.class.unlock()
                        }
                    }
                }).start();
            }
             try {
            	TimeUnit.SECONDS.sleep(30);
       		 } catch (InterruptedException e) {
          		 e.printStackTrace();
        	 }
       		  System.out.println("执行1000次并发自增操作， count = " + count);
       		 }    		
     }
```

* **修饰普通方法**

```java
        public class ConcurrentPlainAtomicIncrease{
			public static int count = 0;
            //synchronized关键字用法三：修饰普通方法
            public synchronized void count(){
                //method before 进入方法前获取 ConcurrentAtomicIncrease.class的锁
                //相当于执行this.lock()
                count++;
                //method after 执行完方法内容后，释放 ConcurrentAtomicIncrease.class的锁
                //相当于执行this.unlock()
            }
            public static void main(String args[]){
			ConcurrentPlainAtomicIncrease lock = new  ConcurrentPlainAtomicIncrease()
             for (int i=0; i<1000; i++) {
                new Thread(new Runnable() {
        	    @Override
                    public void run() {
                        // 所有子线程休息 10s 后执行，增加并发执行的概率
                        try {
                            TimeUnit.SECONDS.sleep(10);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                        // 注意下面这种方式不能实现控制并发访问，每次都是不同的实例，获取的锁也是不同的锁
                        // new ConcurrentPlainAtomicIncrease().countAtomicIncrease();
                        lock.countAtomicIncrease();
                    }
                }
            ).start();
        }      
             
         try {
            TimeUnit.SECONDS.sleep(30);
         } catch (InterruptedException e) {
             e.printStackTrace();
         }
         System.out.println("执行1000次并发自增操作， count = " + count);             
        }
  }
```

**修饰实例对象，修饰代码块**

```java
    public class ConcurrentStaticBlockAtomicIncrease {
		public static int count=0;
        public static void main(Stirng args[]){
            Object lock = new Object();
            for (int i=0; i<1000; i++) {
                new Thread(new Runnable() {
        	    @Override
                    public void run() {
                        try {
                            TimeUnit.SECONDS.sleep(10);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                        //synchronized用法四：获取对象实例锁来控制并发
                        synchronized(lock){
                            //获取lock对象锁，相当于lock.lock
                            count++;
                            //代码块执行完，释放对象锁，相当于lock.unlock              
                        }
                    }
                }
            ).start();
        }   
             try {
                TimeUnit.SECONDS.sleep(30);
             } catch (InterruptedException e) {
                 e.printStackTrace();
             }
             System.out.println("执行1000次并发自增操作， count = " + count);             
            }
        }
    }
```

**总结：**

>1.**修饰静态方法**：
>
>**优点：**使用方便，相当于类衍生的全部实例
>
>2.**修饰代码块：**
>
>**特点：**和1修饰静态方法差不多
>
>3.**修饰普通方法：**
>
>**特点：** 一定是同一个对象实例调用才可以
>
>4.**通过实例对象，修饰普通方法**
>
>**优点：** 可以精准控制并发代码块
>
>**特点：** 注意一定是同一个对象实例



###### synchronized实现的原理分析

1.synchronized修饰代码块，锁的位置

> synchronized实现的锁是储存在**java对象头**
>
> **什么是对象头** ：在Hotspot虚拟机中，对象在内存中储存布局，可以分为三个区域：对象头（Header）,实例数据（Instance Data）,对齐填充（Padding）

![hotspot JVM对象在虚拟机内存.png](https://i.loli.net/2019/01/11/5c381e9045d19.png)

<center>（对象在内存中的分布）</center>

在java代码中，使用new创建一个对象实例的时候，（hotspot虚拟机）JVM层面实际上会创建一个 `instanceOopDesc`对象

> Hotspot虚拟机采用Oop-Klass模型来描述java对象实例，OOP(Ordinary Object Point)指的是普通对象指针，Klass来描述对象实例的具体类型。Hotspot采用instanceOopDesc和arrayOopDesc来描述对象头，arrayOopDesc对象来描述数组类型。

instanceOopDesc的定义在HotSpot源码中的`instanceOop.hpp`文件中，另外`arrayOopDesc`的定义对应`arrayOop.hpp`

```C++
class instanceOopDesc : public oopDesc {
public:
  // aligned header size.
  static int header_size(){
      return sizeof(instanceOopDesc)/HeapWordSize;
 } 
  // If compressed, the offset of the fields of the instance may not be aligned.
  static int base_offset_in_bytes(){
  // offset computation code breaks if UseCompressedClassPointers
  // only is true
    return(UseCompressedOops&&UseCompressedClassPointers)?
             klass_gap_offset_in_bytes():
             sizeof(instanceOopDesc); 
} 
 static bool contains_field_offset(int offset,int nonstatic_field_size){
     int base_in_bytes = base_offset_in_bytes();
    	return(offset >=base_in_bytes &&(offset-base_in_bytes)<nonstatic_field_size *heapOopSize);
  }
};
#endif
// SHARE_VM_OOPS_INSTANCEOOP_HPP
```

`instanceOopDesc`继承自oopDesc，oopDesc的定义载Hotspot源码中的 `oop.hpp`文件中

```C++
class oopDesc {
  friend class VMStructs;
  private:volatile markOop  _mark;
  union _metadata {
    Klass *_klass;
    narrowKlass _compressed_klass;
}
 _metadata;
  // Fast access to barrier set.  Must be initialized.
  static  BarrierSet *_bs;  
    ...
}
```

在普通的实例对象中，oopDesc的定义包含`_mark`和`_metadata`

`_mark`:表示对象标记，属于markOop类型，也就是Mark  Word,他记录了对象和锁有关的信息

`_metadata`:表示类元信息，类元信息储存的对象指向它的类元数据（Klass）的首地址，其中Klass表示普通指针、`_compressed_kless`表示压缩类指针



###### Mark Word 

普通的对象头有两部分组成，分别是MarkOop以及类元信息，markOop官方称为Mark Word

在HotSpot中，markOop定义在markoop.hpp文件中

```c++
class markOopDesc: 
	public oopDesc {
        private:
  		// Conversion
        uintptr_t value() const{
            return(uintptr_t)this;
        }
 	public:
  	// Constants
    enum{
         age_bits = 4,//分代年龄
         lock_bits = 2,//锁标识
         biased_lock_bits = 1,//是否为偏向锁
         max_hash_bits = BitsPerWord-age_bits -lock_bits -biased_lock_bits,
         hash_bits  = max_hash_bits >31?31:max_hash_bits,//对象的hashcode
         cms_bits  = LP64_ONLY(1)
         NOT_LP64(0),
         epoch_bits=2//偏向锁的时间戳
  };
...
```

Mark word记录了对象和锁有关的信息，当某个对象被synchronized关键字当成同步锁时，那么围绕这个锁的一系列操作都和Mark word有关系。Mark Word在32位虚拟机的长度是32bit、在64位虚拟机的长度是64bit。

2.synchronized的字节码

```java
    public class Test{
   	 public static void main(String args[]){
        Test test = new Test();
        
        synchronized(test){
            System.out.print("同步方法");
        }
        test.testsynchronized();
         
    }
    public static synchronized void testsynchronized(){
        System.out.print("测试同步方法");
    }
}
```

**javap -v查看反编译代码**

```
 public Test();
    descriptor: ()V
    flags: ACC_PUBLIC
    Code:
      stack=1, locals=1, args_size=1
         0: aload_0
         1: invokespecial #1                  // Method java/lang/Object."<init>":()V
         4: return
      LineNumberTable:
        line 1: 0

  public static void main(java.lang.String[]);
    descriptor: ([Ljava/lang/String;)V
    flags: ACC_PUBLIC, ACC_STATIC
    Code:
      stack=2, locals=4, args_size=1
         0: new           #2                  // class Test
         3: dup
         4: invokespecial #3                  // Method "<init>":()V
         7: astore_1
         8: aload_1
         9: dup
        10: astore_2
        11: moniterenter
        12: getstatic     #4                  // Field java/lang/System.out:Ljava/io/PrintStream;
        15: ldc           #5                  // String 同步方法
        17: invokevirtual #6                  // Method java/io/PrintStream.print:(Ljava/lang/String;)V
        20: aload_2
        21: monitorexit
        22: goto          30
        25: astore_3
        26: aload_2
        27: monitorexit
        28: aload_3
        29: athrow
        30: aload_1
        31: pop
        32: invokestatic  #7                  // Method testsynchronized:()V
        35: return
      Exception table:
         from    to  target type
            12    22    25   any
            25    28    25   any
      LineNumberTable:
        line 3: 0
        line 5: 8
        line 6: 12
        line 7: 20
        line 8: 30
        line 10: 35
      StackMapTable: number_of_entries = 2
        frame_type = 255 /* full_frame */
          offset_delta = 25
          locals = [ class "[Ljava/lang/String;", class Test, class java/lang/Object ]
          stack = [ class java/lang/Throwable ]
        frame_type = 250 /* chop */
          offset_delta = 4

  public static synchronized void testsynchronized();
    descriptor: ()V
    flags: ACC_PUBLIC, ACC_STATIC, ACC_SYNCHRONIZED
    Code:
      stack=2, locals=0, args_size=0
         0: getstatic     #4                  // Field java/lang/System.out:Ljava/io/PrintStream;
         3: ldc           #8                  // String 测试同步方法
         5: invokevirtual #6                  // Method java/io/PrintStream.print:(Ljava/lang/String;)V
         8: return
      LineNumberTable:
        line 12: 0
        line 13: 8
}
```

注意：通过字节码可以发现

<table><tr><td bgcolor=#C0FF3E>
    monitorenter    //监视器进入，获取锁
    ACC_SYNCHRONIZED
    monitorexit     //监视器退出，释放锁
 </td></tr></table>
通过字节码可以发现，修饰在方法层面的同步关键字，会多一个` ACC_SYNCHRONIZED`的flag;修饰在代码块层面的同步块会多一个`monitorenter`和`monitorexit`关键字。无论采用哪一种方式，本质上都是对一个对象的监视器（monitor）进行获取，而这个获取的过程是排他的，也就是同一时刻只能有一个线程获得同步块对象的监视器

* monitor

> 同步块的实现使用 `monitorenter`和 `monitorexit`指令，而同步方法是依靠方法修饰符上的flag `ACC_SYNCHRONIZED`来完成。其本质是对一个对象监视器(monitor)进行获取，这个获取过程是排他的，也就是同一个时刻只能有一个线程获得由synchronized所保护对象的监视器。所谓的监视器，实际上可以理解为一个同步工具，它是由Java对象进行描述的。在Hotspot中，是通过ObjectMonitor来实现，每个对象中都会内置一个ObjectMonitor对象

https://docs.oracle.com/javase/specs/jvms/se8/html/jvms-2.html#jvms-2.11.10

oracle官方文档对**synchronized**的描述

![oracle官方文档的synchronize的描述.png](https://i.loli.net/2019/01/11/5c38133915906.png)

