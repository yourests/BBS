<%@ page language="java" import="java.util.*,java.sql.*,com.cdut.bbs.*" pageEncoding="GB18030"%>
<%
request.setCharacterEncoding("GBK");	// �����ϸ�ҳ�洫�ݹ�������Ϣ ���뷽ʽ

String title = request.getParameter("title");
System.out.println(title);
String cont = request.getParameter("cont");
System.out.println(cont);

// ��ȡ���ݹ���������,��Ҫ�������ݿ��������

Connection conn = DB.getConnection();

boolean autoCommit = conn.getAutoCommit();
conn.setAutoCommit(false);

String sql="insert into article values (null, ?, ?, ?, ?, now(), ?)";
String sql2="update article set isleaf = 1 where id = " + Integer.parseInt(request.getParameter("pid"));

// ע: PreparedStatement ���� ���Ӻʹ������� SQL ���, ����ֵ��ֱ�ӵ��� executeUpdate() ����ִ��
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


<span id = "time">5</span>���Ӻ��Զ���ת,��δ��ת,������������
<br>
<a href = "article.jsp">������ҳ</a>

<script language="JavaScript1.2" type="text/javascript">

function delayURL(url) {
	var delay = document.getElementById("time").innerHTML;	// getElementById �õ����Ƕ���,��Ҫ���� innerHTML ����
	
	if(delay == 0)
		window.top.location.href = url;
	
	else
	{
		delay --;
		document.getElementById("time").innerHTML = delay;	// ��ָ̬��(ע������ �����Ӧ��ֵ)
	}
	
    setTimeout("delayURL('" + url + "')",1000);	// 1���Ӻ���ø÷���
    			// !!! url ��Ȼ�� String ����,������д������ʱ���ǲ��� ""��,��˱��뵥������''
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
