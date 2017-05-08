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
    	$("#postForm_TaskQuene").attr("target","self");
    	$("#postForm_TaskQuene").on("submit", function(event) {
        	$.messager.progress({
            		title : "提示",
            		text : "请稍后...."
        	});
    	});
    	$("#postForm_TaskQuene").form({
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
    	var isValid = $("#postForm_TaskQuene").form("validate");
    	if (!isValid){
        		$.messager.alert("信息不完整", "请将信息填写完整后，再进行下一步");
        		$.messager.progress("close");
    	}else
    	{
        		$("#postForm_TaskQuene").submit();
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
<form action="<%=request.getAttribute("classname")%>Action.jsp" method="post" name="postForm_TaskQuene" id="postForm_TaskQuene">
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="page" value="<%=currpage%>">
<%=Tool.join("\n", forms)%>
<div class="jqueryform" id="jqueryform">
<table border="0" width="100%" cellspacing="0">
<input type="hidden" name="Id" id="Id" value="<%=v.getId()%>">
</table>
<table border="0" width="100%" cellspacing="0">
<tr id="postForm_TaskQuene_Uuid"><td class="td_label">
<div align="right">Uuid:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Uuid"  id="Uuid" size="50" maxlength="50" value="<%=v.getUuid()%>">
</td></tr>
<tr id="postForm_TaskQuene_Name"><td class="td_label">
<div align="right">名称:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Name"  id="Name" size="50" maxlength="50" value="<%=v.getName()%>">
</td></tr>
<input type="hidden" name="TaskId" id="TaskId" value="<%=v.getTaskId()%>">
<input type="hidden" name="Carid" id="Carid" value="<%=v.getCarid()%>">
<tr id="postForm_TaskQuene_Yxj"><td class="td_label">
<div align="right">优先级:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Yxj"  id="Yxj" size="50" maxlength="50" value="<%=v.getYxj()%>">
</td></tr>
<tr id="postForm_TaskQuene_Rwzt"><td class="td_label">
<div align="right">任务状态0未定义1待命区2执行区:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Rwzt"  id="Rwzt" size="50" maxlength="50" value="<%=v.getRwzt()%>">
</td></tr>
<tr id="postForm_TaskQuene_Qd"><td class="td_label">
<div align="right">起点地址:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Qd"  id="Qd" size="50" maxlength="50" value="<%=v.getQd()%>">
</td></tr>
<tr id="postForm_TaskQuene_Zd"><td class="td_label">
<div align="right">终点地址:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Zd"  id="Zd" size="50" maxlength="50" value="<%=v.getZd()%>">
</td></tr>
<input type="hidden" name="QdId" id="QdId" value="<%=v.getQdId()%>">
<input type="hidden" name="ZdId" id="ZdId" value="<%=v.getZdId()%>">
<tr id="postForm_TaskQuene_Flow"><td class="td_label">
<div align="right">路径流程:</div>
</td><td class="td_value">
<textarea name="Flow"  id="Flow" class="easyui-textbox"  data-options="multiline:true" style="height:40px;width:200px"><%=v.getFlow()%></textarea>
</td></tr>
<tr id="postForm_TaskQuene_His_itemids"><td class="td_label">
<div align="right">历史流程:</div>
</td><td class="td_value">
<textarea name="His_itemids"  id="His_itemids" class="easyui-textbox"  data-options="multiline:true" style="height:40px;width:200px"><%=v.getHis_itemids()%></textarea>
</td></tr>
<tr id="postForm_TaskQuene_Cur_itemsids"><td class="td_label">
<div align="right">当前流程:</div>
</td><td class="td_value">
<textarea name="Cur_itemsids"  id="Cur_itemsids" class="easyui-textbox"  data-options="multiline:true" style="height:40px;width:200px"><%=v.getCur_itemsids()%></textarea>
</td></tr>
<tr id="postForm_TaskQuene_Cur_dates"><td class="td_label">
<div align="right">当前状态时间:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Cur_dates"  id="Cur_dates" size="50" maxlength="50" value="<%=v.getCur_dates()%>">
</td></tr>
<tr id="postForm_TaskQuene_Flow_logs"><td class="td_label">
<div align="right">日志:</div>
</td><td class="td_value">
<textarea name="Flow_logs"  id="Flow_logs" class="easyui-textbox"  data-options="multiline:true" style="height:40px;width:200px"><%=v.getFlow_logs()%></textarea>
</td></tr>
<tr id="postForm_TaskQuene_EndFlag"><td class="td_label">
<div align="right">是否结束1待命区2缓冲区3执行区:</div>
</td><td class="td_value">
<input name="EndFlag"  id="EndFlag" class="easyui-numberbox" size="0" value="<%=v.getEndFlag()%>"">
</td></tr>
<tr id="postForm_TaskQuene_Kybz"><td class="td_label">
<div align="right">可用标志:</div>
</td><td class="td_value">
<input name="Kybz"  id="Kybz" class="easyui-numberbox" size="-1" value="<%=v.getKybz()%>"">
</td></tr>
<tr id="postForm_TaskQuene_Hwzl"><td class="td_label">
<div align="right">货物种类:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Hwzl"  id="Hwzl" size="50" maxlength="50" value="<%=v.getHwzl()%>">
</td></tr>
<tr id="postForm_TaskQuene_Hwbm"><td class="td_label">
<div align="right">货物编码:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Hwbm"  id="Hwbm" size="50" maxlength="50" value="<%=v.getHwbm()%>">
</td></tr>
<tr id="postForm_TaskQuene_Hwmc"><td class="td_label">
<div align="right">货物名称:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Hwmc"  id="Hwmc" size="50" maxlength="50" value="<%=v.getHwmc()%>">
</td></tr>
<tr id="postForm_TaskQuene_Hwrfid"><td class="td_label">
<div align="right">货物RFID:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Hwrfid"  id="Hwrfid" size="50" maxlength="50" value="<%=v.getHwrfid()%>">
</td></tr>
<tr id="postForm_TaskQuene_Fhl"><td class="td_label">
<div align="right">发货量:</div>
</td><td class="td_value">
<input name="Fhl"  id="Fhl" class="easyui-numberbox" precision="2" size="0" value="<%=v.getFhl()%>"">
</td></tr>
<tr id="postForm_TaskQuene_CreateTime"><td class="td_label">
<div align="right">创建时间:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="CreateTime"  id="CreateTime" size="50" maxlength="50" value="<%=v.getCreateTime()%>">
</td></tr>
<tr id="postForm_TaskQuene_XfTime"><td class="td_label">
<div align="right">下发时间:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="XfTime"  id="XfTime" size="50" maxlength="50" value="<%=v.getXfTime()%>">
</td></tr>
<tr id="postForm_TaskQuene_StartTime"><td class="td_label">
<div align="right">执行时间 :</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="StartTime"  id="StartTime" size="50" maxlength="50" value="<%=v.getStartTime()%>">
</td></tr>
<tr id="postForm_TaskQuene_EndTime"><td class="td_label">
<div align="right">执行完成时间:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="EndTime"  id="EndTime" size="50" maxlength="50" value="<%=v.getEndTime()%>">
</td></tr>
<tr id="postForm_TaskQuene_Type"><td class="td_label">
<div align="right">任务类型0无效1运货2充电3维修:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Type"  id="Type" size="50" maxlength="50" value="<%=v.getType()%>">
</td></tr>
<tr id="postForm_TaskQuene_Userid"><td class="td_label">
<div align="right">用户编号:</div>
</td><td class="td_value">
<input name="Userid"  id="Userid" class="easyui-numberbox" size="-1" value="<%=v.getUserid()%>"">
</td></tr>
</table>
</form>
</div>
</div>
</body>
</html>
