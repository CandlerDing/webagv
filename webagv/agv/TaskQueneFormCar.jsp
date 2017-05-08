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
UserInfo userInfo = Tool.getUserInfo(request);
List cdt = new ArrayList();
cdt.clear();
cdt.add("length(code)=8");  
cdt.add("ORDER BY CODE"); 
cdt.add("PID=2"); 
List CarNameoptions = (List)COptionConst.getCarNameOptions(userInfo,"", cdt);
%>
<html>
<head>
<title><%=request.getAttribute("describe")%></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/web_oa.css">
<%@ include file="/js/jsheader.jsp"%>
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
           postForm_TaskQuene.submit();
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
      <%--   <li><img src="<%=request.getContextPath()%>/images/default/s_sx.gif" border=0 onclick="document.postForm_TaskQuene.reset();" style="cursor:pointer;"></li>
        <li><a href="TaskQueneAction.jsp?cmd=list&page=<%=currpage%><%=((url.length() == 0) ? "" : "&" + url)%>"><img src="<%=request.getContextPath()%>/images/default/s_back.gif"></a></li> --%>
    </ul>
 	 <table border="0" width="100%" cellspacing="0" cellpadding="0">
		   <tr>
			    <td background="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/an_hr.JPG" width="99%" height=1></td>
		   </tr>
	   </table>
</div>
<div id="form" style="overflow:auto;height:280px">
<form action="<%=request.getAttribute("classname")%>Action.jsp" method="post" name="postForm_TaskQuene" id="postForm_TaskQuene">
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="page" value="<%=currpage%>">
<%=Tool.join("\n", forms)%>
<table border="0" width="100%" cellspacing="0">
<input type="hidden" name="Id" id="_Id_" value="<%=v.getId()%>">

<input type="hidden" name="TaskId" value="<%=v.getTaskId()%>">
<tr id="postForm_TaskQuene_Carid"><td class="td_label">
<div align="right">小车:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(CarNameoptions, "" + v.getCarid(), "Carid", "-1")%>
<%-- <input name="Carid" id="_Carid_" value="<%=v.getCarid()%>"> --%>
</td></tr>
<%-- <tr id="postForm_TaskQuene_CarUUId"><td class="td_label">
<div align="right">小车Uuid:</div>
</td><td class="td_value">
<input name="CarUUId" id="_CarUUId_" size="50" maxlength="50" value="<%=v.getCarUUId()%>">
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
