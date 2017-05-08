<%@ page import="org.apache.poi.util.SystemOutLogger"%>
<%@ page language="java"%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="java.io.*,java.util.*,com.software.main.db.*,com.service.command.*"%>
<%@ page import="org.apache.commons.logging.*,com.service.commucation.client.*,com.agvcommucation.*,com.agvdirecting.*"%>
<%@ page import="com.software.util.*"%>
<%
	int taskid = ParamUtils.getIntParameter(request, "taskid", 0);
	TaskQuene task = new TaskQuene();
	CarPath cp = new CarPath();
	task = task.getById(taskid);
	List cdt = new ArrayList();
	cdt.clear();
	cdt.add("Taskid="+taskid);  
	try{
		cp.deleteByCondition(cdt);
		task.delete(taskid);
		out.println("É¾³ý³É¹¦£¡");
		out.clear();
		} catch (Exception e) {
			e.printStackTrace();
			out.println("É¾³ýÊ§°Ü");
			out.clear();
		}
%>
