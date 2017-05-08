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
    out.print(HtmlTool.msgBox(request, "���ȵ���Action.jsp��"));
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
//Ĭ��ֵ����
List Politicsoptions = (List)request.getAttribute("Politicsoptions");
List TechPostCodeoptions = (List)request.getAttribute("TechPostCodeoptions");
List Degree1Codeoptions = (List)request.getAttribute("Degree1Codeoptions");
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
//parent���÷��� start
function addNew0()
	{
    		addNew('<%=request.getContextPath()%>/Ŀ¼��/<%=request.getAttribute("classname")%>', url_para);
	}
function deleteList0()
{
    	deleteList('<%=request.getContextPath()%>/Ŀ¼��/<%=request.getAttribute("classname")%>', url_para);
	}
function save() {
            if (doValidate('postForm_User')) postForm_User.submit();
}
function initP() {
             parent.buttonlist = ["reload","addNew","deleteList"];
    					parent.init();
}
//parent���÷��� end
</script>
</head>
<body onload="init();">
<div id="nav1" style="display:">
    <ul>
        <li><a href="javascript:addNew('<%=request.getAttribute("classname")%>', url_para);"><img src="<%=request.getContextPath()%>/images/default/16_038.gif" alt="���Ӽ�¼"></a></li>
        <li><a href="javascript:deleteList('<%=request.getAttribute("classname")%>', url_para);"><img src="<%=request.getContextPath()%>/images/default/button4.gif" alt="ɾ����¼"></a></li>
        <li><a href="javascript:document.queryForm_User.cmd.value = 'list' ;document.queryForm_User.submit();"><img src="<%=request.getContextPath()%>/images/default/button_cx.gif" alt="��ѯ"></a></li>
        <li><a href="javascript:document.queryForm_User.cmd.value = 'excel'; document.queryForm_User.submit();"><img src="<%=request.getContextPath()%>/images/default/button_dc.gif" alt="����Excel�ļ�"></a></li>
        <li><b>[�û�����]</b></li>
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td background="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/an_hr.JPG" width="99%" height=1></td>
				</tr>
				</table>
    </ul>
</div>
<div id="queryform">
<table border="0" width="100%" cellspacing="0" onclick="showhidden('searchTable')" style="cursor:pointer">
<tr><td colspan="8" align="center" class=title_bgcolor>��ѯ����</td></tr></table>
<table border="0" width="100%" cellspacing="0" id="searchTable" style="display:none" >
<form action="<%=request.getAttribute("classname")%>Action.jsp" name="queryForm_User" id="queryForm_User">
<input type="hidden" name="cmd" value="list">
<%=Tool.join("\n", forms)%>
<tr>
<td>
<div align="right">�û�����</div>
</td><td>
<input name="_Name_" value="<%=ParamUtils.getParameter(request, "_Name_", "")%>">
</td>
<input type="hidden" name="_OFFICEID_" value="<%=ParamUtils.getParameter(request, "_OFFICEID_", "")%>">
<td>
<div align="right">��¼�û���</div>
</td><td>
<input name="_LOGID_" value="<%=ParamUtils.getParameter(request, "_LOGID_", "")%>">
</td>
<td>
<div align="right">��¼����</div>
</td><td>
<input name="_LOGPASS_" value="<%=ParamUtils.getParameter(request, "_LOGPASS_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">�ֻ�</div>
</td><td>
<input name="_Phone_" value="<%=ParamUtils.getParameter(request, "_Phone_", "")%>">
</td>
<td>
<div align="right">��ϵ�绰</div>
</td><td>
<input name="_SubPhone_" value="<%=ParamUtils.getParameter(request, "_SubPhone_", "")%>">
</td>
<td>
<div align="right">��ַ</div>
</td><td>
<input name="_Address_" value="<%=ParamUtils.getParameter(request, "_Address_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">�Ա�</div>
</td><td>
<input name="_XB_" value="<%=ParamUtils.getParameter(request, "_XB_", "")%>">
</td>
<td>
<div align="right">���֤����</div>
</td><td>
<input name="_Sfzhm_" value="<%=ParamUtils.getParameter(request, "_Sfzhm_", "")%>">
</td>
<td>
<div align="right">������ò</div>
</td><td>
<%=HtmlTool.renderSelect(Politicsoptions, ParamUtils.getParameter(request,"_Zzmm_",""), "_Zzmm_", "")%>
<%//radio��ʽ%>
<%//Politicsoptions.remove(0);%>
<%//=HtmlTool.renderRadio(Politicsoptions, ParamUtils.getParameter(request,"_Zzmm_",""), "_Zzmm_", "")%>
<%//checkbox��ʽ%>
<%//=HtmlTool.renderCheckBox(Politicsoptions, ParamUtils.getParameter(request,"_Zzmm_",""), "_Zzmm_", "")%>
</td>
</tr><tr>
<td>
<div align="right">ѧ��</div>
</td><td>
<%=HtmlTool.renderSelect(Degree1Codeoptions, ParamUtils.getParameter(request,"_DegreeCode_",""), "_DegreeCode_", "")%>
<%//radio��ʽ%>
<%//Degree1Codeoptions.remove(0);%>
<%//=HtmlTool.renderRadio(Degree1Codeoptions, ParamUtils.getParameter(request,"_DegreeCode_",""), "_DegreeCode_", "")%>
<%//checkbox��ʽ%>
<%//=HtmlTool.renderCheckBox(Degree1Codeoptions, ParamUtils.getParameter(request,"_DegreeCode_",""), "_DegreeCode_", "")%>
</td>
<td>
<div align="right">��ʼ����ʱ��</div>
</td><td>
<input name="_WorkStart_" value="<%=ParamUtils.getParameter(request, "_WorkStart_", "")%>">
</td>
<td>
<div align="right">ְ��</div>
</td><td>
<input name="_TechPostCode_" value="<%=ParamUtils.getParameter(request, "_TechPostCode_", "")%>">
<%-- <%=HtmlTool.renderSelect(TechPostCodeoptions, ParamUtils.getParameter(request,"_TechPostCode_",""), "_TechPostCode_", "")%> --%>
<%//radio��ʽ%>
<%//TechPostCodeoptions.remove(0);%>
<%//=HtmlTool.renderRadio(TechPostCodeoptions, ParamUtils.getParameter(request,"_TechPostCode_",""), "_TechPostCode_", "")%>
<%//checkbox��ʽ%>
<%//=HtmlTool.renderCheckBox(TechPostCodeoptions, ParamUtils.getParameter(request,"_TechPostCode_",""), "_TechPostCode_", "")%>
</td>
</tr><tr>
<td>
<div align="right">����</div>
</td><td>
<input name="_OrderNum_" value="<%=ParamUtils.getParameter(request, "_OrderNum_", "")%>">
</td>
<td>
<div align="right">״̬   </div>
</td><td>
<input name="_STATE_" value="<%=ParamUtils.getParameter(request, "_STATE_", "")%>">
</td>
<td colspan="2">&nbsp;</td>
</tr><tr><td colspan="8" align="center">
<input type="button" value="Reset" onClick="clearForm('queryForm_User')" />
</td></tr></form></table>
</div>
<div>ÿҳ��ʾ������<%=Tool.getUserInfo(request).getDispNum()%></div>
<div id="list">
</div>
<%=(("listall".equals(cmd)))? "": pagecontrol.getControl((String)request.getAttribute("classname") + "Action.jsp?cmd=list" + ((url.length() == 0) ? "" : "&" + url), "")%>
</body>
</html>
