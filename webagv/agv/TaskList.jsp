<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%!
private static Log log = LogFactory.getLog(com.software.common.PageControl.class);
%>
<%
log.debug("List");
String msg = (String)request.getAttribute("msg");
String back_msg = (String)request.getAttribute("back_msg");
if ((msg != null)) {
    out.print(HtmlTool.msgBox(request, msg));
    return;
}
if ((back_msg != null)) {
    out.print(HtmlTool.alert(request, back_msg));
}
String cmd = ParamUtils.getParameter(request, "cmd", "list");
StringBuffer str = new StringBuffer();
List rows = (List)request.getAttribute("List");
if (rows == null) {
    out.print(HtmlTool.msgBox(request, "请先调用Action.jsp！"));
    return;
}
int currpage = ParamUtils.getIntParameter(request, "page", 1);
Map extMaps = (Map)request.getAttribute("Ext");
List paras = HttpTool.getSavedUrlForm(request, "Ext");
List urls = (List)paras.get(0);
List forms = (List)paras.get(1);
urls.addAll((List)paras.get(2));
String url = Tool.join("&", urls);
com.software.common.PageControl pagecontrol = (com.software.common.PageControl)request.getAttribute("PageControl");
if (pagecontrol == null) {
    pagecontrol = new com.software.common.PageControl(0, 1, 1);
}
String[] dickeys = (String[])request.getAttribute("dickeys");
String[][] dicvalues = (String[][])request.getAttribute("dicvalues");
List diclist = new ArrayList();
for (int i = 0; i < dickeys.length; i ++) {
    diclist.add("\"" + dickeys[i] + "\": [\"" + Tool.join("\", \"", dicvalues[i]) + "\"]");
}
//默认值定义
List RfidNameoptions = (List)request.getAttribute("RfidNameoptions");
%>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/web_oa.css">
<title> <%=request.getAttribute("describe")%> </title>
<jsp:include page="/jqueryinc.jsp">
<jsp:param value="metro-blue" name="style"/>
</jsp:include>
<%@ include file="/js/jsheader.jsp"%>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/listfunction.js"></script>
<script type="text/JavaScript">
var curr_orderby = ["<%=HttpTool.getString(extMaps, "orderfield", "")%>", "<%=HttpTool.getString(extMaps, "ordertype", "")%>"];
var url_para = "<%=url%>";
var dic = {<%=Tool.join(",\r\n", diclist)%>};
var keyfield = "<%=(String)request.getAttribute("keyfield")%>";
var allfields = ["<%=Tool.join("\", \"", (String[])request.getAttribute("allfields"))%>"];
var fields = ["<%=Tool.join("\", \"", (String[])request.getAttribute("fields"))%>"];
var queryfields = ["<%=Tool.join("\", \"", (String[])request.getAttribute("queryfields"))%>"];
var queryvalues = ["<%=Tool.join("\", \"", (List)request.getAttribute("queryvalues"))%>"];
var rows = [<%=Tool.join(",\r\n", rows)%>];
function init() {
    showList("<%=request.getAttribute("classname")%>", <%=pagecontrol.getCurrPage()%>, url_para);
    //showListReport("<%=request.getAttribute("classname")%>", <%=pagecontrol.getCurrPage()%>, url_para);
}
//parent调用方法 start
function addNew0()
	{
    		addNew('<%=request.getContextPath()%>/目录名/<%=request.getAttribute("classname")%>', url_para);
	}
function deleteList0()
{
    	deleteList('<%=request.getContextPath()%>/目录名/<%=request.getAttribute("classname")%>', url_para);
	}
function save() {
            if (doValidate('postForm_Task')) postForm_Task.submit();
}
function initP() {
             parent.buttonlist = ["reload","addNew","deleteList"];
    					parent.init();
}
var currpage='<%=currpage%>';
function subtask() {
    var chks = document.getElementsByName("chk1");
    if (!url_para)
    url_para = "";
    var chkeds = new Array();
    for (var i = 0; i < chks.length; i ++) {  //当前页面上有多条记录时
    if (chks[i].checked == true) {
      chkeds.push(chks[i].value);
    }
  }
  if (chkeds.length > 0) { 

	tijiaoform.action="TaskAction.jsp?cmd=subtask&idlist="+ chkeds.join(',')+"&page=" + currpage+ ((url_para.length == 0) ? "" : "&" + url_para);
    tijiaoform.method="post";
    tijiaoform.target="_self";
    tijiaoform.submit();
  }else{
  alert("请选择记录");
  }
}
function editTask() {
	var chks=document.getElementsByName("chk1");
	 var chkeds = new Array();
	    for (var i = 0; i < chks.length; i ++) {  //当前页面上有多条记录时
	    if (chks[i].checked == true) {
	      chkeds.push(chks[i].value);
	    }}
	if(chkeds.length==1){
	var top =  window.screen.availHeight/2-400;
	var left = window.screen.width/2-500;
	$("#openDlgIframejs")[0].src="SubTask.jsp?id="+chkeds[0];
	$("#openDlgDiv").dialog("open").window('resize',{width:'870px',height:'450px',top: top,left:left});
	//$("#openDlgDiv").dialog("open").window('resize',{width:'500px',height:'680px'});
	//$("#openDlgDiv").panel("move",{top:$(document).scrollTop() + ($(window).height()-150) * 0.5,left:left});  
	}else{
		$.messager.alert("提示", "请选择一个任务划分子任务", "info");
		return;
	}
	}
