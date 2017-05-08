<%@ page contentType="text/xml;charset=utf-8"%><?xml version="1.0" encoding="gbk" ?><%
//////op=sub 表示取子节点
///////////root=数字表示上级节点
String ParentID=request.getParameter("parent");
String Op=request.getParameter("op");
String Title="成都铁路公安局",more="dd",SN="rootdept";
out.println("<xml>");
if(ParentID!=null && (ParentID.equals("rootdept")))
{	
	for(int i=0;i<10;i++)
	out.println("<directory name=\"子部门3333中顺" +i+ "\" more=\"" + more+"\" sn=\"childDept"+i+"\" />");
}
else if (ParentID!=null && (ParentID.indexOf("childDept")>=0))
{
	more="";
	for(int i=0;i<10;i++)
	out.println("<directory name=\"三级部门3" +i+ "\" more=\"" + more+"\" sn=\"ttttt"+i+"\" />");
}
else
out.println("<directory name=\"" +Title+ "\" more=\"" + more+"\" sn=\""+SN+"\" />");
out.println("</xml>");
%>