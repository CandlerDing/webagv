<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*,jxl.*,jxl.write.*"%>
<%
UserInfo userInfo = Tool.getUserInfo(request);
if(userInfo==null)
{
	out.clear();
	out.print("[]");
	return 	;
}
String depid = "a";//审核单位depid
String id = ParamUtils.getParameter(request,"id","");
String text = ParamUtils.getParameter(request,"text","");

String flag = ParamUtils.getParameter(request,"flag","");
String depname = ParamUtils.getParameter(request,"depname","");

List row = new ArrayList();
List rows = new ArrayList();
System.out.println("----id="+id);
if(id.equals(""))
{	
	if(userInfo.isAdmin())
	{
		row.add("\"id\":\"00\"");
		row.add("\"text\":\"权限设置\"");
		row.add("\"state\":\"closed\"");
		row.add("\"attributes\":{\"url\":\"\"}");
		
		rows.add("{" + Tool.join(",", row) + "}");
		}
} 
else if(id.length()>0 && id.equals("00"))
{
	row.add("\"id\":\"0001\"");
	row.add("\"text\":\"模块管理\"");
	row.add("\"state\":\"open\"");
	row.add("\"attributes\":{\"url\":\""+request.getContextPath()+"/admin/role_list.jsp?cmd=UserModule\"}");
	rows.add("{" + Tool.join(",", row) + "}");
	
	row.add("\"id\":\"0001\"");
	row.add("\"text\":\"角色管理\"");
	row.add("\"state\":\"open\"");
	row.add("\"attributes\":{\"url\":\""+request.getContextPath()+"/admin/role_list.jsp?cmd=JiaoSe\"}");
	rows.add("{" + Tool.join(",", row) + "}"); 
	
	row.add("\"id\":\"0002\"");
	row.add("\"text\":\"权限管理\"");
	row.add("\"state\":\"open\"");
	row.add("\"attributes\":{\"url\":\""+request.getContextPath()+"/admin/role_list.jsp?cmd=QuanXian\"}");
	rows.add("{" + Tool.join(",", row) + "}");
} //admin/role_index_tree.jsp?cmd=UserModule
	String result = "[" + Tool.join(",", rows) + "]";
			out.clear();
			out.print(result);
		%>