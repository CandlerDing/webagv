<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.software.main.db.*,com.software.main.*"%>
<%@ page import="com.software.util.*,java.util.*,com.software.main.*"%>
<%@ page import="com.software.main.db.*,com.software.common.*"%>
<%

String url = HeadConst.root_url_path;
Cookie cookie = new Cookie(HeadConst.MainCookieName, "");
response.addCookie(cookie);
session.removeAttribute("UserInfo");
%>
<script language=javascript>
  window.opener=null;
  top.location.href="logon.jsp";
</script>