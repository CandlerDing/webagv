<%@ page language="java" %>
<%--RFID站点--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
Log log = LogFactory.getLog(Rfid.class);
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
Rfid v = (Rfid)request.getAttribute("fromBean");
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
List PathsNameoptions = (List)request.getAttribute("PathsNameoptions");
%>
<html>
<head>
<title><%=request.getAttribute("describe")%></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/web_oa.css">
<%@ include file="/js/jsheader.jsp"%>
<script type="text/JavaScript" src="<%=request.getContextPath()%>/js/jquery-1.7.min.js"></script>
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
             postForm_Rfid.submit();
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
<div id="nav1" style="display:">
    <ul>
        <li><img src="<%=request.getContextPath()%>/images/default/16_04.gif"  border=0 onclick="save();" style="cursor:pointer;"></li>
        <li><img src="<%=request.getContextPath()%>/images/default/s_sx.gif" border=0 onclick="document.postForm_Rfid.reset();" style="cursor:pointer;"></li>
        <li><a href="RfidAction.jsp?cmd=list&page=<%=currpage%><%=((url.length() == 0) ? "" : "&" + url)%>"><img src="<%=request.getContextPath()%>/images/default/s_back.gif"></a></li>
    </ul>
 	 <table border="0" width="100%" cellspacing="0" cellpadding="0">
		   <tr>
			    <td background="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/an_hr.JPG" width="99%" height=1></td>
		   </tr>
	   </table>
</div>
<div id="errorDiv" style="color:red;font-weight:bold"></div>
<div id="jserrorDiv" style="color:red;font-weight:bold"></div>
<div id="form" style="overflow:auto;height:480px">
<form action="<%=request.getAttribute("classname")%>Action.jsp" method="post" name="postForm_Rfid" id="postForm_Rfid">
<input type="hidden" name="cmd" value="<%=cmd%>">
<input type="hidden" name="page" value="<%=currpage%>">
<%=Tool.join("\n", forms)%>
<table border="0" width="100%" cellspacing="0">
<input type="hidden" name="Id" id="_Id_" value="<%=v.getId()%>">
<tr id="postForm_Rfid_Code"><td class="td_label">
<div align="right">编码:</div>
</td><td class="td_value">
<input name="Code" id="_Code_" size="50" maxlength="50" value="<%=v.getCode()%>">
</td></tr>
<tr id="postForm_Rfid_Name"><td class="td_label">
<div align="right">名称:</div>
</td><td class="td_value">
<input name="Name" id="_Name_" size="50" maxlength="50" value="<%=v.getName()%>">
</td></tr>
<tr id="postForm_Rfid_Wladdress"><td class="td_label">
<div align="right">物理地址:</div>
</td><td class="td_value">
<input name="Wladdress" id="_Wladdress_" size="50" maxlength="50" value="<%=v.getWladdress()%>">
</td></tr>
<tr id="postForm_Rfid_Rfid"><td class="td_label">
<div align="right">RFID:</div>
</td><td class="td_value">
<input name="Rfid" id="_Rfid_" size="50" maxlength="50" value="<%=v.getRfid()%>">
</td></tr>
<tr id="postForm_Rfid_PathbsUuId"><td class="td_label">
<div align="right">路径标识ID:</div>
</td><td class="td_value">
<input name="PathbsUuId" id="_PathbsUuId_" size="50" maxlength="50" value="<%=v.getPathbsUuId()%>">
</td></tr>
<input type="hidden" name="IdP" value="<%=v.getIdP()%>">
<tr id="postForm_Rfid_Flag"><td class="td_label">
<div align="right">是否可用:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(YesNooptions, "" + v.getFlag(), "Flag", "-1")%>
<%//radio形式%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, "" + v.getFlag(), "Flag", "-1")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(YesNooptions, "" + v.getFlag(), "Flag", "-1")%>
</td></tr>
<%-- <tr id="postForm_Rfid_Pathid"><td class="td_label">
<div align="right">路径ID:</div>
</td><td class="td_value">
<%=HtmlTool.renderSelect(PathsNameoptions, "" + v.getPathid(), "Pathid", "-1")%>
<%//radio形式%>
<%//PathsNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(PathsNameoptions, "" + v.getPathid(), "Pathid", "-1")%>
<%//checkbox形式%>
<%//=HtmlTool.renderCheckBox(PathsNameoptions, "" + v.getPathid(), "Pathid", "-1")%>
</td></tr> --%>
<tr id="postForm_Rfid_Orderno"><td class="td_label">
<div align="right">排序:</div>
</td><td class="td_value">
<input name="Orderno" id="_Orderno_" value="<%=v.getOrderno()%>">
</td></tr>
<tr id="postForm_Rfid_Type"><td class="td_label">
<div align="right">类型:</div>
</td><td class="td_value">
<input name="Type" id="_Type_" size="50" maxlength="50" value="<%=v.getType()%>">
</td></tr>
<tr id="postForm_Rfid_Remark"><td class="td_label">
<div align="right">备注:</div>
</td><td class="td_value">
<input name="Remark" id="_Remark_" size="50" maxlength="50" value="<%=v.getRemark()%>">
</td></tr>
</table>
</form>
</div>
</body>
</html>
