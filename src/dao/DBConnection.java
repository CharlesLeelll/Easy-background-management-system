package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBConnection {
	private static String Driver_Class="com.mysql.jdbc.Driver";
	private String url="jdbc:mysql://localhost:3306/haha";
	private String user="root";
	private String password="Charles";
	private Connection conn=null;
	private PreparedStatement pstmt=null;
	private ResultSet rs=null;
	/*
	 *  1.添加驱动器[翻译官]
		2.连接数据库[登陆到mysql]
		3.创建执行SQL的对象
		4.使用SQL执行对象,执行SQL命令
		5.获得执行结果
		6.关闭资源[退出登陆]
	 */
	//static代码块,会在构造方法及普通代码库 main之前,直接运行
	static{
		try {
			//通过反射机制,将驱动器引入到当前程序
			Class.forName(Driver_Class);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	/*
	 * 获得连接: 登陆数据库
	 * DriverManager类: 驱动器管理,主要负责登陆数据库
	 * getConnection(url, user, password);
	 * 参数说明:
	 * 1.url设置要登陆的数据库位置
	 *  主协议:子协议://主机名或IP:端口号/数据库实例名
	 *  jdbc:mysql://localhost:3306/mydb
	 * 2.user设置登陆的账号
	 * 3.password设置登陆的密码
	 */
	public void getConnection() {
		try {
			conn=DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (conn!=null) {
			System.out.println("Login Success!");
		} else {
			System.out.println("Login Failed!");
		}
	}
	//执行SQL: 添加 修改 删除 查询
	public void doSQL(String sql,String[] params) {
		getConnection();
		/*
		 * 创建执行对象: 
		 * 连接对象.createStatement() : 创建一个只能执行静态SQL的执行对象[不含有占位符]
		 * 连接对象.prepareStatement(): 创建一个能够执行静态SQL和动态SQL[含有占位符]的执行对象
		 * PreparedStatement----继承--->Statement[静态SQL]
		 */
		try {
			//创建执行SQL的对象	
			//insert into t1(name,sex,age,address) values(?,?,?,?)
			pstmt=conn.prepareStatement(sql);
			for (int i = 0; i < params.length; i++) {
				pstmt.setString(i+1,params[i]);
			}
			//执行指定的SQL命令
			pstmt.execute();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	//影响行数: 添加 修改 删除
	public int getUpCount() {
		//获得执行结果
		int i=-1;
		try {
			i = pstmt.getUpdateCount();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return i;
	}
	//结果集: 查询
	public ResultSet getRS() {
		try {
			rs=pstmt.getResultSet();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return rs;
	}
	/*
	 * 关闭资源: 结果集,执行对象,连接对象  [先开启的资源,后关闭]
	 */
	public void getClose() {
		try {
			if (rs!=null) {
				rs.close();
			}
		} catch (Exception e) {
			// TODO: handle exception
		}finally{
			try {
				if (pstmt!=null) {
					pstmt.close();
				}
			} catch (Exception e2) {
				// TODO: handle exception
			}finally{
				try {
					if (conn!=null) {
						conn.close();
					}
				} catch (Exception e3) {
					// TODO: handle exception
				}
			}
		}
	}
}
