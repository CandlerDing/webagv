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
            if (doValidate('postForm_User_Module')) postForm_User_Module.submit();
}
function initP() {
             parent.buttonlist = ["reload","addNew","deleteList"];
    					parent.init();
}
//parent���÷��� end
function showUser(moduleId)
{
    url = "role_ChoiceAction.jsp?cmd=UserModuleList&moduleId="+moduleId+"&userType=0";
    openwin=window.open(url,"new_choice","top=58,left=140,width=400,height=300,status=no,toolbar=no,menubar=no,scrollbars=no, resizable=no");

}
</script>
</head>
<body onload="init();">
<div id="nav1" style="display:">
    <ul>
        <li><a href="javascript:addNew('<%=request.getAttribute("classname")%>', url_para);"><img src="<%=request.getContextPath()%>/images/default/16_038.gif" alt="���Ӽ�¼"></a></li>
        <li><a href="javascript:deleteList('<%=request.getAttribute("classname")%>', url_para);"><img src="<%=request.getContextPath()%>/images/default/button4.gif" alt="ɾ����¼"></a></li>
        <li><b>[ϵͳ����ģ���]</b></li>
				<table border="0" width="100%" cellspacing="0" cellpadding="0">
				<tr>
					<td background="<%=request.getContextPath()%>/images/<%=Tool.getUserInfo(request).getSkinId().equals("")?"default":Tool.getUserInfo(request).getSkinId()%>/an_hr.JPG" width="99%" height=1></td>
				</tr>
				</table>
    </ul>
</div>
<div id="queryform">
<form name="queryForm_User_Module" id="queryForm_User_Module" action="User_ModuleAction.jsp" method="POST">
<input type="hidden" name="cmd"/>
<%=Tool.join("\n", forms)%>
</form>
</div>
<div>
<%int Classid = ParamUtils.getIntParameter(request,"Classid",0);
if(Classid>0)
{
  User_Module userModule= new User_Module();
  userModule = userModule.getById(Classid);
  if(userModule!=null && userModule.getId()>0)
  {
    out.print("<font style='color:red;font-weight:bold;line-height:30px;'>��ǰģ�飺"+userModule.getName()+"</font>");
  }
}
%>
</div>
<div id="list">
</div>
<%=(("listall".equals(cmd)))? "": pagecontrol.getControl((String)request.getAttribute("classname") + "Action.jsp?cmd=list" + ((url.length() == 0) ? "" : "&" + url), "")%>
</body>
</html>
