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
List YesNooptions = (List)request.getAttribute("YesNooptions");
List RfidNameoptions = (List)request.getAttribute("RfidNameoptions");
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
            if (doValidate('postForm_Car')) postForm_Car.submit();
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
        <li><a href="javascript:document.queryForm_Car.cmd.value = 'list' ;document.queryForm_Car.submit();"><img src="<%=request.getContextPath()%>/images/default/button_cx.gif" alt="��ѯ"></a></li>
        <li><a href="javascript:document.queryForm_Car.cmd.value = 'excel'; document.queryForm_Car.submit();"><img src="<%=request.getContextPath()%>/images/default/button_dc.gif" alt="����Excel�ļ�"></a></li>
        <li><b>[��������]</b></li>
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
<form action="<%=request.getAttribute("classname")%>Action.jsp" name="queryForm_Car" id="queryForm_Car">
<input type="hidden" name="cmd" value="list">
<%=Tool.join("\n", forms)%>
<tr>
<td>
<div align="right">����</div>
</td><td>
<input name="_Name_" id="_Name_" value="<%=ParamUtils.getParameter(request, "_Name_", "")%>">
</td>
<td>
<div align="right">����</div>
</td><td>
<input name="_Jd_" id="_Jd_" value="<%=ParamUtils.getParameter(request, "_Jd_", "")%>">
</td>
<td>
<div align="right">��ص�ѹ</div>
</td><td>
<input name="_Dcdy_" id="_Dcdy_" value="<%=ParamUtils.getParameter(request, "_Dcdy_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">���ֱ���ٶ�</div>
</td><td>
<input name="_Zxsd_" id="_Zxsd_" value="<%=ParamUtils.getParameter(request, "_Zxsd_", "")%>">
</td>
<td>
<div align="right">�������ٶ�</div>
</td><td>
<input name="_Gwsd_" id="_Gwsd_" value="<%=ParamUtils.getParameter(request, "_Gwsd_", "")%>">
</td>
<td>
<div align="right">���ٶ�</div>
</td><td>
<input name="_Jiasd_" id="_Jiasd_" value="<%=ParamUtils.getParameter(request, "_Jiasd_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">���ٶ�</div>
</td><td>
<input name="_Jiansd_" id="_Jiansd_" value="<%=ParamUtils.getParameter(request, "_Jiansd_", "")%>">
</td>
<td>
<div align="right">���Ϸ�ʽ</div>
</td><td>
<input name="_Slfs_" id="_Slfs_" value="<%=ParamUtils.getParameter(request, "_Slfs_", "")%>">
</td>
<td>
<div align="right">�ٶ�</div>
</td><td>
<input name="_Sd_" id="_Sd_" value="<%=ParamUtils.getParameter(request, "_Sd_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">������ʽ</div>
</td><td>
<input name="_Dyfs_" id="_Dyfs_" value="<%=ParamUtils.getParameter(request, "_Dyfs_", "")%>">
</td>
<td>
<div align="right">���γߴ�</div>
</td><td>
<input name="_Wxcc_" id="_Wxcc_" value="<%=ParamUtils.getParameter(request, "_Wxcc_", "")%>">
</td>
<td>
<div align="right">����</div>
</td><td>
<input name="_Fz_" id="_Fz_" value="<%=ParamUtils.getParameter(request, "_Fz_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">��λ����</div>
</td><td>
<input name="_Dwjd_" id="_Dwjd_" value="<%=ParamUtils.getParameter(request, "_Dwjd_", "")%>">
</td>
<td>
<div align="right">������ʽ</div>
</td><td>
<input name="_Qdxs_" id="_Qdxs_" value="<%=ParamUtils.getParameter(request, "_Qdxs_", "")%>">
</td>
<td>
<div align="right">��������ʱ��</div>
</td><td>
<input name="_Lxtime_" id="_Lxtime_" value="<%=ParamUtils.getParameter(request, "_Lxtime_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">��緽ʽ</div>
</td><td>
<input name="_Cdfs_" id="_Cdfs_" value="<%=ParamUtils.getParameter(request, "_Cdfs_", "")%>">
</td>
<td>
<div align="right">��Сת��뾶</div>
</td><td>
<input name="_Zwlj_" id="_Zwlj_" value="<%=ParamUtils.getParameter(request, "_Zwlj_", "")%>">
</td>
<td>
<div align="right">��ȫ��Ӧ��Χ</div>
</td><td>
<input name="_Aqgyfw_" id="_Aqgyfw_" value="<%=ParamUtils.getParameter(request, "_Aqgyfw_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">·��ʶ��</div>
</td><td>
<input name="_Ljsb_" id="_Ljsb_" value="<%=ParamUtils.getParameter(request, "_Ljsb_", "")%>">
</td>
<td>
<div align="right">������ʾ</div>
</td><td>
<input name="_Xzts_" id="_Xzts_" value="<%=ParamUtils.getParameter(request, "_Xzts_", "")%>">
</td>
<td>
<div align="right">���ϱ���</div>
</td><td>
<input name="_Gzbj_" id="_Gzbj_" value="<%=ParamUtils.getParameter(request, "_Gzbj_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">��ȫ����</div>
</td><td>
<input name="_Aqfh_" id="_Aqfh_" value="<%=ParamUtils.getParameter(request, "_Aqfh_", "")%>">
</td>
<td>
<div align="right">�����</div>
</td><td>
<input name="_Zdfz_" id="_Zdfz_" value="<%=ParamUtils.getParameter(request, "_Zdfz_", "")%>">
</td>
<td>
<div align="right">���ֱ���г�</div>
</td><td>
<input name="_Zdzxxc_" id="_Zdzxxc_" value="<%=ParamUtils.getParameter(request, "_Zdzxxc_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">��س���ѹ</div>
</td><td>
<input name="_Cddy_" id="_Cddy_" value="<%=ParamUtils.getParameter(request, "_Cddy_", "")%>">
</td>
<td>
<div align="right">��͹�����ѹ</div>
</td><td>
<input name="_Zddy_" id="_Zddy_" value="<%=ParamUtils.getParameter(request, "_Zddy_", "")%>">
</td>
<td>
<div align="right">������</div>
</td><td>
<input name="_Cd_" id="_Cd_" value="<%=ParamUtils.getParameter(request, "_Cd_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">������</div>
</td><td>
<input name="_Kd_" id="_Kd_" value="<%=ParamUtils.getParameter(request, "_Kd_", "")%>">
</td>
<td>
<div align="right">ͨѶ��ʽ </div>
</td><td>
<input name="_Txfs_" id="_Txfs_" value="<%=ParamUtils.getParameter(request, "_Txfs_", "")%>">
</td>
<input type="hidden" name="_Hwsl_" id="_Hwsl_" value="<%=ParamUtils.getParameter(request, "_Hwsl_", "")%>">
<input type="hidden" name="_Hwzl_" id="_Hwzl_" value="<%=ParamUtils.getParameter(request, "_Hwzl_", "")%>">
<td>
<div align="right">IP��ַ</div>
</td><td>
<input name="_Ipaddress_" id="_Ipaddress_" value="<%=ParamUtils.getParameter(request, "_Ipaddress_", "")%>">
</td>
</tr><tr>
<td>
<div align="right">��е������</div>
</td><td>
<input name="_Handnum_" id="_Handnum_" value="<%=ParamUtils.getParameter(request, "_Handnum_", "")%>">
</td>
<td>
<div align="right">IOͨ������</div>
</td><td>
<input name="_Ionum_" id="_Ionum_" value="<%=ParamUtils.getParameter(request, "_Ionum_", "")%>">
</td>
<td>
<div align="right">������ַ</div>
</td><td>
<%=HtmlTool.renderSelect(RfidNameoptions, ParamUtils.getParameter(request,"_AddressId_",""), "_AddressId_", "")%>
<%//radio��ʽ%>
<%//RfidNameoptions.remove(0);%>
<%//=HtmlTool.renderRadio(RfidNameoptions, ParamUtils.getParameter(request,"_AddressId_",""), "_AddressId_", "")%>
<%//checkbox��ʽ%>
<%//=HtmlTool.renderCheckBox(RfidNameoptions, ParamUtils.getParameter(request,"_AddressId_",""), "_AddressId_", "")%>
</td>
</tr><tr>
<td>
<div align="right">�Ƿ����</div>
</td><td>
<%=HtmlTool.renderSelect(YesNooptions, ParamUtils.getParameter(request,"_Flag_",""), "_Flag_", "")%>
<%//radio��ʽ%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, ParamUtils.getParameter(request,"_Flag_",""), "_Flag_", "")%>
<%//checkbox��ʽ%>
<%//=HtmlTool.renderCheckBox(YesNooptions, ParamUtils.getParameter(request,"_Flag_",""), "_Flag_", "")%>
</td>
<td>
<div align="right">ͨѶ�Ƿ�����</div>
</td><td>
<%=HtmlTool.renderSelect(YesNooptions, ParamUtils.getParameter(request,"_TxFlag_",""), "_TxFlag_", "")%>
<%//radio��ʽ%>
<%//YesNooptions.remove(0);%>
<%//=HtmlTool.renderRadio(YesNooptions, ParamUtils.getParameter(request,"_TxFlag_",""), "_TxFlag_", "")%>
<%//checkbox��ʽ%>
<%//=HtmlTool.renderCheckBox(YesNooptions, ParamUtils.getParameter(request,"_TxFlag_",""), "_TxFlag_", "")%>
</td>
<td colspan="2">&nbsp;</td>
</tr><tr><td colspan="8" align="center">
<input type="button" value="Reset" onClick="clearForm('queryForm_Car')" />
</td></tr></form></table>
</div>
<div>ÿҳ��ʾ������<%=Tool.getUserInfo(request).getDispNum()%></div>
<div id="list">
</div>
<%=(("listall".equals(cmd)))? "": pagecontrol.getControl((String)request.getAttribute("classname") + "Action.jsp?cmd=list" + ((url.length() == 0) ? "" : "&" + url), "")%>
</body>
</html>
