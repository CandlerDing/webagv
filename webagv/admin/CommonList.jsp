<%@ page language="java" %>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%!
private static Log log = LogFactory.getLog(Tool.class);
%>
<%
log.debug("List");
String msg = (String)request.getAttribute("msg");
String back_msg = (String)request.getAttribute("back_msg");
if ((msg != null)) {
    out.print(HtmlTool.alert(msg));
    out.print("<script>");
    out.print("if (parent.PageReload) parent.PageReload();");
    out.print("</script>");
}

int currpage = ParamUtils.getIntParameter(request,"page",1);
int deptid = ParamUtils.getIntParameter(request,"deptid",1);

Map<String, String> extMaps = (Map<String, String>)request.getAttribute("Ext");
List<String> paras = HttpTool.getSavedUrl(request, "Ext");
String url = Tool.join("&", paras);
com.software.common.PageControl pagecontrol = (com.software.common.PageControl)request.getAttribute("PageControl");
List<String> rows = (List<String>)request.getAttribute("List");
if (rows == null) {
    out.print(HtmlTool.msgBox("请先调用Action.jsp！"));
    return;
}
String[] dickeys = (String[])request.getAttribute("dickeys");
String[][] dicvalues = (String[][])request.getAttribute("dicvalues");
List<String> diclist = new ArrayList<String>();
for (int i = 0; i < dickeys.length; i ++) {
    diclist.add("\"" + dickeys[i] + "\": [\"" + Tool.join("\", \"", dicvalues[i]) + "\"]");
}
%>
<html>
<head>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/images/default/web_oa.css">
<style type="text/css">
<!--
.css { font-size: 12px; color: #FFFFFF; text-decoration: none; word-spacing: 0.1em; letter-spacing: 0.1em; }
.hei { font-size: 12px; color: #000000; letter-spacing: 0.1em; word-spacing: 0.1em; }
-->
</style>
<title> <%=request.getAttribute("describe")%> </title>
<%@ include file="/js/jsheader.jsp"%>
<script src="<%=request.getContextPath()%>/js/listfunction.js"></script>
<script>
var curr_orderby = ["<%=(extMaps.get("orderfield") == null) ? "": extMaps.get("orderfield")%>", "<%=(extMaps.get("ordertype") == null) ? "": extMaps.get("ordertype")%>"];
var url_para = "<%=url%>";
var dic = {<%=Tool.join(", ", diclist)%>};
var keyfield = "<%=(String)request.getAttribute("keyfield")%>";
var allfields = ["<%=Tool.join("\", \"", (String[])request.getAttribute("allfields"))%>"];
var fields = ["<%=Tool.join("\", \"", (String[])request.getAttribute("fields"))%>"];
var rows = [<%=Tool.join(", ", rows)%>];

unitshow = "<%=request.getAttribute("classname")%>";
function init() {
    parent.buttonlist = ["reload","addNew","deleteList"];
    parent.init();
    showList(unitshow, <%=pagecontrol.getCurrPage()%>, url_para);
    if ("<%=request.getAttribute("prompt")%>" != "null" && parent.currItem[4] != "---")
    {
        document.getElementById("first_bar").style.display = "block";
        document.getElementById("display-name").innerHTML = parent.currItem[4];
    }

}
function addNew0()
{
    addNew('admin/<%=request.getAttribute("classname")%>', url_para);
}
function deleteList0()
{
    deleteList('admin/<%=request.getAttribute("classname")%>', url_para);
}
function save()
{

}
function modifyDept()
{
    location = "DeptCodeAction.jsp?cmd=modify&Id="+parent.currItem[0];
}
function deleteDept()
{
    if(confirm("确实要删除本条记录吗？"))
    {
        var keyId=parent.currItem[0];
        parent.currItem[0] = "";
        location = "DeptCodeAction.jsp?cmd=delete&Id="+keyId;

    }
    else
        return;
}
function addDept()
{
    location = "DeptCodeAction.jsp?cmd=create" + ((url_para.length == 0) ? "" : "&" + url_para);
}
function query()
{
      document.querydata._CnName_.value=document.all["_Lcnname"].value;
   document.querydata._Code_.value=document.all["_Lcode"].value;
  document.querydata.submit();
}
function query0(Str0)
{
    document.querydata.action=Str0;
    document.querydata.moreCond.value=getFieldList();
    document.querydata.submit();
}
function getFieldList()
{
  var rtn=Array();
  var tagList=["input","select"];
  for(var p=0;p<tagList.length;p++)
  {
    var tags = document.all.tags(tagList[p]);
    for(var i=0;i<tags.length;i++)
     {
       var name0=tags(i).name;
       if(name0.indexOf("_L")==0)
       {
         if(tags(i).value=="")
           continue;
         var tmp=name0.split("_L");
         rtn.push(tmp[1]+"***"+tags(i).value);
       }
       else if(name0.indexOf("_E")==0)
       {
         if(tags(i).value=="")
           continue;
         var tmp=name0.split("_E");
         rtn.push(tmp[1]+"==="+tags(i).value);
       }
     }
   }
   return rtn.join("^^^");
}
</script>

</head>
<body onload="init();top.mainFrame.hasDH();">
<div id="form" style="overflow:auto;height:430px">
<table height="100%" width="100%"  border="0" cellpadding="0" cellspacing="0" class="hei">
 <tr>
     <td valign="center"  width="99%" height="26" id="first_bar" style="display:none">
          <%=request.getAttribute("prompt")%>[<span id="display-name"></span>]
          <a href="javascript:addDept();"><img border=0 src="<%=request.getContextPath()%>/images/default/uploadtable.gif">录入新部门</a>
          <a href="javascript:modifyDept();"><img border=0 src="<%=request.getContextPath()%>/images/default/uploadtable.gif">修改当前部门</span></a>
          <a href="javascript:deleteDept();"><img border=0 src="<%=request.getContextPath()%>/images/default/uploadtable.gif">删除当前部门</span></a>
     </td>
 </tr>
 <%if (request.getAttribute("classname").equals("DeptUserCode")){%>
 <tr><td colspan="10">
 <span style="color:red">
<%if(request.getParameter("errInfo")!=null ) out.println(request.getParameter("errInfo"));%></span>
</td></tr>
<tr>
<td height="25px">
中文显示名称：<input name="_Lcnname" value="<%=Tool.getMoreCond(request,"_CnName_")%>">&nbsp;登录名：<input name="_Lcode" value="<%=Tool.getMoreCond(request,"_Code_")%>"><a href=javascript:query() >『查询』</a>
<div style="display:none">
<form name="querydata" method="POST" action="DeptUserCodeAction.jsp">
<input name="cmd" size=10 value="list">
<input name="_CnName_" size=10 value="">
<input name="_Code_" size=10 value="">
<input name="deptid" size=10 value="<%=deptid%>">
</form>
</div>
</td>
</tr>
<%}%>
 <tr >
     <td valign="top" id="list" height=100>
     </td>
 </tr>
 <tr>
     <td valign="top">
         <%=pagecontrol.getControl((String)request.getAttribute("classname") + "Action.jsp?cmd=list" + ((url.length() == 0) ? "" : "&" + url), "")%>
     </td>
 </tr>

</table>
</div>
</body>
</html>


