<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.software.main.db.*,com.software.main.*"%>
<%@ page import="com.software.util.*,java.util.*,com.software.main.*"%>
<%@ page import="com.software.main.db.*,com.software.common.*"%>
<%
//文件名字：logoff.jsp
//功能说明：注销登录,然后返回登录页面.
//作者：        ylx@beelink.com
//创建日期：    2002-04-11 18:17
//最后修改日期：2002-04-11 18:25
//关键算法说明：无
//其他：        无
String url = HeadConst.root_url_path;
Cookie cookie = new Cookie(HeadConst.MainCookieName, "");
response.addCookie(cookie);
session.removeAttribute("UserInfo");
%>
<script>
top.location="<%=request.getContextPath()%>/logon.jsp";
</script>