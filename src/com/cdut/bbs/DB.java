package com.cdut.bbs;

import java.sql.*;

public class DB {

	public static Connection getConnection()
	{
		Connection conn = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/bbs", "yujun", "951025");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return conn;
	}

	public static Statement createStatement(Connection conn)
	{
		Statement stmt = null;

		try {
			stmt = conn.createStatement();
			System.out.println(stmt);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return stmt;
	}

	public static PreparedStatement perparedStatement(Connection conn,String sql)
	{
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return pstmt;
	}

	public static PreparedStatement perparedStatement(Connection conn,String sql,int autoGeneratedKeys)
	{
		PreparedStatement pstmt = null;

		try {
			pstmt = conn.prepareStatement(sql, autoGeneratedKeys);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return pstmt;
	}

	public static ResultSet getResultSet(Statement stmt, String sql)
	{
		ResultSet rs = null;

		try {
			rs = stmt.executeQuery(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return rs;
	}

	public static int executeUpdate(Connection conn, String sql)
	{
		int ret = 0;
		Statement stmt = null;

		try {
			stmt = createStatement(conn);
			ret = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(stmt);
		}
		return ret;
	}

	public static void close(Connection conn)
	{
		if(conn != null)
		{
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			conn = null;
		}
	}

	public static void close(Statement stmt)
	{
		if(stmt != null)
		{
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			stmt = null;
		}
	}

	public static void close(ResultSet rs)
	{
		if(rs != null)
		{
			try {
				rs.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			rs = null;
		}
	}
}
