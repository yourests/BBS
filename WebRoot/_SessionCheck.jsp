<%@ page contentType="text/html; charset=GBK"%>

<%
	boolean isLogin = false;
	String strLogin = (String) session.getAttribute("logined");
	
	if(strLogin == null || !strLogin.trim().equals("true"))		// 如果没有登录进来,删除之前检查该项,要求重新登录
	{
		response.sendRedirect("login.jsp");
		return;		// 必须写 return,否则还会往下执行删除操作
	}
%>
