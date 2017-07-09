<%@page import = "java.sql.*,java.io.*,java.util.*,com.cdut.bbs.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%-- 鐎规矮绠熼柅鎺戠秺閺傝纭� --%>
<%!
	private void tree(List<Article> articles, Connection conn, int id, int grade)
	{
		// 瀵帮拷tree閺傝纭舵稉顓濈炊閸忋儰閲� Set/List, 瀵邦亞骞嗘导鐘插弳 Article 鐎电钖�,楠炴儼顔曠�规艾鐫橀幀褍锟斤拷(娴犲孩鏆熼幑顔肩氨娑擃厼褰�),娑斿鎮楅崷鈺ml妞ょ敻娼版稉顓炰粵鐏炴洜骞�
		
		String sql = "select * from article where pid = " + id;	// 閹垫儳鍩岀�涙劕绗�
		Statement stmt = DB.createStatement(conn);
		ResultSet rs = DB.getResultSet(stmt, sql); // 鏉╂柨娲栫�涙劕绗橀惃鍕波閺嬫粓娉�
		
		try 
		{
			while(rs.next()) // 瀵邦亞骞嗛幍锟介張澶婄摍鐢拷,楠炶泛鎮� Set 娑擃厺绱堕崗锟� 鐎涙劕绗樼�电钖�
			{
				Article a = new Article();
				
				a.initFromRs(rs);
				a.setGrade(grade);
				
				articles.add(a);
				if(a.isLeaf()!=true)
				{
					tree(articles, conn, a.getId(), grade + 1);
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			DB.close(rs);
			DB.close(stmt);
		}
		
	}
%>

<%-- _jspService閺傝纭堕崘锟� 閹笛嗩攽闁劌鍨� --%>
<%
	List<Article> articles = new ArrayList<Article>();	// 鐎规矮绠熸稉锟� Set,瀵帮拷tree娑擃厺绱堕崗锟� Article 鐎电钖�
	Connection conn = DB.getConnection();
	tree(articles, conn, 0, 0);
	DB.close(conn);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>Java|Java娑撴牜鏅玙娑擃厽鏋冪拋鍝勬涧|ChinaJavaWorld閹讹拷閺堫垵顔戦崸锟� : Java鐠囶叀鈻�*閸掓繄楠囬悧锟�</title>
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
      <td width="140"><a href="http://bbs.chinajavaworld.com/index.jspa"><img src="images/header-left.gif" alt="Java|Java娑撴牜鏅玙娑擃厽鏋冪拋鍝勬涧|ChinaJavaWorld閹讹拷閺堫垵顔戦崸锟�" border="0"></a></td>
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
        <td width="98%"><p class="jive-breadcrumbs">鐠佸搫娼�: Java鐠囶叀鈻�*閸掓繄楠囬悧锟�
            (濡�茶雹)</p>
          <p class="jive-description"> 閹恒垼顓縅ava鐠囶叀鈻堥崺铏诡攨閻儴鐦�,閸╃儤婀扮拠顓熺《缁涳拷 婢堆冾啀娑擄拷鐠ц渹姘﹀ù锟� 閸忓崬鎮撻幓鎰扮彯閿涗浇闃跨紒婵呮崲娴ｆ洖鑸板蹇曟畱楠炲灝鎲� </p>
          </td>
      </tr>
    </tbody>
  </table>
  <div class="jive-buttons">
    <table summary="Buttons" border="0" cellpadding="0" cellspacing="0">
      <tbody>
        <tr>
          <td class="jive-icon"><img src="images/post-16x16.gif" alt="閸欐垼銆冮弬棰佸瘜妫帮拷" border="0" height="16" width="16"></td>
          <td class="jive-icon-label"><a id="jive-post-thread" href="post.jsp">閸欐垼銆冮弬棰佸瘜妫帮拷</a></td>
          <td><a href = "article_flat.jsp">楠炶櫕婢橀弰鍓с仛</a></td>
        </tr>
      </tbody>
    </table>
  </div>
  <br>
  <table border="0" cellpadding="3" cellspacing="0" width="100%">
    <tbody>
      <tr valign="top">
        <td><span class="nobreak"> 妞わ拷:
          1,316 - <span class="jive-paginator"> [ <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=0&amp;isBest=0">娑撳﹣绔存い锟�</a> | <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=0&amp;isBest=0" class="">1</a> <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=25&amp;isBest=0" class="jive-current">2</a> <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=50&amp;isBest=0" class="">3</a> <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=75&amp;isBest=0" class="">4</a> <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=100&amp;isBest=0" class="">5</a> <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=125&amp;isBest=0" class="">6</a> | <a href="http://bbs.chinajavaworld.com/forum.jspa?forumID=20&amp;start=50&amp;isBest=0">娑撳绔存い锟�</a> ] </span> </span> </td>
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
                    <th class="jive-first" colspan="3"> 娑撳顣� </th>
                    <th class="jive-author"> <nobr> 娴ｆ粏锟斤拷
                      &nbsp; </nobr> </th>
                    <th class="jive-view-count"> <nobr> 濞村繗顫�
                      &nbsp; </nobr> </th>
                    <th class="jive-msg-count" nowrap="nowrap"> 閸ョ偛顦� </th>
                    <th class="jive-last" nowrap="nowrap"> 閺堬拷閺傛澘绗樼�涳拷 </th>
                  </tr>
                </thead>
                <tbody>
                <% 
                for(Iterator<Article> it = articles.iterator(); it.hasNext(); ){ 
                	Article a = it.next();
                	String prtStr = "";
                	
                	for (int i = 0; i < a.getGrade(); i++)
                		prtStr += "----";
                %>
                  <tr class="jive-even">
                    <td class="jive-first" nowrap="nowrap" width="1%"><div class="jive-bullet"> <img src="images/read-16x16.gif" alt="瀹歌尪顕�" border="0" height="16" width="16">
                        <!-- div-->
                      </div></td>
                    <td nowrap="nowrap" width="1%">
                    
                    	<a href="delete.jsp?id=<%= a.getId() %>&isLeaf=<%= a.isLeaf()%>&pid=<%= a.getPid()%>">閸掔娀娅�</a>
                    
                    </td>
                    <td class="jive-thread-name" width="95%"><a id="jive-thread-1" href="article_detail.jsp?id=<%= a.getId()%>"><%= prtStr + a.getTitle() %></a></td>
                    <td class="jive-author" nowrap="nowrap" width="1%"><span class=""> <a href="http://bbs.chinajavaworld.com/profile.jspa?userID=226030">YuJun</a> </span></td>
                    <td class="jive-view-count" width="1%"> 12450</td>
                    <td class="jive-msg-count" width="1%"> 10</td>
                    <td class="jive-last" nowrap="nowrap" width="1%"><div class="jive-last-post"> <%= new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(a.getPdate()) %> <br>
                        by: <a href="http://bbs.chinajavaworld.com/thread.jspa?messageID=780182#780182" title="jingjiangjun" style="">CDUT &#187;</a> </div></td>
                  </tr>
                  
                  <%--
                  <tr class="jive-odd">
                    <td class="jive-first" nowrap="nowrap" width="1%"><div class="jive-bullet"> <img src="images/read-16x16.gif" alt="瀹歌尪顕�" border="0" height="16" width="16">
                        <!-- div-->
                      </div></td>
                    <td nowrap="nowrap" width="1%">&nbsp;
                      
                      
                      
                      
                      &nbsp;</td>
                    <td class="jive-thread-name" width="95%"><a id="jive-thread-2" href="http://bbs.chinajavaworld.com/thread.jspa?threadID=744234&amp;tstart=25">鐠囷拷 閸忓嫬绱垫禒顒佸瘹閻愰�涚瑓闁綁鍣� 闁挎瑨顕ら敍宀嬬礉閿涳拷</a></td>
                    <td class="jive-author" nowrap="nowrap" width="1%"><span class=""> <a href="http://bbs.chinajavaworld.com/profile.jspa?userID=226028">403783154</a> </span></td>
                    <td class="jive-view-count" width="1%"> 52</td>
                    <td class="jive-msg-count" width="1%"> 2</td>
                    <td class="jive-last" nowrap="nowrap" width="1%"><div class="jive-last-post"> 2007-9-13 娑撳﹤宕�8:40 <br>
                        by: <a href="http://bbs.chinajavaworld.com/thread.jspa?messageID=780172#780172" title="downing114" style="">downing114 &#187;</a> </div></td>
                  </tr>
                  --%>
                  
                  <% } %>
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
