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
List YesNooptions = (List)request.getAttribute("YesNooptions");
List TaskNameoptions = (List)request.getAttribute("TaskNameoptions");
List CarNameoptions = (List)request.getAttribute("CarNameoptions");
%>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/web_oa.css">
<title> <%=request.getAttribute("describe")%> </title>
<%@ include file="/js/jsheader.jsp"%>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/listfunction.js"></script>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/prototype.js"></script>
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
            if (doValidate('postForm_CarScheduling')) postForm_CarScheduling.submit();
}
function initP() {
             parent.buttonlist = ["reload","addNew","deleteList"];
    					parent.init();
}
//parent调用方法 end
</script>
</head>
<body onload="init();">
<div id="nav1" style="display:">
    <ul>
        <li><a href="javascript:addNew('<%=request.getAttribute("classname")%>', url_para);"><img src="<%=request.getContextPath()%>/images/default/16_038.gif" alt="增加记录"></a></li>
        <li><a href="javascript:deleteList('<%=request.getAttribute("classname")%>', url_para);"><img src="<%=request.getContextPath()%>/images/default/button4.gif" alt="删除记录"></a></li>
        <li><a href="javascript:document.queryForm_CarScheduling.cmd.value = 'list' ;document.queryForm_CarScheduling.submit();"><img src="<%=request.getContextPath()%>/images/default/button_cx.gif" alt="查询"></a></li>
        <li><a href="javascript:document.queryForm_CarScheduling.cmd.value = 'excel'; document.queryForm_CarScheduling.submit();"><img src="<%=request.getContextPath()%>/images/default/button_dc.gif" alt="导出Excel文件"></a></li>
        <li><b>[车辆运行记录]</b></li>
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td background="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/an_hr.JPG" width="99%" height=1></td>
				</tr>
				</table>
    </ul>
</div>
<div id="queryform">
<table border="0" width="100%" cellspacing="0" onclick="showhidden('searchTable')" style="cursor:pointer">
<tr><td colspan="8" align="center" class=title_bgcolor>查询条件</td></tr></table>
<table border="0" width="100%" cellspacing="0" id="searchTable" style="display:none" >
<form action="<%=request.getAttribute("classname")%>Action.jsp" name="queryForm_CarScheduling" id="queryForm_CarScheduling">
<input type="hidden" name="cmd" value="list">
<%=Tool.join("\n", forms)%>
<tr>
<td>
<div align="right">小车</div>
</td><td>
<%=HtmlTool.renderSelect(CarNameoptions, ParamUtils.getParameter(request,"_Carid_",""), "_Carid_", "")%>
<%//radio形式%>
<%//CarNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(CarNameoptions, ParamUtils.getParameter(request,"_Carid_",""), "_Carid_", "")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(CarNameoptions, ParamUtils.getParameter(request,"_Carid_",""), "_Carid_", "")%>
</td>
<td>
<div align="right">任务ID</div>
</td><td>
<%=HtmlTool.renderSelect(TaskNameoptions, ParamUtils.getParameter(request,"_Taskid_",""), "_Taskid_", "")%>
<%//radio形式%>
<%//TaskNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(TaskNameoptions, ParamUtils.getParameter(request,"_Taskid_",""), "_Taskid_", "")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(TaskNameoptions, ParamUtils.getParameter(request,"_Taskid_",""), "_Taskid_", "")%>
</td>
<td>
<div align="right">运行速度</div>
</td><td>
<input name="_Dqsd_" id="_Dqsd_" value="<%=ParamUtils.getParameter(request, "_Dqsd_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">电池电压</div>
</td><td>
<input name="_Dqdy_" id="_Dqdy_" value="<%=ParamUtils.getParameter(request, "_Dqdy_", "")%>">
</td>
<td>
<div align="right">负载状态</div>
</td><td>
<%=HtmlTool.renderSelect(YesNooptions, ParamUtils.getParameter(request,"_Fzzt_",""), "_Fzzt_", "")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, ParamUtils.getParameter(request,"_Fzzt_",""), "_Fzzt_", "")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, ParamUtils.getParameter(request,"_Fzzt_",""), "_Fzzt_", "")%>
</td>
<td>
<div align="right">运行状态</div>
</td><td>
<%=HtmlTool.renderSelect(YesNooptions, ParamUtils.getParameter(request,"_Yxzt_",""), "_Yxzt_", "")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, ParamUtils.getParameter(request,"_Yxzt_",""), "_Yxzt_", "")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, ParamUtils.getParameter(request,"_Yxzt_",""), "_Yxzt_", "")%>
</td>
</tr><tr>
<td>
<div align="right">起点</div>
</td><td>
<input name="_Qd_" id="_Qd_" value="<%=ParamUtils.getParameter(request, "_Qd_", "")%>">
</td>
<td>
<div align="right">终点</div>
</td><td>
<input name="_Zd_" id="_Zd_" value="<%=ParamUtils.getParameter(request, "_Zd_", "")%>">
</td>
<td>
<div align="right">运行时间</div>
</td><td>
<input name="_Yxtime_" id="_Yxtime_" value="<%=ParamUtils.getParameter(request, "_Yxtime_", "")%>">
</td>
</tr><tr>
<input type="hidden" name="_TaskRemark_" id="_TaskRemark_" value="<%=ParamUtils.getParameter(request, "_TaskRemark_", "")%>">
</tr><tr><td colspan="8" align="center">
<input type="button" value="Reset" onClick="clearForm('queryForm_CarScheduling')" />
</td></tr></form></table>
</div>
<div>每页显示条数：<%=Tool.getUserInfo(request).getDispNum()%></div>
<div id="list">
</div>
<%=(("listall".equals(cmd)))? "": pagecontrol.getControl((String)request.getAttribute("classname") + "Action.jsp?cmd=list" + ((url.length() == 0) ? "" : "&" + url), "")%>
</body>
</html>
