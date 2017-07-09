<%@page import = "java.sql.*,java.io.*,java.util.*,com.cdut.bbs.*" %>

<!-- jsp 源码的保存编码 -->
<%@page pageEncoding="utf-8"%>

<!-- 调用jsp时编码执行方式,防止中文乱码 -->
<%@page contentType="text/html; charset=utf-8" %>

<%
	request.setCharacterEncoding("utf-8");
	
	Connection conn = DB.getConnection();
	
	final int PAGE_SIZE = 4;	// 每页显示多少条 根帖
	int  pageNo = 1;

	String sql1 = "";			// 筛选方式决定 记录条数
	String sql2 = "";			// 具体搜索方式 (取决于搜索栏的keyword)

	boolean isLogin = false;
	String strLogin = (String) session.getAttribute("logined");		// 是否登录
	
	String strFromSearched = request.getParameter("fromSearched");	// 是否是通过搜索栏访问的
	
	String keyword = request.getParameter("keyword");				// 得到搜索关键词
	System.out.println("keyword:" + keyword);						// 检验关键词
	
//	String keyword2 = new String(keyword.getBytes("ISO_8859_1"),"UTF-8");
//	System.out.println("keyword2:" + keyword2);

	if(strLogin != null && strLogin.trim().equals("true"))
	{
		isLogin = true;
	}
	
	String strPageNo = request.getParameter("pageNo");	// 通过上下页浏览本页面的处理
	System.out.println("-------------------------------------");
	System.out.println("strPageNo:" + strPageNo);
	
	if(strPageNo != null && !strPageNo.trim().equals(""))
	{
		pageNo = Integer.parseInt(strPageNo);
		System.out.println("pageNo:" + pageNo);
	}

	if(pageNo < 1)		// 当第一页再上一页时,直接url跳转到第一页
	{
		System.out.print("--------------------------------------------");
		pageNo = 1;
		response.sendRedirect("article_flat.jsp?pageNo=1&fromSearched=" + strFromSearched + "&keyword=" + keyword);
		return;
		
		// article_flat.jsp?pageNo=0&fromSearched=true&keyword=大象
	}	
	
	int startPos = (pageNo-1) * PAGE_SIZE;	// 分页起点 (需要提前知道此时位于的 页数)
	
	
	if(strFromSearched != null && strFromSearched.trim().equals("true"))	// 通过点击搜索按钮进本页面的处理
	{
	
		if(keyword != null && !keyword.trim().equals(""))
		{
			sql1 = "select count(*) from article where title like '%" + keyword + "%'";			// 有多少条根帖记录满足查询条件
					
			System.out.println("sql1:" + sql1);
			
			sql2 = "select * from article where title like '%" + keyword +"%' and pid = 0"
					+ " order by pdate asc limit " + startPos + "," + PAGE_SIZE;		// 满足关键词的搜索方式
					
			System.out.println("sql2:" + sql2);
			
		} else {
			strFromSearched = "false";
			
			sql1 = "select count(*) from aricle where pid = 0";	// 搜索为空 或 全为空格,则默认为显示所有根帖
			sql2 = "select * from article where pid = 0 order by pdate asc limit " + startPos + "," + PAGE_SIZE;
		}
		
	} else {												// 第一次访问 默认显示所有根帖
		sql1 = "select count(*) from article where pid = 0";
		sql2 = "select * from article where pid = 0 order by pdate asc limit " + startPos + "," + PAGE_SIZE;
	}

	
	Statement stmt1 = DB.createStatement(conn);	// 注: 一条 Statement 对象只能返回一个 ResultSet 对象
	Statement stmt2 = DB.createStatement(conn);
	
	ResultSet rs1 = DB.getResultSet(stmt1, sql1);	
	ResultSet rs2 = DB.getResultSet(stmt2, sql2);

	rs1.next();
	int totalRoot = rs1.getInt(1);
	int totalPages = (totalRoot - 1) / PAGE_SIZE + 1;
	

	if(pageNo > totalPages)		// 当页数 > 最大页数时, 跳转到最大页数
	{
		pageNo = totalPages;
		response.sendRedirect("article_flat.jsp?pageNo=" + totalPages + "&fromSearched=" + strFromSearched + "&keyword=" + keyword);
		
		// article_flat.jsp?pageNo= totalPages &fromSearched=true&keyword=大象
	}
	
	List<Article> articles = new ArrayList<Article>();
	
	while(rs2.next())
	{
		Article a = new Article();
		a.initFromRs(rs2);
		articles.add(a);
	}
	
	DB.close(rs1);
	DB.close(rs2);
	DB.close(stmt1);
	DB.close(stmt2);
	DB.close(conn);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Java|Java世界_中文论坛|ChinaJavaWorld技术论坛 : Java语言*初级版</title>
