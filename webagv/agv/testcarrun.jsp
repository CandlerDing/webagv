<%@ page language="java" %>
<%--任务队列--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%

TaskQuene v = new TaskQuene();

//默认值定义
UserInfo userInfo = null;

List cdt = new ArrayList();
cdt.clear();

cdt.add("length(code)=8");  
cdt.add("ORDER BY CODE"); 
cdt.add("PID=4"); 
List RfidNameoptions = (List)COptionConst.getRfidNameOptions(userInfo,"", cdt);
cdt.clear();
cdt.add("PID=2"); 
List CarNameoptions = (List)COptionConst.getCarNameOptions(userInfo,"", cdt);
%>
<html>
<head>
<title><%=request.getAttribute("describe")%></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/images/default/web_oa.css">
<%@ include file="/js/jsheader.jsp"%>
<script type="text/JavaScript"  src="<%=request.getContextPath()%>/js/jquery-1.7.min.js"></script>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/listfunction.js"></script>
	<link id="easyuiTheme" rel="stylesheet" href="<%=request.getContextPath()%>/js/jquery-easyui-1.3.3/themes/default/easyui.css" type="text/css">
 <link rel="stylesheet" href="<%=request.getContextPath()%>/js/jquery-easyui-1.3.3/themes/icon.css" type="text/css"> 
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.3.3/jquery.easyui.min.js" charset="utf-8"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>

<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/formfunction.js"></script>
<script type="text/JavaScript">
function addcar() {         
    $.ajax({
        type: "POST",
        url: "testcaradd.jsp",
        data: {carid:$("#Carid").val(),qd:$("#Qd").val(),zd:$("#Zd").val()},       
        success: function(data){
        	       alert("连接成功");                 
          }
    });	
}
function run() {         
           $.ajax({
               type: "POST",
               url: "testrun.jsp",
               data: {carid:$("#Carid").val(),qd:$("#Qd").val(),zd:$("#Zd").val()},       
               success: function(data){
               	       alert("发送成功");                 
                 }
           });	
}
</script>
</head>
<body onload="init();">
<div  style="display:">
<a href="#" class="easyui-linkbutton"   onClick="addcar();">连接小车</a>
 <a href="#" class="easyui-linkbutton"   onClick="run();">任务运行</a>
</div>
<div id="form" style="overflow:auto;height:180px">
<form action="<%=request.getAttribute("classname")%>Action.jsp" method="post" name="postForm_TaskQuene" id="postForm_TaskQuene">
<table border="0" width="100%" cellspacing="0">
<input type="hidden" name="Id" id="_Id_" value="<%=v.getId()%>">

<tr id="postForm_TaskQuene_Name"><td class="td_label">
<div align="right">任务名称:</div>
</td><td class="td_value">
<input name="Name" id="_Name_" size="20" maxlength="50" value="<%=v.getName()%>">
</td></tr>
<input type="hidden" name="TaskId" value="<%=v.getTaskId()%>">
<tr id="postForm_TaskQuene_Carid"><td class="td_label">
<div align="right">小车:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(CarNameoptions, "" + v.getCarid(), "Carid", "1")%>
</td></tr>
<tr id="postForm_TaskQuene_Qd"><td class="td_label">
<div align="right">起点:</div>
</td><td class="td_value">
<%-- <input name="Qd" id="_Qd_" size="30" maxlength="50" value="<%=v.getQd()%>"> --%>
<%=HtmlTool.renderSelect(RfidNameoptions, "" + v.getQd(), "Qd", "")%>
</td></tr>
<tr id="postForm_TaskQuene_Zd"><td class="td_label">
<div align="right">终点:</div>
</td><td class="td_value">
<%-- <input name="Zd" id="_Zd_" size="30" maxlength="50" value="<%=v.getZd()%>"> --%>
<%=HtmlTool.renderSelect(RfidNameoptions, "" + v.getZd(), "Zd", "")%>
</td></tr>
</table>
</form>
</div>
</body>
</html>
