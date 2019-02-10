**JDBC Dao模式**
>Data  Access Odject 数据访问规则
1.新建一个Dao接口，里面声明数据库访问规则
   package com.hyt.dao;
######  
    /*
     * 定义数据库的方法
     */
    public interface StudentDao {
    	/*
    	 * 查询所有
    	 */
    	void findAll();
    }

2.新建一个Dao的实现类，具体实现早前定义的规则
######
    public class StudentDaoImpl implements StudentDao{

	public void findAll() {
		Connection conn = null;
		Statement st = null;
		ResultSet rs = null;		
		//1.获取连接
		try {
			 conn = JDBCUtil.getConn();
		//2.创建statement对象
			 st = conn.createStatement();
		//3.创建sql语句
			String sql = "select * from student";
			rs = st.executeQuery(sql);
			while(rs.next()) {
				String name = rs.getString("name");
				int id  = rs.getInt("id");
				System.out.println(id + " " +name );
			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}



3.直接使用实现
######
    public class TestUserDaoImpl {
	@Test
	public void testFindAll() {
		StudentDao dao = new StudentDaoImpl();
		dao.findAll();
	}
}

**Statement的安全问题**
1.Statement执行,其实是拼接sql语句的。 顺序是，先拼接sql语句，然后再一起执行

    String sql = "select *from t_user where username = '"+username+"' and password = '"+password+"'";
        
    //前面先拼接sql语句，如果变量里面有了数据库关键字，不认为是普通的字符串
        
    dao.login("james", "aaa 'or' 1 = 1");
2.PrepareStatement
>该对象就是替换前面的Statement对象
1.相比较以前的statement，预先处理给定的sql语句，对其执行语法检查，在sql语句里使用?占位符来替代后续传递进来的变量，后面进来的变量值，将会是字符串，不会产生任何的关键字。

        public void insert(String username,String password) {
        try {
    		// 1.获取连接
    		conn = JDBCUtil.getConn();
    		// 2.创建statement对象
    		// st = conn.createStatement();
    		// 预先对sql语句语法进行校验 ？对应的内容，后面的不管传递什么值进来，全部看成是字符串
    		String sql = "insert into t_user values(?,?)";
    		PreparedStatement ps = conn.prepareStatement(sql);
    		// ？对应的索引从1开始
    		ps.setString(1, username);
    		ps.setString(2, password);
    		int result = ps.executeUpdate();
    		// 3.创建sql语句
    		// String sql = "select *from t_user where username = '"+username+"' and
    		// password = '"+password+"'";
    		if (result>0) {
    		System.out.println("插入成功");
    		} else {
    			System.out.println("插入失败");
    		}
    	} catch (ClassNotFoundException e) {
    		e.printStackTrace();
    	} catch (SQLException e) {
    		e.printStackTrace();
    	}finally{
    		JDBCUtil.release(st, conn);
    	}
    }

**总结**

1. JDBC入门
        
2. 抽取工具类
        
    
3. Statement CRUE

    演练CRUE
4. Dao模式
    
    声明与实现分开
5. PerpareStatement CRUE
        
    预处理sql语句，解决上面Statement问题

