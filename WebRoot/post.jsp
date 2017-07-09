<%@ page import="com.cdut.bbs.*,java.sql.*"%>
<%@ page pageEncoding="GB18030"%>

<%
	request.setCharacterEncoding("GBK");
	String method = request.getParameter("method");

	if(method != null && method.trim().equals("post"))
	{
		String title = request.getParameter("title");
		String cont = request.getParameter("cont");
		
		String sql = "insert into article values (null, 0, ?, ?, ?, now(), ?)";
		
		int rootId = -1;
		
		Connection conn = DB.getConnection();
		boolean autoCommit = conn.getAutoCommit();
		conn.setAutoCommit(false);
		
		PreparedStatement pstmt = DB.perparedStatement(conn, sql, Statement.RETURN_GENERATED_KEYS);
		
		pstmt.setInt(1, rootId);
		pstmt.setString(2, title);
		pstmt.setString(3, cont);
		pstmt.setInt(4, 0);
		pstmt.executeUpdate();
		
		ResultSet rsKey = pstmt.getGeneratedKeys();
		rsKey.next();
		rootId = rsKey.getInt(1);
		
		Statement stmt = DB.createStatement(conn);
		stmt.execute("update article set rootid = " + rootId + " where id = " + rootId);	// 更正之前的插入数据库中的rootId
		
		conn.commit();
		
		conn.setAutoCommit(autoCommit);
		
		DB.close(rsKey);
		DB.close(stmt);
		DB.close(pstmt);
		
		response.sendRedirect("article.jsp");
	}
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Java|Java世界_中文论坛|ChinaJavaWorld技术论坛 :
	初学java遇一难题！！望大家能帮忙一下 ...</title>
<meta http-equiv="content-type" content="text/html; charset=GBK">
<link rel="stylesheet" type="text/css" href="images/style.css"
	title="Integrated Styles">
<script language="JavaScript" type="text/javascript"
	src="images/global.js"></script>

<!-- fckeditor start -->
<script src="fckeditor/ckeditor.js"></script>

<!-- fckeditor end -->

<link rel="alternate" type="application/rss+xml" title="RSS"
	href="http://bbs.chinajavaworld.com/rss/rssmessages.jspa?threadID=744236">
</head>
<body id="main">
	<table border="0" cellpadding="0" cellspacing="0" width="100%">
		<tbody>
			<tr>
				<td width="140"><a
					href="http://bbs.chinajavaworld.com/index.jspa"><img
						src="images/header-left.gif"
						alt="Java|Java世界_中文论坛|ChinaJavaWorld技术论坛" border="0"></a></td>
				<td><img src="images/header-stretch.gif" alt="" border="0"
					height="57" width="100%"></td>
				<td width="1%"><img src="images/header-right.gif" alt=""
					border="0"></td>
			</tr>
		</tbody>
	</table>
	<br>
	<div id="jive-flatpage">
		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tbody>
				<tr valign="top">
					<td width="99%"><p class="jive-breadcrumbs">
							<a href="http://bbs.chinajavaworld.com/index.jspa">首页</a> &#187;
							<a
								href="http://bbs.chinajavaworld.com/forumindex.jspa?categoryID=1">ChinaJavaWorld技术论坛|Java世界_中文论坛</a>
							&#187; <a
								href="http://bbs.chinajavaworld.com/category.jspa?categoryID=2">Java
								2 Platform, Standard Edition (J2SE)</a> &#187; <a
								href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=0">Java语言*初级版</a>
						</p>
						<p class="jive-page-title">
							主题: 发表帖子

						</p></td>
					<td width="1%"><div class="jive-accountbox"></div></td>
				</tr>
			</tbody>
		</table>
		<div class="jive-buttons"></div>

		<table border="0" cellpadding="0" cellspacing="0" width="100%">
			<tbody>
				<tr valign="top">
					<td width="99%"><div id="jive-message-holder">
							<div class="jive-message-list">
								<div class="jive-table">
									<div class="jive-messagebox">

						<!-- form start -->
										<!-- 发表帖子提交给自身 -->
										<form action="post.jsp" method="post">
											标题：<input type="text" name="title"><br> 内容：
											<br>
											<textarea rows="20" cols="100" name="cont"></textarea>
											
											<script type="text/javascript">
												CKEDITOR.replace('cont');
											</script>
											
											<!-- 发帖子时向自身传递 名为 method 的隐含参数,以此区分是不是第一次创建此贴 -->
											<input type="hidden" name="method" value="post">
											
											<br> <input type="submit" value="提交">
										</form>
						<!-- form end -->
										
									</div>
								</div>
							</div>
							<div class="jive-message-list-footer">
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tbody>
										<tr>
											<td nowrap="nowrap" width="1%"></td>
											<td align="center" width="98%"><table border="0"
													cellpadding="0" cellspacing="0">
													<tbody>
														<tr>
															<td><a
																href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20"><img
																	src="images/arrow-left-16x16.gif" alt="返回到主题列表"
																	border="0" height="16" hspace="6" width="16"></a></td>
															<td><a
																href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20">返回到主题列表</a>
															</td>
														</tr>
													</tbody>
												</table></td>
											<td nowrap="nowrap" width="1%">&nbsp;</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div></td>
					<td width="1%"></td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
</html>
