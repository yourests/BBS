<%@ page contentType="text/html; charset=GBK"%>

<%
	boolean isLogin = false;
	String strLogin = (String) session.getAttribute("logined");
	
	if(strLogin == null || !strLogin.trim().equals("true"))		// ���û�е�¼����,ɾ��֮ǰ������,Ҫ�����µ�¼
	{
		response.sendRedirect("login.jsp");
		return;		// ����д return,���򻹻�����ִ��ɾ������
	}
%>
