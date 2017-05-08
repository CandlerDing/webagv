<%@ page language="java" %>
<%--任务--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
UserInfo userInfo = Tool.getUserInfo(request);
Log log = LogFactory.getLog(Task.class);
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
Task v = (Task)request.getAttribute("fromBean");
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

List YesNooptions = CEditConst.getYesNoOptions(userInfo);
List cdt = new ArrayList();
cdt.clear();
cdt.add("length(code)=8");  
cdt.add("ORDER BY CODE"); 
cdt.add("PID=4"); 
List RfidNameoptions = (List)COptionConst.getRfidNameOptions(userInfo,"", cdt);
cdt.clear();
List TaskTypeNameoptions =CEditConst.getTaskTypeNameOptions(userInfo,"1");

%>
<html>
<head>
<title><%=request.getAttribute("describe")%></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/web_oa.css">
<%@ include file="/js/jsheader.jsp"%>
<script type="text/JavaScript" language="JavaScript" src="<%=request.getContextPath()%>/js/validation-framework.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/themes/default/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/themes/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/demo/demo.css">
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/syUtil.js" charset="utf-8"></script>
	<script type="text/javascript" src="<%=request.getContextPath()%>/js/locale/easyui-lang-zh_CN.js" charset="utf-8"></script>
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/extEasyUIIcon.css?v=201305232126" type="text/css">
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
            postForm_Task.submit();
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
//parent调用方法 end
// onkeypress="repeatPhone();" onChange="checkPhone(this);"js，无刷新验证手机号，
</script>
</head>
<body onload="init();">
<div id="nav1" style="display:">
    <ul>
        <li><img src="<%=request.getContextPath()%>/images/default/16_04.gif"  border=0 onclick="save();" style="cursor:pointer;"></li>
        <li><img src="<%=request.getContextPath()%>/images/default/s_sx.gif" border=0 onclick="document.postForm_Task.reset();" style="cursor:pointer;"></li>
        <li><a href="TaskAction.jsp?cmd=list&page=<%=currpage%><%=((url.length() == 0) ? "" : "&" + url)%>"><img src="<%=request.getContextPath()%>/images/default/s_back.gif"></a></li>
    </ul>
 	 <table border="0" width="100%" cellspacing="0" cellpadding="0">
		   <tr>
			    <td background="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/an_hr.JPG" width="99%" height=1></td>
		   </tr>
	   </table>
