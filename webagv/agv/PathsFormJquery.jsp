<%@ page language="java" %>
<%--路径管理--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
Log log = LogFactory.getLog(Paths.class);
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
Paths v = (Paths)request.getAttribute("fromBean");
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
    	$("#postForm_Paths").attr("target","self");
    	$("#postForm_Paths").on("submit", function(event) {
        	$.messager.progress({
            		title : "提示",
            		text : "请稍后...."
        	});
    	});
    	$("#postForm_Paths").form({
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
    	var isValid = $("#postForm_Paths").form("validate");
    	if (!isValid){
        		$.messager.alert("信息不完整", "请将信息填写完整后，再进行下一步");
        		$.messager.progress("close");
    	}else
    	{
        		$("#postForm_Paths").submit();
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
<form action="<%=request.getAttribute("classname")%>Action.jsp" method="post" name="postForm_Paths" id="postForm_Paths">
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="page" value="<%=currpage%>">
<%=Tool.join("\n", forms)%>
<div class="jqueryform" id="jqueryform">
<table border="0" width="100%" cellspacing="0">
<input type="hidden" name="Id" id="Id" value="<%=v.getId()%>">
</table>
<table border="0" width="100%" cellspacing="0">
<tr id="postForm_Paths_Code"><td class="td_label">
<div align="right">编码:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Code"  id="Code" size="50" maxlength="50" value="<%=v.getCode()%>">
</td></tr>
<tr id="postForm_Paths_Name"><td class="td_label">
<div align="right">名称:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Name"  id="Name" size="50" maxlength="50" value="<%=v.getName()%>">
</td></tr>
<input type="hidden" name="IdP" id="IdP" value="<%=v.getIdP()%>">
<tr id="postForm_Paths_Start"><td class="td_label">
<div align="right">起点:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Start"  id="Start" size="50" maxlength="50" value="<%=v.getStart()%>">
</td></tr>
<tr id="postForm_Paths_End"><td class="td_label">
<div align="right">终点:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="End"  id="End" size="50" maxlength="50" value="<%=v.getEnd()%>">
</td></tr>
<tr id="postForm_Paths_Len"><td class="td_label">
<div align="right">长度:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Len"  id="Len" size="50" maxlength="50" value="<%=v.getLen()%>">
</td></tr>
<tr id="postForm_Paths_Dire"><td class="td_label">
<div align="right">方向:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Dire"  id="Dire" size="50" maxlength="50" value="<%=v.getDire()%>">
</td></tr>
<tr id="postForm_Paths_Type"><td class="td_label">
<div align="right">类型:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Type"  id="Type" size="50" maxlength="50" value="<%=v.getType()%>">
</td></tr>
<tr id="postForm_Paths_FxType"><td class="td_label">
<div align="right">方向类型:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="FxType"  id="FxType" size="50" maxlength="50" value="<%=v.getFxType()%>">
</td></tr>
<tr id="postForm_Paths_Isuse"><td class="td_label">
<div align="right">是否可用:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getIsuse(), "Isuse", "-1")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getIsuse(), "Isuse", "-1")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getIsuse(), "Isuse", "-1")%>
</td></tr>
<tr id="postForm_Paths_Isct"><td class="td_label">
<div align="right">是否有磁条:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getIsct(), "Isct", "-1")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getIsct(), "Isct", "-1")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getIsct(), "Isct", "-1")%>
</td></tr>
<tr id="postForm_Paths_Isbr"><td class="td_label">
<div align="right">是否有避让区:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getIsbr(), "Isbr", "-1")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getIsbr(), "Isbr", "-1")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getIsbr(), "Isbr", "-1")%>
</td></tr>
<tr id="postForm_Paths_Braddress"><td class="td_label">
<div align="right">避让区位置:</div>
</td><td class="td_value">
<input type="text" class="easyui-textbox" name="Braddress"  id="Braddress" size="50" maxlength="50" value="<%=v.getBraddress()%>">
</td></tr>
<tr id="postForm_Paths_Orderno"><td class="td_label">
<div align="right">排序:</div>
</td><td class="td_value">
<input name="Orderno"  id="Orderno" class="easyui-numberbox" size="-1" value="<%=v.getOrderno()%>"">
</td></tr>
<tr id="postForm_Paths_Remark"><td class="td_label">
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
