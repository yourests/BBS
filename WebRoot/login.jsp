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
			out.println("�û���������,����������.");
		} else if (strPassword == null || !strPassword.trim().equals("admin"))
		{
			out.println("�������,����������.");
		} else {
			session.setAttribute("logined", "true");
			out.println("��¼�ɹ�");
%>
			<br/>
			<a href="article_flat.jsp">����ƽ����ҳ</a>
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
<title>����Ա��¼</title>


</head>
	<body>
	
		<form action="login.jsp" method="post">
			�Ñ�����<input type="text" name="username" value=<%= strUsername%>><br> 
			���ݣ�<input type="password" name="password"/>

			<!-- ��¼ʱ�������� ��Ϊ action ����������,�Դ������Ƿ��ǵ�¼����ҳ��� -->
			<input type="hidden" name="action" value="post"> <br>
			<input type="submit" value="��¼">
		</form>
	
	</body>
</html>

<%
	}
%>


