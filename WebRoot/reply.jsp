<%@ page import="com.cdut.bbs.*,java.sql.*"%>
<%@ page pageEncoding="GB18030"%>

<%
	// 由于是通过其他页面点进来,所以可以不用判断 id 是否存在有效
	int id = Integer.parseInt(request.getParameter("id")); // 非直接访问,否则可能出现空指针错误
%>
<%
	String sql = "select * from article where id = " + id;
	Article a = null;

	// 找到帖子 id 后,并且参数合法,则连接数据库,找到帖子的结果集, 并赋值给 javaBean 做展现

	Connection conn = DB.getConnection();
	Statement stmt = DB.createStatement(conn);
	ResultSet rs = DB.getResultSet(stmt, sql);

	while (rs.next()) {
		a = new Article();

		a.initFromRs(rs);
	}

	DB.close(rs);
	DB.close(stmt);
	DB.close(conn);
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
							主题:
							<%=a.getTitle()%>
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

										<!-- 回复的 form -->

										<form action="replyDeal.jsp" method="post">
											标题：<input type="text" name="title"><br> 内容：
											<br>
											<textarea rows="20" cols="100" name="cont"></textarea>

											<script type="text/javascript">
												CKEDITOR.replace('cont');
											</script>
<!--
											<div class="adjoined-bottom">
												<div class="grid-container">
													<div class="grid-width-100">
														<div id="editor">
															<h1>Hello world!</h1>
															<p>
																I'm an instance of <a href="http://ckeditor.com">CKEditor</a>.
															</p>
														</div>
													</div>
												</div>
											</div>

											<script>
												initSample();
											</script>
-->
											<br> <input type="submit" value="提交">

											<!-- 将要回复的贴的id作为 hidden 传递给下个页面 作为其 pid -->
											<input type="hidden" name="pid" value=<%=a.getId()%>>
											<input type="hidden" name="rootId" value=<%=a.getRootId()%>>
										</form>

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