function d_close(){
	$('#editpstepdg').dialog('close');
	}
$(document).ready(function(){    
	   $('#openDlgDiv').window({
	       onClose:function(){ 
	    	   self.location.reload(); 
	       }
	   });
	});
function closet(){	
	//self.location.reload(); 
	//alert("划分成功！");
	$("#openDlgDiv").dialog('close');
}
//parent调用方法 end
</script>
</head>
<body onload="init();">
<div id="nav1" style="margin-top:-10px;display:">
    <ul>      
        <a href="javascript:addNew('<%=request.getAttribute("classname")%>', url_para);"  class="easyui-linkbutton" data-options="iconCls:'icon-add'">增加</a>&nbsp;&nbsp;
        <a href="javascript:deleteList('<%=request.getAttribute("classname")%>', url_para);"  class="easyui-linkbutton" data-options="iconCls:'icon-del'">删除</a>&nbsp;&nbsp;        
        <a href="javascript:document.queryForm_Task.cmd.value = 'excel'; document.queryForm_Task.submit();"  class="easyui-linkbutton" data-options="iconCls:'icon-redo'">导出</a>&nbsp;&nbsp;   
      <!--   <a id="tijiao" href="javascript:void(0);" onclick="subtask();" class="easyui-linkbutton" >划分子任务</a></li> -->
        <a href="javascript:editTask();" class="easyui-linkbutton" >划分子任务</a></li>
       <%--  <li><b>[任务]</b></li> --%>
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td background="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/an_hr.JPG" width="99%" height=1></td>
				</tr>
				</table>
    </ul>
</div>
<div id="queryform" >
<!-- <table border="0" width="100%" cellspacing="0" onclick="showhidden('searchTable')" style="cursor:pointer">
<tr><td colspan="8" align="center" class=title_bgcolor>查询条件</td></tr></table> -->
<table border="0" width="100%" cellspacing="0" id="searchTable" style="display:" >
<form action="<%=request.getAttribute("classname")%>Action.jsp" name="queryForm_Task" id="queryForm_Task">
<input type="hidden" name="cmd" value="list">
<%=Tool.join("\n", forms)%>
<tr>
<td>
<div align="right">名称</div>
</td><td>
<input name="_Name_" id="_Name_" value="<%=ParamUtils.getParameter(request, "_Name_", "")%>">
</td>
<td>
<div align="right">任务类型</div>
</td><td>
<input name="_Type_" id="_Type_" value="<%=ParamUtils.getParameter(request, "_Type_", "")%>">
</td>
<td>
<div align="right">是否结束</div>
</td><td>
<input name="_Endflag_" id="_Endflag_" value="<%=ParamUtils.getParameter(request, "_Endflag_", "")%>">
</td>
<td>
<div align="right">是否可用</div>
</td><td>
<input name="_Kybz_" id="_Kybz_" value="<%=ParamUtils.getParameter(request, "_Kybz_", "")%>">
</td><td><a href="javascript:document.queryForm_Task.cmd.value = 'list' ;document.queryForm_Task.submit();"  class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a></td>
</tr></form></table>
</div>
<form action="" method="post" name="tijiaoform" id="tijiaoform">
<input name="idlist" id="idlist"  size="15" type="hidden" value="">
</form>

<div id="list" style="margin-top:-10px;">
</div>
<%=(("listall".equals(cmd)))? "": pagecontrol.getControl((String)request.getAttribute("classname") + "Action.jsp?cmd=list" + ((url.length() == 0) ? "" : "&" + url), "")%>
<div id="openDlgDiv" class="easyui-window" closed="true" modal="true" title="划分子任务" style="width:350px;height:300px;overflow:hidden; z-index:9999">
	<iframe scrolling="auto" id="openDlgIframejs" frameborder="0"  src="" style="width:100%;height:99%;"></iframe>
</div>
<div id="editpstepdg"></div>
</body>
</html>