</div>
<div id="form" style="overflow:auto;height:500px">
<form action="<%=request.getAttribute("classname")%>Action.jsp" method="post" name="postForm_Task" id="postForm_Task">
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="page" value="<%=currpage%>">
<%=Tool.join("\n", forms)%>
<table border="0" width="100%" cellspacing="0">
<input type="hidden" name="Id" id="_Id_" value="<%=v.getId()%>">
<%if(v.getId()>0){ %>
<tr id="postForm_Task_Uuid"><td class="td_label">
<div align="right">Uuid:</div>
</td><td class="td_value">
<input name="Uuid" id="_Uuid_" size="50" maxlength="50" value="<%=v.getUuid()%>">
</td></tr>
<%} %>
<%-- <tr id="postForm_Task_Code"><td class="td_label">
<div align="right">编码:</div>
</td><td class="td_value">
<input name="Code" id="_Code_" size="50" maxlength="50" value="<%=v.getCode()%>">
</td></tr> --%>
<tr id="postForm_Task_Name"><td class="td_label" width="40%">
<div align="right">名称:</div>
</td><td class="td_value">
<input name="Name" id="_Name_" size="50" maxlength="50" value="<%=v.getName()%>">
</td></tr>
<input type="hidden" name="IdP" value="<%=v.getIdP()%>">
<input type="hidden" name="Carid" value="<%=v.getCarid()%>">
<%-- <tr id="postForm_Task_Sd"><td class="td_label">
<div align="right">速度:</div>
</td><td class="td_value">
<input name="Sd" id="_Sd_" value="<%=v.getSd()%>">
</td></tr> --%>
<input type="hidden" name="Pathid" value="<%=v.getPathid()%>">
<tr id="postForm_Task_Yxj"><td class="td_label">
<div align="right">优先级:</div>
</td><td class="td_value">
<input name="Yxj" id="_Yxj_" size="20" maxlength="50" value="<%=v.getYxj()%>">
</td></tr>
<%-- <tr id="postForm_Task_Rwzt"><td class="td_label">
<div align="right">任务状态:</div>
</td><td class="td_value">
<input name="Rwzt" id="_Rwzt_" size="50" maxlength="50" value="<%=v.getRwzt()%>">
</td></tr> --%>
<%-- <tr id="postForm_Task_Qd"><td class="td_label">
<div align="right">起点地址:</div>
</td><td class="td_value">
<input name="Qd" id="_Qd_" size="50" maxlength="50" value="<%=v.getQd()%>">
<a href="#" class="easyui-linkbutton"  style="width:80px" onClick="getMap();">地图</a>
</td></tr>
<tr id="postForm_Task_Zd"><td class="td_label">
<div align="right">终点地址:</div>
</td><td class="td_value">
<input name="Zd" id="_Zd_" size="50" maxlength="50" value="<%=v.getZd()%>">
</td></tr> --%>
<tr id="postForm_Task_QdId"><td class="td_label">
<div align="right">起点:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(RfidNameoptions, "" +v.getQdId(), "QdId", "")%>
<%//radio形式%>
<%//RfidNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(RfidNameoptions, "" + v.getQdId(), "QdId", "-1")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(RfidNameoptions, "" + v.getQdId(), "QdId", "-1")%>
</td></tr>
<tr id="postForm_Task_ZdId"><td class="td_label">
<div align="right">终点:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(RfidNameoptions, "" + v.getZdId(), "ZdId", "-1")%>
<%//radio形式%>
<%//RfidNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(RfidNameoptions, "" + v.getZdId(), "ZdId", "-1")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(RfidNameoptions, "" + v.getZdId(), "ZdId", "-1")%>
</td></tr>
<input type="hidden" name="Commands" value="<%=v.getCommands()%>">
<%-- <tr id="postForm_Task_ComandsCode"><td class="td_label">
<div align="right">命令代码:</div>
</td><td class="td_value">
<input name="ComandsCode" id="_ComandsCode_" size="50" maxlength="50" value="<%=v.getComandsCode()%>">
</td></tr> --%>
<%-- <tr id="postForm_Task_Currfid"><td class="td_label">
<div align="right">当前点:</div>
</td><td class="td_value">
<input name="Currfid" id="_Currfid_" size="50" maxlength="50" value="<%=v.getCurrfid()%>">
</td></tr> --%>
<%-- <tr id="postForm_Task_Length"><td class="td_label">
<div align="right">路径长度:</div>
</td><td class="td_value">
<input name="Length" id="_Length_" value="<%=v.getLength()%>">
</td></tr>
<tr id="postForm_Task_Weigh"><td class="td_label">
<div align="right">权重:</div>
</td><td class="td_value">
<input name="Weigh" id="_Weigh_" value="<%=v.getWeigh()%>">
</td></tr> --%>

