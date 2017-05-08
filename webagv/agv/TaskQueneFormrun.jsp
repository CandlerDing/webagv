<%@ page language="java" %>
<%--任务队列--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
Log log = LogFactory.getLog(TaskQuene.class);
String msg = (String)request.getAttribute("msg");
String back_msg = (String)request.getAttribute("back_msg");
if ((msg != null)) {
    out.print(HtmlTool.msgBox(request, msg));
    return;
}
if ((back_msg != null)) {
    out.print(HtmlTool.alert(request, back_msg));
}
String cmd = ParamUtils.getParameter(request, "cmd", "insert");
int currpage = ParamUtils.getIntParameter(request, "page", 1);
TaskQuene v = (TaskQuene)request.getAttribute("fromBean");
if (v == null) {
    out.print(HtmlTool.msgBox(request, "请先调用Action.jsp！"));
    return;
}
log.debug(request.getAttribute("classname") + "Form");
String[] dickeys = (String[])request.getAttribute("dickeys");
String[][] dicvalues = (String[][])request.getAttribute("dicvalues");
List diclist = new ArrayList();
for (int i = 0; i < dickeys.length; i ++) {
    diclist.add("\"" + dickeys[i] + "\": [\"" + Tool.join("\", \"", dicvalues[i]) + "\"]");
}
Map extMaps = (Map)request.getAttribute("Ext");
List paras = HttpTool.getSavedUrlForm(request, "Ext");
List urls = (List)paras.get(0);
List forms = (List)paras.get(1);
urls.addAll((List)paras.get(2));
forms.addAll((List)paras.get(3));
String url = Tool.join("&", urls);
//默认值定义
UserInfo userInfo = Tool.getUserInfo(request);
List CarNameoptions =CEditConst.getCarNameOptions(userInfo,"");
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
var url_para = "<%=url%>";
var dic = {<%=Tool.join(", ", diclist)%>};
var keyfield = "<%=(String)request.getAttribute("keyfield")%>";
var allfields = ["<%=Tool.join("\", \"", (String[])request.getAttribute("allfields"))%>"];
var fields = ["<%=Tool.join("\", \"", (String[])request.getAttribute("fields"))%>"];
var options= {<%=HtmlTool.getJsOptions(request)%>};
function init() {
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
           $.ajax({
               type: "POST",
               url: "testrun.jsp",
               data: {carid:$("#Carid").val(),taskid:$("#Id").val()},       
               success: function(data){
               	       alert("发送成功");                 
                 }
           });	
}
function initP() {
             parent.buttonlist = ["reload","save","browse"];;
    					parent.init();
}
function getMap(){	
    var top =  window.screen.availHeight/2-300;
	var left = window.screen.width/2-600;
	$("#openDlgIframe")[0].src="../html/agv.html";
	$("#openDlgDiv").dialog("open").window('resize',{width:'900px',height:'500px',top: top,left:left});
}
function setSelected(rfids)
{
	alert(rfids);
}
$(function () {
    $("#dlg").dialog("close");
}); 

</script>
</head>
<body onload="init();">
<div  style="display:">
 <a href="#" class="easyui-linkbutton"   onClick="save();">任务运行</a>
</div>
<div id="form" style="overflow:auto;height:180px">
<form action="<%=request.getAttribute("classname")%>Action.jsp" method="post" name="postForm_TaskQuene" id="postForm_TaskQuene">
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="page" value="<%=currpage%>">
<%=Tool.join("\n", forms)%>
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
<input name="Qd" id="_Qd_" size="30" maxlength="50" value="<%=v.getQd()%>">
</td></tr>
<tr id="postForm_TaskQuene_Zd"><td class="td_label">
<div align="right">终点:</div>
</td><td class="td_value">
<input name="Zd" id="_Zd_" size="30" maxlength="50" value="<%=v.getZd()%>">
</td></tr>
<input type="hidden" name="QdId" value="<%=v.getQdId()%>">
<input type="hidden" name="ZdId" value="<%=v.getZdId()%>">
<input type="hidden" name="QdUUId" value="<%=v.getQdUUId()%>">
<input type="hidden" name="ZdUUId" value="<%=v.getZdUUId()%>">

</table>
</form>
</div>
</body>
</html>
