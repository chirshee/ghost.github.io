package com.hyt.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class Conn {
	static String Driver = null;
	static String url = null;
	static String username = null;
	static String password = null;
	public static Connection getConn() throws IOException {
		Connection conn = null;
		Properties properties = new Properties();
		InputStream is = Conn.class.getClassLoader().getResourceAsStream("jdbc.properties");
		properties.load(is);
		Driver = properties.getProperty("Driver");
		url = properties.getProperty("url");
		username = properties.getProperty("user");
		password = properties.getProperty("password");
		try {
			Class.forName(Driver);
			conn = DriverManager.getConnection(url, username, password);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}	
		return conn;	
	}
	
	public static void colseConn(Connection conn) {
		try {
			conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
