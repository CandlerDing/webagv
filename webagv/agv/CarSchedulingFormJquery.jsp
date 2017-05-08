<%@ page language="java" %>
<%--车辆运行记录--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
Log log = LogFactory.getLog(CarScheduling.class);
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
CarScheduling v = (CarScheduling)request.getAttribute("fromBean");
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
List YesNooptions = (List)request.getAttribute("YesNooptions");
List TaskNameoptions = (List)request.getAttribute("TaskNameoptions");
List CarNameoptions = (List)request.getAttribute("CarNameoptions");
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
    	$("#postForm_CarScheduling").attr("target","self");
    	$("#postForm_CarScheduling").on("submit", function(event) {
        	$.messager.progress({
            		title : "提示",
            		text : "请稍后...."
        	});
    	});
    	$("#postForm_CarScheduling").form({
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
    	var isValid = $("#postForm_CarScheduling").form("validate");
    	if (!isValid){
        		$.messager.alert("信息不完整", "请将信息填写完整后，再进行下一步");
        		$.messager.progress("close");
    	}else
    	{
        		$("#postForm_CarScheduling").submit();
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
<form action="<%=request.getAttribute("classname")%>Action.jsp" method="post" name="postForm_CarScheduling" id="postForm_CarScheduling">
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="page" value="<%=currpage%>">
<%=Tool.join("\n", forms)%>
<div class="jqueryform" id="jqueryform">
<table border="0" width="100%" cellspacing="0">
<input type="hidden" name="Id" id="Id" value="<%=v.getId()%>">
</table>
<table border="0" width="100%" cellspacing="0">
<tr id="postForm_CarScheduling_Carid"><td class="td_label">
<div align="right">小车:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(CarNameoptions, "" + v.getCarid(), "Carid", "-1")%>
<%//radio形式%>
<%//CarNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(CarNameoptions, "" + v.getCarid(), "Carid", "-1")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(CarNameoptions, "" + v.getCarid(), "Carid", "-1")%>
</td></tr>
<tr id="postForm_CarScheduling_Taskid"><td class="td_label">
<div align="right">任务ID:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(TaskNameoptions, "" + v.getTaskid(), "Taskid", "-1")%>
<%//radio形式%>
<%//TaskNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(TaskNameoptions, "" + v.getTaskid(), "Taskid", "-1")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(TaskNameoptions, "" + v.getTaskid(), "Taskid", "-1")%>
</td></tr>
<tr id="postForm_CarScheduling_Dqsd"><td class="td_label">
<div align="right">运行速度:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Dqsd"  id="Dqsd" size="50" maxlength="50" value="<%=v.getDqsd()%>">
</td></tr>
<tr id="postForm_CarScheduling_Dqdy"><td class="td_label">
<div align="right">电池电压:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Dqdy"  id="Dqdy" size="50" maxlength="50" value="<%=v.getDqdy()%>">
</td></tr>
<tr id="postForm_CarScheduling_Fzzt"><td class="td_label">
<div align="right">负载状态:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getFzzt(), "Fzzt", "-1")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getFzzt(), "Fzzt", "-1")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getFzzt(), "Fzzt", "-1")%>
</td></tr>
<tr id="postForm_CarScheduling_Yxzt"><td class="td_label">
<div align="right">运行状态:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getYxzt(), "Yxzt", "-1")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getYxzt(), "Yxzt", "-1")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getYxzt(), "Yxzt", "-1")%>
</td></tr>
<tr id="postForm_CarScheduling_Qd"><td class="td_label">
<div align="right">起点:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Qd"  id="Qd" size="50" maxlength="50" value="<%=v.getQd()%>">
</td></tr>
<tr id="postForm_CarScheduling_Zd"><td class="td_label">
<div align="right">终点:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Zd"  id="Zd" size="50" maxlength="50" value="<%=v.getZd()%>">
</td></tr>
<tr id="postForm_CarScheduling_Yxtime"><td class="td_label">
<div align="right">运行时间:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Yxtime"  id="Yxtime" size="50" maxlength="50" value="<%=v.getYxtime()%>">
</td></tr>
<input type="hidden" name="TaskRemark" id="TaskRemark" value="<%=v.getTaskRemark()%>">
</table>
</form>
</div>
</div>
</body>
</html>
