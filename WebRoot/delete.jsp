<%@page import = "java.sql.*,java.io.*,java.util.*,com.cdut.bbs.*" %>
<%@page pageEncoding="GBK"%>

<%@include file="_SessionCheck.jsp" %>

<%-- _jspService方法内 执行部分 --%>
<%
	boolean isLeaf = Boolean.parseBoolean(request.getParameter("isLeaf"));
	int pid = Integer.parseInt(request.getParameter("pid"));
	int id = Integer.parseInt(request.getParameter("id"));
	String strFrom = request.getParameter("from");
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	
	boolean autoCommit = true;

	try{
			conn = DB.getConnection();
			autoCommit = conn.getAutoCommit();
			conn.setAutoCommit(false);
			
			deleteTree(conn, id, isLeaf);

			stmt = DB.createStatement(conn);
			rs = DB.getResultSet(stmt, "select count(*) from article where pid = " + pid);
			rs.next();
			
			int count = rs.getInt(1);
			
			if(count <= 0)
			{
				DB.executeUpdate(conn, "update article set isleaf = 0 where id = " + pid);
			}
			
		conn.commit();
	} finally {
		conn.setAutoCommit(autoCommit);
		DB.close(rs);
		DB.close(stmt);
		DB.close(conn);
	}
%>

<%-- 定义递归方法 --%>
<%!
	private void deleteTree(Connection conn, int id, boolean isLeaf)
	{
		// deleteTree(conn, children's id);
		// delete itself

		Statement stmt = null;
		ResultSet rs = null;

		if(!isLeaf)		// 是非叶子节点时循环取出子帖
		{
			stmt = DB.createStatement(conn);
			String sql = "select * from article where pid = " + id;	// 找到子帖
	
			rs = DB.getResultSet(stmt, sql); // 返回子帖的结果集
	
			try{
				while(rs.next())
				{
					deleteTree(conn, rs.getInt("id"), rs.getInt("isLeaf")==0 ? true : false);
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		// 当为叶子节点时,则删除该节点
		Statement delStmt = DB.createStatement(conn);
		String sql = "delete from article where id = " + id;
		
		try {
			DB.executeUpdate(conn, sql);
		} finally {
		
		DB.close(rs);
		DB.close(stmt);
		DB.close(delStmt);
		}
	}
%>

Congratulations!
<br>
<a href="article.jsp">返回树状首页</a>
<br>
<a href="article_flat.jsp">返回平板首页</a>
<br>
<a href=<%= strFrom%>>返回上个页面</a>




