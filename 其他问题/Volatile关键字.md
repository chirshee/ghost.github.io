# Volatile关键字

### java内存模型（铺垫）

> java内存模型简称**JMM(Java Memory Model)**,是java虚拟机所定义的一种抽象规范，用来屏蔽不同硬件和操作系统的内存访问差异，让java程序在各种平台都能达到一致的内存访问效果。

###### 两个概念：

1. **主内存（Main Memory）**

   主内存可以理解为计算机当中的内存，但是不完全等同于。主内存被所有的线程所共享，对于一个共享变量（静态变量/堆内存中的实例）来说，主内存存储了它的“本尊”。

2. **工作内存（Working Memory）**

   工作内存可以简单理解为计算机当中的CPU高速缓存，但是也不完全等同。每一个线程拥有自己 的工作内存，对于一个共享变量来说，工作内存相当于储存了它的“副本”。



​	线程对共享变量的所有的操作都必须在工作内存中进行，不能直接读写主内存中的变量。不同线程之间也无		   法访问彼此的工作内存，变量值的传递只能通过主内存来进行。

[![java内存模型.png](https://i.loli.net/2018/12/30/5c285593e3ae0.png)](https://i.loli.net/2018/12/30/5c285593e3ae0.png)

### volatile的特性：

#### **1.volatile与可见性：** 

可见性

> 当一个线程修改了变量的值，新的值立刻回同步到主内存中当中，而其他线程读取变量的时候，读取的也是最新的变量。

**volatile**关键字提供一个功能，那就是被其修饰的变量被修改之后可以立即同步到主内存，被其修饰的变量在每次用之前都从主内存刷新。因此，**可以使用volatile来保证多线程操作时变量的可见性。**



为什么volatile又这样的特性？

> 因为java语言的**先行发生原则**

###### 先行发生原则：

> In computer science, the happened-before relation is a relation between the result of two events, such that if one event should happen before another event, the result must reflect that, even if those events are in reality executed out of order (usually to optimize program flow). 
>
>
>
> 在计算机科学中，先行发生原则是两个事件的结果之间的关系，如果一个事件发生在另一个事件之前，结果必须反映，即使这些事件实际上是乱序执行的（通常是优化程序流程）。
>
> 其中的事件指的就是各种指令操作，比如读操作、写操作、初始化操作、锁操作等等

对于一个volatile变量。写操作先行发生于后面对这个变量的读操作

#### **2.volatile与原子性**

原子性：

> 原子性是指一个操作是不可中断的，要全部执行完成，要不就都不执行

线程是CPU调度的基本单位。CPU有的时间片的概念，会根据不同的调度算法进行线程调度，当一个线程获得时间片之后开始执行，再时间片耗尽之后，就会失去CPU使用权。所以时间片再线程间轮换，就会发生原子性问题。

在synchronized中，为了保证原子性，需要通过字节码指令monitorenter和monitorexit，但是volatile和这两个指令没有任何关系

**volatile不能保证原子性**

关于volatile不能保证原子性的一个例子：

```java
public  class VolatileTest{
    public volatile static int count = 0;
    public static void main(String args[]){
        //开启十个线程
        for(int i=0;i<10;i++){
		new thread(
            new Runnable(){
                public void run(){
                    try{
                        Thread.sleep(1);
                    }catch(InterruptedExeption e){
                        e.printStackTrace();
                    }
                    //每个线程中让count自增100次
                    for(int j=0;j<100;j++){
                        count++;
                    }
                }
              }
          ).start();
        }
        try{
            Thread.sleep(2000);
        }catch(InterruptedExeption e){
           e.printStackTrace();
        }
        System.out.print("count"+count);
    }
}
```

上面的代码，开启十个线程，每个线程让静态变量count自增100，执行之后发现，结果未必等于1000，有可能小于1000



在并发的时候为什么会出现这样的问题，因为count++并不是原子性的操作，在字节码中可以拆分成这样的指令。

​	getstatic      //读取静态变量

​	icons_1         //自定义常量1

​	iadd              //count增加1

​	putstatic      //把count结果同步到主内存

虽然每次getstatic获取变量的值都是主内存中最新的值，但是由于该操作不是原子性的，有可能在读取之前已经有多个线程对count变量自增了很多次。这样本线程更新的可能是一个陈旧的值，就无法保证线程安全

###### 什么时候使用volatile关键字：

**1.运行结果并不依赖变量的当前值，或者能够确保只有单一的线程修改变量的值**

**2.变量不需要与其他的状态变量共同参与不变约束**

第二条的解释：

eg :

```java
	volatile static int start = 3;
	volatile static int end = 6;
	//线程a执行的
    while(start<end){
		//do something
    }
	//线程b执行的
	start+=3;
	end+=3;
```

此时可能会瞬间跳出while循环，如果在线程a中执行了线程b,start有可能更新到6,直接跳出while循环。

#### **3.volatile与有序性**

有序性

> 即程序执行的顺序按照代码的先后顺序执行

**volatile**除了能保证数据可见性，还有一个强大的功能，那就是他可以**禁止指令重排优化**，这保证了程序会严格按照代码的先后顺序执行。这就保证了有序性。

###### 什么叫指令重排：

> 计算机执行指令的顺序在经过程序编译时候形成的指令序列，一般而言，这个指令序列会输出确定的结果；以确保每次执行都有结果。但是在一般情况下，CPU和编译器为了提升程序执行的效率，会按照一定的规则允许指令优化，在某些情况下，这种优化会带来一些执行的逻辑问题，主要的原因是代码逻辑之间是存在一定的先后顺序，并在并行的情况下发生，即按照不同的执行逻辑，会得到不同的结果。

**指令重排：**

比如java中简单的一句：instance = new Singleton,会被编译成如下的JVM指令

memory  = allocate(); //1.分配对象的内存空间

ctorInstance(memory) //2.初始化对象

instance = memory //3.将instance指向刚才分配的内存地址



但是这些指令顺序并非是一程不变的，有可能经过CPU和JVM的优化，排成以下的顺序

memory  = allocate(); //1.分配对象的内存空间

instance = memory //3.将instance指向刚才分配的内存地址

ctorInstance(memory) //2.初始化对象



###### **如何解决指令重排——内存屏障**

内存屏障（Memory Barrier）

> 是一种CPU指令
>
>
>
> A memory barrier, also known as a membar, memory fence or fence instruction, is a type of barrier instruction that causes a CPU or compiler to enforce an ordering constraint on memory operations issued before and after the barrier instruction. This typically means that operations issued prior to the barrier are guaranteed to be performed before operations issued after the barrier.
>
>
>
> 内存屏障也称为内存栅栏或栅栏指令，是一种屏障指令，它使CPU或编译器对屏障指令之前和之后发出的内存操作执行一个排序约束。 这通常意味着在屏障之前发布的操作被保证在屏障之后发布的操作之前执行。

内存屏障分为四种：

**LoadLoad屏障**：

抽象场景：Load1; LoadLoad; Load2

Load1 和 Load2 代表两条读取指令。在Load2要读取的数据被访问前，保证Load1要读取的数据被读取完毕。



**StoreStore屏障：**

抽象场景：Store1; StoreStore; Store2

Store1 和 Store2代表两条写入指令。在Store2写入执行前，保证Store1的写入操作对其它处理器可见



**LoadStore屏障：**

抽象场景：Load1; LoadStore; Store2

在Store2被写入前，保证Load1要读取的数据被读取完毕。



**StoreLoad屏障：**

抽象场景：Store1; StoreLoad; Load2

在Load2读取操作执行前，保证Store1的写入对所有处理器可见。StoreLoad屏障的开销是四种屏障中最大的。



**volatile做了什么：**
1.在每个volatile写操作前插入**StoreStore**屏障，在写操作后插入**StoreLoad**屏障。

2.在每个volatile读操作前插入**LoadLoad**屏障，在读操作后插入**LoadStore**屏障。

从而避免了指令重排



### 总结：

**volatile特性之一：**

保证变量在线程之间的可见性。可见性的保证是基于CPU的内存屏障指令。

**volatile特性之二：**

阻止编译时和运行时的指令重排。编译时JVM编译器遵循内存屏障的约束，运行时依靠CPU屏障指令来阻止重排。