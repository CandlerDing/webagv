<%@ page contentType="text/html; charset=GBK"%>
<%@ page import="com.software.main.db.*,com.software.main.*"%>
<%@ page import="com.software.util.*,java.util.*,com.software.main.*"%>
<%@ page import="com.software.main.db.*,com.software.common.*"%>
<%
//�ļ����֣�logoff.jsp
//����˵����ע����¼,Ȼ�󷵻ص�¼ҳ��.
//���ߣ�        ylx@beelink.com
//�������ڣ�    2002-04-11 18:17
//����޸����ڣ�2002-04-11 18:25
//�ؼ��㷨˵������
//������        ��
String url = HeadConst.root_url_path;
Cookie cookie = new Cookie(HeadConst.MainCookieName, "");
response.addCookie(cookie);
session.removeAttribute("UserInfo");
%>
<script>
top.location="<%=request.getContextPath()%>/logon.jsp";
</script>