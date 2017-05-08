<%@ page language="java" %>
<%--任务命令--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
Log log = LogFactory.getLog(TaskCommand.class);
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
TaskCommand v = (TaskCommand)request.getAttribute("fromBean");
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
List TaskNameoptions = (List)request.getAttribute("TaskNameoptions");
%>
<html>
<head>
<title><%=request.getAttribute("describe")%></title>
<jsp:include page="/jqueryinc.jsp">
<jsp:param value="metro-blue" name="style"/>
</jsp:include>
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
    	$("#postForm_TaskCommand").attr("target","self");
    	$("#postForm_TaskCommand").on("submit", function(event) {
        	$.messager.progress({
            		title : "提示",
            		text : "请稍后...."
        	});
    	});
    	$("#postForm_TaskCommand").form({
        		success:function(data){
            			$.messager.progress("close");
            			var obj = eval("("+data+")");
            			if(obj.success)
            			{
                			if(obj.success=="true")
                			{
                    				$.messager.progress({
                        					title : "提示",
                        					text : "操作成功"
                    				});
                    				//关闭
                    				parent.reloadData();
                    				parent.$("#openDlgDiv").dialog("close");
                			}else
                			{
                    				$.messager.alert("Info", "操作失败，请联系技术人员(success=false)");
                			}
            			}else
            			{
                				$.messager.alert("Info", "操作失败，请联系技术人员(success is null)");
            			}
        		}
    	});
    	var isValid = $("#postForm_TaskCommand").form("validate");
    	if (!isValid){
        		$.messager.alert("信息不完整", "请将信息填写完整后，再进行下一步");
        		$.messager.progress("close");
    	}else
    	{
        		$("#postForm_TaskCommand").submit();
    	}
}
function initP() {
             parent.buttonlist = ["reload","save","browse"];;
    					parent.init();
}
//parent调用方法 end
// onkeypress="repeatPhone();" onChange="checkPhone(this);"js，无刷新验证手机号，
</script>
</head>
<body onload="init();">
<div id="footer" style="padding:5px;">
<div style="text-align:right;padding:5px">
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" style="width:80px" onclick="save()">保存</a>
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:80px"  onclick="document.postForm_User_Module.reset()">刷新</a>
<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" style="width:80px" onclick="parent.$('#openDlgDiv').dialog('close');">关闭</a>
</div>
</div>
<div id="errorDiv" style="color:red;font-weight:bold"></div>
<div id="jserrorDiv" style="color:red;font-weight:bold"></div>
<div class="easyui-panel" title="" style="width:100%" data-options="footer:'#footer'">
<form action="<%=request.getAttribute("classname")%>Action.jsp" method="post" name="postForm_TaskCommand" id="postForm_TaskCommand">
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="page" value="<%=currpage%>">
<%=Tool.join("\n", forms)%>
<div class="jqueryform" id="jqueryform">
<table border="0" width="100%" cellspacing="0">
<input type="hidden" name="Id" id="Id" value="<%=v.getId()%>">
</table>
<table border="0" width="100%" cellspacing="0">
<tr id="postForm_TaskCommand_Xh"><td class="td_label">
<div align="right">序号:</div>
</td><td class="td_value">
<input name="Xh"  id="Xh" class="easyui-numberbox" size="-1" value="<%=v.getXh()%>"">
</td></tr>
<tr id="postForm_TaskCommand_Taskid"><td class="td_label">
<div align="right">任务ID:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(TaskNameoptions, "" + v.getTaskid(), "Taskid", "-1")%>
<%//radio形式%>
<%//TaskNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(TaskNameoptions, "" + v.getTaskid(), "Taskid", "-1")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(TaskNameoptions, "" + v.getTaskid(), "Taskid", "-1")%>
</td></tr>
<input type="hidden" name="RfidId" id="RfidId" value="<%=v.getRfidId()%>">
<tr id="postForm_TaskCommand_ComandsCode"><td class="td_label">
<div align="right">命令代码:</div>
</td><td class="td_value">
<textarea name="ComandsCode"  id="ComandsCode" class="easyui-textbox"  data-options="multiline:true" style="height:40px;width:200px"><%=v.getComandsCode()%></textarea>
</td></tr>
<tr id="postForm_TaskCommand_Sendtime"><td class="td_label">
<div align="right">发送时间:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Sendtime"  id="Sendtime" size="50" maxlength="50" value="<%=v.getSendtime()%>">
</td></tr>
<tr id="postForm_TaskCommand_Flag"><td class="td_label">
<div align="right">是否已执行:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Flag"  id="Flag" size="50" maxlength="50" value="<%=v.getFlag()%>">
</td></tr>
<tr id="postForm_TaskCommand_Remark"><td class="td_label">
<div align="right">备注:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Remark"  id="Remark" size="50" maxlength="50" value="<%=v.getRemark()%>">
</td></tr>
</table>
</form>
</div>
</div>
</body>
</html>
