<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.db.*"%>
<%@ page import="com.software.main.*"%>
<%@ page import="com.software.util.*,com.software.common.*,com.agvdirecting.util.Logger"%>
<%@ page import="java.io.*,java.util.*,com.agvdirecting.DirectingSystem,com.agvdirecting.car.CarManager"%>
<%
UserInfo userInfo = Tool.getUserInfo(request);
if (userInfo==null) {
    out.print("<meta http-equiv='refresh' content='0;url=logon.jsp'>");
    return;
}
%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Insert title here</title>
</head>
<body>
<%
//任务列表
// 初始操作
DirectingSystem directingSystem = DirectingSystem.GetInstance();

// 加载地图
directingSystem.loadMap("D:\\tomcat7\\webapps\\simple.agvcad");

directingSystem.getDbCommucation().Open();

CarManager carManager = directingSystem.getCarManager();

//out.println(Logger.GetLogger().getInfo());
out.println("=4=");
// 执行测试
directingSystem.testExecute();
%>
</body>
</html>