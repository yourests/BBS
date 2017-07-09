<%@ page language="java" import="java.util.*,java.sql.*,com.cdut.bbs.*" pageEncoding="GB18030"%>
<%
request.setCharacterEncoding("GBK");	// 解析上个页面传递过来的信息 编码方式

String title = request.getParameter("title");
System.out.println(title);
String cont = request.getParameter("cont");
System.out.println(cont);

// 获取传递过来的输入,需要连接数据库插入数据

Connection conn = DB.getConnection();

boolean autoCommit = conn.getAutoCommit();
conn.setAutoCommit(false);

String sql="insert into article values (null, ?, ?, ?, ?, now(), ?)";
String sql2="update article set isleaf = 1 where id = " + Integer.parseInt(request.getParameter("pid"));

// 注: PreparedStatement 传入 连接和带参数的 SQL 语句, 设置值后直接调用 executeUpdate() 方法执行
PreparedStatement pstmt = DB.perparedStatement(conn, sql);

pstmt.setInt(1, Integer.parseInt(request.getParameter("pid")));
pstmt.setInt(2, Integer.parseInt(request.getParameter("rootId")));
pstmt.setString(3, title);
pstmt.setString(4, cont);
pstmt.setInt(5, 0);

conn.commit();
conn.setAutoCommit(autoCommit);
/*
	id int primary key auto_increment,
	pid int,
	rootid int,
	title varchar(255),
	cont text,
	pdate datetime,
	isleaf int -- 0 leaf ; 1 not leaf
*/

pstmt.execute(sql2);
pstmt.executeUpdate();
DB.close(pstmt);
DB.close(conn);



String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>


<span id = "time">5</span>秒钟后自动跳转,若未跳转,请点击下面链接
<br>
<a href = "article.jsp">返回首页</a>

<script language="JavaScript1.2" type="text/javascript">

function delayURL(url) {
	var delay = document.getElementById("time").innerHTML;	// getElementById 得到的是对象,需要调用 innerHTML 方法
	
	if(delay == 0)
		window.top.location.href = url;
	
	else
	{
		delay --;
		document.getElementById("time").innerHTML = delay;	// 动态指定(注意对象和 对象对应的值)
	}
	
    setTimeout("delayURL('" + url + "')",1000);	// 1秒钟后调用该方法
    			// !!! url 虽然是 String 类型,但单独写出来的时候是不带 ""的,因此必须单独加上''
}

</script>

<script type="text/javascript">
	delayURL("article.jsp");
</script>

<!--
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'replyDeal.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
//	<link rel="stylesheet" type="text/css" href="styles.css">


  </head>
  
  <body>
    Insert successfully! <br>
  </body>
</html>
-->