<tr id="postForm_Task_Hwzl"><td class="td_label">
<div align="right">货物种类:</div>
</td><td class="td_value">
<input name="Hwzl" id="_Hwzl_" size="50" maxlength="50" value="<%=v.getHwzl()%>">
</td></tr>
<%-- <tr id="postForm_Task_Hwbm"><td class="td_label">
<div align="right">货物编码:</div>
</td><td class="td_value">
<input name="Hwbm" id="_Hwbm_" size="50" maxlength="50" value="<%=v.getHwbm()%>">
</td></tr> --%>
<tr id="postForm_Task_Hwmc"><td class="td_label">
<div align="right">货物名称:</div>
</td><td class="td_value">
<input name="Hwmc" id="_Hwmc_" size="50" maxlength="50" value="<%=v.getHwmc()%>">
</td></tr>
<tr id="postForm_Task_Hwrfid"><td class="td_label">
<div align="right">货物RFID:</div>
</td><td class="td_value">
<input name="Hwrfid" id="_Hwrfid_" size="50" maxlength="50" value="<%=v.getHwrfid()%>">
</td></tr>
<tr id="postForm_Task_Hwsl"><td class="td_label">
<div align="right">货物数量:</div>
</td><td class="td_value">
<input name="Hwsl" id="_Hwsl_" value="<%=v.getHwsl()>0?v.getHwsl():""%>">
</td></tr>
<tr id="postForm_Task_Dwssl"><td class="td_label">
<div align="right">单位输送量:</div>
</td><td class="td_value">
<input name="Dwssl" id="_Dwssl_" value="<%=v.getDwssl()>0?v.getDwssl():""%>">
</td></tr>
<tr id="postForm_Task_Fhl"><td class="td_label">
<div align="right">发货量:</div>
</td><td class="td_value">
<input name="Fhl" id="_Fhl_" value="<%=v.getFhl()>0?v.getFhl():""%>">
</td></tr>
<tr id="postForm_Task_CreateTime"><td class="td_label">
<div align="right">创建时间:</div>
</td><td class="td_value">
<input name="CreateTime" id="_CreateTime_" size="50" maxlength="50" value="<%=v.getCreateTime()%>">
</td></tr>
<tr id="postForm_Task_XfTime"><td class="td_label">
<div align="right">下发时间:</div>
</td><td class="td_value">
<input name="XfTime" id="_XfTime_" size="50" maxlength="50" value="<%=v.getXfTime()%>">
</td></tr>
<tr id="postForm_Task_StartTime"><td class="td_label">
<div align="right">执行时间 :</div>
</td><td class="td_value">
<input name="StartTime" id="_StartTime_" size="50" maxlength="50" value="<%=v.getStartTime()%>">
</td></tr>
<tr id="postForm_Task_EndTime"><td class="td_label">
<div align="right">执行完成时间:</div>
</td><td class="td_value">
<input name="EndTime" id="_EndTime_" size="50" maxlength="50" value="<%=v.getEndTime()%>">
</td></tr>
<tr id="postForm_Task_Type"><td class="td_label">
<div align="right">任务类型:</div>
</td><td class="td_value">
<%//=HtmlTool.renderSelect(TaskTypeNameoptions, "" + v.getType(), "Type", "-1")%>
<%=HtmlTool.renderSelect(TaskTypeNameoptions, "" + v.getType(), "Type", "1")%>
</td></tr>
<tr id="postForm_Task_Endflag"><td class="td_label">
<div align="right">是否结束:</div>
</td><td class="td_value">
<%//=HtmlTool.renderSelect(YesNooptions, v.getEndflag(), "Endflag", "")%>
<%=HtmlTool.renderRadio(YesNooptions, v.getEndflag(), "Endflag", "")%>

</td></tr>
<%-- <tr id="postForm_Task_Kybz"><td class="td_label">
<div align="right">是否已划分子任务:</div>
</td><td class="td_value">
<%//=HtmlTool.renderSelect(YesNooptions, "" + v.getKybz(), "Kybz", "1")%>
<%=HtmlTool.renderRadio(YesNooptions, "" + v.getKybz(), "Kybz", "-1")%>
</td></tr> --%>
<%-- <tr id="postForm_Task_Userid"><td class="td_label">
<div align="right">用户编号:</div>
</td><td class="td_value">
<input name="Userid" id="_Userid_" value="<%=v.getUserid()%>">
</td></tr> --%>
</table>
</form>
</div>
<div id="dlg" class="easyui-dialog" title="地图" data-options="iconCls:'icon-save'" style="width:400px;height:250px;padding:5px">
</div>
<div id="openDlgDiv" class="easyui-window" closed="true" modal="true" title="地图" style="width:400px;height:250px;overflow:hidden; z-index:9999">
	<iframe scrolling="auto" id="openDlgIframe" frameborder="0"  src="" style="width:100%;height:99%;"></iframe>
</div> 
</body>
</html>
