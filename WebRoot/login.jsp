<%@ page import="com.cdut.bbs.*,java.sql.*"%>
<%@ page pageEncoding="GB18030"%>

<%
	request.setCharacterEncoding("GBK");
	
	String srtAction = request.getParameter("action");
	String strUsername = request.getParameter("username");
	String strPassword = request.getParameter("password");

	if(srtAction != null && srtAction.trim().equals("post"))
	{
		if(strUsername == null || !strUsername.trim().equals("admin"))
		{
			out.println("用户名不存在,请重新输入.");
		} else if (strPassword == null || !strPassword.trim().equals("admin"))
		{
			out.println("密码错误,请重新输入.");
		} else {
			session.setAttribute("logined", "true");
			out.println("登录成功");
%>
			<br/>
			<a href="article_flat.jsp">返回平板首页</a>
<%
		}
	}

%>

<% 
	if(session.getAttribute("logined") == null) {
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>管理员登录</title>


</head>
	<body>
	
		<form action="login.jsp" method="post">
			用戶名：<input type="text" name="username" value=<%= strUsername%>><br> 
			内容：<input type="password" name="password"/>

			<!-- 登录时向自身传递 名为 action 的隐含参数,以此区分是否是登录进该页面的 -->
			<input type="hidden" name="action" value="post"> <br>
			<input type="submit" value="登录">
		</form>
	
	</body>
</html>

<%
	}
%>


