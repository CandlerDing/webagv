<%@ page language="java" %>
<%--通用显示树--%>
<%@ page contentType="text/html;charset=GBK"%>
<%@ page import="com.software.main.*,com.software.main.db.*"%>
<%@ page import="com.software.util.*,com.software.common.*"%>
<%@ page import="org.apache.commons.logging.*"%>
<%@ page import="java.io.*,java.util.*"%>
<%
Log log = LogFactory.getLog(Tool.class);
log.debug("Tree.jsp");
String msg = (String)request.getAttribute("msg");
if ((msg != null)) {
    out.print(HtmlTool.msgBox(msg));
    return;
}
String type = ParamUtils.getParameter(request,"type","bank");
String Id = ParamUtils.getParameter(request,"Id","-1");
String Name = ParamUtils.getParameter(request,"Name","未选择单位");
String Code = ParamUtils.getParameter(request,"Code","000");
String action = "showBank";
if (!type.equals("bank")) {
    action = "showBankUser";
}
//以下代码将产生树
Map<String, String> extparaMap = (Map<String, String>)request.getAttribute("TreeExt");
String tree = (String)request.getAttribute("tree");
String strTree = (String)request.getAttribute("strTree");
%>
<html>
<head>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312">
<link rel="STYLESHEET" type="text/css" href="<%=request.getContextPath()%>/images/web_oa.css">
<style type="text/css">
<!--
body {
    margin-left: 0px;
    margin-top: 0px;
    margin-right: 0px;
    margin-bottom: 0px;
    background-color: #F1F1F7;
}
input {
    font-size: 12px;
color: #000000;
       text-decoration: none;
       background-color: #FFFFFF;
border: 0px solid #ffffff;
}
-->

</style>
<link href="css/cssz.css" rel="stylesheet" type="text/css">
<%@ include file="/js/jsheader.jsp"%>
<script src="<%=request.getContextPath()%>/js/xtree2.js"></script>
    <script>
function init()
{

    if(parent.currItem[0] == "")
    {
        parent.currItem[0] = "<%=Id%>";

        parent.currItem[4] = "<%=Name%>";
        parent.query();
    }
}
</script>
<link type="text/css" rel="stylesheet" href="<%=request.getContextPath()%>/js/xtree.css">
</head>
<body onload="init()" >
<table width="209" border="0" cellpadding="0" cellspacing="0">
<tr>
<td height="90%" valign="top">
<div style="padding:0 0 0 10px">
    <script>
function treeClick(item)
{
  //id,name,text,data
    var objArray=new Array();
    var objArray1=new Array();
    objArray=item.data;
    objArray1 = objArray[0];
    parent.currItem = objArray1;
    parent.currItem[0] = objArray1.id;
    parent.currItem[1] = objArray1.code;
    parent.currItem[4] = objArray1.name;
    parent.query();
}

var defOpenClose=true;
function tree0Click() //一级的最大值
{
    parent.currItem[0] = "0";
    parent.currItem[1] = "";
    parent.currItem[4] = "---";
    parent.query();
}

if (document.getElementById) {
    <%=tree%>
        tree.setBehavior("classic");
    <%=strTree%>
        document.write(tree);
}

var PrestrName="济南市中级人民法院";
var NowstrName="济南市人大代表大会";

var pname="<%=session.getAttribute("pname")%>";
var fpname="<%=session.getAttribute("fpname")%>";
if(pname!=""){
  PrestrName=pname;
  NowstrName=fpname;
}
//alert(PrestrName+NowstrName);
ary=tree.MoRendoExpand(PrestrName,NowstrName);
//alert(ary.length);
for(var i=(ary.length-2);i>=0;i--)
{
	tree.doExpand1(ary[i]);
}




</script>
</td>
</tr>
</table>
</body>
</html>