<meta http-equiv="content-type" content="text/html; charset=GBK">
<link rel="stylesheet" type="text/css" href="images/style.css" title="Integrated Styles">
<script language="JavaScript" type="text/javascript" src="images/global.js"></script>
<link rel="alternate" type="application/rss+xml" title="RSS" href="http://bbs.chinajavaworld.com/rss/rssmessages.jspa?forumID=20">
<script language="JavaScript" type="text/javascript" src="images/common.js"></script>
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tbody>
    <tr>
      <td width="140"><a href="http://bbs.chinajavaworld.com/index.jspa"><img src="images/header-left.gif" alt="Java|Java世界_中文论坛|ChinaJavaWorld技术论坛" border="0"></a></td>
      <td><img src="images/header-stretch.gif" alt="" border="0" height="57" width="100%"></td>
      <td width="1%"><img src="images/header-right.gif" alt="" border="0"></td>
    </tr>
  </tbody>
</table>
<br>
<div id="jive-forumpage">
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="98%"><p class="jive-breadcrumbs">论坛: Java语言*初级版
            (模仿)</p>
          <p class="jive-description"> 探讨Java语言基础知识,基本语法等 大家一起交流 共同提高！谢绝任何形式的广告 </p>
          </td>
      </tr>
    </tbody>
  </table>
  <div class="jive-buttons">
    <table summary="Buttons" border="0" cellpadding="0" cellspacing="0">
      <tbody>
        <tr>
          <td class="jive-icon"><img src="images/post-16x16.gif" alt="发表新主题" border="0" height="16" width="16"></td>
          <td class="jive-icon-label"><a id="jive-post-thread" href="post.jsp">发表新主题</a></td>
          <td><a href="article.jsp">树状显示</a></td>
          <td><a href="login.jsp">登录</a></td>
        </tr>
      </tbody>
    </table>
  </div>
  <br>
  <table border="0" cellpadding="3" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td><span class="nobreak"> 当前第<%=pageNo %>页
          	共有<%= totalPages%>页 - <span class="jive-paginator"> 
          [ <a href="article_flat.jsp?pageNo=1&fromSearched=<%= strFromSearched%>&keyword=<%= keyword%>">第一页</a> | 
          	<a href="article_flat.jsp?pageNo=<%= pageNo - 1 %>&fromSearched=<%= strFromSearched%>&keyword=<%= keyword %>" class="">上一页</a> | 
          	<a href="article_flat.jsp?pageNo=<%= pageNo + 1 %>&fromSearched=<%= strFromSearched%>&keyword=<%= keyword %>" class="">下一页</a> | 
          	<a href="article_flat.jsp?pageNo=<%= totalPages %>&fromSearched=<%= strFromSearched%>&keyword=<%= keyword %>" class="jive-current">最后一页</a>
          ]
          		  </span> 
      		</span> 
      	</td>
      	
   <!-- 根据关键词 搜索帖子 -->
      	<td>
      		<form action="article_flat.jsp" method="get">
      			搜索主题帖即内容:
      			<input type="text" name="keyword">
      			<input type="submit" value="搜索">
      			<input type="hidden" name="fromSearched" value="true">
      		</form>
      	</td>
      	
      	
      </tr>
    </tbody>
  </table>
  <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td width="99%"><div class="jive-thread-list">
            <div class="jive-table">
              <table summary="List of threads" cellpadding="0" cellspacing="0" width="100%">
                <thead>
                  <tr>
                    <th class="jive-first" colspan="3"> 主题 </th>
                    <th class="jive-author"> <nobr> 作者
                      &nbsp; </nobr> </th>
                    <th class="jive-view-count"> <nobr> 浏览
                      &nbsp; </nobr> </th>
                    <th class="jive-msg-count" nowrap="nowrap"> 回复 </th>
                    <th class="jive-last" nowrap="nowrap"> 最新帖子 </th>
                  </tr>
                </thead>
                <tbody>
                <% 
                int line = 0;
                
                for(Iterator<Article> it = articles.iterator(); it.hasNext(); ){ 
                	Article a = it.next();
                	
                	line = line%2;
                	
                	String Class = line == 0 ? "jive-even" : "jive-odd";
                	
                	for (int i = 0; i < a.getGrade(); i++)
                %>
                  <tr class=<%=Class %>>
                    <td class="jive-first" nowrap="nowrap" width="1%"><div class="jive-bullet"> <img src="images/read-16x16.gif" alt="已读" border="0" height="16" width="16">
                        <!-- div-->
                      </div></td>
                    <td nowrap="nowrap" width="1%">
                    	
                    	<%
                    		String url = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort();
                    		url += request.getContextPath();
                    		url += request.getServletPath();
                    		url += request.getQueryString() == null ? ("") : ("?" + request.getQueryString());
//                    		System.out.println(url);
//                    		System.out.println(request.getRequestURI());	相对 ip+端口 的地址
//                    		System.out.println(request.getRequestURL());	完整路径

							if(isLogin) {
                    	%>
                    	<a href="update.jsp?id=<%= a.getId() %>">修改</a>
                    	<a href="delete.jsp?id=<%= a.getId() %>&isLeaf=<%= a.isLeaf()%>&pid=<%= a.getPid()%>&from=<%= url%>">删除</a>
                    	
                    	<%
                    		}
                    	%>
                    </td>
                    <td class="jive-thread-name" width="95%"><a id="jive-thread-1" href="article_detail_flat.jsp?id=<%= a.getId()%>"><%= a.getTitle() %></a></td>
                    <td class="jive-author" nowrap="nowrap" width="1%"><span class=""> <a href="http://bbs.chinajavaworld.com/profile.jspa?userID=226030">YuJun</a> </span></td>
                    <td class="jive-view-count" width="1%"> 12450</td>
                    <td class="jive-msg-count" width="1%"> 10</td>
                    <td class="jive-last" nowrap="nowrap" width="1%"><div class="jive-last-post"> <%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(a.getPdate()) %> <br>
                        by: <a href="http://bbs.chinajavaworld.com/thread.jspa?messageID=780182#780182" title="jingjiangjun" style="">CDUT &#187;</a> </div></td>
                  </tr>
                  
                  <%--
                  <tr class="jive-odd">
                    <td class="jive-first" nowrap="nowrap" width="1%"><div class="jive-bullet"> <img src="images/read-16x16.gif" alt="已读" border="0" height="16" width="16">
                        <!-- div-->
                      </div></td>
                    <td nowrap="nowrap" width="1%">&nbsp;
                      
                      
                      
                      
                      &nbsp;</td>
                    <td class="jive-thread-name" width="95%"><a id="jive-thread-2" href="http://bbs.chinajavaworld.com/thread.jspa?threadID=744234&amp;tstart=25">请 兄弟们指点下那里 错误，，，</a></td>
                    <td class="jive-author" nowrap="nowrap" width="1%"><span class=""> <a href="http://bbs.chinajavaworld.com/profile.jspa?userID=226028">403783154</a> </span></td>
                    <td class="jive-view-count" width="1%"> 52</td>
                    <td class="jive-msg-count" width="1%"> 2</td>
                    <td class="jive-last" nowrap="nowrap" width="1%"><div class="jive-last-post"> 2007-9-13 上午8:40 <br>
                        by: <a href="http://bbs.chinajavaworld.com/thread.jspa?messageID=780172#780172" title="downing114" style="">downing114 &#187;</a> </div></td>
                  </tr>
                  --%>
                  
                  <% 
                  	line ++;
                  } %>
                </tbody>
              </table>
            </div>
          </div>
          <div class="jive-legend"></div></td>
      </tr>
    </tbody>
  </table>
  <br>
  <br>
</div>
</body>
</html>
